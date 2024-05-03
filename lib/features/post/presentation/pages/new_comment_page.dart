import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/comment_input.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item_without_icons.dart';
import 'package:descolar_front/core/components/app_bars.dart';

class NewComment extends StatefulWidget {
  final PostEntity post;

  const NewComment({
    super.key,
    required this.post,
  });

  @override
  State<StatefulWidget> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    TextEditingController controller = provider.controller;
    return Scaffold(
      appBar: AppBars.closeIconAppBar(context, controller),
      body: Expanded(
        child: ListView(
          children: [
            PostItemWithoutIcons(post: widget.post),
            CommentInput(post: widget.post, controller: controller, provider: provider),
          ],
        ),
      ),
    );
  }
}
