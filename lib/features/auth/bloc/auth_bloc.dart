import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:movpedia/data/users_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final UserRepository _userRepository;

  AuthBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUser();
        final avatar = await _userRepository.getAvatar();
        final fullname = await _userRepository.getUserFullname();
        final isGoogleAuth = await _userRepository.isUserGoogleAuth();
        final tokenFCM = await _userRepository.getUserTokenFCM();
        yield Authenticated(
            displayName: name,
            avatar: avatar,
            fullname: fullname,
            isGoogleAuth: isGoogleAuth,
            tokenFCM: tokenFCM);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    final name = await _userRepository.getUser();
    final avatar = await _userRepository.getAvatar();
    final fullname = await _userRepository.getUserFullname();
    final isGoogleAuth = await _userRepository.isUserGoogleAuth();
    final tokenFCM = await _userRepository.getUserTokenFCM();

    final newToken = await _firebaseMessaging.getToken();

    if (newToken != tokenFCM) {
      _userRepository.updateUserTokenFCM(name, newToken);
    }

    yield Authenticated(
      displayName: name,
      avatar: avatar,
      isGoogleAuth: isGoogleAuth,
      fullname: fullname,
      tokenFCM: newToken != tokenFCM ? newToken : tokenFCM,
    );
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
