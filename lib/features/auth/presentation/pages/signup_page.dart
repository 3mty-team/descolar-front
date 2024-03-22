import 'package:age_calculator/age_calculator.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? emailErrorMsg;
  String? firstnameErrorMsg;
  String? lastnameErrorMsg;
  String? dateErrorMsg;
  String? usernameErrorMsg;
  String? passwordErrorMsg;
  String? confirmPasswordErrorMsg;

  bool _validateForm() {
    bool isValid = true;
    if (currentStep == 0) {
      isValid = _validateEmail(emailController.text) && isValid;
      isValid = _validateLastname(lastnameController.text) && isValid;
      isValid = _validateFirstname(firstnameController.text) && isValid;
      isValid = _validateDate(dateController.text) && isValid;
    } else if (currentStep == 1) {
      isValid = _validateUsername(usernameController.text) && isValid;
      isValid = _validatePassword(passwordController.text) && isValid;
      isValid =
          _validateConfirmPassword(confirmPasswordController.text) && isValid;
    }
    return isValid;
  }

  bool _validateEmail(String value) {
    if (value.isEmpty) {
      setState(
        () => emailErrorMsg = 'Veuillez renseigner votre email académique',
      );
      return false;
    }
    final bool isEmailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@etu\.u-paris\.fr",
    ).hasMatch(value);
    if (!isEmailValid) {
      setState(
        () => emailErrorMsg = 'Veuillez email académique n\'est pas valide',
      );
      return false;
    }
    setState(
      () => emailErrorMsg = null,
    );
    return true;
  }

  bool _validateLastname(String value) {
    if (value.isEmpty) {
      setState(
        () => lastnameErrorMsg = 'Veuillez renseigner votre nom',
      );
      return false;
    }
    setState(
      () => lastnameErrorMsg = null,
    );
    return true;
  }

  bool _validateFirstname(String value) {
    if (value.isEmpty) {
      setState(
        () => firstnameErrorMsg = 'Veuillez renseigner votre prénom',
      );
      return false;
    }
    setState(
      () => firstnameErrorMsg = null,
    );
    return true;
  }

  bool _validateDate(String value) {
    if (value.isEmpty) {
      setState(
        () => dateErrorMsg = 'Veuillez renseigner votre date',
      );
      return false;
    }

    List<String> dateSplitted = value.split('/');
    String formattedDate =
        '${dateSplitted[2]}-${dateSplitted[1]}-${dateSplitted[0]}';
    final date = DateTime.parse(formattedDate);
    if (AgeCalculator.age(date).years < 18) {
      setState(
        () => dateErrorMsg = 'Vous n\'êtes pas majeur',
      );
      return false;
    }

    setState(
      () => dateErrorMsg = null,
    );
    return true;
  }

  bool _validateUsername(String value) {
    if (value.isEmpty) {
      setState(
        () => usernameErrorMsg = 'Veuillez renseigner votre pseudonyme',
      );
      return false;
    }
    setState(
      () => usernameErrorMsg = null,
    );
    return true;
  }

  bool _validatePassword(String value) {
    if (value.isEmpty) {
      setState(
        () => passwordErrorMsg = 'Veuillez renseigner votre mot de passe',
      );
      return false;
    }

    final bool isPasswordValid = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(value);
    if (!isPasswordValid) {
      setState(
        () => passwordErrorMsg =
            'Votre mot de passe doit faire minimum 8 caractères, avec une minuscule, une majuscule, 1 chiffre et 1 caratère spéciale',
      );
      return false;
    }

    setState(
      () => passwordErrorMsg = null,
    );
    return true;
  }

  bool _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(
        () => confirmPasswordErrorMsg = 'Veuillez confirmer votre mot de passe',
      );
      return false;
    }

    if (value != passwordController.text) {
      setState(
        () => confirmPasswordErrorMsg =
            'Vos mot de passes ne sont pas identiques',
      );
      return false;
    }

    setState(
      () => confirmPasswordErrorMsg = null,
    );
    return true;
  }

  List<Step> getSteps() => [
        Step(
          title: const Text('Coordonnées'),
          isActive: currentStep >= 0,
          content: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Inscription',
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextInput(
                    label: 'Email universitaire',
                    hint: 'prenom.nom@etu.u-paris.fr',
                    controller: emailController,
                    errorText: emailErrorMsg,
                    keyboardType: TextInputType.emailAddress,
                    required: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextInput(
                    label: 'Nom',
                    required: true,
                    controller: lastnameController,
                    errorText: lastnameErrorMsg,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextInput(
                    label: 'Prénom',
                    required: true,
                    controller: firstnameController,
                    errorText: firstnameErrorMsg,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DateInput(
                    label: 'Date de naissance',
                    required: true,
                    controller: dateController,
                    errorText: dateErrorMsg,
                  ),
                ],
              ),
            ),
          ),
        ),
        Step(
          title: const Text('Profil'),
          isActive: currentStep >= 1,
          content: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Inscription',
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextInput(
                    label: 'Pseudonyme',
                    required: true,
                    controller: usernameController,
                    errorText: usernameErrorMsg,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PasswordInput(
                    label: 'Mot de passe',
                    required: true,
                    controller: passwordController,
                    errorText: passwordErrorMsg,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PasswordInput(
                    label: 'Confirmation du mot de passe',
                    required: true,
                    controller: confirmPasswordController,
                    errorText: confirmPasswordErrorMsg,
                  ),
                ],
              ),
            ),
          ),
        ),
      ];

  bool _isLastStep() => currentStep == getSteps().length - 1;

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryTextButton(
                      text: 'Précédent',
                      isActive: currentStep > 0,
                      onTap: () {
                        setState(() => currentStep--);
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
                        // TODO : check if form is valid
                        if (_validateForm()) {
                          if (_isLastStep()) {
                            // create user
                          } else {
                            setState(() => currentStep++);
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
        data: ThemeData(
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
          ),
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
