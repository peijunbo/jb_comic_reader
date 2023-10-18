import 'package:flutter/services.dart';
import 'package:jb_comic_reader/device/permission_util.dart';
import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> getSystemAlbumList({
  bool hasAll = false,
  bool onlyAll = false,
  RequestType type = RequestType.image,
}) async {
  return PhotoManager.getAssetPathList(
    hasAll: false,
    type: RequestType.image,
  );
}

/// Get system photo list
///
/// [start] start index
/// [end] end index
/// [type] RequestType
/// [sortDesc] sort by createDateTime desc
Future<List<AssetEntity>> getSystemPhotoList(
    {int start = 0,
    int? end,
    RequestType type = RequestType.image,
    bool sortDesc = true}) async {
  final permitted = await requestMediaPermission();
  if (!permitted) {
    throw PlatformException(code: "No permission");
  }

  final assetCount = await PhotoManager.getAssetCount();
  if (assetCount == 0) {
    return [];
  }
  final photos = await PhotoManager.getAssetListRange(
      start: start, end: end ?? assetCount, type: type);
  if (sortDesc) {
    photos.sort((a, b) => b.createDateTime.compareTo(a.createDateTime));
  }
  return photos;
}
