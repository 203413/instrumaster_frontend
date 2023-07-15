import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';
import '../../Domain/repositories/exercise_repository.dart';
import '../datasources/exercise_remote_Datasource.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseRemoteDataSource exerciseRemoteDataSource;

  ExerciseRepositoryImpl({
    required this.exerciseRemoteDataSource,
  });

  @override
  Future<List<Exercise>> getExerciseByLessonID(String id_lesson) async {
    //print('Repository');
    return await exerciseRemoteDataSource.getExerciseByLessonID(id_lesson);
  }
}
