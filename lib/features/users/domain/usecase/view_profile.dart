import '../../Data/models/profile_model.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ViewProfileUseCase {
  final UserRepository userRepository;

  ViewProfileUseCase(this.userRepository);

  Future<ProfileModel> execute(int userId) async {
    return await userRepository.findUserByUsername(userId);
  }
}
