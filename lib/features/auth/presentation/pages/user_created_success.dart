import 'package:descolar_front/features/auth/presentation/widgets/account_link.dart';
import 'package:flutter/material.dart';

class UserCreatedSuccessPage extends StatelessWidget {
  const UserCreatedSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Votre compte à bien été créé',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            AccountLink(
              route: '/login',
              linkText: 'Connectez-vous',
            ),
          ],
        ),
      ),
    );
  }
}
