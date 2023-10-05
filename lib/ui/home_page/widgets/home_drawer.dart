import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key, required this.navigationShell}) : super(key: key);
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            child: const Text('Drawer Header')
          ),
          const ListTile(
            leading: Icon(Icons.star_border),
            title: Text('Stars'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          const ListTile(
            leading: Icon(Icons.error),
            title: Text('About'),
          ),
        ],
      ),
    );
  }

}