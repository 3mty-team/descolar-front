import 'package:flutter/material.dart';

import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';
import 'package:descolar_front/core/arguments/arguments.dart';

class UserResultItem extends StatefulWidget {
  final UserResultEntity user;

  const UserResultItem({
    super.key,
    required this.user,
  });

  @override
  State<UserResultItem> createState() => _UserResultItemState();
}

class _UserResultItemState extends State<UserResultItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/profil', arguments: UserProfilArguments(widget.user.uuid));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ProfilPicture(
              radius: 25,
              imagePath: widget.user.userPfp,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '@${widget.user.username}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: '${widget.user.followersNb} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: widget.user.followersNb > 1 ? 'abonnés' : 'abonné',
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
