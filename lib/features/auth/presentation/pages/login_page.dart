import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/checkbox_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/password_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/text_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? loginErrorMsg;
  String? passwordErrorMsg;

  bool _validateForm() {
    bool isValid = true;
    isValid = _validateLogin(loginController.text) && isValid;
    isValid = _validatePassword(passwordController.text) && isValid;
    return isValid;
  }

  bool _validateLogin(String value) {
    value = value.trim();
    if (value.isEmpty) {
      setState(
        () => loginErrorMsg =
            'Veuillez renseigner votre email ou votre pseudonyme',
      );
      return false;
    }
    setState(
      () => loginErrorMsg = null,
    );
    return true;
  }

  bool _validatePassword(String value) {
    value = value.trim();
    if (value.isEmpty) {
      setState(
        () => passwordErrorMsg = 'Veuillez renseigner votre mot de passe',
      );
      return false;
    }
    setState(
      () => passwordErrorMsg = null,
    );
    return true;
  }

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
                      text: 'Se connecter',
                      onTap: () {
                        if (_validateForm()) {
                          // TODO : connect
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
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextInput(
                  label: 'Email ou pseudonyme',
                  controller: loginController,
                  errorText: loginErrorMsg,
                  required: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordInput(
                  label: 'Mot de passe',
                  required: true,
                  controller: passwordController,
                  errorText: passwordErrorMsg,
                  maxLength: 255,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CheckboxInput(
                      title: Text('Se souvenir de moi'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Pas de compte ? ',
                        style: TextStyle(color: AppColors.gray),
                      ),
                      TextSpan(
                        text: 'Créer un compte',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
