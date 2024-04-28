import 'package:flutter/material.dart';

import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';
import 'package:descolar_front/core/constants/user_info.dart';

class PostPopMenu extends StatefulWidget {
  final PostModel post;
  final ActionPostProvider provider;

  const PostPopMenu({
    super.key,
    required this.post,
    required this.provider,
  });

  @override
  State<PostPopMenu> createState() => _PostPopMenuState();
}

class _PostPopMenuState extends State<PostPopMenu> {
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
          widget.provider.deletePost(context, widget.post);
        }
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> menuItems = [];
        if (widget.post.userId == UserInfo.user.uuid) {
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
        }
        menuItems.add(
          const PopupMenuItem<String>(
            value: 'reportPost',
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.report),
                ),
                Text('Signaler', style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        );
        return menuItems;
      },
    );
  }
}
