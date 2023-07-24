
import 'package:instrumaster_v1/features/users/Domain/entities/user.dart';

import '../repositories/user_repository.dart';

class RegisterUseCase {
  final UserRepository userRepository;

  RegisterUseCase(this.userRepository);

  Future<void> execute(User user) async {
    print('Esta entrand al bloc');
    return await userRepository.register(user);
  }
}
