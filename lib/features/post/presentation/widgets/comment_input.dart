import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_input.dart';

class CommentInput extends StatefulWidget {
  final PostEntity post;
  final TextEditingController controller;
  final ActionPostProvider provider;

  const CommentInput({
    super.key,
    required this.post,
    required this.controller,
    required this.provider,
  });

  @override
  State<StatefulWidget> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostInput(
          controller: widget.controller,
          hint: 'Que souhaitez-vous répondre ?',
          maxPostCharacters: 400,
          userIcon: const Icon(Icons.account_circle_rounded, size: 40),
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
                onTap: () {
                  widget.provider.createComment(context, widget.post);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
