import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_action_buttons.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';

class AppBars {
  static AppBar blankAppBar({required BuildContext context, Widget? leading, Widget? title}) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(900, 50),
        ),
      ),
      leading: leading,
      title: title,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  static SliverAppBar blankSliverAppBar({required BuildContext context, Widget? leading, Widget? title}) {
    return SliverAppBar(
      floating: true,
      snap: true,
      toolbarHeight: 70,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(900, 50),
        ),
      ),
      leading: leading,
      title: title ?? AppAssets.descolarLogoSvg,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.white),
    );
  }

  static SliverAppBar homeSliverAppBar(BuildContext context, GlobalKey<ScaffoldState> key) {
    return blankSliverAppBar(
      context: context,
      leading: IconButton(
        icon: AppAssets.optionsIcon,
        onPressed: () {
          key.currentState!.openDrawer();
        },
      ),
    );
  }

  static SliverAppBar profilSliverAppBar(BuildContext context, ProfilProvider profilProvider) {
    return blankSliverAppBar(
      context: context,
      leading: IconButton(
        icon: AppAssets.backIcon,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const ProfilPicture(radius: 10,),
              Text(
                profilProvider.userProfil != null ? '${profilProvider.userProfil!.firstname} ${profilProvider.userProfil!.lastname}' : '- -',
              ),
            ],
          ),
          ProfilActionButtons(provider: profilProvider),
        ],
      ),
    );
  }

  static AppBar backAppBar(BuildContext context) {
    return blankAppBar(
      context: context,
      leading: IconButton(
        icon: AppAssets.backIcon,
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      ),
      title: AppAssets.descolarLogoSvg,
    );
  }

  static AppBar closeIconAppBar(BuildContext context, TextEditingController controller) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
          controller.clear();
        },
      ),
      title: AppAssets.descolarLogoSvg,
    );
  }

  static AppBar conversationAppBar(BuildContext context, UserProfilEntity receiver) {
    return blankAppBar(
      context: context,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profil', arguments: UserProfilArguments(receiver.uuid));
            },
            child: ProfilPicture(
              radius: 20,
              imagePath: receiver.pfpPath,
              borderWidth: 2,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${receiver.firstname} ${receiver.lastname}',
            style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      leading: IconButton(
        icon: AppAssets.backIcon,
        onPressed: () {
          Navigator.pop(
            context,
          );
        },
      ),
    );
  }
}
