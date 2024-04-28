import 'package:flutter/material.dart';

import 'package:descolar_front/core/resources/app_colors.dart';

class SearchConversationBar extends StatefulWidget {
  final TextEditingController? controller;

  const SearchConversationBar({
    super.key,
    this.controller,
  });

  @override
  State<SearchConversationBar> createState() => _SearchConversationBarState();
}

class _SearchConversationBarState extends State<SearchConversationBar> {
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
          decoration: const InputDecoration(
            hintText: 'Rechercher une conversation...',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 0),
          ),
        ),
      ),
    );
  }
}
