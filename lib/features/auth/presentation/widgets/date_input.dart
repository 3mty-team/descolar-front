import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:flutter/material.dart';

class DateInput extends StatefulWidget {
  final String label;
  final String? hint;
  final String? help;
  final bool required;
  final String? errorText;
  final TextEditingController? controller;

  const DateInput({
    super.key,
    required this.label,
    this.hint,
    this.help,
    this.required = false,
    this.errorText,
    required this.controller,
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
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.help,
            errorText: widget.errorText,
            counter: const Offstage(),
            errorMaxLines: 3,
            border: const OutlineInputBorder(),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              locale: const Locale('fr'),
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 100),
              lastDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
            );

            if (pickedDate != null) {
              String formattedDate = datetimeToFrenchFormat(pickedDate);
              setState(() {
                widget.controller!.text = formattedDate;
              });
            }
          },
        ),
      ],
    );
  }
}
