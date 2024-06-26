import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfilButton extends StatelessWidget {
  final UserEditProfilArguments args;

  const EditProfilButton({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/editProfil',
          arguments: UserEditProfilArguments(
            uuid: this.args.uuid,
            biography: this.args.biography,
          ),
        );
      },
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
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
      ),
      child: const Text(
        'Éditer le profil',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
