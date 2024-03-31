import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:flutter/material.dart';

class CheckboxRememberMeInput extends StatefulWidget {
  final Widget title;
  final bool required;
  final LoginProvider provider;
  final String? errorText;

  const CheckboxRememberMeInput({
    super.key,
    required this.title,
    this.required = false,
    required this.provider,
    this.errorText,
  });

  @override
  State<CheckboxRememberMeInput> createState() => _CheckboxRememberMeInputState();
}

class _CheckboxRememberMeInputState extends State<CheckboxRememberMeInput> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              if (widget.required)
                const Text(
                  '*',
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              Checkbox(
                value: widget.provider.checkboxRememberMe,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.provider.checkboxRememberMe = value;
                    // widget.provider.notifyListeners();
                  });
                },
              ),
              widget.title,
            ],
          ),
          Text(
            widget.errorText ?? '',
            style: const TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
