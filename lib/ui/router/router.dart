import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jb_comic_reader/ui/album_screen/album_screen.dart';
import 'package:jb_comic_reader/ui/home_page/home_page.dart';
import 'package:jb_comic_reader/ui/photo_screen/photo_screen.dart';
import 'package:jb_comic_reader/ui/preview_screen/preview_screen.dart';
import 'package:jb_comic_reader/ui/router/location.dart';
import 'package:jb_comic_reader/ui/widgets/test_widget.dart';

final _rootKey = GlobalKey<NavigatorState>();
final goRouter = GoRouter(
  initialLocation: NavLocation.photo.path,
  navigatorKey: _rootKey,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: NavLocation.photo.path,
              builder: (context, state) => const PhotoScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavLocation.album.path,
            builder: (context, state) => const AlbumScreen(),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: NavLocation.find.path,
            builder: (context, state) => const PreviewScreen(),
          )
        ])
      ],
      pageBuilder: (context, state, navigationShell) => NoTransitionPage(
        child: HomePage(navigationShell: navigationShell),
      ),
    ),
  ],
);
