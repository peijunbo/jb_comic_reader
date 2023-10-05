import 'package:flutter/material.dart';
import 'package:jb_comic_reader/source_local/media/system_photo.dart';
import 'package:jb_comic_reader/ui/photo_screen/widgets/photo_list.dart';
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
  final _photos = <AssetEntity>[];
  List<Widget> _buildScreens() {
    return [
      Center(child:  PhotoList(photos: _photos)),
      const Center(child: TestWidget(testMessage: 'App')),
      const Center(child: TestWidget(testMessage: 'Picsum')),
    ];
  }
  void getPhotos() async {
    developer.log("getPhotos", name: "PhotoScreen");
    final albumList = await getSystemAlbumList().catchError((e) {
      developer.log(e.toString(), name: "PhotoScreen", error: e);
      return <AssetPathEntity>[];
    });
    developer.log("getPhotos albumList: ${albumList.length}", name: "PhotoScreen");
    final photos = <AssetEntity>[];
    for (final album in albumList) {
      final assetList = await album.getAssetListRange(start: 0, end: await album.assetCountAsync);
      photos.addAll(assetList);
      developer.log("getPhotos album: ${album.name} assetList: ${assetList.length}", name: "PhotoScreen");
    }
    setState(() {
      _photos.addAll(photos);
    });
  }
  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
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
            )));
  }
}
