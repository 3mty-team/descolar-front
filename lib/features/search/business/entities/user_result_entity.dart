class UserResultEntity {
  final String uuid;
  final String username;
  final String firstName;
  final String lastName;
  final int followersNb;
  final String? userPfp;

  const UserResultEntity({
    required this.uuid,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.followersNb,
    this.userPfp,
  });
}
