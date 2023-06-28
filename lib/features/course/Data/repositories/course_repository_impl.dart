import 'package:instrumaster_v1/features/course/Domain/entities/course.dart';
import 'package:instrumaster_v1/features/course/Domain/repositories/course_repositoy.dart';
import '../datasources/course_remote_Datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;

  CourseRepositoryImpl({
    required this.courseRemoteDataSource,
  });

  @override
  Future<List<Course>> getPosts() async {
    //print('Repository');
    return await courseRemoteDataSource.getPosts();
  }
}
