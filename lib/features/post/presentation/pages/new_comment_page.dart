import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_input.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class NewComment extends StatefulWidget {
  final PostModel post;

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
      body: Column(
        children: [
          PostItem(post: widget.post),
          const PostInput(
            hint: 'Que souhaitez-vous répondre ?',
            maxPostCharacters: 400,
            userIcon: Icon(Icons.account_circle_rounded, size: 40),
          ),
          const Padding(
            padding: EdgeInsets.all(5),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                const Spacer(),
                PrimaryTextButton(
                  text: 'Publier la réponse',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
