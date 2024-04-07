import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final Text username;
  final Text text;
  final Icon profilPicture;
  final PostItem? quote;
  final int likes;
  final int responses;

  const PostItem({
    super.key,
    required this.username,
    required this.likes,
    required this.responses,
    required this.profilPicture,
    required this.text,
    this.quote,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 5, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              widget.profilPicture,
            ],
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.username,
                    const Spacer(),
                    const Icon(Icons.more_horiz, size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                widget.text,
                const SizedBox(height: 7),
                Wrap(
                  spacing: 20,
                  children: [
                    AppAssets.likeIcon,
                    AppAssets.commentIcon,
                    AppAssets.shareIcon,
                  ],
                ),
                const SizedBox(height: 7),
                Text("${widget.responses} réponses - ${widget.likes} J'aime"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
