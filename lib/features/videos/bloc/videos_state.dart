part of 'videos_bloc.dart';



abstract class VideosState extends Equatable {
  const VideosState();
  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {
  @override
  List<Object> get props => [];
}

class HasVideos extends VideosState {
  final List<Video> videos;
  final bool isLoading;
  final bool isFailure;
  final bool isComplete;
  final bool hasReachedMax;
  final String nextPageToken;

  HasVideos({
    @required this.videos,
    @required this.isComplete,
    @required this.isFailure,
    @required this.isLoading,
    @required this.hasReachedMax,
    this.nextPageToken,
  });
  
  HasVideos copyWith({
    List<Video> videos,
    bool hasReachedMax,
    bool isLoading,
    bool isFailure,
    bool isComplete,
    String nextPageToken,
  }) {
    return HasVideos(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      isComplete: isComplete ?? this.isComplete,
      videos: videos ?? this.videos,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }

  @override
  List<Object> get props => [
        videos,
        isComplete,
        isLoading,
        isFailure,
        hasReachedMax,
        nextPageToken,
      ];

  @override
  String toString() =>
      'HasVideos { videos: $videos, isLoading: $isLoading, isFailure: $isFailure, isComplete: $isComplete, hasReachedMax: $hasReachedMax, nextPagetoken: $nextPageToken }';
}
