// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final List<XFile> _selectedImages = [];
  static const MAX_POST_IMAGES = 4;
  static const MAX_POST_CHARACTERS = 400;
  static const IMAGES_SIZE = 150.0;
  static const DEFAULT_USER_ICON = Icon(Icons.account_circle_rounded, size: 40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [

          //User image and post field
          const Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  maxLines: null,
                  maxLength: MAX_POST_CHARACTERS,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 10, left: 5),
                      child: DEFAULT_USER_ICON,
                    ),
                    hintText: 'Quoi de neuf ?',
                    counter: Offstage(),
                  ),
                ),
              ),
            ],
          ),

          //Imported images space
          Padding(
            padding: const EdgeInsets.all(5),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: _selectedImages.map((image) {
                return Stack(
                  children: [
                    Image.file(
                      File(image.path),
                      fit: BoxFit.cover,
                      height: IMAGES_SIZE,
                      width: IMAGES_SIZE,
                    ),
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImages.remove(image);
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
          Text('Images importées : ${_selectedImages.length}/$MAX_POST_IMAGES'),
          const Spacer(),

          //Add image and post buttons
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: _pickImageFromGallery,
                  icon: AppAssets.addImageIcon,
                ),
                const Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: processPost,
                  child: const Text('Poster'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final List<XFile> selection = await ImagePicker().pickMultiImage();

    if (_selectedImages.length < MAX_POST_IMAGES) {
      _selectedImages.addAll(selection);
      setState(() {});
    }
  }
}

void processPost() {
  //TODO : Fonction de publication
}
