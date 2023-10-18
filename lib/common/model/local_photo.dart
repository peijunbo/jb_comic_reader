import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

sealed class LocalPhoto {
  DateTime get createDateTime;
  String get id;
  // 获取图片文件
  Future<File?> get file;
}

class AssetEntityPhoto extends LocalPhoto {
  final AssetEntity assetEntity;

  AssetEntityPhoto(this.assetEntity);

  @override
  DateTime get createDateTime => assetEntity.createDateTime;

  @override
  String get id => assetEntity.id;

  @override
  Future<File?> get file => assetEntity.originFile;

  factory AssetEntityPhoto.fromAssetEntity(AssetEntity assetEntity) {
    return AssetEntityPhoto(assetEntity);
  }
}
