import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/course/Presentation/bloc/courses_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/login.dart';
import 'package:instrumaster_v1/usecaseconfig.dart';

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
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: LoginPage()));
  }
}
