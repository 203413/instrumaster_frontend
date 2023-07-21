import 'package:instrumaster_v1/features/users/Data/datasource/user_remote_datasource.dart';
import 'package:instrumaster_v1/features/users/Data/models/profile_model.dart';
import 'package:instrumaster_v1/features/users/Data/models/progress_model.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/authentication.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/user.dart';

import '../../Domain/repositories/user_repository.dart';

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
  Future<ProfileModel> findUserByUsername(int userId) async {
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

  @override
  Future<List<ProgressModel>> getProgressByUserID(int userId) async {
    return await userRemoteDataSource.getProgressByUserID(userId);
  }
}
