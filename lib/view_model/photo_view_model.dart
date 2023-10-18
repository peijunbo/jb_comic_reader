import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jb_comic_reader/common/model/picsum_photo.dart';
import 'package:jb_comic_reader/config.dart' as config;
import 'package:jb_comic_reader/source_local/media/system_photo.dart';
import 'package:photo_manager/photo_manager.dart';

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

  late Future<List<AssetEntity>> devicePhotoList = getSystemPhotoList();
  void loadDevicePhotoList() async {
    devicePhotoList = getSystemPhotoList();
  }
}

final photoViewModelProvider = Provider((ref) => PhotoViewModel());