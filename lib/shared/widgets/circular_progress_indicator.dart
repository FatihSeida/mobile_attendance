import 'package:flutter/material.dart';

class DefaultProgressIndicator extends StatelessWidget {
  const DefaultProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}