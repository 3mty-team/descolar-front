import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/followUserProfilButton.dart';
import 'package:descolar_front/features/profil/presentation/widgets/modifyUserProfilButton.dart';
import 'package:descolar_front/features/profil/presentation/widgets/unfollowUserProfilButton.dart';
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
    if (widget.provider.userProfil != null) {
      if (widget.provider.isMyUserProfil == true) {
        return const ModifyUserProfilButton();
      } else {
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

    return const SizedBox();
  }
}
