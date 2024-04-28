import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item_without_icons.dart';

import 'package:flutter/material.dart';

class ViewPostPage extends StatefulWidget {
  final PostModel post;

  const ViewPostPage({super.key, required this.post});

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
        ],
      ),
    );
  }
}
