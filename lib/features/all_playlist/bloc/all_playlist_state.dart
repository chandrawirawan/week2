part of 'all_playlist_bloc.dart';



abstract class AllPlaylistState extends Equatable {
  const AllPlaylistState();
  @override
  List<Object> get props => [];
}

class PlaylistInitial extends AllPlaylistState {
  @override
  List<Object> get props => [];
}

class HasAllPlaylist extends AllPlaylistState {
  final List<PlayList> allPlaylist;
  final bool isLoading;
  final bool isFailure;
  final bool isComplete;
  final bool hasReachedMax;
  final String lastItem;

  HasAllPlaylist({
    @required this.allPlaylist,
    @required this.isComplete,
    @required this.isFailure,
    @required this.isLoading,
    @required this.hasReachedMax,
    this.lastItem,
  });
  
  HasAllPlaylist copyWith({
    List<PlayList> allPlaylist,
    bool hasReachedMax,
    bool isLoading,
    bool isFailure,
    bool isComplete,
    String lastItem,
  }) {
    return HasAllPlaylist(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      isFailure: isFailure ?? this.isFailure,
      isComplete: isComplete ?? this.isComplete,
      allPlaylist: allPlaylist ?? this.allPlaylist,
      lastItem: lastItem ?? this.lastItem,
    );
  }

  @override
  List<Object> get props => [
        allPlaylist,
        isComplete,
        isLoading,
        isFailure,
        hasReachedMax,
        lastItem,
      ];

  @override
  String toString() =>
      'HasAllPlaylist { allPlaylist: $allPlaylist, isLoading: $isLoading, isFailure: $isFailure, isComplete: $isComplete, hasReachedMax: $hasReachedMax, nextPagetoken: $lastItem }';
}
