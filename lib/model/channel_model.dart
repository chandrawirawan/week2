import 'package:movpedia/model/video_model.dart';

class Channel {
  final String id;
  final String title;
  final String profilePictureUrl;
  final String subscriberCount;
  // final String uploadPlaylistId;
  final String videoCount;
  List<Video> videos;

  Channel({
    this.id,
    this.title,
    this.profilePictureUrl,
    this.subscriberCount,
    // this.uploadPlaylistId,
    this.videoCount,
  });

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      // uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  }
}
