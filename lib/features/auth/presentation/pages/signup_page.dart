import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/auth/presentation/widgets/date_input.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: PrimaryTextButton(
                    text:'Suivant',
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Sign Up',
                style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 32,),
              TextInput(
                label: 'Email universitaire',
                hint: 'prenom.nom@u-paris.fr',
                help: 'Votre mail associé à l\'Université Paris Cité',
                required: true,
              ),
              SizedBox(height: 16,),
              TextInput(
                label: 'Nom',
                required: true,
              ),
              SizedBox(height: 16,),
              TextInput(
                label: 'Prénom',
                required: true,
              ),
              SizedBox(height: 16,),
              DateInput(
                label: 'Date de naissance',
                required: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
