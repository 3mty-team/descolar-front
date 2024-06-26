import 'package:flutter/material.dart';

import 'package:descolar_front/core/resources/app_colors.dart';

class SnackBars {
  static const int duration = 5;

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> successSnackBar({
    required BuildContext context,
    required String title,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        duration: const Duration(seconds: duration),
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> failureSnackBar({
    required BuildContext context,
    required String title,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
        duration: const Duration(seconds: duration),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
