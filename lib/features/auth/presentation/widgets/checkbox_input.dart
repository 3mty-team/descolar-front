import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CheckboxInput extends StatefulWidget {
  final Widget title;
  final bool required;


  const CheckboxInput({
    super.key,
    required this.title,
    this.required = false,
  });

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          if (widget.required)
            const Text(
              '*',
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
          Checkbox(
            value: isChecked,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
          widget.title,
        ],
      ),
    );
  }
}
