import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movpedia/model/playlist_model.dart';
import 'package:movpedia/model/video_model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  @override
  PlayerState get initialState => PlayerInitial();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is SetPlayer) {
      yield* _mapSetPlayerToState(event.video);
    } else if (event is InitPlayer) {
      yield* _mapInitPlayerToState(event.playList);
    }
  }

  Stream<PlayerState> _mapSetPlayerToState(video) async* {
    final HasPlayer currentState = (state as HasPlayer);
    yield HasPlayer(video: video, playlist: currentState.playlist);
  }

  Stream<PlayerState> _mapInitPlayerToState(playlist) async* {
    yield HasPlayer(playlist: playlist);
  }
}
