import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:flutter/material.dart';

class UserBlockedDetails extends StatelessWidget {
  final UserProfilEntity user;

  const UserBlockedDetails({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ProfilPicture(
            radius: 25,
            imagePath: user.pfpPath,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.firstname} ${user.lastname}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '@${user.username}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),

              // RichText(
              //   text: TextSpan(
              //     style: DefaultTextStyle.of(context).style,
              //     children: [
              //       TextSpan(
              //         text: '${widget.user.followersNb} ',
              //         style: const TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //       TextSpan(
              //         text:
              //         widget.user.followersNb > 1 ? 'abonnés' : 'abonné',
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
