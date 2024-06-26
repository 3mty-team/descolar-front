import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/core/constants/device_info.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/banner_picture.dart';
import 'package:descolar_front/features/profil/presentation/widgets/edit_profil_button.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_action_buttons.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
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
    DeviceInfo().getWidth(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                BannerPicture(imagePath: provider.userProfil?.bannerPath),
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
                Positioned(
                  right: 0,
                  top: 32,
                  child: TextButton(
                    onPressed: () {
                      provider.changeBannerPicture();
                    },
                    child: Visibility(
                      visible: provider.isMyUserProfil,
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(42),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Body page (error, success)
            provider.failure != null && provider.userProfil == null
                ? Transform.translate(
                    offset: const Offset(0, -78),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Null Profil picture
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ProfilPicture(
                                radius: 60,
                                imagePath: null,
                                borderWidth: 4,
                              ),
                            ],
                          ),
                        ),

                        // User Info
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.failure!.errorMessage,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ) // ERROR PAGE
                : Transform.translate(
                    offset: const Offset(0, -60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profil picture + buttons
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (provider.isMyUserProfil)
                                TextButton(
                                  onPressed: () {
                                    provider.changeProfilPicture(context);
                                  },
                                  child: provider.isChangingPfp
                                      ? Center(
                                          child: Stack(
                                            alignment: AlignmentDirectional.center,
                                            children: [
                                              ProfilPicture(
                                                radius: 60,
                                                imagePath: provider.userProfil?.pfpPath,
                                                borderWidth: 4,
                                              ),
                                              const SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: CircularProgressIndicator(),
                                              ),
                                            ],
                                          ),
                                        )
                                      : ProfilPicture(
                                          radius: 60,
                                          imagePath: provider.userProfil?.pfpPath,
                                          borderWidth: 4,
                                        ),
                                )
                              else
                                ProfilPicture(
                                  radius: 60,
                                  imagePath: provider.userProfil?.pfpPath,
                                  borderWidth: 4,
                                ),
                              if (provider.isMyUserProfil)
                                EditProfilButton(
                                  args: UserEditProfilArguments(
                                    uuid: widget.args.uuid,
                                    biography: provider.userProfil?.biography,
                                  ),
                                )
                              else
                                ProfilActionButtons(provider: provider),
                            ],
                          ),
                        ),

                        // User Info
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                provider.userProfil != null ? '${provider.userProfil!.firstname} ${provider.userProfil!.lastname}' : '- -',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                provider.userProfil != null ? '@${provider.userProfil!.username}' : '@-',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '📝 ${provider.userProfil?.biography ?? '-'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                provider.userProfil != null ? '🎓 ${provider.userProfil!.diploma} - ${provider.userProfil!.formation}' : '- -',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                  fontSize: 14,
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
                                      style: const TextStyle(color: AppColors.gray, fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: provider.userProfil != null ? '${provider.userProfil!.followers.length} ' : '- ',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(
                                          text: 'Abonnés ',
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
                                      style: const TextStyle(color: AppColors.gray, fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: provider.userProfil != null ? '${provider.userProfil!.following.length} ' : '- ',
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          height: 10,
                          color: AppColors.gray,
                        ),
                        // Posts
                        if (provider.posts == null)
                          // Spinner
                          const Padding(
                            padding: EdgeInsets.only(top: 64),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else
                          //
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 16),
                            children: provider.posts!.map(
                              (post) {
                                return PostItem(
                                  post: post,
                                );
                              },
                            ).toList(),
                          ),
                      ],
                    ),
                  ), // SUCCESS PAGE
          ],
        ),
      ),
    );
  }
}
