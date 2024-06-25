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
    UserProfilEntity testReceiver = const UserProfilEntity(
      uuid: 'f442c0bd-c321-4c26-b3c3-f8b074159c34',
      firstname: 'Yohan',
      lastname: 'Rudny',
      username: 'Zakiryo',
      followers: [],
      following: [],
      pfpPath: null,
    );

    List<ConversationModel> conversations = [];

    final jsonStringList = sharedPreferences.getStringList(cachedConversations);

    if (jsonStringList != null) {
      jsonStringList.forEach((jsonString) {
        final data = json.decode(jsonString);
        conversations.add(ConversationModel.fromJson(json: data));
      });
    }

    return Future(() => conversations);
  }

  @override
  Future<bool> cacheConversation(ConversationModel conversation) async {
    // TODO : Check if conversation already exist, if yes delete and add it at the end of the list
    //  (and show the list in reverse on the page)
    List<ConversationModel> conversations = await getConversations();
    conversations.add(conversation);
    sharedPreferences.setStringList(cachedConversations, conversations.map((c) => json.encode(c.toJson())).toList());
    return true;
  }
}
