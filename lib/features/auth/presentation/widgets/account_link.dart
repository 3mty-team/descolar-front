import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AccountLink extends StatelessWidget {
  final String? text;
  final String? linkText;
  final String route;
  final Function? action;

  const AccountLink({
    super.key,
    this.text,
    this.linkText,
    required this.route,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(color: AppColors.gray),
          ),
          TextSpan(
            text: linkText,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                action!();
                Navigator.pushReplacementNamed(context, route);
              },
          ),
        ],
      ),
    );
  }
}
