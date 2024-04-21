import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

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
      child: Stack(
        children: [
          Positioned(
            left: 19,
            top: 40,
            bottom: 0,
            child: Container(
              width: 2,
              color: AppColors.primary,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle_rounded, size: 40),
              const SizedBox(width: 5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          widget.post.username,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        Text(postDateToFrenchFormat(widget.post.postDate)),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          // override default min size of 48px
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: const Icon(Icons.more_horiz, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.post.content,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      spacing: 15,
                      children: [
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          // override default min size of 48px
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: AppAssets.shareIcon,
                        ),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          // override default min size of 48px
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: AppAssets.commentIcon,
                        ),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          // override default min size of 48px
                          style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: AppAssets.likeIcon,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "${widget.post.comments} réponse - ${widget.post.likes} j'aime",
                      style: const TextStyle(
                        color: AppColors.lightGray,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
