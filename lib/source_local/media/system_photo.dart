import 'package:jb_comic_reader/device/permission_util.dart';
import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> getSystemAlbumList() async{
  await requestMediaPermission();
  return PhotoManager.getAssetPathList(
    onlyAll: true,
    type: RequestType.image,
  );
}