import 'package:descolar_front/features/messages/presentation/widgets/message_item.dart';
import 'package:descolar_front/features/messages/presentation/widgets/send_message_bar.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.conversationAppBar(context, widget.receiver),
      body: const Column(
        children: [
          Spacer(),
          MessageItem(
            messageText: 'Salut comment ça va ça fait longtemps',
            isSentByCurrentUser: false,
          ),
          MessageItem(
            messageText: 'ça va et toi',
            isSentByCurrentUser: true,
          ),
          SendMessageBar(),
        ],
      ),
    );
  }
}
