import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jb_comic_reader/common/model/picsum_photo.dart';
import 'package:jb_comic_reader/state/photo_util.dart';

class PreviewScreen extends StatefulWidget {
  static const imageItemHeight = 200.0;
  static const imageItemWidth = 200.0;

  const PreviewScreen({Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final List<PicsumPhoto> _photos = List.empty(growable: true);
  var _hasNextPage = true;
  var _pageIndex = 1;

  void addPhotos(List<PicsumPhoto> photos) {
    setState(() {
      _photos.addAll(photos);
    });
  }

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    PhotoUtil.getSamplePhotos(page: _pageIndex).then(addPhotos).catchError(
        (error) => developer.log(error.toString(), name: "PreviewScreen"));
  }

  void _nextPage() async {
    PhotoUtil.getSamplePhotos(page: _pageIndex).then((photos) {
      if (photos.isEmpty) {
        _hasNextPage = false;
      } else {
        _pageIndex++;
        addPhotos(photos);
      }
    }).catchError((error) {
      developer.log(error.toString(), name: "PreviewScreen");
    });
  }

  @override
  void dispose() {
    _photos.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverGrid.builder(
            itemCount: _photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final photo = _photos[index];
              if (index == _photos.length - 1 &&
                  _photos.isNotEmpty &&
                  _hasNextPage) {
                _nextPage();
              }
              return GestureDetector(
                  child: CachedNetworkImage(
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
                placeholder: (context, url) => const Center(
                  child: Text("Loading..."),
                ),
                key: ValueKey(photo.id),
                imageUrl: photo.downloadUrl,
                fit: BoxFit.cover,
                width: PreviewScreen.imageItemWidth,
                height: PreviewScreen.imageItemHeight,
              ));
            }),
        _hasNextPage
            ? const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("No more photos"),
                  ),
                ),
              )
      ],
      scrollDirection: Axis.vertical,
      cacheExtent: 1000,
    );
  }
}
