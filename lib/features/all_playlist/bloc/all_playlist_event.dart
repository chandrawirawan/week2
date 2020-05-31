part of 'all_playlist_bloc.dart';

abstract class AllPlaylistEvent extends Equatable {
  const AllPlaylistEvent();
  @override
  List<Object> get props => [];
}

class GetAllPlaylist extends AllPlaylistEvent {
  
}