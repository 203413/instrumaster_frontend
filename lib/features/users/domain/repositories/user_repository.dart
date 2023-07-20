import 'package:instrumaster_v1/features/users/Domain/entities/authentication.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/user.dart';

import '../../Data/models/profile_model.dart';
import '../../Data/models/progress_model.dart';

abstract class UserRepository {
  Future<void> register(User user);
  Future<ProfileModel> findUserByUsername(int userId);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  Future<Authentication> login(String username, String password);
  Future<List<ProgressModel>> getProgressByUserID(int userId);
}
