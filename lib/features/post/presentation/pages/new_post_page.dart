import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/post/presentation/providers/new_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_input.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  static const imagesSize = 150.0;

  @override
  Widget build(BuildContext context) {
    NewPostProvider provider = Provider.of<NewPostProvider>(context);
    TextEditingController controller = provider.controller;
    List<XFile> selectedImages = provider.selectedImages;
    int maxPostImages = provider.maxPostImages;

    return Scaffold(
      appBar: AppBars.closeIconAppBar(context, controller),
      body: Column(
        children: [
          PostInput(
            controller: controller,
            hint: 'Quoi de neuf ?',
            maxPostCharacters: 400,
            userIcon: const Icon(Icons.account_circle_rounded, size: 40),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: selectedImages.map((image) {
                return Stack(
                  children: [
                    Image.file(
                      File(image.path),
                      fit: BoxFit.cover,
                      height: imagesSize,
                      width: imagesSize,
                    ),
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImages.remove(image);
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Text('Images importées : ${selectedImages.length}/$maxPostImages'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: provider.pickImageFromGallery,
                  icon: AppAssets.addImageIcon,
                ),
                const Spacer(),
                PrimaryTextButton(
                  text: 'Poster',
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      provider.processPost(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
