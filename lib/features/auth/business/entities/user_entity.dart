class UserEntity {
  final String email;
  final String lastname;
  final String firstname;
  final DateTime dateOfBirth;
  final String username;
  final String password;

  const UserEntity({
    required this.email,
    required this.lastname,
    required this.firstname,
    required this.dateOfBirth,
    required this.username,
    required this.password,
  });
}
