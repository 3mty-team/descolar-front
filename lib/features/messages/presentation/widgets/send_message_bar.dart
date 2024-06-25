import 'dart:convert';

import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/messages/presentation/widgets/write_message_bar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SendMessageBar extends StatefulWidget {
  final TextEditingController controller;
  final WebSocketChannel channel;
  final String receiverUUID;

  const SendMessageBar({
    super.key,
    required this.controller,
    required this.channel,
    required this.receiverUUID,
  });

  @override
  State<StatefulWidget> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10,),
      child: Row(
        children: [
          WriteMessageBar(controller: widget.controller),
          PrimaryTextButton(text: 'Envoyer', onTap: () {
            debugPrint('[SENDING MESSAGE] ${widget.controller.text}');
            widget.channel.sink.add(
              json.encode({
                'method': 'send',
                'fromUUID': UserInfo.user.uuid,
                'toUUID': widget.receiverUUID,
                'message': widget.controller.text,
              }),
            );
          },),
        ],
      ),
    );
  }
}
