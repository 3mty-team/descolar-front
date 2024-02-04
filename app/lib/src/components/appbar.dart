import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize;

  const MyAppBar({super.key, this.preferredSize = const Size.fromHeight(50)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.red,
      title: const Text('Descolar'),
    );
  }
}