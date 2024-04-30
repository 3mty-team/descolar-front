import 'package:descolar_front/features/profil/business/entities/user_profil_entity.dart';

class UserProfilModel extends UserProfilEntity {
  const UserProfilModel({
    required String uuid,
    required String firstname,
    required String lastname,
    required String username,
    required int followers,
    required int followed,
  }) : super(
          uuid: uuid,
          firstname: firstname,
          lastname: lastname,
          username: username,
          followers: followers,
          followed: followed,
        );

  factory UserProfilModel.fromJson({required Map<String, dynamic> json}) {
    // TODO : put json data in UserProfilModel
    return UserProfilModel(
      uuid: json['uuid'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      username: json['username'],
      followers: 727, // TODO
      followed: 4096, // TODO
    );
  }

  Map<String, dynamic> toJson() {
    // TODO : put right json keys and values
    return {
      'uuid': uuid,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'followers': followers,
      'followed': followed,
    };
  }
}
