import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/core/constants/device_info.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/followUserProfilButton.dart';
import 'package:descolar_front/features/profil/presentation/widgets/modifyUserProfilButton.dart';
import 'package:descolar_front/features/profil/presentation/widgets/unfollowUserProfilButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  final UserProfilArguments args;

  const ProfilPage({
    Key? key,
    required this.args,
  }) : super(
          key: key,
        );

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ProfilProvider provider = Provider.of<ProfilProvider>(context, listen: false);
      provider.getUserProfil(this.widget.args.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfilProvider provider = Provider.of<ProfilProvider>(context);
    double screenWidth = DeviceInfo().getWidth(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                ),
              ),

              // Back button
              Positioned(
                left: 0,
                top: 32,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(42),
                    ),
                    child: AppAssets.backIcon,
                  ),
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profil Picture
                FractionalTranslation(
                  translation: const Offset(0, -0.5),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/pp_placeholder.jpg',
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ),
                ),

                // Modify profil button
                if (provider.isMyUserProfil == true)
                  const ModifyUserProfilButton()
                else
                // Follow or Unfollow
                  if (provider.isFollower())
                    UnfollowUserProfilButton(profilProvider: provider,)
                  else
                    FollowUserProfilButton(profilProvider: provider,),
              ],
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${provider.userProfil.firstname} ${provider.userProfil.lastname}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  '@${provider.userProfil.username}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    // Abonnées
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: AppColors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: '${provider.userProfil.followers.length} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: 'Abonnées ',
                            style: TextStyle(
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // Abonnements
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: AppColors.black, fontSize: 16),
                        children: [
                          TextSpan(
                            text: '${provider.userProfil.following.length} ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: 'Abonnements ',
                            style: TextStyle(
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Posts
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: null,
          ),
        ],
      ),
    );
  }
}
