import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DescolarNavigationBar {
  static Theme mainNavBar(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.primary,
        items: [
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
