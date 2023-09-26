import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jb_comic_reader/common/model/picsum_photo.dart';
import 'package:jb_comic_reader/config.dart' as config;

class PhotoViewModel {
  static Future<List<PicsumPhoto>> getSamplePhotos(
      {int? page, int limit = 50}) async {
    List<PicsumPhoto> photos = [];
    final response = await http.get(Uri.https(
        config.picsumDomain,
        config.picsumPhotoList,
        {"page": page?.toString() ?? "1", "limit": limit.toString()}));
    if (response.statusCode == 200) {
      final photoRes = json.decode(response.body) as List<dynamic>;
      photos = photoRes.map((e) => PicsumPhoto.fromJson(e)).toList();
    }
    return photos;
  }
}
