import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/post/business/entities/post_entity.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class QuotedPostItem extends StatelessWidget {
  final PostEntity? quotedPost;

  const QuotedPostItem({
    super.key,
    required this.quotedPost,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profil', arguments: UserProfilArguments(quotedPost!.userId));
                    },
                    child: ProfilPicture(
                      radius: 15,
                      imagePath: quotedPost?.authorPfp,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    quotedPost?.username ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    datetimeToFormattedString('dd MMM yyyy', quotedPost!.postDate),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                quotedPost?.content ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 7),
              Text(
                "${quotedPost?.comments ?? 0} réponse - ${quotedPost?.likes ?? 0} ${quotedPost!.likes > 1 ? 'j\'aimes' : 'j\'aime'}",
                style: const TextStyle(
                  color: AppColors.lightGray,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
