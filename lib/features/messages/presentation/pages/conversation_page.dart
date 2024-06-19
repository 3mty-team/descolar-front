import 'dart:convert';

import 'package:descolar_front/features/messages/presentation/provider/message_provider.dart';
import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:descolar_front/features/messages/presentation/widgets/send_message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:descolar_front/features/auth/data/models/user_model.dart';
import 'package:descolar_front/core/components/app_bars.dart';

class ConversationPage extends StatefulWidget {
  final UserModel receiver;

  const ConversationPage({
    super.key,
    required this.receiver,
  });

  @override
  State<StatefulWidget> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://websocket.descolar.fr:8000/'),
  );

  // final channel = IOWebSocketChannel.connect(
  //   Uri.parse('ws://echo.websocket.org'),
  // );

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      MessageProvider provider = Provider.of<MessageProvider>(context, listen: false);
      channel.ready.then(
        (value) {
          // Listen answers
          channel.stream.listen(
            (data) {
              debugPrint(data);
              // provider.sendMessage(data, true); // Test with ws://echo.websocket.org
              data = json.decode(data);
              if (data['message'] != null) {
                provider.sendMessage(data['message'], true);
              }
            },
            onDone: () {
              debugPrint('ws channel closed');
            },
            onError: (error) {
              debugPrint('ws error $error');
            },
          );

          // Connect to websocket channel
          // // Sender
          // channel.sink.add(
          //   json.encode({
          //     'method': 'register',
          //     'userUUID': 'b01f6aad-48f7-4e6d-b627-bb294912e692', // badoux
          //   }),
          // );

          // // Receiver
          // channel.sink.add(
          //   json.encode({
          //     'method': 'register',
          //     'userUUID': '3460046c-593a-4c02-87f0-d5b6f72e86bc', // tosu (email not verified)
          //     // 'userUUID': '84218e05-a355-4888-b1dd-400909b021b2', // Zakiryo
          //   }),
          // );

          // channel.sink.add(
          //   json.encode({
          //     'method': 'send',
          //     'fromUUID': 'b01f6aad-48f7-4e6d-b627-bb294912e692',
          //     'toUUID': '3460046c-593a-4c02-87f0-d5b6f72e86bc',
          //     'message': 'TEEEST',
          //   }),
          // );
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close().then((value) {
      debugPrint(value);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MessageProvider provider = Provider.of<MessageProvider>(context);

    return Scaffold(
      appBar: AppBars.conversationAppBar(context, widget.receiver),
      body: Column(
        children: [
          const Spacer(),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.messages.length,
              itemBuilder: (context, index) => provider.messages[index],
            ),
          ),
          SendMessageBar(
            channel: channel,
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}
