import 'package:flutter/material.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/features/post/presentation/widgets/comment_item.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item_without_icons.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';

class ViewPostPage extends StatefulWidget {
  final PostEntity post;

  const ViewPostPage({
    super.key,
    required this.post,
  });

  @override
  State<StatefulWidget> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backAppBar(context),
      body: Column(
        children: [
          const SizedBox(height: 15),
          PostItemWithoutIcons(post: widget.post),
          const Divider(height: 10, color: Colors.grey),
          const SizedBox(height: 5),
          const Text('Réponses'),
          const SizedBox(height: 5),
          Expanded(
            child: ListView(
              children: CachedPost.loadedComments.map((item) {
                return CommentItem(
                  comment: item,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
