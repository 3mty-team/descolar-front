import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;
  final String? errorText;
  final TextEditingController? controller;

  const PasswordInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
    this.errorText,
    this.controller,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.label),
            const SizedBox(
              width: 4,
            ),
            if (widget.required)
              const Text(
                '*',
                style: TextStyle(
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
        TextFormField(
          controller: widget.controller,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.text,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.help,
            errorText: widget.errorText,
            border: const OutlineInputBorder(),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
