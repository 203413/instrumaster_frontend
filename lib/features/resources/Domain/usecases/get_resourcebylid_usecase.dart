import 'package:instrumaster_v1/features/resources/Domain/entities/resources.dart';

import '../repositories/resources_repository.dart';

class GetResourceByLIdUsecase {
  final ResourceRepository resourceRepository;

  GetResourceByLIdUsecase(this.resourceRepository);

  Future<List<Resource>> execute(String id_exercise) async {
    return await resourceRepository.getResourceByLessonID(id_exercise);
  }
}
