// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instrumaster_v1/features/resources/Domain/entities/resources.dart';
import 'package:instrumaster_v1/features/resources/Presentation/bloc/resources_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../exercises/Presentation/bloc/exercise_bloc.dart';
import '../../../exercises/Presentation/pages/tests_exercises.dart';
import '../../../lesson/Presentation/widgets/bnavigationbar.dart';
import '../../../resources/Presentation/pages/info_resource_page.dart';
import '../../../resources/Presentation/pages/video_resource_page.dart';
import '../../Domain/entities/lesson.dart';

class SingleLessonPage extends StatefulWidget {
  final Lesson arg;
  const SingleLessonPage({super.key, required this.arg});

  @override
  State<SingleLessonPage> createState() => _SingleLessonPageState();
}

class _SingleLessonPageState extends State<SingleLessonPage> {
  @override
  void initState() {
    print(widget.arg.lesson_name);
    BlocProvider.of<ResourceBloc>(context)
        .add(GetResourceByLessonID(id_lesson: widget.arg.id));
    BlocProvider.of<ExerciseBloc>(context)
        .add(GetExercisesByLessonID(id_lesson: widget.arg.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xFFFDBE00),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                      child: Center(
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFDBE00),
                            // Cambia el color del círculo si lo deseas
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SvgPicture.asset(
                              'assets/images/' +
                                  widget.arg.lesson_icon +
                                  ".svg",
                              // ignore: deprecated_member_use
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      widget.arg.lesson_name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 60, right: 60, top: 60),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: BlocBuilder<ResourceBloc, ResourceState>(
                                  builder: (context, state) {
                                if (state is LoadingR) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedR) {
                                  List<Resource> allResources = state.resources;
                                  List<Resource> videoResources = allResources
                                      .where((lesson) =>
                                          lesson.resource_type == "video")
                                      .toList();
                                  return Column(
                                    children: videoResources.map((resources) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoResourcesPage(
                                                          arg: resources)));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.square,
                                              color: Color(0xFFFDBE00),
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                resources.name,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                            Icon(
                                              LineIcons.playCircle,
                                              size: 35,
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else if (state is ErrorR) {
                                  print(state.error);
                                  return Center(
                                    child: Text(state.error,
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: BlocBuilder<ResourceBloc, ResourceState>(
                                  builder: (context, state) {
                                if (state is LoadingR) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is LoadedR) {
                                  List<Resource> allResources = state.resources;
                                  List<Resource> infoResources = allResources
                                      .where((lesson) =>
                                          lesson.resource_type == "capsula")
                                      .toList();
                                  return Column(
                                    children: infoResources.map((resources) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      InfoResourcesPage(
                                                          arg: resources)));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.square,
                                              color: Color(0xFFFDBE00),
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                resources.name,
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                            Icon(
                                              LineIcons.infoCircle,
                                              size: 35,
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else if (state is ErrorR) {
                                  print(state.error);
                                  return Center(
                                    child: Text(state.error,
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       LineIcons.square,
                            //       color: Color(0xFFFDBE00),
                            //       size: 30,
                            //     ),
                            //     SizedBox(
                            //       width: 20,
                            //     ),
                            //     Text(
                            //       'Ejercicio',
                            //       style: TextStyle(fontSize: 24),
                            //     ),
                            //     Expanded(child: SizedBox()),
                            //     Icon(
                            //       LineIcons.music,
                            //       size: 35,
                            //     )
                            //   ],
                            // ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: BlocBuilder<ExerciseBloc, ExerciseState>(
                                  builder: (context, state) {
                                if (state is Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is Loaded) {
                                  return Column(
                                    children:
                                        state.exercises.map((modexercises) {
                                      if (state.exercises.length == 0) {
                                        return Container();
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            print('hola');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExercisesPage2(
                                                            arg:
                                                                modexercises)));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                LineIcons.square,
                                                color: Color(0xFFFDBE00),
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Preguntas',
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                              ),
                                              Icon(
                                                LineIcons.questionCircle,
                                                size: 35,
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    }).toList(),
                                  );
                                } else if (state is Error) {
                                  print(state.error);
                                  return Center(
                                      // child: Text(state.error,
                                      //     style: const TextStyle(color: Colors.red)),
                                      );
                                } else {
                                  return Container();
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
