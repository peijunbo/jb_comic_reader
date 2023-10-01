import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key, required this.testMessage});
  final String testMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Text(testMessage),
      )
    );
  }
}
