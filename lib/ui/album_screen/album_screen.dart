import 'package:flutter/material.dart';
import 'package:jb_comic_reader/device/permission_util.dart';
import 'package:jb_comic_reader/source_local/media/system_photo.dart';
import 'package:jb_comic_reader/ui/album_screen/widgets/album_list.dart';

import 'package:jb_comic_reader/ui/widgets/test_widget.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:developer' as developer;

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AlbumScreenState();
  }
}

class _AlbumScreenState extends State<AlbumScreen> {
  late Future<List<AssetPathEntity>> _albumList = getSystemAlbumList();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background,
        child: FutureBuilder<List<AssetPathEntity>>(
            future: _albumList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  developer.log(snapshot.error.toString(), name: "PhotoScreen");
                  return Center(
                      child: Column(
                    children: [
                      const Text('No permission'),
                      MaterialButton(
                          onPressed: () async {
                            final result = await requestMediaPermission();
                            if (result) {
                              setState(() {
                                _albumList = getSystemAlbumList();
                              });
                            }
                          },
                          child: const Text('Request permission'))
                    ],
                  ));
                }
                final albumList = snapshot.data;
                if (albumList != null) {
                  return AlbumList(pathList: albumList);
                } else {
                  return const Center(child: Text('No photos'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
