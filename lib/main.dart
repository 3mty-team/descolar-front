import 'package:dartz/dartz.dart';
import 'package:descolar_front/config/routes/app_routes.dart';
import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
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
    return Scaffold(
      // TODO : Custom Desolar appbar
      appBar: AppBar(
        title: const Text('Descolar'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.primary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: AppAssets.homeIcon,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: AppAssets.searchIcon,
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: AppAssets.newPostIcon,
            label: 'New Post',
          ),
          BottomNavigationBarItem(
            icon: AppAssets.profilIcon,
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: AppAssets.messageIcon,
            label: 'Messages',
          ),
        ],
        onTap: (value) {
          switch (value) {
            case 0:
              Navigator.pushNamed(context, '/'); //Must be replaced by the true routes when created
            case 1:
              Navigator.pushNamed(context, '/');
            case 2:
              Navigator.pushNamed(context, '/');
            case 3:
              Navigator.pushNamed(context, '/');
            case 4:
              Navigator.pushNamed(context, '/');
          }
        },
      ),
    );
  }
}
