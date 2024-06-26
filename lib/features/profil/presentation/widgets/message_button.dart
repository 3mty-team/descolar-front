import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/messages/presentation/pages/messages_page.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:flutter/material.dart';

class MessageButton extends StatelessWidget {
  final ProfilProvider profilProvider;
  // final MessageProvider messageProvider;

  const MessageButton({super.key, required this.profilProvider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 42,
      child: TextButton(
        onPressed: () async {
          // Cache conversation

          // Go to conversation page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessagesPage(
                receiver: profilProvider.userProfil!,
              ),
            ),
          );
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(AppColors.lightGray),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
        child: const Icon(
          Icons.mail,
          color: AppColors.white,
        ),
      ),
    );
  }
}
