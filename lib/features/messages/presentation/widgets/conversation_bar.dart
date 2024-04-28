import 'package:flutter/material.dart';

import 'package:descolar_front/core/resources/app_colors.dart';

class ConversationBar extends StatefulWidget {
  final TextEditingController? controller;
  final String placeHolder;

  const ConversationBar({
    super.key,
    required this.placeHolder,
    this.controller,
  });

  @override
  State<ConversationBar> createState() => _ConversationBarState();
}

class _ConversationBarState extends State<ConversationBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.lightGray,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 0),
          ),
        ),
      ),
    );
  }
}
