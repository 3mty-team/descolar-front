import 'dart:convert';

import 'package:descolar_front/features/messages/data/models/conversation_model.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MessagesLocalDataSource {
  Future<List<ConversationModel>> getConversations();

  Future<bool> cacheConversation(ConversationModel conversation);
}

const cachedConversations = 'CACHED_CONVERSATIONS';

class MessagesLocalDataSourceImpl implements MessagesLocalDataSource {
  final SharedPreferences sharedPreferences;

  MessagesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ConversationModel>> getConversations() {
    List<ConversationModel> conversations = [];

    final jsonStringList = sharedPreferences.getStringList(cachedConversations);

    if (jsonStringList != null) {
      for (var jsonString in jsonStringList) {
        final data = json.decode(jsonString);
        conversations.add(ConversationModel.fromJson(json: data));
      }
    }

    return Future(() => conversations);
  }

  @override
  Future<bool> cacheConversation(ConversationModel conversation) async {
    List<ConversationModel> conversations = await getConversations();

    conversations.removeWhere((c) => c.receiver.uuid == conversation.receiver.uuid);

    conversations.add(conversation);

    sharedPreferences.setStringList(cachedConversations, conversations.map((c) => json.encode(c.toJson())).toList());

    return true;
  }
}
