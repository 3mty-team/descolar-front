import 'package:flutter/material.dart';
import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/post/presentation/widgets/quoted_post_item.dart';
import 'package:provider/provider.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/core/constants/cached_posts.dart';
import 'package:descolar_front/features/post/presentation/widgets/post_pop_menu.dart';
import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class PostItem extends StatefulWidget {
  final PostEntity post;

  const PostItem({
    super.key,
    required this.post,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late bool isLiked;
  late int localLikeNumber;

  @override
  void initState() {
    super.initState();
    isLiked = CachedPost.postAlreadyInLikedPost(widget.post);
    localLikeNumber = widget.post.likes;
  }

  @override
  Widget build(BuildContext context) {
    ActionPostProvider provider = Provider.of<ActionPostProvider>(context);
    return InkWell(
      onTap: () async {
        await provider.getAllCommentsInRange(context, widget.post);
        Navigator.pushNamed(context, '/viewPost', arguments: widget.post);
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
                      Visibility(
                        visible: widget.post.repostedPost != null,
                        child: widget.post.repostedPost != null ? QuotedPostItem(quotedPost: widget.post.repostedPost) : const SizedBox(),
                      ),
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 15,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/newQuote', arguments: widget.post);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: AppAssets.shareIcon,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/newComment', arguments: widget.post);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: AppAssets.commentIcon,
                          ),
                          IconButton(
                            icon: !this.isLiked ? AppAssets.likeIcon : AppAssets.likedIcon,
                            onPressed: () async {
                              if (!this.isLiked) {
                                await provider.likePost(context, widget.post);
                                setState(() {
                                  isLiked = !isLiked;
                                  ++localLikeNumber;
                                });
                              } else {
                                await provider.unlikePost(context, widget.post);
                                setState(() {
                                  isLiked = !isLiked;
                                  --localLikeNumber;
                                });
                              }
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "${widget.post.comments} ${widget.post.comments > 1 ? 'réponses' : 'réponse'} - $localLikeNumber ${localLikeNumber > 1 ? 'j\'aimes' : 'j\'aime'}",
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
