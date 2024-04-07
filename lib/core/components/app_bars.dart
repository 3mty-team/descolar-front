import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppBars {
  static AppBar blankAppBar ({Widget? leading}) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(900, 50),

        ),
      ),
      leading: leading,
      title: AppAssets.descolarLogoSvg,
      centerTitle: true,
    );
  }

  static AppBar homeAppBar(BuildContext context) {
    return blankAppBar(
      leading: IconButton(
        icon: AppAssets.settingsIcon,
        onPressed: () {
        },
      ),
    );
  }

  static AppBar backAppBar(BuildContext context) {
    return blankAppBar(
      leading: IconButton(
        icon: AppAssets.backIcon,
        onPressed: () {
          Navigator.pop(context); //Replace "null" by navigate to settings page when created
        },
      ),
    );
  }
}
