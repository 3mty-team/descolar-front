import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_bar.dart';
import 'package:descolar_front/features/auth/data/models/user_model.dart';
import 'package:descolar_front/features/messages/presentation/widgets/conversation_item.dart';

class MessagesMenu extends StatefulWidget {
  const MessagesMenu({super.key});

  @override
  State<StatefulWidget> createState() => _MessagesMenuState();
}

class _MessagesMenuState extends State<MessagesMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO : Récupérer les conversations depuis le cache et
    UserProfilEntity receiver = const UserProfilEntity(
      uuid: 'uuid',
      lastname: 'Nom',
      firstname: 'Prénom',
      username: 'Pseudo',
      followers: [],
      following: [],
    );
    return Scaffold(
      appBar: AppBars.backAppBar(context),
      body: Column(
        children: [
          const ConversationBar(placeHolder: 'Rechercher une conversation...'),
          Expanded(
            child: ListView(
              children: [
                ConversationItem(receiver: receiver, messagePreview: 'messagePreview', time: '5 min'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
