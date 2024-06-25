import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/messages/presentation/provider/message_provider.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_bar.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      MessageProvider provider = Provider.of<MessageProvider>(context, listen: false);
      provider.getConversationFromCache();
    });
  }

  @override
  Widget build(BuildContext context) {
    MessageProvider provider = Provider.of<MessageProvider>(context);

    return Scaffold(
      appBar: AppBars.backAppBar(context),
      body: Column(
        children: [
          const ConversationBar(placeHolder: 'Rechercher une conversation...'),
          Expanded(
            child: ListView.builder(
              itemCount: provider.conversations.length,
              itemBuilder: (context, index) {
                return ConversationItem(receiver: provider.conversations[index].receiver, messagePreview: '...', time: '...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
