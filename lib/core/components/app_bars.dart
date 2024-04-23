import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppBars {
  static AppBar blankAppBar({Widget? leading}) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(900, 50),
        ),
      ),
      leading: leading,
      title: AppAssets.descolarLogoSvg,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  static AppBar homeAppBar(BuildContext context, GlobalKey<ScaffoldState> key) {
    return blankAppBar(
      leading: IconButton(
        icon: AppAssets.settingsIcon,
        onPressed: () {
          key.currentState!.openDrawer();
        },
      ),
    );
  }

  static AppBar backAppBar(BuildContext context) {
    return blankAppBar(
      leading: IconButton(
        icon: AppAssets.backIcon,
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      ),
    );
  }

  static AppBar closeIconAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
