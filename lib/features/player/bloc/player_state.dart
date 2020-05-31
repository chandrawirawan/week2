part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  // const PlayerState() : super();
}

class PlayerInitial extends PlayerState {
  @override
  List<Object> get props => [];
}

class HasPlayer extends PlayerInitial {
  final PlayList playlist;
  final Video video;
  HasPlayer({ this.playlist, this.video }) : super();

  HasPlayer copyWith({
    PlayList playlist,
    List<Video> video,
  }) {
    return HasPlayer(
      playlist: playlist ?? this.playlist,
      video: video ?? this.video,
    );
  }

  List<Object> get props => [
    playlist,
    video,
  ];
}