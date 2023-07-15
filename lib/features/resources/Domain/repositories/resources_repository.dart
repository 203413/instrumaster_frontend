import '../entities/resources.dart';

abstract class ResourceRepository {
  Future<List<Resource>> getResourceByLessonID(String id_lesson);
}
