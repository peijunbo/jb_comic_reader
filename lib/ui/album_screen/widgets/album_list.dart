import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumList extends StatelessWidget {
  final List<AssetPathEntity> pathList;

  const AlbumList({Key? key, required this.pathList}) : super(key: key);

  List<Widget> _buildWidgets() {
    final widgets = <Widget>[];
    for (final path in pathList) {
      widgets.add(SliverToBoxAdapter(
        child: Row(
          children: [
            Text(path.name),
            FutureBuilder(
                future: path.assetCountAsync,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final count = snapshot.data;
                    if (count != null) {
                      return Text(' ($count)');
                    } else {
                      return const Text(' (0)');
                    }
                  } else {
                    return const Text(' (0)');
                  }
                }),
          ],
        ),
      ));
      widgets.add(
        FutureBuilder<List<AssetEntity>>(
          future: path.getAssetListRange(start: 0, end: 100),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final photos = snapshot.data;
              if (photos != null) {
                return PhotoGrid(photos: photos);
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No photos'),
                  ),
                );
              }
            } else {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(8),
        child: CustomScrollView(
          slivers: _buildWidgets(),
        ));
  }
}

class PhotoGrid extends StatelessWidget {
  final List<AssetEntity> photos;

  const PhotoGrid({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(4),
              child: PhotoGridItem(
                  key: ValueKey(photos[index].id), photo: photos[index]));
        });
  }
}

class PhotoGridItem extends StatelessWidget {
  final AssetEntity photo;

  const PhotoGridItem({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.cover,
      width: 200,
      height: 200,
      image: AssetEntityImageProvider(
        photo,
        isOriginal: false,
      ),
    );
  }
}
