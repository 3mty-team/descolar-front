import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DescolarWidgets {
  static AppBar descolarAppBar = AppBar(
    toolbarHeight: 70,
    backgroundColor: AppColors.primary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(900, 20),
      ),
    ),
    title: AppAssets.descolarLogoSvg,
    centerTitle: true,
    leading: AppAssets.backIcon,
    leadingWidth: 40,
  );
}
