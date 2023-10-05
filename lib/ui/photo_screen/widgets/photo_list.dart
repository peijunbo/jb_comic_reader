import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoList extends StatelessWidget {
  final List<AssetEntity> photos;

  const PhotoList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return PhotoListItem(
          photo: photos[index],
        );
      },
    );
  }
}

class PhotoListItem extends StatelessWidget {
  final AssetEntity photo;

  const PhotoListItem({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Image(
        image: AssetEntityImageProvider(
          photo,
          isOriginal: false,
        ),
      ),
    );
  }
}