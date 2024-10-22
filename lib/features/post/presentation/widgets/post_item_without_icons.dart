import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_media_display.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/presentation/widgets/post_pop_menu.dart';
import 'package:descolar_front/features/post/presentation/widgets/quoted_post_item.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class PostItemWithoutIcons extends StatefulWidget {
  final PostEntity post;

  const PostItemWithoutIcons({
    super.key,
    required this.post,
  });

  @override
  State<PostItemWithoutIcons> createState() => _PostItemWithoutIconsState();
}

class _PostItemWithoutIconsState extends State<PostItemWithoutIcons> {
  bool isLiked = false;

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
                  Navigator.pushNamed(context, '/profil', arguments: UserProfilArguments(widget.post.userId));
                },
                child: ProfilPicture(
                  radius: 20,
                  imagePath: widget.post.authorPfp,
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
                          widget.post.username,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        Text(datetimeToFormattedString('dd MMM yyyy', widget.post.postDate)),
                        const SizedBox(width: 10),
                        PostPopMenu(post: widget.post, provider: provider),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.post.content,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Visibility(
                      visible: widget.post.mediasPath != null && widget.post.mediasPath!.isNotEmpty,
                      child: PostImageDisplay(mediasPath: widget.post.mediasPath),
                    ),
                    Visibility(
                      visible: widget.post.repostedPost != null,
                      child: widget.post.repostedPost != null ? QuotedPostItem(quotedPost: widget.post.repostedPost) : const SizedBox(),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "${widget.post.comments} réponse - ${widget.post.likes} j'aime",
                      style: const TextStyle(
                        color: AppColors.lightGray,
                        fontSize: 15,
                      ),
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
