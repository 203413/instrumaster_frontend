import 'package:instrumaster_v1/features/course/Domain/entities/course.dart';
import 'package:instrumaster_v1/features/course/Domain/repositories/course_repositoy.dart';

class GetCoursesUsecase {
  final CourseRepository courseRepository;

  GetCoursesUsecase(this.courseRepository);

  Future<List<Course>> execute() async {
    return await courseRepository.getPosts();
  }
}
