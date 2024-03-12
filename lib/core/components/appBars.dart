import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppBars {
  static AppBar iconAppBar(BuildContext context) {
    final isHomePage = ModalRoute.of(context)?.settings.name == '/';
    final leadingIcon = isHomePage ? AppAssets.settingsIcon : AppAssets.backIcon;
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(900, 50),
        ),
      ),
      title: AppAssets.descolarLogoSvg,
      centerTitle: true,
      leading: IconButton(
        icon: leadingIcon,
        onPressed: () {
          isHomePage ? null : Navigator.pop(context); //Replace "null" by navigate to settings page when created
        },
      ),
    );
  }

    static AppBar blankAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(900, 50),
        ),
      ),
      title: AppAssets.descolarLogoSvg,
      centerTitle: true,
    );
  }
}
