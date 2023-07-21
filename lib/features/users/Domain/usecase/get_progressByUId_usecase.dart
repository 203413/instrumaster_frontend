import 'package:instrumaster_v1/features/users/Domain/entities/progress.dart';
import 'package:instrumaster_v1/features/users/Domain/repositories/user_repository.dart';

class GetProgressByUId {
  final UserRepository userRepository;

  GetProgressByUId(this.userRepository);

  Future<List<Progress>> execute(int userId) async {
    return await userRepository.getProgressByUserID(userId);
  }
}
