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

  String? getValidImagePath() {
    if (widget.imagePath != null) {
      if (widget.imagePath!.isEmpty) {
        return null;
      }
      if (widget.imagePath!.length <= 64) {
        return null;
      }
      if (widget.imagePath!.substring(0, 63) != 'https://internal-api.descolar.fr/v1/App/Adapters/Media/Storage/') {
        return null;
      }
    }

    return widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    String? validPath = getValidImagePath();

    return CircleAvatar(
      radius: widget.radius + (widget.borderWidth ?? 0),
      backgroundColor: AppColors.white,
      child: CircleAvatar(
        radius: widget.radius,
        foregroundImage: validPath != null
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
