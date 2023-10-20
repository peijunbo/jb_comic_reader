/// The destination of go_router's routes.
///
/// [NavLocation.photo] is the page show photos of system album and app album.
/// [NavLocation.album] is the page show albums of system album and app album.
/// [NavLocation.find] is the page show directories of device and app data.
/// [NavLocation.list] is the page show photos to be read.
/// [NavLocation.none] is an invalid destination.
enum NavLocation {
  photo(path: '/photo'),
  album(path: '/album'),
  find(path: '/find'),
  none(path: '/none');

  final String path;

  const NavLocation({required this.path});

  static NavLocation fromPath(String path) =>
      NavLocation.values.firstWhere((element) => element.path == path,
          orElse: () => NavLocation.none);
}
