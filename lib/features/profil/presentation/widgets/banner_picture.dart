import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/presentation/pages/view_media.dart';
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
          ? GestureDetector(
              onTap: () => _showFullScreenImage(context, validPath),
              child: Image.network(
                validPath,
                fit: BoxFit.cover,
              ),
            )
          : GestureDetector(
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.image,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }
}
