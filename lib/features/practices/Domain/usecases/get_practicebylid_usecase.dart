import '../entities/practice.dart';
import '../repositories/practices_repository.dart';

class GetPracticeByLIdUsecase {
  final PracticeRepository practiceRepository;

  GetPracticeByLIdUsecase(this.practiceRepository);

  Future<List<Practice>> execute(String id_lesson) async {
    return await practiceRepository.getPracticeByLessonID(id_lesson);
  }
}
