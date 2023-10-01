/// The destination of go_router's routes.
///
/// [Destination.photo] is the page show photos of system album and app album.
/// [Destination.album] is the page show albums of system album and app album.
/// [Destination.find] is the page show photos from [Picsum](https://picsum.photos/).
/// [Destination.favorite] is the page show favorite photos.
/// [Destination.none] is an invalid destination.
enum Destination {
  photo(path: '/photo'),
  album(path: '/album'),
  find(path: '/find'),
  favorite(path: '/favorite'),
  settings(path: '/settings'),
  none(path: '/none');

  final String path;

  const Destination({required this.path});

  static Destination fromPath(String path) =>
      Destination.values.firstWhere((element) => element.path == path,
          orElse: () => Destination.none);
}
