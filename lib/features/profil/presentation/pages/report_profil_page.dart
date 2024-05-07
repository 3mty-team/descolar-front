import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/profil/business/usecases/report_user_profil.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/settings/presentation/widgets/user_blocked_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item_without_icons.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/components/app_bars.dart';

class ReportProfilPage extends StatefulWidget {
  final UserProfilArguments args;

  const ReportProfilPage({
    super.key,
    required this.args,
  });

  @override
  State<StatefulWidget> createState() => _ReportProfilPageState();
}

class _ReportProfilPageState extends State<ReportProfilPage> {
  String? selectedReason;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ProfilProvider provider =
          Provider.of<ProfilProvider>(context, listen: false);
      provider.getAllReportCategories(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfilProvider provider = Provider.of<ProfilProvider>(context);
    TextEditingController controller = provider.reportController;

    return Scaffold(
      appBar: AppBars.closeIconAppBar(context, controller),
      body: provider.reportCategories == null
          ? const Padding(
              padding: EdgeInsets.only(top: 64),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Afficher Utilistaeur
                    UserBlockedDetails(user: provider.userProfil!),
                    const Divider(
                      height: 10,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 14, left: 14),
                      child: Column(
                        children: [
                          const Text(
                            'Cet utilisateur ou ce compte pose problème ?\n'
                            'Merci de le signaler en remplissant le formulaire ci-dessous. Les modérateurs de Descolar se chargeront de prendre une décision.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: DropdownButton<String>(
                              value: selectedReason,
                              hint: const Text('Choisissez une raison'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedReason = newValue;
                                });
                              },
                              items: provider.reportCategories!
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Center(
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Décrivez le problème',
                              ),
                              maxLines: 4,
                            ),
                          ),
                          const SizedBox(height: 25),
                          PrimaryTextButton(
                            text: 'Soumettre le signalement',
                            onTap: () {
                              if (selectedReason != null &&
                                  controller.text.isNotEmpty) {
                                provider.reportUser(
                                  context,
                                  ReportUserParams(
                                      uuid: provider.userProfil!.uuid,
                                      category: provider.reportCategories!
                                              .indexOf(selectedReason!) +
                                          1,
                                      comment: controller.text,
                                      date: DateTime.now()
                                              .millisecondsSinceEpoch ~/
                                          1000),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
