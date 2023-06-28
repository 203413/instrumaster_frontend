import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import 'package:instrumaster_v1/features/lesson/Domain/repositories/lesson_repository.dart';

class GetLessonByCIdUsecase {
  final LessonRepository lessonRepository;

  GetLessonByCIdUsecase(this.lessonRepository);

  Future<List<Lesson>> execute(String id_lesson) async {
    return await lessonRepository.getLessonsByCourseID(id_lesson);
  }
}
