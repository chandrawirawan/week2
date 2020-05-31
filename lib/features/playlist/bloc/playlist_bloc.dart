import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movpedia/model/playlist_model.dart';
import 'package:movpedia/model/video_model.dart';
import 'package:movpedia/services/videos_service.dart';
import 'package:movpedia/utilities/logger.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  @override
  PlaylistState get initialState => HasPlaylist(
        isComplete: false,
        isFailure: false,
        isLoading: false,
        hasReachedMax: false,
        videos: [],
        filteredVideos: 0,
      );

  @override
  Stream<PlaylistState> mapEventToState(
    PlaylistEvent event,
  ) async* {
    if (event is SetDetailPlaylist) {
      yield* _mapPlaylistToState(event.playlist);
    } else if (event is ResetPlaylist) {
      yield* _mapResetPlaylistToState();
    }
  }
  Stream<PlaylistState> _mapResetPlaylistToState() async* {
    yield HasPlaylist(
      isComplete: false,
      isFailure: false,
      isLoading: false,
      hasReachedMax: false,
      videos: [],
      filteredVideos: 0,
    );
  }

  Stream<PlaylistState> _mapPlaylistToState(PlayList playlist) async* {
    final HasPlaylist currentState = (state as HasPlaylist);
    if (!_hasReachedMax(state)) {
      yield HasPlaylist(
        isComplete: false,
        isLoading: true,
        isFailure: false,
        videos: currentState.videos,
        hasReachedMax: false,
        totalVideo: 0,
        playlist: playlist,
      );
      if (!currentState.isLoading) {
        try {
          final ResponseListYoutubeVideos videos =
              await VideoServices.instance.fetchVideosByPlaylistId(
            playlistId: playlist.id,
            nextPageToken: currentState.nextPageToken,
          );
          currentState.videos..addAll(videos.videos);
          yield HasPlaylist(
            playlist: playlist,
            videos: videos.videos,
            totalVideo: videos.totalVideo,
            nextPageToken: videos.nextPageToken,
            hasReachedMax: (currentState.videos.length + videos.filteredVideos) == videos.totalVideo,
            isFailure: false,
            isComplete: true,
            isLoading: false,
            filteredVideos: currentState.filteredVideos + videos.filteredVideos,
          );
        } catch (e) {
          Logger.e('E: ', e: e, s: null);
          yield (state as HasPlaylist)
              .copyWith(isLoading: false, isComplete: false, isFailure: true);
        }
      }
    }
  }

  bool _hasReachedMax(PlaylistState state) =>
      state is HasPlaylist && state.hasReachedMax;
}
