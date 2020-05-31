import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movpedia/model/playlist_model.dart';
import 'package:movpedia/services/api_service.dart';
import 'package:movpedia/utilities/logger.dart';

part 'all_playlist_event.dart';
part 'all_playlist_state.dart';

class ResponseYoutubePlaylist {
  final String lastItem;
  final List<PlayList> allPlaylist;
  final int totalPlaylist;

  ResponseYoutubePlaylist({
    @required this.lastItem,
    @required this.totalPlaylist,
    @required this.allPlaylist,
  });
}

class AllPlaylistBloc extends Bloc<AllPlaylistEvent, AllPlaylistState> {
  final _service = APIService.instance;

  @override
  AllPlaylistState get initialState => HasAllPlaylist(
        isComplete: false,
        isFailure: false,
        isLoading: false,
        hasReachedMax: false,
        allPlaylist: [],
      );

  @override
  Stream<AllPlaylistState> mapEventToState(
    AllPlaylistEvent event,
  ) async* {
    if (event is GetAllPlaylist) {
      yield* _mapEventToState();
    }
  }

  Stream<AllPlaylistState> _mapEventToState() async* {
    final HasAllPlaylist currentState = (state as HasAllPlaylist);
    yield HasAllPlaylist(
      isComplete: false,
      isLoading: true,
      isFailure: false,
      allPlaylist: currentState.allPlaylist,
      hasReachedMax: currentState.hasReachedMax,
    );
    final allPlaylist = await _service.fetchAllPlaylistChannel(
      lastItem: currentState.lastItem,
    );
    if (allPlaylist.allPlaylist.isEmpty) {
      yield (state as HasAllPlaylist).copyWith(hasReachedMax: true);
      return;
    }

    if (!_hasReachedMax(state) && !currentState.isLoading) {
      try {
        currentState.allPlaylist..addAll(allPlaylist.allPlaylist);
        yield HasAllPlaylist(
          isComplete: true,
          isLoading: false,
          isFailure: false,
          allPlaylist: currentState.allPlaylist,
          hasReachedMax: allPlaylist.totalPlaylist == 0,
          lastItem: allPlaylist.lastItem,
        );
      } catch (e) {
        Logger.e('Error $e', s: StackTrace.current, e: e );
        yield HasAllPlaylist(
          isComplete: true,
          isLoading: false,
          isFailure: true,
          allPlaylist: currentState.allPlaylist,
          hasReachedMax: false,
        );
        Logger.e('Error get all all_playlist', e: e, s: StackTrace.current);
      }
    }
  }

  bool _hasReachedMax(AllPlaylistState state) =>
      state is HasAllPlaylist && state.hasReachedMax;
}
