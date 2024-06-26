import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:descolar_front/features/auth/presentation/widgets/account_link.dart';
import 'package:descolar_front/features/auth/presentation/widgets/cgu_text.dart';
import 'package:descolar_front/features/auth/presentation/widgets/checkbox_cgu_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/date_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/password_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/text_input.dart';
import 'package:descolar_front/features/profil/presentation/providers/edit_profil_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Step> getSteps() {
    SignupProvider provider = Provider.of<SignupProvider>(context, listen: false);
    EditProfilProvider profilProvider = Provider.of<EditProfilProvider>(context, listen: false);
    return [
      Step(
        title: const Text('Coordonnées'),
        isActive: provider.currentStep >= 0,
        content: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInput(
                  label: 'Email universitaire',
                  hint: 'prenom.nom@etu.u-paris.fr',
                  controller: provider.controllers[SignupInputName.email],
                  errorText: provider.errors[SignupInputName.email],
                  keyboardType: TextInputType.emailAddress,
                  required: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInput(
                  label: 'Nom',
                  required: true,
                  controller: provider.controllers[SignupInputName.lastname],
                  errorText: provider.errors[SignupInputName.lastname],
                  maxLength: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextInput(
                  label: 'Prénom',
                  required: true,
                  controller: provider.controllers[SignupInputName.firstname],
                  errorText: provider.errors[SignupInputName.firstname],
                  maxLength: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                DateInput(
                  label: 'Date de naissance',
                  required: true,
                  controller: provider.controllers[SignupInputName.date],
                  errorText: provider.errors[SignupInputName.date],
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>(
                  items: profilProvider.diplomasList!,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '🎓 Diplôme préparé',
                      errorText: provider.errors[SignupInputName.diploma],
                    ),
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      profilProvider.getFormationsByDiploma(context, int.parse(newValue[0]));
                      setState(() {
                        provider.controllers[SignupInputName.diploma]?.text = newValue;
                        provider.controllers[SignupInputName.formation]?.text = '';
                      });
                    }
                  },
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownSearch<String>(
                  items: profilProvider.formationList == null ? [] : profilProvider.formationList!,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '🎓 Formation préparée',
                      errorText: provider.errors[SignupInputName.formation],
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      provider.controllers[SignupInputName.formation]?.text = newValue!;
                    });
                  },
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                AccountLink(
                  route: '/login',
                  text: 'Déjà un compte ? ',
                  linkText: 'Connectez-vous',
                  action: Provider.of<LoginProvider>(context, listen: false).reset,
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        title: const Text('Profil'),
        isActive: provider.currentStep >= 1,
        content: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextInput(
                  label: 'Pseudonyme',
                  required: true,
                  controller: provider.controllers[SignupInputName.username],
                  errorText: provider.errors[SignupInputName.username],
                  maxLength: 20,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordInput(
                  label: 'Mot de passe',
                  required: true,
                  maxLength: 255,
                  controller: provider.controllers[SignupInputName.password],
                  errorText: provider.errors[SignupInputName.password],
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordInput(
                  label: 'Confirmation du mot de passe',
                  required: true,
                  maxLength: 255,
                  controller: provider.controllers[SignupInputName.confirmpassword],
                  errorText: provider.errors[SignupInputName.confirmpassword],
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxCGUInput(
                  provider: provider,
                  errorText: provider.errors[SignupInputName.cgu],
                  required: true,
                  title: Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'En cochant cette case, je déclare avoir pris connaissance des ',
                            style: TextStyle(color: AppColors.gray, fontSize: 12),
                          ),
                          TextSpan(
                            text: 'conditions générales d\'utilisation ',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CGUText(),
                                  ),
                                );
                              },
                          ),
                          const TextSpan(
                            text: 'de l\'application et de les accepter',
                            style: TextStyle(color: AppColors.gray, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                AccountLink(
                  route: '/login',
                  text: 'Déjà un compte ? ',
                  linkText: 'Connectez-vous',
                  action: Provider.of<LoginProvider>(context, listen: false).reset,
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  bool _isLastStep() {
    return Provider.of<SignupProvider>(context, listen: false).isLastStep(getSteps().length - 1);
  }

  @override
  Widget build(BuildContext context) {
    SignupProvider provider = Provider.of<SignupProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryTextButton(
                      text: 'Précédent',
                      isActive: provider.currentStep > 0,
                      onTap: () {
                        provider.previousStep();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryTextButton(
                      text: _isLastStep() ? 'Confirmer' : 'Suivant',
                      onTap: () {
                        if (provider.validateForm()) {
                          if (_isLastStep()) {
                            provider.createUser(context);
                          } else {
                            provider.nextStep();
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Theme(
        data: AppTheme.theme(),
        child: Stepper(
          controlsBuilder: (context, controller) => const SizedBox.shrink(),
          type: StepperType.horizontal,
          currentStep: provider.currentStep,
          onStepTapped: (value) {
            if (value > provider.currentStep) {
              if (provider.validateForm()) {
                provider.changeStep(value);
              }
            } else {
              provider.changeStep(value);
            }
          },
          steps: getSteps(),
        ),
      ),
    );
  }
}
