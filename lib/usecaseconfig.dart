import 'package:instrumaster_v1/features/lesson/Data/datasources/lesson_remote_Datasource.dart';
import 'package:instrumaster_v1/features/lesson/Data/repositories/lesson_repository_impl.dart';

import 'features/course/Data/datasources/course_remote_Datasource.dart';
import 'features/course/Data/repositories/course_repository_impl.dart';
import 'features/course/Domain/usecases/get_courses_usercase.dart';
import 'features/exercises/Data/datasources/exercise_remote_Datasource.dart';
import 'features/exercises/Data/repositories/exercise_repository_impl.dart';
import 'features/exercises/Domain/usecases/get_exercisebylid_usecase.dart';
import 'features/lesson/Domain/usecases/get_lessonsbycid_usecase.dart';

class UsecaseConfig {
  GetCoursesUsecase? getCoursesUsecase;
  CourseRepositoryImpl? courseRepositoryImpl;
  CourseRemoteDataSourceImp? courseRemoteDataSourceImp;

  GetLessonByCIdUsecase? getLessonByCIdUsecase;
  LessonRepositoryImpl? lessonRepositoryImpl;
  LessonRemoteDataSourceImp? lessonRemoteDataSourceImp;

  GetExerciseByLIdUsecase? getExerciseByLIdUsecase;
  ExerciseRepositoryImpl? exerciseRepositoryImpl;
  ExerciseRemoteDataSourceImp? exerciseRemoteDataSourceImp;

  UsecaseConfig() {
    courseRemoteDataSourceImp = CourseRemoteDataSourceImp();
    courseRepositoryImpl = CourseRepositoryImpl(
        courseRemoteDataSource: courseRemoteDataSourceImp!);
    getCoursesUsecase = GetCoursesUsecase(courseRepositoryImpl!);

    lessonRemoteDataSourceImp = LessonRemoteDataSourceImp();
    lessonRepositoryImpl = LessonRepositoryImpl(
        lessonRemoteDataSource: lessonRemoteDataSourceImp!);
    getLessonByCIdUsecase = GetLessonByCIdUsecase(lessonRepositoryImpl!);

    exerciseRemoteDataSourceImp = ExerciseRemoteDataSourceImp();
    exerciseRepositoryImpl = ExerciseRepositoryImpl(
        exerciseRemoteDataSource: exerciseRemoteDataSourceImp!);
    getExerciseByLIdUsecase = GetExerciseByLIdUsecase(exerciseRepositoryImpl!);
  }
}
