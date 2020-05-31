import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpedia/features/videos/bloc/videos_bloc.dart';
import 'package:movpedia/ui/home_screen_card.dart';

class AllVideos extends StatefulWidget {
  @override
  _AllVideosState createState() => _AllVideosState();
}

class _AllVideosState extends State<AllVideos> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<VideosBloc>(context).add(GetVideos());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<VideosBloc>(context).add(GetVideos());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
        builder: (BuildContext bloccontext, VideosState state) {
      if (state is HasVideos && state.videos.isNotEmpty) {
        return ListView.builder(
          itemCount: state.hasReachedMax
              ? state.videos.length
              : state.videos.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return index >= state.videos.length
                ? Text('loading')
                : GestureDetector(
                    onTap: () {
                      
                    },
                    child: HomeScreenCard(
                      title: state.videos[index].title,
                      thumbnails: state.videos[index].thumbnailUrl,
                      description: state.videos[index].description,
                    ),
                  );
          },
          controller: _scrollController,
        );
      }
      return Text('Loading...');
    });
  }
}
