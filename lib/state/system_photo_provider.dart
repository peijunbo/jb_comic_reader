import 'package:flutter/services.dart';
import 'package:jb_comic_reader/source_local/media/system_photo.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_photo_provider.g.dart';

@riverpod
class SystemPhoto extends _$SystemPhoto {
  @override
  Future<List<AssetEntity>> build() async {
    return getSystemPhotoList();
  }

  refresh() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await getSystemPhotoList());
    } on PlatformException catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}