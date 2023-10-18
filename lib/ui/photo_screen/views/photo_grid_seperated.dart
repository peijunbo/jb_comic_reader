import 'package:flutter/material.dart';
import 'package:jb_comic_reader/common/model/local_photo.dart';
import 'package:jb_comic_reader/ui/photo_screen/views/widgets/local_photo_item.dart';

class PhotoGridSeparated extends StatelessWidget {
  const PhotoGridSeparated({super.key, required this.photos});

  final List<LocalPhoto> photos;

  /// Separate photos by date, photos in the same date will be grouped together
  List<List<LocalPhoto>> separatePhotosByDate() {
    final separatedPhotos = <List<LocalPhoto>>[];
    if (photos.isNotEmpty) {
      var currentPhotos = <LocalPhoto>[];
      var currentDate = photos[0].createDateTime;
      for (var photo in photos) {
        if (photo.createDateTime.difference(currentDate).inDays > 0) {
          separatedPhotos.add(currentPhotos);
          currentPhotos = <LocalPhoto>[];
          currentDate = photo.createDateTime;
        }
        currentPhotos.add(photo);
      }
      separatedPhotos.add(currentPhotos);
    }
    return separatedPhotos;
  }

  List<Widget> _buildWidgets() {
    final widgets = <Widget>[];
    final separatedPhotos = separatePhotosByDate();
    // show photos separated by date
    for (final photos in separatedPhotos) {
      widgets.add(SliverToBoxAdapter(
        child: Text(photos[0].createDateTime.day == DateTime.now().day
            ? "Today"
            : photos[0].createDateTime.day.toString()),
      ));
      widgets.add(SliverGrid.builder(
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return LocalPhotoItem(photo: photos[index]);
        },
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _buildWidgets(),
    );
  }
}
