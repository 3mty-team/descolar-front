import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:flutter/material.dart';

class UnfollowUserProfilButton extends StatelessWidget {
  final ProfilProvider profilProvider;

  const UnfollowUserProfilButton({super.key, required this.profilProvider});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        profilProvider.unfollow();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
      ),
      child: Text(
        'Abonné',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
