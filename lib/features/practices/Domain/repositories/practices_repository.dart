import '../entities/practice.dart';

abstract class PracticeRepository {
  Future<List<Practice>> getPracticeByLessonID(String id_lesson);
}
