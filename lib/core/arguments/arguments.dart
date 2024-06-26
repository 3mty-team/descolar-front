import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class UserProfilArguments {
  final String uuid;
  UserProfilArguments(this.uuid);
}

class MessageProfilArguments {
  final UserProfilEntity receiver;
  MessageProfilArguments({required this.receiver});
}
