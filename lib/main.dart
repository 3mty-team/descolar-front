import 'package:descolar_front/config/routes/app_routes.dart';
import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:descolar_front/screens/splash_screen.dart';

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
      onGenerateRoute: AppRoutes.onGenerateRoutes, // /!\ MAYBE USELESS WITH PROVIDERS /!\
      title: 'Descolar',
      theme: AppTheme.theme(),
      home: const SplashScreen(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : Custom Desolar appbar
      appBar: AppBar(
        title: const Text('Descolar'),
      ),
    );
  }
}
