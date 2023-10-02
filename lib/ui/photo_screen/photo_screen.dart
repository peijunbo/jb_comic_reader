import 'package:flutter/material.dart';
import 'package:jb_comic_reader/ui/widgets/test_widget.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  List<Widget> _buildScreens() {
    return [
      const Center(child: TestWidget(testMessage: 'Device')),
      const Center(child: TestWidget(testMessage: 'App')),
      const Center(child: TestWidget(testMessage: 'Picsum')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Device'),
                    Tab(text: 'App'),
                    Tab(text: 'Picsum'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: _buildScreens(),
                  ),
                ),
              ],
            )));
  }
}
