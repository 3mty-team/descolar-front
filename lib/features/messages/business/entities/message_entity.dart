import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class MessageEntity {
  final UserProfilEntity sender;
  final UserProfilEntity receiver;
  final String content;
  final DateTime date;

  const MessageEntity({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.date,
  });
}
