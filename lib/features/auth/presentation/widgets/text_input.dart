import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;

  const TextInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
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
