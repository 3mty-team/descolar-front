import 'package:flutter/material.dart';

import 'package:descolar_front/features/post/presentation/pages/view_media.dart';

class PostImageDisplay extends StatelessWidget {
  final List<String>? mediasPath;

  const PostImageDisplay({super.key, required this.mediasPath});

  @override
  Widget build(BuildContext context) {
    if (mediasPath == null || mediasPath!.isEmpty) {
      return const SizedBox();
    }

    switch (mediasPath!.length) {
      case 1:
        return _buildSingleImage(context, mediasPath!.first);
      case 2:
        return _buildTwoImages(context, mediasPath!);
      case 3:
        return _buildThreeImages(context, mediasPath!);
      case 4:
      default:
        return _buildFourImages(context, mediasPath!);
    }
  }

  Widget _buildSingleImage(BuildContext context, String imageUrl) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, imageUrl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTwoImages(BuildContext context, List<String> images) {
    return Row(
      children: images.map((url) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _showFullScreenImage(context, url),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThreeImages(BuildContext context, List<String> images) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showFullScreenImage(context, images[0]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: SizedBox(
                height: 150,
                child: Image.network(
                  images[0],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: images.skip(1).map((url) {
            return Expanded(
              child: GestureDetector(
                onTap: () => _showFullScreenImage(context, url),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFourImages(BuildContext context, List<String> images) {
    return Column(
      children: [
        Row(
          children: images.take(2).map((url) {
            return Expanded(
              child: GestureDetector(
                onTap: () => _showFullScreenImage(context, url),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          children: images.skip(2).map((url) {
            return Expanded(
              child: GestureDetector(
                onTap: () => _showFullScreenImage(context, url),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
