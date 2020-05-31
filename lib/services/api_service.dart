import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:movpedia/features/all_playlist/bloc/all_playlist_bloc.dart';
import 'package:movpedia/features/videos/bloc/videos_bloc.dart';
import 'package:movpedia/model/channel_model.dart';
import 'package:movpedia/model/playlist_model.dart';
import 'package:movpedia/model/video_model.dart';
import 'package:movpedia/utilities/keys.dart';
import 'package:movpedia/utilities/logger.dart';

const String MAX_RESULTS = '5';

class APIService {
  final CollectionReference playlistsCollection =
      Firestore.instance.collection('playlists');
  APIService._instantiate();

  static String _baseUrl = 'www.googleapis.com';
  static final APIService instance = APIService._instantiate();
  static final client = new http.Client();

  Future<Channel> fetchChannel() async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': CHANNEL_ID,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<ResponseYoutubeVideos> fetchVideosFromPlaylist(
      {String playlistId, String nextPageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': MAX_RESULTS,
      'key': API_KEY,
    };
    if (nextPageToken != null) {
      parameters['pageToken'] = nextPageToken;
    }
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final nextPageToken = data['nextPageToken'] ?? null;
      final totalResults = data['pageInfo']['totalResults'];
      List<dynamic> videosJson = data['items'];

      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json),
        ),
      );
      return ResponseYoutubeVideos(
          nextPageToken: nextPageToken,
          videos: videos,
          totalVideo: totalResults);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<ResponseYoutubeVideos> fetchAllVideosChannel(
      {String nextPageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'channelId': CHANNEL_ID,
      'maxResults': MAX_RESULTS,
      'key': API_KEY,
      'type': 'video',
    };
    if (nextPageToken != null) {
      parameters['pageToken'] = nextPageToken;
    }
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final nextPageToken = data['nextPageToken'] ?? null;
      final totalResults = data['pageInfo']['totalResults'];
      List<dynamic> videosJson = data['items'];

      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMapAllVideos(json),
        ),
      );
      return ResponseYoutubeVideos(
          nextPageToken: nextPageToken,
          videos: videos,
          totalVideo: totalResults);
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future fetchPlaylistById() async {}

  Future fetchAllPlatlistByIds(List<String> playlistIds) async {
    List<Future<http.Response>> listAwait = playlistIds.map((id) {
      Map<String, String> parameters = {
        'part': 'snippet,ContentDetails',
        'maxResults': '50',
        'playlistId': id,
        'key': API_KEY,
      };
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      Uri uri = Uri.https(
        _baseUrl,
        '/youtube/v3/playlistItems',
        parameters,
      );
      return http.get(uri, headers: headers);
    }).toList();

    final futureList = await Future.wait(listAwait);

    final List<PlayList> playlist = futureList.fold([], (acc, cur) {
      final PlayList playlist = PlayList.fromMap(json.decode(cur.body));
      acc.add(playlist);
      return acc;
    });
    print(playlist);
  }

  Future<ResponseYoutubePlaylist> fetchAllPlaylistChannel({String lastItem}) async {
      ResponseYoutubePlaylist response;
    try {
      final List<DocumentSnapshot> list =
          (await playlistsCollection
          .limit(int.parse(MAX_RESULTS))
          .orderBy('id')
          .startAfter([lastItem])
          .getDocuments()).documents;
      
      List<Future<http.Response>> listAwait = list.map((e) {
        Map<String, String> parameters = {
          'part': 'snippet, contentDetails',
          'maxResults': MAX_RESULTS,
          'id': e.data['id'],
          'key': API_KEY,
        };
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: 'application/json',
        };
        Uri uri = Uri.https(
          _baseUrl,
          '/youtube/v3/playlists',
          parameters,
        );
        return http.get(uri, headers: headers);
      }).toList();

      final List futureList = await Future.wait(listAwait);
      final List<PlayList> playlist = futureList.fold([], (acc, cur) {

        final PlayList playlist =
            PlayList.fromMap(json.decode(cur.body)['items'][0]);
        acc.add(playlist);
        return acc;
      });


      String nextLastItem;
      if (playlist.length > 0) {
        nextLastItem = list[list.length - 1]['id'] ?? null;
      }

      response = ResponseYoutubePlaylist(
        totalPlaylist: list.length,
        allPlaylist: playlist,
        lastItem: nextLastItem,
      );
    } catch (e) {
      Logger.e('ERROR GET fetchAllPlaylistChannel:', e: e, s: StackTrace.current);
      return throw Exception(e);
    }
    return response;
  }
}
