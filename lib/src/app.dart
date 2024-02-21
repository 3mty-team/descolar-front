import 'package:descolar_front/src/resources/app_assets.dart';
import 'package:descolar_front/src/resources/app_colors.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, // turn to false before release
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const MyAppBar({super.key, this.preferredSize = const Size.fromHeight(50)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: AppAssets.descolarLogoSvg,
      centerTitle: true,
    );
  }
}
