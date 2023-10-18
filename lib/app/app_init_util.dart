import 'package:mmkv/mmkv.dart';
void initApp() async {
  await _initMmkv();

}

Future<String> _initMmkv() async {
  return MMKV.initialize();
}

void initPhotoManager() {
  // TODO: implement initPhotoManager
}