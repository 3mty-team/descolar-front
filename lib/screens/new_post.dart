import 'package:descolar_front/core/resources/app_assets.dart';
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
      body: Row(
        children: [
          AppAssets.closeIcon,
          const TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Une chose à partager ?',
            ),
          ),
        ],
      ),
    );
  }
}
