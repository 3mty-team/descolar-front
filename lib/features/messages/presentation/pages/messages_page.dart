import 'dart:convert';

import 'package:descolar_front/core/constants/websocket.dart';
import 'package:descolar_front/features/messages/presentation/provider/message_provider.dart';
import 'package:descolar_front/features/messages/presentation/widgets/send_message_bar.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/core/components/app_bars.dart';

class MessagesPage extends StatefulWidget {
  final UserProfilEntity receiver;

  const MessagesPage({
    super.key,
    required this.receiver,
  });

  @override
  State<StatefulWidget> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      MessageProvider provider = Provider.of<MessageProvider>(context, listen: false);
      provider.getMessagesFromDB(widget.receiver.uuid);
    });
  }

  @override
  Widget build(BuildContext context) {
    MessageProvider provider = Provider.of<MessageProvider>(context);

    return Scaffold(
      appBar: AppBars.conversationAppBar(context, widget.receiver),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                shrinkWrap: true,
                controller: provider.scrollController,
                itemCount: provider.messages[widget.receiver.uuid]?.length,
                itemBuilder: (context, index) => provider.messages[widget.receiver.uuid]?[index],
              ),
            ),
          ),

          // Bottom send message bar
          Align(
            alignment: Alignment.bottomCenter,
            child: SendMessageBar(
              channel: WebSocket.channel,
              controller: TextEditingController(),
              receiverUUID: widget.receiver.uuid,
            ),
          ),
        ],
      ),
    );
  }
}
