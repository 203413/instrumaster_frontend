import 'package:instrumaster_v1/features/course/Domain/entities/course.dart';
import 'package:instrumaster_v1/features/course/Domain/repositories/course_repositoy.dart';
import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import '../../Domain/repositories/lesson_repository.dart';

import '../datasources/lesson_remote_Datasource.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonRemoteDataSource lessonRemoteDataSource;

  LessonRepositoryImpl({
    required this.lessonRemoteDataSource,
  });

  @override
  Future<List<Lesson>> getLessonsByCourseID(int id_lesson) async {
    //print('Repository');
    return await lessonRemoteDataSource.getLessonsByCourseID(id_lesson);
  }
}
