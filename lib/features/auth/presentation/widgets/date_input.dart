import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;

  const DateInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
  });



  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
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
        InputDatePickerFormField(
          firstDate: DateTime(DateTime.now().year - 120),
          lastDate: DateTime.now(),
          fieldLabelText: '',
          fieldHintText: 'jj/mm/yyyy',
        ),
      ],
    );
  }
}
