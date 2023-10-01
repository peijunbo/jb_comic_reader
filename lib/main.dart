import 'package:flutter/material.dart';
import 'package:jb_comic_reader/app/app_init_util.dart';
import 'package:jb_comic_reader/ui/router/router.dart';


void main() async {
  await AppInitUtil.initMmkv();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
