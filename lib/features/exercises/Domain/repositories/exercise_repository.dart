import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExerciseByLessonID(String id_lesson);
}
