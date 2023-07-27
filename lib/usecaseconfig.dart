import 'package:instrumaster_v1/features/lesson/Data/datasources/lesson_remote_Datasource.dart';
import 'package:instrumaster_v1/features/lesson/Data/repositories/lesson_repository_impl.dart';

import 'features/course/Data/datasources/course_remote_Datasource.dart';
import 'features/course/Data/repositories/course_repository_impl.dart';
import 'features/course/Domain/usecases/get_courses_usercase.dart';
import 'features/exercises/Data/datasources/answer_remote_Datasource.dart';
import 'features/exercises/Data/datasources/exercise_remote_Datasource.dart';
import 'features/exercises/Data/repositories/answer_repository_impl.dart';
import 'features/exercises/Data/repositories/exercise_repository_impl.dart';
import 'features/exercises/Domain/usecases/get_exercisebylid_usecase.dart';
import 'features/exercises/Domain/usecases/get_fouranswerbyeid_usecase.dart';
import 'features/lesson/Domain/usecases/get_lessonsbycid_usecase.dart';
import 'features/practices/Data/datasources/practices_remote_Datasource.dart';
import 'features/practices/Data/repositories/practices_repository_impl.dart';
import 'features/practices/Domain/usecases/get_practicebylid_usecase.dart';
import 'features/users/Domain/usecase/get_progressByUId_usecase.dart';
import 'features/users/Domain/usecase/register_usecase.dart';
import 'features/users/Domain/usecase/view_profile.dart';
import 'features/users/Data/datasource/user_remote_datasource.dart';
import 'features/users/Data/repositories/user_repository_imp.dart';
import 'features/users/Domain/usecase/login_usecase.dart';
import 'features/resources/Data/datasources/resources_remote_Datasource.dart';
import 'features/resources/Data/repositories/resources_repository_impl.dart';
import 'features/resources/Domain/usecases/get_resourcebylid_usecase.dart';

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

  ViewProfileUseCase? viewProfileUseCase;
  LoginUseCase? loginUseCase;
  RegisterUseCase? registerUseCase;
  UserRepositoryImp? userRepositoryImpl;
  UserRemoteDataSourceImp? userRemoteDataSourceImpl;
  GetFourAnswerByEIdUsecase? getFourAnswerByEIdUsecase;
  AnswerRepositoryImpl? answerRepositoryImpl;
  AnswerRemoteDataSourceImp? answerRemoteDataSourceImp;
  GetResourceByLIdUsecase? getResourceByLIdUsecase;
  ResourceRepositoryImpl? resourceRepositoryImpl;
  ResourceRemoteDataSourceImp? resourceRemoteDataSourceImp;
  GetProgressByUId? getProgressByUId;

  GetPracticeByLIdUsecase? getPracticeByLIdUsecase;
  PracticeRepositoryImpl? practiceRepositoryImpl;
  PracticeRemoteDataSourceImp? practiceRemoteDataSourceImp;

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

    userRemoteDataSourceImpl = UserRemoteDataSourceImp();
    userRepositoryImpl =
        UserRepositoryImp(userRemoteDataSource: userRemoteDataSourceImpl!);
    loginUseCase = LoginUseCase(userRepositoryImpl!);
    registerUseCase = RegisterUseCase(userRepositoryImpl!);
    viewProfileUseCase = ViewProfileUseCase(userRepositoryImpl!);
    getProgressByUId = GetProgressByUId(userRepositoryImpl!);
    answerRemoteDataSourceImp = AnswerRemoteDataSourceImp();
    answerRepositoryImpl = AnswerRepositoryImpl(
        answerRemoteDataSource: answerRemoteDataSourceImp!);
    getFourAnswerByEIdUsecase =
        GetFourAnswerByEIdUsecase(answerRepositoryImpl!);

    resourceRemoteDataSourceImp = ResourceRemoteDataSourceImp();
    resourceRepositoryImpl = ResourceRepositoryImpl(
        resourceRemoteDataSource: resourceRemoteDataSourceImp!);
    getResourceByLIdUsecase = GetResourceByLIdUsecase(resourceRepositoryImpl!);

    practiceRemoteDataSourceImp = PracticeRemoteDataSourceImp();
    practiceRepositoryImpl = PracticeRepositoryImpl(
        practiceRemoteDataSource: practiceRemoteDataSourceImp!);
    getPracticeByLIdUsecase = GetPracticeByLIdUsecase(practiceRepositoryImpl!);
  }
}
