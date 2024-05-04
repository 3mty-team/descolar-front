import 'package:flutter/material.dart';

import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class CommentPopMenu extends StatefulWidget {
  final CommentEntity comment;
  final ActionPostProvider provider;

  const CommentPopMenu({
    super.key,
    required this.comment,
    required this.provider,
  });

  @override
  State<CommentPopMenu> createState() => _CommentPopMenuState();
}

class _CommentPopMenuState extends State<CommentPopMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: const Icon(Icons.more_horiz, size: 20),
      ),
      onSelected: (value) {
        if (value == 'deletePost') {
          widget.provider.deleteComment(context, widget.comment);
        }
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> menuItems = [];
        menuItems.add(
          const PopupMenuItem<String>(
            value: 'deletePost',
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.delete),
                ),
                Text('Supprimer', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        );
        return menuItems;
      },
    );
  }
}
