import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;

  const TextInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.maxLength,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
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
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.help,
            border: const OutlineInputBorder(),
            errorText: widget.errorText,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }
}