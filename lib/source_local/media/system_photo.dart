import 'package:photo_manager/photo_manager.dart';
import 'dart:developer' as developer;

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
  final photos = await PhotoManager.getAssetListRange(
      start: start, end: end ?? await PhotoManager.getAssetCount(), type: type).catchError( (e) {
        developer.log("cannot get photo list", name: "getSystemPhotoList", error: e);
        return <AssetEntity>[];
      });
  if (sortDesc) {
    photos.sort((a, b) => b.createDateTime.compareTo(a.createDateTime));
  }
  return photos;
}
