import 'package:descolar_front/core/utils/date_converter.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uuid,
    required String email,
    required String lastname,
    required String firstname,
    required DateTime dateOfBirth,
    required String username,
    required String password,
  }) : super(
          uuid: uuid,
          email: email,
          lastname: lastname,
          firstname: firstname,
          dateOfBirth: dateOfBirth,
          username: username,
          password: password,
        );

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      uuid: json['uuid'],
      email: json['mail'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      dateOfBirth: formattedStringToDatetime('MM-dd-yyyy', json['date']),
      username: json['username'],
      password: json['password'] ?? '', // Descolar API on register not giving password
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'mail': email,
      'lastname': lastname,
      'firstname': firstname,
      'date': dateOfBirth.toString(),
      'username': username,
      'password': password,
    };
  }
}
