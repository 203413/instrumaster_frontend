import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/course/Presentation/bloc/courses_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/answer_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import 'package:instrumaster_v1/features/users/Presentation/blocs/user_bloc.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/login.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/passthrough.dart';
import 'package:instrumaster_v1/usecaseconfig.dart';

import 'features/resources/Presentation/bloc/resources_bloc.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CoursesBloc>(
              create: (BuildContext context) => CoursesBloc(
                  getCoursesUsecase: usecaseConfig.getCoursesUsecase!)),
          BlocProvider<LessonsBloc>(
              create: (BuildContext context) => LessonsBloc(
                  getLessonByCIdUsecase: usecaseConfig.getLessonByCIdUsecase!)),
          BlocProvider<ExerciseBloc>(
              create: (BuildContext context) => ExerciseBloc(
                  getExerciseByLIdUsecase:
                      usecaseConfig.getExerciseByLIdUsecase!)),
          BlocProvider<AnswerBloc>(
              create: (BuildContext context) => AnswerBloc(
                  getFourAnswerByEIdUsecase:
                      usecaseConfig.getFourAnswerByEIdUsecase!)),
          BlocProvider<ResourceBloc>(
              create: (BuildContext context) => ResourceBloc(
                  getResourceByLIdUsecase:
                      usecaseConfig.getResourceByLIdUsecase!)),
           BlocProvider<UserAuthentication>(
          create: (BuildContext context) => UserAuthentication(
              loginUseCase: usecaseConfig.loginUseCase!,
              registerUseCase: usecaseConfig.registerUseCase!)),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: LoginPage()));
  }
}
