import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessonsByCourseID(String id_lesson);
}
