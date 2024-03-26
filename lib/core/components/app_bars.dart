import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppBars {
  static AppBar blankAppBar({Widget? leading}) {
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

  static AppBar iconAppBar(BuildContext context) {
    final isHomePage = ModalRoute.of(context)?.settings.name == '/home';
    final leadingIcon = isHomePage ? AppAssets.settingsIcon : AppAssets.backIcon;
    return blankAppBar(
      leading: IconButton(
        icon: leadingIcon,
        onPressed: () {
          isHomePage ? null : Navigator.pop(context);
        },
      ),
    );
  }
}
