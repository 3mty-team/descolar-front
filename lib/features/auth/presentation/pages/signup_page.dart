import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/date_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/password_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int currentStep = 0;

  List<Step> getSteps() => [
    Step(
      title: const Text('Coordonnées'),
      isActive: currentStep >= 0,
      content: const Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(
                height: 32,
              ),

              TextInput(
                label: 'Email universitaire',
                hint: 'prenom.nom@u-paris.fr',
                help: 'Votre mail associé à l\'Université Paris Cité',
                required: true,
              ),
              SizedBox(
                height: 16,
              ),
              TextInput(
                label: 'Nom',
                required: true,
              ),
              SizedBox(
                height: 16,
              ),
              TextInput(
                label: 'Prénom',
                required: true,
              ),
              SizedBox(
                height: 16,
              ),
              DateInput(
                label: 'Date de naissance',
                required: true,
              ),
            ],
          ),
        ),
      ),
    ),
    Step(
      title: const Text('Profil'),
      isActive: currentStep >= 1,
      content: const Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(
                height: 32,
              ),

              TextInput(
                label: 'Pseudonyme',
                required: true,
              ),
              SizedBox(
                height: 16,
              ),
              PasswordInput(
                label: 'Mot de passe',
                required: true,
              ),
              SizedBox(
                height: 16,
              ),
              PasswordInput(
                label: 'Confirmation du mot de passe',
                required: true,
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  bool isLastStep() => currentStep == getSteps().length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.blankAppBar(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: PrimaryTextButton(
                  text: 'Précédant',
                  isActive: currentStep > 0,
                  onTap: () {
                      setState(() => currentStep--);
                  },
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: PrimaryTextButton(
                  text: isLastStep() ? 'Confirmer' : 'Suivant',
                  onTap: () {
                    // TODO : check if form is valid
                    if (isLastStep()) {
                      // create user
                    } else {
                      setState(() => currentStep++);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Theme(
        data: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
          )
        ),
        child: Stepper(
          controlsBuilder: (context, controller) => const SizedBox.shrink(),
          type: StepperType.horizontal,
          currentStep: currentStep,
          steps: getSteps(),
        ),
      ),
    );
  }
}
