import '../../Domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required int id_user,
    required String username,
    required String email,
    String? password,
  }) : super(
          id_user: id_user,
          username: username,
          email: email,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id_user: json['id_user'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id_user: user.id_user,
      username: user.username,
      email: user.email,
      password: user.password,
    );
  }
}
