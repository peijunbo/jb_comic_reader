import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jb_comic_reader/common/model/local_photo.dart';
import 'package:jb_comic_reader/state/system_photo_provider.dart';
import 'package:jb_comic_reader/ui/photo_screen/views/photo_grid_seperated.dart';
import 'package:jb_comic_reader/ui/widgets/test_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_screen.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }
}

class PhotoScreen extends ConsumerWidget {
  const PhotoScreen({super.key});

  List<Widget> _buildScreens(BuildContext context,WidgetRef ref) {
    final systemPhotos = ref.watch(systemPhotoProvider);
    return [
      systemPhotos.when(
          data: (photoList) {
            developer.log(
                photoList.map((e) => e.createDateTime).toList().toString(),
                name: "PhotoScreen");
            photoList.sort((a, b) => b.createDateTime.compareTo(a.createDateTime));
            final photos = photoList.map((e) => AssetEntityPhoto(e)).toList();
            return PhotoGridSeparated(photos: photos);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("No permission"),
                    MaterialButton(
                        color: Theme.of(context).colorScheme.errorContainer,
                        onPressed: () async {
                          ref.read(systemPhotoProvider.notifier).refresh();
                        },
                        child: const Text('Request permission'))
                  ],
                ),
              )),
      const Center(child: TestWidget(testMessage: 'App')),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Device'),
                Tab(text: 'App'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: _buildScreens(context, ref),
              ),
            ),
          ],
        ));
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
