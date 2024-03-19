import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:flutter/material.dart';

class DescolarNavigationBar {
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  static Stack mainNavBar(BuildContext context) {
    return Stack(
      alignment: const Alignment(0, 1.5),
      children: [
        AppAssets.backgroundNav,
        Theme(
          data: ThemeData(splashColor: Colors.transparent),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconSize: 24,
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
        ),
      ],
    );
  }
}
