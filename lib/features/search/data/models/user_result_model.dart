import 'package:descolar_front/features/search/business/entities/user_result_entity.dart';

class UserResultModel extends UserResultEntity {
  const UserResultModel({
    required String uuid,
    required String username,
    required String firstName,
    required String lastName,
    required int followersNb,
    String? userPfp,
  }) : super(
          uuid: uuid,
          username: username,
          firstName: firstName,
          lastName: lastName,
          followersNb: followersNb,
          userPfp: userPfp,
        );

  factory UserResultModel.fromJson({required Map<String, dynamic> json}) {
    return UserResultModel(
      uuid: json['uuid'],
      username: json['username'],
      firstName: 'Prénom', //TODO : Get first name and last name
      lastName: 'Nom',
      followersNb: 0, //TODO : Get followers number
      userPfp: json['pfpPath'],
    );
  }
}
