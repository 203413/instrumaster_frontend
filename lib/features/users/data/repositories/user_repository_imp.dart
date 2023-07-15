import 'package:instrumaster_v1/features/users/domain/entities/authentication.dart';
import 'package:instrumaster_v1/features/users/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_datasource.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImp({required this.userRemoteDataSource});

  @override
  Future<Authentication> login(String username, String password) async {
    return await userRemoteDataSource.login(username, password);
  }

  @override
  Future<void> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> findUserByUsername(int userId) async {
    return await userRemoteDataSource.viewProfile(userId);
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> register(User user) async {
    return await userRemoteDataSource.register(user);
  }
}