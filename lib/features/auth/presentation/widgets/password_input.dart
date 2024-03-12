import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;

  const PasswordInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
  });



  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.label),
            const SizedBox(width: 4,),
            if (widget.required) 
              const Text('*',
                style: TextStyle(
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.help,
            border: const OutlineInputBorder(),
            isDense: true, 
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
