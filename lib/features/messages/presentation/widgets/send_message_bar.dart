import 'dart:convert';

import 'package:descolar_front/core/components/buttons.dart';
import 'package:descolar_front/features/messages/presentation/widgets/write_message_bar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SendMessageBar extends StatefulWidget {
  final TextEditingController controller;
  final WebSocketChannel channel;

  const SendMessageBar({
    super.key,
    required this.controller,
    required this.channel,
  });

  @override
  State<StatefulWidget> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10, top: 20),
      child: Row(
        children: [
          WriteMessageBar(controller: widget.controller),
          PrimaryTextButton(text: 'Envoyer', onTap: () {
            debugPrint('[SENDING MESSAGE] ${widget.controller.text}');
            // widget.channel.sink.add(widget.controller.text); // Test with ws://echo.websocket.org
            widget.channel.sink.add(
              json.encode({
                'method': 'send',
                'fromUUID': 'b01f6aad-48f7-4e6d-b627-bb294912e692',
                'toUUID': '3460046c-593a-4c02-87f0-d5b6f72e86bc',
                'message': widget.controller.text,
              }),
            );
          },),
        ],
      ),
    );
  }
}
