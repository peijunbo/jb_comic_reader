import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jb_comic_reader/bean/picsum_photo.dart';
import 'package:jb_comic_reader/config.dart' as config;
import 'dart:developer' as developer;
class PhotoViewModel {
  static Future<List<PicsumPhoto>> getSamplePhotos() async {
    List<PicsumPhoto> photos = [];
    final response = await http.get(Uri.parse(config.picsumBaseUrl + config.picsumPhotoList));
    if (response.statusCode == 200) {
      developer.log(response.body, name: "PhotoViewModel");
      final photoRes = json.decode(response.body) as List<dynamic>;
      photos = photoRes.map((e) => PicsumPhoto.fromJson(e)).toList();
    }
    developer.log("getSamplePhotos ${photos.toString()}", name: "PhotoViewModel");
    return photos;
  }

}