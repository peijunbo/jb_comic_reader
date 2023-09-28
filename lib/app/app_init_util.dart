import 'package:mmkv/mmkv.dart';

class AppInitUtil {
  static Future<String> initMmkv() async{
    return MMKV.initialize();
  }
}
