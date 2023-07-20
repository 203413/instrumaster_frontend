class User {
  int id_user;

  String username;
  String email;
  String? password;

  User({
    required this.id_user,
    required this.username,
    required this.email,
    this.password,
  });
}
