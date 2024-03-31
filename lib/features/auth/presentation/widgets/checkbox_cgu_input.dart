import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:flutter/material.dart';

class CheckboxCGUInput extends StatefulWidget {
  final Widget title;
  final bool required;
  final SignupProvider provider;
  final String? errorText;

  const CheckboxCGUInput({
    super.key,
    required this.title,
    this.required = false,
    required this.provider,
    this.errorText,
  });

  @override
  State<CheckboxCGUInput> createState() => _CheckboxCGUInputState();
}

class _CheckboxCGUInputState extends State<CheckboxCGUInput> {
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
                value: widget.provider.checkboxCGU,
                side: MaterialStateBorderSide.resolveWith((states) =>  BorderSide(width: 1, color: widget.provider.errors[SignupInputName.cgu] != null ? Colors.redAccent : AppColors.black)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.provider.checkboxCGU = value;
                    // widget.provider.notifyListeners();
                  });
                },
              ),
              widget.title,
            ],
          ),
          Text(
            widget.errorText?? '',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
