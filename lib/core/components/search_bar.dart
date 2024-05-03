import 'package:flutter/material.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class DescolarSearchBar {
  static Padding searchBar(String placeHolder, TextEditingController controller) {
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
          controller: controller,
          decoration: InputDecoration(
            hintText: placeHolder,
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 0),
          ),
        ),
      ),
    );
  }
}
