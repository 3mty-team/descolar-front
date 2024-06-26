import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:flutter/material.dart';

class EditProfilButton extends StatelessWidget {
  final UserEditProfilArguments args;

  const EditProfilButton({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/editProfil',
          arguments: UserEditProfilArguments(
            uuid: this.args.uuid,
            biography: this.args.biography,
          ),
        );
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
      child: Text(
        'Éditer le profil',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
