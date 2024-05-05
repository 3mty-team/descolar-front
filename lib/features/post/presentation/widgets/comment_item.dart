import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/features/post/business/entities/comment_entity.dart';
import 'package:descolar_front/features/post/presentation/widgets/comment_pop_menu.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';

class CommentItem extends StatefulWidget {
  final CommentEntity comment;

  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 5, bottom: 20),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profil', arguments: UserProfilArguments(widget.comment.userID));
                },
                child: ProfilPicture(
                  radius: 20,
                  imagePath: widget.comment.authorPfp,
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          widget.comment.username,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        Text(datetimeToFormattedString('dd MMM yyyy', widget.comment.commentDate)),
                        const SizedBox(width: 10),
                        Visibility(
                          visible: widget.comment.userID == UserInfo.user.uuid,
                          child: CommentPopMenu(
                            comment: widget.comment,
                            provider: provider,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.comment.content,
                      style: const TextStyle(fontSize: 16),
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
