import 'dart:convert';

class PicsumPhoto {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  PicsumPhoto({
    this.id = "0",
    this.author = "",
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory PicsumPhoto.fromJson(Map<String, dynamic> json) {
    return PicsumPhoto(
      id: json['id'] as String,
      author: json['author'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['url'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }
}

List<PicsumPhoto> photoListFromJson(String str) => List<PicsumPhoto>.from(json.decode(str).map((x) => PicsumPhoto.fromJson(x)));
