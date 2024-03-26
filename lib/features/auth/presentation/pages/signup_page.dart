import 'package:age_calculator/age_calculator.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/checkbox_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/date_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/password_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/text_input.dart';
import 'package:flutter/gestures.dart';
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
    value = value.trim();
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
        () => emailErrorMsg = 'Votre email académique n\'est pas valide',
      );
      return false;
    }
    setState(
      () => emailErrorMsg = null,
    );
    return true;
  }

  bool _validateLastname(String value) {
    value = value.trim();
    if (value.isEmpty) {
      setState(
        () => lastnameErrorMsg = 'Veuillez renseigner votre nom',
      );
      return false;
    }
    final bool isLastnameValid = RegExp(
      r'^[a-zA-ZÀ-Ÿ- ]*$',
    ).hasMatch(value);
    if (!isLastnameValid) {
      setState(
        () => lastnameErrorMsg = 'Le nom n\'est pas valide',
      );
      return false;
    }
    setState(
      () => lastnameErrorMsg = null,
    );
    return true;
  }

  bool _validateFirstname(String value) {
    value = value.trim();
    if (value.isEmpty) {
      setState(
        () => firstnameErrorMsg = 'Veuillez renseigner votre prénom',
      );
      return false;
    }
    final bool isFirstnameValid = RegExp(
      r'^[a-zA-ZÀ-Ÿ- ]*$',
    ).hasMatch(value);
    if (!isFirstnameValid) {
      setState(
        () => firstnameErrorMsg = 'Le prénom n\'est pas valide',
      );
      return false;
    }
    setState(
      () => firstnameErrorMsg = null,
    );
    return true;
  }

  bool _validateDate(String value) {
    value = value.trim();
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
    value = value.trim();
    if (value.isEmpty) {
      setState(
        () => usernameErrorMsg = 'Veuillez renseigner votre pseudonyme',
      );
      return false;
    }
    final bool isUsernameValid = RegExp(
      r'^[a-zA-Z0-9-_]+$',
    ).hasMatch(value);
    if (!isUsernameValid) {
      setState(
        () => usernameErrorMsg = 'Le pseudonyme n\'est pas valide',
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
      r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{7,255}$',
    ).hasMatch(value);
    if (!isPasswordValid) {
      setState(
        () => passwordErrorMsg =
            'Votre mot de passe doit faire au minimum 7 caractères avec au moins une majuscule et un chiffre.',
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
            'Vos mots de passe ne sont pas identiques',
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
                    maxLength: 50,
                  ),
                  TextInput(
                    label: 'Prénom',
                    required: true,
                    controller: firstnameController,
                    errorText: firstnameErrorMsg,
                    maxLength: 100,
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
                    maxLength: 20,
                  ),
                  PasswordInput(
                    label: 'Mot de passe',
                    required: true,
                    maxLength: 255,
                    controller: passwordController,
                    errorText: passwordErrorMsg,
                  ),
                  PasswordInput(
                    label: 'Confirmation du mot de passe',
                    required: true,
                    maxLength: 255,
                    controller: confirmPasswordController,
                    errorText: confirmPasswordErrorMsg,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CheckboxInput(
                    required: true,
                    title: Flexible(
                      child: RichText(
                        text:  TextSpan(
                          children: [
                            const TextSpan(
                              text: 'En cochant cette case, je déclare avoir pris connaissance des ',
                              style: TextStyle(color: AppColors.gray, fontSize: 12),
                            ),
                            TextSpan(
                              text: 'conditions générales d\'utilisation ',
                              style: const TextStyle(color: Colors.blue, fontSize: 12),
                              recognizer: TapGestureRecognizer()..onTap = ()  {
                                print('CGU');
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
                        if (_validateForm()) {
                          if (_isLastStep()) {
                            // TODO : create user
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
