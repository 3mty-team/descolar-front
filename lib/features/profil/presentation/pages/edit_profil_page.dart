import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/profil/presentation/providers/edit_profil_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/core/components/buttons.dart';

import '../../../../core/resources/app_assets.dart';

class EditProfilPage extends StatefulWidget {
  final UserProfilArguments args;

  const EditProfilPage({super.key, required this.args});

  @override
  State<StatefulWidget> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      EditProfilProvider provider = Provider.of<EditProfilProvider>(context, listen: false);
      provider.getAllDiplomas(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    EditProfilProvider provider = Provider.of<EditProfilProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            provider.reset();
            Navigator.pop(context);
          },
        ),
        title: AppAssets.descolarLogoSvg,
      ),
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
                          const SizedBox(height: 40),
                          Center(
                            child: DropdownSearch<String>(
                              items: provider.diplomasList!,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: '🎓 Diplôme préparé',
                                  errorText: provider.errors[EditProfilInputName.diploma],
                                ),
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  provider.getFormationsByDiploma(context, int.parse(newValue[0]));
                                  setState(() {
                                    provider.controllers[EditProfilInputName.diploma]?.text = newValue;
                                    provider.controllers[EditProfilInputName.formation]?.text = '';
                                  });
                                }
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          DropdownSearch<String>(
                            items: provider.formationList == null ? [] : provider.formationList!,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: '🎓 Formation préparée',
                                errorText: provider.errors[EditProfilInputName.formation],
                              ),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                provider.controllers[EditProfilInputName.formation]?.text = newValue!;
                              });
                            },
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Center(
                            child: TextField(
                              controller: provider.controllers[EditProfilInputName.biography],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "📝 Écrivez ici une rapide présentation de vous et de vos centres d'intérêts...",
                              ),
                              maxLines: 4,
                            ),
                          ),
                          const SizedBox(height: 25),
                          PrimaryTextButton(
                            text: 'Mettre à jour votre profil',
                            onTap: () {
                              if (provider.validateForm()) {
                                provider.updateProfil(context, widget.args.uuid);
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
