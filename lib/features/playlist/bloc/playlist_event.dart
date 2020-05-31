part of 'playlist_bloc.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent();
  @override
  List<Object> get props => [];
}

class SetDetailPlaylist extends PlaylistEvent {
  final PlayList playlist;

  const SetDetailPlaylist(this.playlist);
}

class ResetPlaylist extends PlaylistEvent{}