import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/settings/presentation/widgets/user_blocked_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/components/app_bars.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  String? selectedDiploma;
  String? selectedFormation;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ProfilProvider provider = Provider.of<ProfilProvider>(context, listen: false);
      provider.getAllDiplomas(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfilProvider provider = Provider.of<ProfilProvider>(context);
    TextEditingController diplomaController = provider.diplomaController;
    TextEditingController formationController = provider.formationController;
    TextEditingController biographyController = provider.formationController;

    return Scaffold(
      appBar: AppBars.closeIconAppBar(context, diplomaController),
      body: provider.diplomasList == null
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
                            'Vous pouvez modifier, ci-dessous, votre formation universitaire et votre biographie.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: DropdownButton<String>(
                              value: selectedDiploma,
                              hint: const Text('Choisissez le diplôme que vous préparez'),
                              onChanged: (String? newValue) {
                                provider.getFormationsByDiploma(context, int.parse(newValue![0]));
                                setState(() {
                                  selectedDiploma = newValue;
                                  selectedFormation = null;
                                });
                              },
                              items: provider.diplomasList!.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButton<String>(
                            value: selectedFormation,
                            hint: const Text('Choisissez votre formation'),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedFormation = newValue;
                              });
                            },
                            items: provider.formationList?.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 25),
                          Center(
                            child: TextField(
                              controller: biographyController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Écrivez ici une rapide présentation de vous et de vos centres d'intérêts...",
                              ),
                              maxLines: 4,
                            ),
                          ),
                          const SizedBox(height: 25),
                          PrimaryTextButton(
                            text: 'Mettre à jour votre profil',
                            onTap: () {},
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
