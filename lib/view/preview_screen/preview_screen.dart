import 'package:flutter/material.dart';
import 'package:jb_comic_reader/bean/picsum_photo.dart';
import 'package:jb_comic_reader/view_model/photo_view_model.dart';
import 'dart:developer' as developer;
class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}
class _PreviewScreenState extends State<PreviewScreen> {
  final List<PicsumPhoto> _photos = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    PhotoViewModel.getSamplePhotos()
        .then((photos) => _photos.addAll(photos))
        .catchError((error) => developer.log(error.toString(), name: "PreviewScreen"));
  }
  @override
  void dispose() {
    _photos.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return photoGridList();
  }

  Widget photoGridList() {
    return GridView.builder(
        itemCount: _photos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {},
            child: Hero(
              tag: _photos[index].id,
              child: Image.network(
                _photos[index].downloadUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        }
    );
  }
}