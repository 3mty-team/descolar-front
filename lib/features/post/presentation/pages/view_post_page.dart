import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';

import 'package:flutter/material.dart';

class ViewPostPage extends StatefulWidget {
  final PostItem post;

  const ViewPostPage({super.key, required this.post});

  @override
  State<StatefulWidget> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBars.closeIconAppBar(context),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      body: widget.post,
    );
  }
}
