import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilPicture extends StatefulWidget {
  final double radius;
  const ProfilPicture({super.key, required this.radius});

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
        padding: const EdgeInsets.all(4),
        child: ClipOval(
          child: Image.asset(
            'assets/images/pp_placeholder.jpg',
            fit: BoxFit.cover,
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}

