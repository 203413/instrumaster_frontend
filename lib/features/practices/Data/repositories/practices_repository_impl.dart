import '../../Domain/entities/practice.dart';
import '../../Domain/repositories/practices_repository.dart';
import '../datasources/practices_remote_Datasource.dart';

class PracticeRepositoryImpl implements PracticeRepository {
  final PracticeRemoteDataSource practiceRemoteDataSource;

  PracticeRepositoryImpl({
    required this.practiceRemoteDataSource,
  });

  @override
  Future<List<Practice>> getPracticeByLessonID(String id_lesson) async {
    return await practiceRemoteDataSource.getPracticeByLessonID(id_lesson);
  }
}
