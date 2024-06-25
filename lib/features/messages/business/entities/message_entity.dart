import 'package:descolar_front/features/auth/business/entities/user_entity.dart';

class MessageEntity {
  final int messageId;
  // TODO : Change to UserProfilEntity
  final UserEntity author;
  final UserEntity receiver;
  final String content;
  final DateTime date;

  const MessageEntity({
    required this.messageId,
    required this.author,
    required this.receiver,
    required this.content,
    required this.date,
  });
}
