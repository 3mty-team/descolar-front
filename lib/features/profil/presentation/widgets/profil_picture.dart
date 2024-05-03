import 'dart:io';

import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilPicture extends StatefulWidget {
  final double radius;
  final File? imageFile;
  final double? borderWidth;

  const ProfilPicture({super.key, required this.radius, this.imageFile, this.borderWidth});

  @override
  State<ProfilPicture> createState() => _ProfilPictureState();
}

class _ProfilPictureState extends State<ProfilPicture> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(widget.borderWidth ?? 0),
        child: ClipOval(
          child: widget.imageFile != null ?
          Image.file(widget.imageFile!, fit: BoxFit.cover,
          ) :
          Image.asset(
            'assets/images/pp_placeholder.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

