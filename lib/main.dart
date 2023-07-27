import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/course/Presentation/bloc/courses_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/answer_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import 'package:instrumaster_v1/features/users/Presentation/blocs/user_bloc.dart';
import 'package:instrumaster_v1/features/users/Presentation/pages/login.dart';
import 'package:instrumaster_v1/onboarding/pages/onboarding.dart';
import 'package:instrumaster_v1/usecaseconfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/practices/Presentation/bloc/practice_bloc.dart';
import 'features/resources/Presentation/bloc/resources_bloc.dart';
import 'features/users/Presentation/pages/profile.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
          BlocProvider<UserBloc>(
              create: (BuildContext context) => UserBloc(
                  viewProfileUseCase: usecaseConfig.viewProfileUseCase!)),
          BlocProvider<ProgressBloc>(
              create: (BuildContext context) => ProgressBloc(
                  getProgressByUId: usecaseConfig.getProgressByUId!)),
          BlocProvider<PracticeBloc>(
              create: (BuildContext context) => PracticeBloc(
                  getPracticeByLIdUsecase:
                      usecaseConfig.getPracticeByLIdUsecase!)),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Readex Pro'),
            home: Home()));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: getUserIdFromSharedPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          print(
              'Error al obtener el usuario desde SharedPreferences: ${snapshot.error}');
          return OnBoarding();
        } else {
          final int? userId = snapshot.data;
          return userId != null ? ProfilePage() : OnBoarding();
        }
      },
    );
  }

  Future<int?> getUserIdFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
