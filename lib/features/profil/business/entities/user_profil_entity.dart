class UserProfilEntity {
  final String uuid;
  final String firstname;
  final String lastname;
  final String username;
  final int followers; // users that follows this // TODO : list of user
  final int followed; // users that this follows // TODO : list of user
  // final Image pp;
  // final Image bg;

  const UserProfilEntity({
    required this.uuid,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.followers,
    required this.followed,
  });
}
