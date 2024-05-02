import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ModifyUserProfilButton extends StatelessWidget {
  const ModifyUserProfilButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
            side: const BorderSide(
              color: AppColors.secondary,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
      child: const Text(
        'Modifier le profil',
        style: TextStyle(
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
