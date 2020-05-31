import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movpedia/features/player/bloc/player_bloc.dart';
import 'package:movpedia/features/player/view/player_view.dart';
import 'package:movpedia/features/playlist/bloc/playlist_bloc.dart';
import 'package:movpedia/model/playlist_model.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/ui/layout/standard_layout.dart';
import 'package:movpedia/ui/playlist_card.dart';

class PlaylistView extends StatefulWidget {
  static String routeName = '/playlist';
  final PlayList playlist;
  PlaylistView({this.playlist});

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  PlayerBloc _blocPlayer;
  PlaylistBloc _blocPlaylist;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _blocPlaylist.add(SetDetailPlaylist(widget.playlist));
    }
  }

  @override
  void initState() {
    super.initState();
    _blocPlayer = BlocProvider.of<PlayerBloc>(context);
    _blocPlaylist = BlocProvider.of<PlaylistBloc>(context);
    _scrollController.addListener(_onScroll);
    _blocPlaylist.add(ResetPlaylist());
    _blocPlaylist.add(SetDetailPlaylist(widget.playlist));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (
      ctxPlayer,
      statePlayer,
    ) {
      String idPlayer = '';
      String title = '';
      if (statePlayer is HasPlayer && statePlayer.video != null) {
        idPlayer = statePlayer.video.id;
      }
      if (statePlayer is HasPlayer && statePlayer.video != null) {
        title = statePlayer.playlist.title;
      }
      return StandardLayout(
        appBar: statePlayer is HasPlayer && statePlayer.video != null,
        backButtonAppBar: statePlayer is HasPlayer && statePlayer.video != null,
        appBarTitle: Padding(
          padding: const EdgeInsets.only(top: 0, left: 0),
          child: Text(
            title,
            style: AppTheme.headingBold,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        bottomBar: true,
        bodyWidget: BlocBuilder<PlaylistBloc, PlaylistState>(builder: (
          ctx,
          state,
        ) {
          if (state is HasPlaylist) {
            return Column(
              children: [
                PlayerView(videos: state.videos.isEmpty ? [] : state.videos ),
                Expanded(
                  child: (state.videos.isNotEmpty)
                      ? ListView.builder(
                          itemCount: state.hasReachedMax
                              ? state.videos.length
                              : state.videos.length + 1,
                          itemBuilder: (BuildContext c, int index) {
                            return index >= state.videos.length
                                ? SpinKitDoubleBounce(
                                    color: AppTheme.colorPrimary)
                                : PlaylistCard(
                                    onPlayButtonPressed: (String id) {
                                      _blocPlayer
                                          .add(SetPlayer(state.videos[index]));
                                    },
                                    isPlayed:
                                        idPlayer == state.videos[index].id,
                                    id: state.videos[index].id,
                                    exerciseNumber: index + 1,
                                    title: state.videos[index].title,
                                    thumbnails:
                                        state.videos[index].thumbnailUrl,
                                    description:
                                        state.videos[index].description,
                                  );
                          },
                          controller: _scrollController,
                        )
                      : SpinKitDoubleBounce(color: AppTheme.colorPrimary),
                ),
              ],
            );
          }
          return SizedBox(
            width: 0,
          );
        }),
      );
    });
  }
}
