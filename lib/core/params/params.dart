class NoParams {}

class TemplateParams {}

class UserParams {
  final String email;
  final String lastname;
  final String firstname;
  final String dateOfBirth;
  final String username;
  final String password;
  const UserParams({
    required this.email,
    required this.lastname,
    required this.firstname,
    required this.dateOfBirth,
    required this.username,
    required this.password,
  });
}

class UserLoginParams {
  final String username;
  final String password;
  final bool? remember;

  const UserLoginParams({
    required this.username,
    required this.password,
    this.remember = false,
  });
}
