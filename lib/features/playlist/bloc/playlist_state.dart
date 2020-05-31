part of 'playlist_bloc.dart';

abstract class PlaylistState extends Equatable {
  const PlaylistState();
}

class InitialPlaylist extends PlaylistState {
  final List<Video> videos;
  final bool isLoading;
  final bool isFailure;
  final bool isComplete;

  InitialPlaylist({
    @required this.videos,
    @required this.isComplete,
    @required this.isFailure,
    @required this.isLoading,
  });

  @override
  List<Object> get props => [
    videos,
    isLoading,
    isFailure,
    isComplete,
  ];

  @override
  String toString() =>
      'InitialPlaylist { isLoading: $isLoading, isFailure: $isFailure, isComplete: $isComplete }';
}

class HasPlaylist extends PlaylistState {
  final PlayList playlist;
  final List<Video> videos;
  final String nextPageToken;
  final int totalVideo;
  final bool isLoading;
  final bool isFailure;
  final bool isComplete;
  final bool hasReachedMax;
  final int filteredVideos;

  HasPlaylist({
    @required this.videos,
    @required this.isComplete,
    @required this.isFailure,
    @required this.isLoading,
    @required this.hasReachedMax,
    this.totalVideo,
    this.playlist,
    this.nextPageToken,
    this.filteredVideos,
  });

  HasPlaylist copyWith({
    PlayList playlist,
    List<Video> videos,
    String nextPageToken,
    int totalVideo,
    bool isLoading,
    bool isFailure,
    bool isComplete,
    bool hasReachedMax,
    int filteredVideos,
  }) {
    return HasPlaylist(
      playlist: playlist ?? this.playlist,
      videos: videos ?? this.videos,
      nextPageToken: nextPageToken ?? this.nextPageToken,
      totalVideo: totalVideo ?? this.totalVideo,
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      isComplete: isComplete ?? this.isComplete,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filteredVideos: 0,
    );
  }

  @override
  List<Object> get props => [
    playlist,
    videos,
    nextPageToken,
    totalVideo,
    isLoading,
    isFailure,
    isComplete,
    hasReachedMax,
  ];

  @override
  String toString() =>
      'HasPlaylist { playlist: $playlist, playlist: $playlist, isLoading: $isLoading, isFailure: $isFailure, isComplete: $isComplete, hasReachedMax: $hasReachedMax, nextPagetoken: $nextPageToken, hasReachedMax: $hasReachedMax }';
}
