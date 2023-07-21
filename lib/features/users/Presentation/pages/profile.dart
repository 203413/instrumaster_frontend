// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/answer_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import 'package:instrumaster_v1/features/users/Presentation/blocs/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../course/Presentation/pages/courses_page.dart';
import '../../../lesson/Presentation/pages/lessonsPage.dart';
import '../../../lesson/Presentation/widgets/bnavigationbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ProfilePage> {
  late String selectedOption = '';
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();

    // final int? user_id = prefs.getInt('user_id');
    // BlocProvider.of<UserBloc>(context).add(GetByUsername(userId: user_id!));
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    final int? user_id = prefs!.getInt('user_id');
    BlocProvider.of<UserBloc>(context).add(GetByUsername(userId: user_id!));
    BlocProvider.of<ProgressBloc>(context)
        .add(GetProgressByUserID(userId: user_id));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: const Color(0xFFFDBE00),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is LoadingUser) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedUser) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_image1.png'),
                      repeat: ImageRepeat.repeat)),
              child: SafeArea(
                top: true,
                child: Column(
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(state.user.icon.image),
                                  radius:
                                      MediaQuery.of(context).size.width * 0.15,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Welcome!',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.user.id_user.username,
                                    style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                        ),
                        // single scroll
                        child: BlocBuilder<ProgressBloc, UserState>(
                            builder: (context, state) {
                          if (state is LoadingProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is LoadedProgress) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  child: Text(
                                    'Mis cursos',
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFF0C4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            3, // Dos círculos por fila
                                      ),
                                      itemCount: state.progress.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LessonsPage(
                                                            arg: state
                                                                .progress[index]
                                                                .id_course
                                                                .toString())));
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                state.progress[index]
                                                    .course_name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFFDBE00),
                                                  // Cambia el color del círculo si lo deseas
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CoursesPage()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFFFDBE00),
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      child: Icon(
                                        Icons.add,
                                        size: 70,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (state is ErrorProgress) {
                            print(state.error);
                            return Center(
                              child: Text(state.error,
                                  style: const TextStyle(color: Colors.red)),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is ErrorUser) {
            print(state.error);
            return Center(
              child:
                  Text(state.error, style: const TextStyle(color: Colors.red)),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

Future<SharedPreferences> _getID() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
