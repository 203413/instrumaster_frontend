import 'package:instrumaster_v1/features/exercises/Domain/entities/Exercise.dart';

import '../repositories/exercise_repository.dart';

class GetExerciseByLIdUsecase {
  final ExerciseRepository exerciseRepository;

  GetExerciseByLIdUsecase(this.exerciseRepository);

  Future<List<Exercise>> execute(String id_lesson) async {
    return await exerciseRepository.getExerciseByLessonID(id_lesson);
  }
}
