import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/messages/business/entities/message_entity.dart';
import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';
import 'package:descolar_front/features/profil/data/models/user_profil_model.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required UserProfilEntity sender,
    required UserProfilEntity receiver,
    required String content,
    required DateTime date,
  }) : super(
    sender: sender,
    receiver: receiver,
    content: content,
    date: date,
  );

  factory MessageModel.fromJson({required Map<String, dynamic> json}) {
    return MessageModel(
      sender: UserProfilModel.fromJson(json: json['sender']),
      receiver: UserProfilModel.fromJson(json: json['receiver']),
      content: json['content'],
      date: stringToDatetime(json['date']['date']),
    );
  }

  Map<String, dynamic> toJson() {
    UserProfilModel receiverModel = UserProfilModel(
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
    UserProfilModel authorModel = UserProfilModel(
      uuid: sender.uuid,
      firstname: sender.firstname,
      lastname: sender.lastname,
      username: sender.username,
      followers: sender.followers,
      following: sender.following,
      pfpPath: sender.pfpPath,
      bannerPath: sender.bannerPath,
      diploma: sender.diploma,
      formation: sender.formation,
      biography: sender.biography,
    );
    return {
      'author': authorModel.toJson(),
      'receiver': receiverModel.toJson(),
      'content': content,
      'date': date,
    };
  }
}
