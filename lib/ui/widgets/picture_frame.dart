import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jb_comic_reader/common/model/picsum_photo.dart';
import 'package:photo_manager/photo_manager.dart';

class PictureFrame extends StatelessWidget {
  const PictureFrame({super.key, this.photo});

  final dynamic photo;

  @override
  Widget build(BuildContext context) {
    switch (photo.runtimeType) {
      case PicsumPhoto:
        return CachedNetworkImage(
            imageUrl: photo.downloadUrl, fit: BoxFit.cover);
      case AssetEntity:
        return AssetEntityImage(photo, fit: BoxFit.cover);
      default:
        return Container();
    }
  }
}
