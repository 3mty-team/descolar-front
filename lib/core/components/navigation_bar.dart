import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:flutter/material.dart';

class DescolarNavigationBar {
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  static Container mainNavBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AppAssets.backgroundNav, fit: BoxFit.fill),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent.withOpacity(0),
        elevation: 0,
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
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              Navigator.pushNamed(context, '/newPost');
              break;
            case 3:
              Navigator.pushNamed(context, '/myProfil');
              break;
            case 4:
              Navigator.pushNamed(context, '/messages');
              break;
          }
        },
      ),
    );
  }
}
