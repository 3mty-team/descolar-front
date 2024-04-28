import 'package:flutter/material.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';
import 'package:descolar_front/features/messages/presentation/widgets/search_conversation_bar.dart';

class MessagesMenu extends StatefulWidget {
  const MessagesMenu({super.key});

  @override
  State<StatefulWidget> createState() => _MessagesMenuState();
}

class _MessagesMenuState extends State<MessagesMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backAppBar(context),
      body: Column(
        children: [
          const SearchConversationBar(),
          Expanded(
            child: ListView(
              children: const [
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
                ConversationItem(fullName: 'Prénom Nom', username: 'Pseudo', messagePreview: 'Oh salut ça fait longtemps', time: '5 min'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
