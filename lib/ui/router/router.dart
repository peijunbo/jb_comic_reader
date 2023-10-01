import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jb_comic_reader/ui/router/location.dart';
import 'package:jb_comic_reader/ui/widgets/home_bottom_bar.dart';
import 'package:jb_comic_reader/ui/widgets/test_widget.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();
final goRouter = GoRouter(
  initialLocation: Destination.photo.path,
  navigatorKey: _rootKey,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: Destination.photo.path,
              builder: (context, state) =>
                  const TestWidget(testMessage: "Photo"))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Destination.album.path,
            builder: (context, state) => const TestWidget(testMessage: "Album"),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Destination.find.path,
            builder: (context, state) => const TestWidget(testMessage: "Find"),
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Destination.favorite.path,
            builder: (context, state) =>
                const TestWidget(testMessage: "Favorite"),
          )
        ]),
      ],
      pageBuilder: (context, state, navigationShell) => NoTransitionPage(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('JB Comic Reader'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(
                onPressed: () =>
                    context.push(Destination.settings.path),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: navigationShell,
          bottomNavigationBar: HomeBottomBar(navigationShell: navigationShell),
        ),
      ),
    ),
    GoRoute(
        parentNavigatorKey: _rootKey,
        path: Destination.settings.path,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: const TestWidget(testMessage: "Settings"),
          );
        }),
  ],
);
