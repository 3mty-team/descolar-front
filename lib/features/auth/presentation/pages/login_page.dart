import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:descolar_front/features/auth/presentation/widgets/account_link.dart';
import 'package:descolar_front/features/auth/presentation/widgets/checkbox_remember_me_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/password_input.dart';
import 'package:descolar_front/features/auth/presentation/widgets/text_input.dart';
import 'package:descolar_front/features/profil/presentation/providers/edit_profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    EditProfilProvider profilProvider = Provider.of<EditProfilProvider>(context, listen: false);
    await profilProvider.getAllDiplomas(context);
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    Map<LoginInputName, TextEditingController> controllers = provider.controllers;
    Map<LoginInputName, String?> errors = provider.errors;

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
                        if (provider.validateForm()) {
                          provider.connect(context);
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
          primaryColor: Theme.of(context).colorScheme.primary,
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextInput(
                  label: 'Email ou pseudonyme',
                  controller: controllers[LoginInputName.login],
                  errorText: errors[LoginInputName.login],
                  required: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordInput(
                  label: 'Mot de passe',
                  required: true,
                  controller: controllers[LoginInputName.password],
                  errorText: errors[LoginInputName.password],
                  maxLength: 255,
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxRememberMeInput(
                  provider: provider,
                  title: const Text('Se souvenir de moi'),
                ),
                const SizedBox(
                  height: 16,
                ),
                AccountLink(
                  route: '/signup',
                  text: 'Pas de compte ? ',
                  linkText: 'Créer un compte',
                  action: Provider.of<SignupProvider>(context, listen: false).reset,
                ),
                const SizedBox(
                  height: 16,
                ),
                if (provider.isLoging)
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
