import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/follow_user_profil_button.dart';
import 'package:descolar_front/features/profil/presentation/widgets/unfollow_user_profil_button.dart';
import 'package:flutter/material.dart';

class ProfilActionButtons extends StatefulWidget {
  final ProfilProvider provider;

  const ProfilActionButtons({super.key, required this.provider});

  @override
  State<ProfilActionButtons> createState() => _ProfilActionButtonsState();
}

class _ProfilActionButtonsState extends State<ProfilActionButtons> {
  @override
  Widget build(BuildContext context) {
    if (widget.provider.userProfil == null || widget.provider.isMyUserProfil == true) {
      return const SizedBox();
    }

    if (widget.provider.isFollower) {
      return UnfollowUserProfilButton(
        profilProvider: widget.provider,
      );
    } else {
      return FollowUserProfilButton(
        profilProvider: widget.provider,
      );
    }

  }
}
