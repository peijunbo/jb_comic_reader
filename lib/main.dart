import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jb_comic_reader/ui/router/router.dart';



void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlueAccent,
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
