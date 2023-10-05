import 'package:photo_manager/photo_manager.dart';
import 'dart:developer' as developer;
Future<bool> requestMediaPermission() async {
  developer.log("start of requestMediaPermission", name: "PermissionUtil");
  final PermissionState ps = await PhotoManager.requestPermissionExtend();
  developer.log("end of requestMediaPermission: ${ps.isAuth}", name: "PermissionUtil");
  if (ps.isAuth) {
    // PhotoManager.setIgnorePermissionCheck(true);
    return true;
  } else {
    return false;
  }
}