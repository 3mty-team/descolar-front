import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class PrimaryTextButton extends StatelessWidget {
  final String text;

  const PrimaryTextButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
      ),
      child: Text(text,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
