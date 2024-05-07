import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:descolar_front/features/settings/presentation/providers/settings_provider.dart';
import 'package:descolar_front/features/settings/presentation/widgets/user_blocked_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({Key? key}) : super(key: key);

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SettingsProvider provider = Provider.of<SettingsProvider>(context, listen: false);
      provider.getBlockedUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBars.backAppBar(context),
      body: provider.blockedUsers == null
          ? const Padding(
              padding: EdgeInsets.only(top: 64),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              itemCount: provider.blockedUsers!.length,
              itemBuilder: (BuildContext context, int index) {
                UserProfilEntity user = provider.blockedUsers![index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserBlockedDetails(user: user),
                      TextButton(
                        onPressed: () async {
                          provider.unblockUser(user.uuid);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.secondary),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Débloquer',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
