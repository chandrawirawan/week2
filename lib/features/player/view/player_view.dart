import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpedia/features/player/bloc/player_bloc.dart';
import 'package:movpedia/model/playlist_model.dart';
import 'package:movpedia/model/video_model.dart';
import 'package:movpedia/theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt;

class PlayerView extends StatelessWidget {
  final List<Video> videos;
  const PlayerView({Key key, this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _blocPlayer = BlocProvider.of<PlayerBloc>(context);
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      double height = MediaQuery.of(context).size.height * 0.27;
      if (state is HasPlayer) {
        if (state.video != null) {
          height = MediaQuery.of(context).size.height * 0.38;
        }
        return Container(
            height: height,
            width: double.infinity,
            child: (state.playlist != null && state.video == null)
                ? Column(children: [
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 40,
                            left: 15,
                            right: 15,
                            bottom: 15,
                          ),
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: double.infinity,
                          color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                state.playlist.title,
                                style: AppTheme.headingBoldBright,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -25,
                          child: RawMaterialButton(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10),
                            elevation: 2.0,
                            fillColor: videos.isEmpty ? AppTheme.colorTextDisabled : AppTheme.colorPrimary,
                            onPressed: () {
                              if(videos.isNotEmpty) {
                                _blocPlayer.add(SetPlayer(videos.first));
                              }
                            },
                            child: Icon(Icons.play_arrow,
                                size: 40, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 90,
                        top: 10,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            state.playlist.description,
                            style: AppTheme.regularText,
                          ),
                        ],
                      ),
                    ),
                  ])
                : YoutubePlaying(state.video, videos, state.playlist));
      }
      return SizedBox(
        width: 0,
      );
    });
  }
}

class YoutubePlaying extends StatefulWidget {
  final Video video;
  final PlayList playlist;
  final List<Video> videos;

  

  YoutubePlaying(this.video, this.videos, this.playlist);

  @override
  _YoutubePlayingState createState() => _YoutubePlayingState();
}

class _YoutubePlayingState extends State<YoutubePlaying> {
  yt.YoutubePlayerController _controller;
  PlayerBloc _blocPlayer;
  bool _isPlayerReady = false;

  void _initVideo() {
    super.initState();
    _controller = yt.YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: yt.YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {}
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void didUpdateWidget(YoutubePlaying oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.video.id != null && _isPlayerReady) {
      _controller.pause();
      _controller.load(widget.video.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _blocPlayer = BlocProvider.of<PlayerBloc>(context);
    _initVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          yt.YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppTheme.colorLightGreen,
            topActions: <Widget>[
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (e) {
              _blocPlayer.add(InitPlayer(widget.playlist));
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(
              widget.video.title,
              style: AppTheme.headingBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
