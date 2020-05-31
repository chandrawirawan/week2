import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movpedia/model/video_model.dart';
import 'package:movpedia/services/api_service.dart';
import 'package:movpedia/utilities/logger.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class ResponseYoutubeVideos {
  final String nextPageToken;
  final List<Video> videos;
  final int totalVideo;

  ResponseYoutubeVideos({
    @required this.nextPageToken,
    @required this.totalVideo,
    @required this.videos,
  });
}

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final _service = APIService.instance;

  @override
  VideosState get initialState => HasVideos(
        isComplete: false,
        isFailure: false,
        isLoading: false,
        hasReachedMax: false,
        videos: [],
      );

  @override
  Stream<VideosState> mapEventToState(
    VideosEvent event,
  ) async* {
    if (event is GetVideos) {
      yield* _mapEventToState();
    }
  }

  Stream<VideosState> _mapEventToState() async* {
    final HasVideos currentState = (state as HasVideos);
    if (!_hasReachedMax(state)) {
      yield HasVideos(
        isComplete: false,
        isLoading: true,
        isFailure: false,
        videos: currentState.videos,
        hasReachedMax: false,
      );
      try {
        ResponseYoutubeVideos videos = await _service.fetchAllVideosChannel(
          nextPageToken: currentState.nextPageToken,
        );
        Logger.d(currentState.nextPageToken);
        if (videos.videos.isEmpty) {
          yield (state as HasVideos).copyWith(hasReachedMax: true);
          return;
        }
        currentState.videos..addAll(videos.videos);
        yield HasVideos(
          isComplete: true,
          isLoading: false,
          isFailure: false,
          videos: currentState.videos,
          hasReachedMax: videos.totalVideo == currentState.videos.length,
          nextPageToken: videos.nextPageToken,
        );
        Logger.d(videos.nextPageToken);
      } catch (e) {
        Logger.e('Error $e', s: StackTrace.current, e: e );
        yield HasVideos(
          isComplete: true,
          isLoading: false,
          isFailure: true,
          videos: currentState.videos,
          hasReachedMax: false,
        );
        Logger.e('Error get all videos', e: e, s: StackTrace.current);
      }
    }
  }

  bool _hasReachedMax(VideosState state) =>
      state is HasVideos && state.hasReachedMax;
}
