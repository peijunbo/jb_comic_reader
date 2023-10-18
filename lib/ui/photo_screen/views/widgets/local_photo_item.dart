import 'package:flutter/material.dart';
import 'package:jb_comic_reader/common/model/local_photo.dart';
import 'package:photo_manager/photo_manager.dart';

class LocalPhotoItem extends StatelessWidget {
  final LocalPhoto photo;

  const LocalPhotoItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (photo) {
      case AssetEntityPhoto assetEntityPhoto:
        return AssetEntityImage(assetEntityPhoto.assetEntity,
            fit: BoxFit.cover);
    }
  }
}
