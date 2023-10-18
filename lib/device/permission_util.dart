import 'package:photo_manager/photo_manager.dart';

Future<bool> requestMediaPermission() async {
  final PermissionState ps = await PhotoManager.requestPermissionExtend();
  if (ps.isAuth) {
    // PhotoManager.setIgnorePermissionCheck(true);
    return true;
  } else {
    return false;
  }
}
