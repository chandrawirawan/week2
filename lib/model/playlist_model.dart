class PlayList {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final int totalVideos;
  final List<String> videoIds;

  PlayList({
    this.id,
    this.title,
    this.description,
    this.thumbnailUrl,
    this.totalVideos,
    this.videoIds,
  });

  factory PlayList.fromMap(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    return PlayList(
      id: json['id'],
      title: snippet['title'],
      description: snippet['description'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      totalVideos: json['contentDetails']['itemCount'],
    );
  }
}
