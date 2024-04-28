import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostView extends StatefulWidget {
  final PostModel post;

  const PostView({
    super.key,
    required this.post,
  });

  @override
  State<StatefulWidget> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          PostItem(post: widget.post),
        ],
      ),
    );
  }
}
