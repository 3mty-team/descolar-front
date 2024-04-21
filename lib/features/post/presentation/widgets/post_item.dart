import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final PostModel post;

  const PostItem({
    super.key,
    required this.post,
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
          const Column(
            children: [
              Icon(Icons.account_circle_rounded, size: 40),
            ],
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(widget.post.username),
                    const Spacer(),
                    const Icon(Icons.more_horiz, size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                Text(widget.post.content),
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
                const Text("${34} réponse(s) - ${3} J'aime(s)"),
                Text(postDateToFrenchFormat(widget.post.postDate)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
