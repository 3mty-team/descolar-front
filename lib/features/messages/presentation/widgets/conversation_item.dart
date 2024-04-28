import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatefulWidget {
  final String fullName;
  final String username;
  final String messagePreview;
  final String time;

  const ConversationItem({
    super.key,
    required this.fullName,
    required this.username,
    required this.messagePreview,
    required this.time,
  });

  @override
  State<ConversationItem> createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.account_circle_rounded, size: 50),
          const SizedBox(width: 7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.fullName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '@${widget.username}',
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
    );
  }
}
