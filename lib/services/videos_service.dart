import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movpedia/model/video_model.dart';
import 'package:movpedia/utilities/keys.dart';
import 'package:movpedia/utilities/logger.dart';

class ResponseListYoutubeVideos {
  final String nextPageToken;
  final List<Video> videos;
  final int totalVideo;
  final int filteredVideos;

  ResponseListYoutubeVideos({
    @required this.nextPageToken,
    @required this.totalVideo,
    @required this.videos,
    @required this.filteredVideos,
  });
}

const String MAX_RESULTS = '5';

class VideoServices {
  VideoServices._instantiate();

  static String _baseUrl = 'www.googleapis.com';
  static final VideoServices instance = VideoServices._instantiate();

  Future<ResponseListYoutubeVideos> fetchVideosByPlaylistId({
    String playlistId,
    String nextPageToken,
  }) async {
    try {
      Map<String, String> parameters = {
        'part': 'snippet, contentDetails',
        'maxResults': MAX_RESULTS,
        'playlistId': playlistId,
        'key': API_KEY,
      };
      if (nextPageToken != null) {
        parameters['pageToken'] = nextPageToken;
      }
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      Uri uri = Uri.https(
        _baseUrl,
        '/youtube/v3/playlistItems',
        parameters,
      );
      final http.Response response = await http.get(uri, headers: headers);
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      final String nextPage = data['nextPageToken'] ?? null;
      final int totalResults = data['pageInfo']['totalResults'];

      final List<Video> videos =
          items.where((i) => i['snippet']['title'] != 'Private video').map((i) {
        return Video.fromMap(i['snippet']);
      }).toList();
      return ResponseListYoutubeVideos(
        videos: videos,
        filteredVideos: items.length - videos.length, 
        totalVideo: totalResults,
        nextPageToken: nextPage,
      );
    } catch (e) {
      Logger.w('$e');
    }
  }
}
