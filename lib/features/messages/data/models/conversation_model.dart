import 'package:descolar_front/features/messages/business/entities/conversation_entity.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';

class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required UserProfilEntity receiver,
    required String? messagePreview,
    required int? iat,
  }) : super(
          receiver: receiver,
          messagePreview: messagePreview,
          iat: iat,
        );

  factory ConversationModel.fromJson({required Map<String, dynamic> json}) {
    return ConversationModel(
      receiver: UserProfilModel.fromJson(json: json['receiver']),
      messagePreview: json['messagePreview'],
      iat: json['iat'],
    );
  }

  Map<String, dynamic> toJson() {
    UserProfilModel userProfilModel = UserProfilModel(
      uuid: receiver.uuid,
      firstname: receiver.firstname,
      lastname: receiver.lastname,
      username: receiver.username,
      followers: receiver.followers,
      following: receiver.following,
      pfpPath: receiver.pfpPath,
      bannerPath: receiver.bannerPath,
      diploma: receiver.diploma,
      formation: receiver.formation,
      biography: receiver.biography,
    );
    return {
      'receiver': userProfilModel.toJson(),
      'messagePreview': messagePreview,
      'iat': iat,
    };
  }
}
