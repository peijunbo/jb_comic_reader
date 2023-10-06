import 'package:flutter/material.dart';
import 'package:jb_comic_reader/device/permission_util.dart';
import 'package:jb_comic_reader/source_local/media/system_photo.dart';
import 'package:jb_comic_reader/ui/widgets/test_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:developer' as developer;
class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PhotoScreenState();
  }
}

class _PhotoScreenState extends State<PhotoScreen> {
  late Future<List<AssetEntity>> _devicePhotoList = getSystemPhotoList();
  List<Widget> _buildScreens() {
    return [
      FutureBuilder<List<AssetEntity>>(
          future: _devicePhotoList,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                    child: Column(
                      children: [
                        const Text('No permission'),
                        MaterialButton(
                            onPressed: () async {
                              final result = await requestMediaPermission();
                              if (result) {
                                setState(() {
                                  _devicePhotoList = getSystemPhotoList();
                                });
                              }
                            },
                            child: const Text('Request permission'))
                      ],
                    ));
              }
              final photoList = snapshot.data;

              if (photoList != null) {
                developer.log(photoList.map((e) => e.createDateTime).toList().toString(), name: "PhotoScreen");
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return PhotoGridItem(photo: photoList[index]);
                  },
                  itemCount: photoList.length,
                );
              } else {
                return const Center(child: Text('No photos'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      const Center(child: TestWidget(testMessage: 'App')),
      const Center(child: TestWidget(testMessage: 'Picsum')),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: Column(
      children: [
        const TabBar(
          tabs: [
            Tab(text: 'Device'),
            Tab(text: 'App'),
            Tab(text: 'Picsum'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: _buildScreens(),
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
