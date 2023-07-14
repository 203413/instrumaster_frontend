import 'package:instrumaster_v1/features/users/domain/entities/authentication.dart';

import '../repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase(this.userRepository);

  Future<Authentication> execute(String username, String password) async {
    print("hola");
    return await userRepository.login(username, password);
  }
}
