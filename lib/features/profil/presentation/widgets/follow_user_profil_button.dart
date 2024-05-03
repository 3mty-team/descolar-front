import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:flutter/material.dart';

class FollowUserProfilButton extends StatelessWidget {
  final ProfilProvider profilProvider;

  const FollowUserProfilButton({super.key, required this.profilProvider});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('follow');
        profilProvider.follow(profilProvider.userProfil!.uuid);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
      ),
      child: const Text(
        'Suivre',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
