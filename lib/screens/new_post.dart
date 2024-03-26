import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: AppAssets.closeIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              const SizedBox(width: 10),
              AppAssets.addImageIcon,
              const SizedBox(width: 20),
              const Flexible(
                child: TextField(
                  maxLines: null,
                  maxLength: 400,
                  decoration: InputDecoration(
                    hintText: 'Une chose à partager ?',
                    counter: Offstage(),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: addImage,
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

  void processPost() {
    //TODO : Post function
  }

  void addImage() {
    //TODO : Image adding function
  }
}
