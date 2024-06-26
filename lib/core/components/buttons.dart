import 'package:flutter/material.dart';

import 'package:descolar_front/core/resources/app_colors.dart';

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isActive;

  const PrimaryTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        if (this.isActive) {
          onTap(),
        },
      },
      style: ButtonStyle(
        backgroundColor: this.isActive ? MaterialStateProperty.all(Theme.of(context).colorScheme.primary) : MaterialStateProperty.all(AppColors.gray),
      ),
      child: Text(text,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
