import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;
  final String? errorText;
  final TextEditingController? controller;
  final int? maxLength;

  const PasswordInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
    this.errorText,
    this.controller,
    this.maxLength,
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
              Text(
                '*',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
        TextFormField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.text,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            counter: const Offstage(),
            hintText: widget.hint,
            helperText: widget.help,
            errorText: widget.errorText,
            errorMaxLines: 3,
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
