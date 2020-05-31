import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movpedia/features/all_playlist/bloc/all_playlist_bloc.dart';
import 'package:movpedia/features/player/bloc/player_bloc.dart';
import 'package:movpedia/features/playlist/view/playlist_view.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/ui/home_screen_card.dart';

class AllPlaylist extends StatefulWidget {
  @override
  _AllPlaylistState createState() => _AllPlaylistState();
}

class _AllPlaylistState extends State<AllPlaylist> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<AllPlaylistBloc>(context).add(GetAllPlaylist());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<AllPlaylistBloc>(context).add(GetAllPlaylist());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPlaylistBloc, AllPlaylistState>(builder: (
      BuildContext bloccontext,
      AllPlaylistState state,
    ) {
      if (state is HasAllPlaylist && state.allPlaylist.isNotEmpty) {
        return ListView.builder(
          itemCount: state.hasReachedMax
              ? state.allPlaylist.length
              : state.allPlaylist.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return index >= state.allPlaylist.length
                ? SpinKitDoubleBounce(color: AppTheme.colorPrimary)
                : GestureDetector(
                    onTap: () {
                      BlocProvider.of<PlayerBloc>(context).add(InitPlayer(state.allPlaylist[index]));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PlaylistView(playlist: state.allPlaylist[index],),
                        ),
                      );
                    },
                    child: HomeScreenCard(
                      title: state.allPlaylist[index].title,
                      thumbnails: state.allPlaylist[index].thumbnailUrl,
                      description: state.allPlaylist[index].description,
                    ),
                  );
          },
          controller: _scrollController,
        );
      }
      return SpinKitDoubleBounce(color: AppTheme.colorPrimary);
    });
  }
}
