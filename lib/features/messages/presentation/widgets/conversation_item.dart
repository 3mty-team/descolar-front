import 'package:descolar_front/core/arguments/arguments.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/presentation/widgets/profil_picture.dart';
import 'package:flutter/material.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class ConversationItem extends StatefulWidget {
  final UserProfilEntity receiver;
  final String messagePreview;
  final String time;

  const ConversationItem({
    super.key,
    required this.receiver,
    required this.messagePreview,
    required this.time,
  });

  @override
  State<ConversationItem> createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  void _viewConversation(BuildContext context) {
    Navigator.pushNamed(context, '/message', arguments: MessageProfilArguments(receiver: widget.receiver));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _viewConversation(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ProfilPicture(
              radius: 25,
              imagePath: widget.receiver.pfpPath,
              borderWidth: 2,
            ),
            const SizedBox(width: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.receiver.firstname} ${widget.receiver.lastname}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '@${widget.receiver.username}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  widget.messagePreview,
                  style: const TextStyle(color: AppColors.lightGray),
                ),
              ],
            ),
            const Spacer(),
            Text(
              widget.time,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.lightGray),
            ),
          ],
        ),
      ),
    );
  }
}
