import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key, required this.navigationShell}) : super(key: key);
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.photo), label: "Photo"),
        BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: "Album"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Find"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
      ],
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      currentIndex: navigationShell.currentIndex,
      onTap: (index) {
        navigationShell.goBranch(index);
      },
    );
  }
}

