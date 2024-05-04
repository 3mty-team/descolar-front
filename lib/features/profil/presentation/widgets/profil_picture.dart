import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilPicture extends StatefulWidget {
  final double radius;
  final String? imagePath;
  final double? borderWidth;

  const ProfilPicture({super.key, required this.radius, this.imagePath, this.borderWidth});

  @override
  State<ProfilPicture> createState() => _ProfilPictureState();
}

class _ProfilPictureState extends State<ProfilPicture> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius + (widget.borderWidth ?? 0),
      backgroundColor: AppColors.white,
      child: CircleAvatar(
        radius: widget.radius,
        foregroundImage: widget.imagePath != null
            ? Image.network(
                widget.imagePath!,
              ).image
            : Image.asset(
                'assets/images/pp_placeholder.jpg',
              ).image,
      ),
    );
  }
}
