import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class ConversationEntity {
  final UserProfilEntity receiver;
  final String? messagePreview;
  final int? iat;

  const ConversationEntity({
    required this.receiver,
    required this.messagePreview,
    required this.iat,
  });
}
