import 'dart:io';

class UserResultEntity {
  final String uuid;
  final String username;
  final int followingNb;
  final int followersNb;
  final File? userPfp;

  const UserResultEntity({
    required this.uuid,
    required this.username,
    required this.followingNb,
    required this.followersNb,
    this.userPfp,
  });
}
