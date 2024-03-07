import 'dart:io';

import 'package:descolar_front/config/routes/app_routes.dart';
import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/core/constants/device_info.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/template/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, // change to false for release
      //onGenerateRoute: AppRoutes.onGenerateRoutes, // /!\ MAYBE USELESS WITH PROVIDERS /!\
      title: 'Descolar',
      theme: theme(),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: DescolarWidgets.descolarAppBar);
  }
}
