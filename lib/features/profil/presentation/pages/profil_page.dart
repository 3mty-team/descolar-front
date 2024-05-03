import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/core/constants/device_info.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/ProfilActionButtons.dart';
import 'package:descolar_front/features/profil/presentation/widgets/ProfilPicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bg + Back button
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

            // Body page
            Transform.translate(
              offset: const Offset(0, -60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profil picture + buttons
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // TODO : if isMyProfil, TextButton, else ProfilPicture
                        if (provider.isMyUserProfil)
                          TextButton(
                          onPressed: () {
                            provider.changeProfilPicture(provider.userProfil!.uuid);
                          },
                          child: ProfilPicture(
                            radius: 60,
                            imageFile: provider.userProfil?.pp,
                          ),
                        )
                        else
                          ProfilPicture(
                            radius: 60,
                            imageFile: provider.userProfil?.pp,
                          ),
                        ProfilActionButtons(provider: provider),
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
                                    text: provider.userProfil != null ? '${provider.userProfil!.followers.length} ' : '- ',
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
                        )
                      ],
                    ),
                  ),

                  // Posts
                  if (provider.posts.isEmpty)
                    // Spinner
                    const Padding(
                      padding: EdgeInsets.only(top: 64),
                      child: Center(child: CircularProgressIndicator(),),
                    )
                  else
                    //
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 16),
                      children: provider.posts.map(
                        (post) {
                          return PostItem(
                            post: PostModel(
                              comments: post.comments,
                              content: post.content,
                              likes: post.likes,
                              postDate: post.postDate,
                              postId: post.postId,
                              userId: post.userId,
                              username: post.username,
                              repostedPost: post.repostedPost,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
