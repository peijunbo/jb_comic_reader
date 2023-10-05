import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jb_comic_reader/ui/home_page/widgets/home_bottom_bar.dart';
import 'package:jb_comic_reader/ui/home_page/widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.navigationShell, this.goRouterState}) : super(key: key);
  final StatefulNavigationShell navigationShell;
  final GoRouterState? goRouterState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JB Comic Reader'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        bottom: null,
      ),
      drawer: HomeDrawer(navigationShell: navigationShell),
      body: navigationShell,
      bottomNavigationBar: HomeBottomBar(navigationShell: navigationShell),
    );
  }
}