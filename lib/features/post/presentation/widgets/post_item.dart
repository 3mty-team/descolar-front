import 'package:descolar_front/features/post/presentation/pages/view_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/post/presentation/widgets/post_pop_menu.dart';
import 'package:descolar_front/features/post/presentation/pages/new_quote_page.dart';
import 'package:descolar_front/features/post/presentation/widgets/quoted_post_item.dart';
import 'package:descolar_front/features/post/presentation/pages/new_comment_page.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/post/data/models/post_model.dart';

class PostItem extends StatefulWidget {
  final PostModel post;

  const PostItem({
    super.key,
    required this.post,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ViewPostPage(post: widget.post)));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 5, bottom: 20),
        child: Stack(
          children: [
            Positioned(
              left: 19,
              top: 40,
              bottom: 0,
              child: Container(
                width: 2,
                color: AppColors.primary,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.account_circle_rounded, size: 40),
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
                          Text(datetimeToFormattedString('dd MMM. yyyy', widget.post.postDate)),
                          const SizedBox(width: 10),
                          PostPopMenu(post: widget.post, provider: provider),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.post.content,
                        style: const TextStyle(fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          //TODO : Faire un appel au back pour get by id car ça marche pas sinon
                        },
                        child: Visibility(
                          visible: widget.post.repostedPost != null,
                          child: widget.post.repostedPost != null ? QuotedPostItem(quotedPost: widget.post.repostedPost) : const SizedBox(),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 15,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => NewQuote(post: widget.post)));
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            // override default min size of 48px
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: AppAssets.shareIcon,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => NewComment(post: widget.post)));
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            // override default min size of 48px
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: AppAssets.commentIcon,
                          ),
                          IconButton(
                            icon: !isLiked ? AppAssets.likeIcon : AppAssets.likedIcon,
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            // override default min size of 48px
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
