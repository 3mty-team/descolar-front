class UserProfilEntity {
  final String uuid;
  final String firstname;
  final String lastname;
  final String username;
  final String diploma;
  final String formation;
  final List<UserProfilEntity> followers; // users that follows this
  final List<UserProfilEntity> following; // users that this follows
  final String? pfpPath;
  final String? bannerPath;
  final String? biography;

  const UserProfilEntity({
    required this.uuid,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.diploma,
    required this.formation,
    required this.followers,
    required this.following,
    this.pfpPath,
    this.bannerPath,
    this.biography,
  });
}
