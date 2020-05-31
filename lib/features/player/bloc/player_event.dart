part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
  @override
  List<Object> get props => [];
}

class InitPlayer extends PlayerEvent{
  final PlayList playList;
  InitPlayer(this.playList);
}

class SetPlayer extends PlayerEvent{
  final Video video;
  SetPlayer(this.video);
}
