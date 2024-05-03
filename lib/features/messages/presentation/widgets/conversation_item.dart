import 'package:descolar_front/features/messages/presentation/pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';

class ConversationItem extends StatefulWidget {
  final UserModel receiver;
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationPage(
          receiver: widget.receiver,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _viewConversation(context),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.account_circle_rounded, size: 50),
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