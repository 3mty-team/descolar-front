import 'package:flutter/material.dart';
import 'package:descolar_front/core/resources/app_colors.dart';

class MessageItem extends StatefulWidget {
  final String messageText;
  final bool isSentByCurrentUser;

  const MessageItem({
    Key? key,
    required this.messageText,
    required this.isSentByCurrentUser,
  }) : super(key: key);

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: widget.isSentByCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: widget.isSentByCurrentUser ? AppColors.primary : AppColors.lightGray,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.messageText,
                style: const TextStyle(
                  color: AppColors.white,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
