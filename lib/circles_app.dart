import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpedia/data/users_repository.dart';
import 'package:movpedia/features/all_playlist/bloc/all_playlist_bloc.dart';
import 'package:movpedia/features/auth/bloc/auth_bloc.dart';
import 'package:movpedia/features/classes/view/classes_view.dart';
import 'package:movpedia/features/home/views/home_screen.dart';
import 'package:movpedia/features/login/bloc/bloc.dart';
import 'package:movpedia/features/login/view/login_screen.dart';
import 'package:movpedia/features/login/view/welcome_screen.dart';
import 'package:movpedia/features/messages/view/messages_view.dart';
import 'package:movpedia/features/player/bloc/player_bloc.dart';
import 'package:movpedia/features/playlist/bloc/playlist_bloc.dart';
import 'package:movpedia/features/playlist/view/playlist_view.dart';
import 'package:movpedia/features/proflie/view/profile_view.dart';
import 'package:movpedia/features/videos/bloc/videos_bloc.dart';
import 'package:movpedia/theme.dart';

class CirclesApp extends StatefulWidget {

  @override
  _CirclesAppState createState() => _CirclesAppState();
}

class _CirclesAppState extends State<CirclesApp> {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(
            userRepository: userRepository,
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginBloc(userRepository: userRepository,),
        ),
        BlocProvider(
          create: (BuildContext context) => VideosBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AllPlaylistBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => PlaylistBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => PlayerBloc(),
        ),
      ],
      child: App(userRepository: userRepository),
    );
  }
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movpedia',
      theme: AppTheme.theme,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state is Unauthenticated) {
            return WelcomeScreen();
          }
          if (state is Authenticated) {
            return HomeScreen();
          }
          if (state is Uninitialized) {
            return WelcomeScreen();
          }
          return WelcomeScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        WelcomeScreen.routeName: (_) => WelcomeScreen(),
        PlaylistView.routeName: (_) => PlaylistView(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        MessagesScreen.routeName: (_) => MessagesScreen(),
        ClassesView.routeName: (_) => ClassesView(),
      },
    );
  }
}
