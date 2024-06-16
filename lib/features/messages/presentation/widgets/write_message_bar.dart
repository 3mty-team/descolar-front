import 'package:flutter/material.dart';

import 'package:descolar_front/core/resources/app_colors.dart';

class WriteMessageBar extends StatefulWidget {
  final TextEditingController? controller;

  const WriteMessageBar({
    super.key,
    this.controller,
  });

  @override
  State<WriteMessageBar> createState() => _WriteMessageBarState();
}

class _WriteMessageBarState extends State<WriteMessageBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightGray,
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          child: TextField(
            controller: widget.controller,
            decoration: const InputDecoration(
              hintText: 'Votre message...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            ),
          ),
        ),
      ),
    );
  }
}
