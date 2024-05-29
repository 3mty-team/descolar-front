import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class BannerPicture extends StatefulWidget {
  final String? imagePath;

  const BannerPicture({super.key, this.imagePath});

  @override
  State<BannerPicture> createState() => _BannerPictureState();
}

class _BannerPictureState extends State<BannerPicture> {
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

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: validPath != null
          ? Image.network(
              validPath,
              fit: BoxFit.cover,
            )
          : Container(
              color: AppColors.primary,
              child: const Icon(
                Icons.image,
                color: AppColors.primary,
              ),
            ),
    );
  }
}
