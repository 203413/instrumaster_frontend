// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import '../../Domain/entities/lesson.dart';
import '../widgets/bnavigationbar.dart';

class LessonsPageTest extends StatefulWidget {
  final String arg;
  const LessonsPageTest({required this.arg});

  @override
  State<LessonsPageTest> createState() => _LessonsPageTestState();
}

class _LessonsPageTestState extends State<LessonsPageTest> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LessonsBloc>(context)
        .add(GetLessonsByCourseID(id_lesson: widget.arg));
    // context
    //     .read<LessonsBloc>()
    //     .add(GetLessonsByCourseID(id_lesson: widget.arg));
    print(widget.arg);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder<LessonsBloc, LessonStatet>(builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          print('AAAA...............................');
          final aux = state.lessons.toString;
          print(aux);
          List<Lesson> allLessons = state
              .lessons; // Obtener la lista completa de lecciones desde el estado

          List<Lesson> beginnerLessons =
              allLessons.where((lesson) => lesson.difficult == "1").toList();
          // ignore: unused_local_variable
          List<Lesson> intermediateLessons =
              allLessons.where((lesson) => lesson.difficult == "2").toList();
          List<Lesson> advancedLessons =
              allLessons.where((lesson) => lesson.difficult == "3").toList();

          print(advancedLessons[0].lesson_name);

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _lessonTittle('Principiante'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Dos círculos por fila
                      ),
                      itemCount: beginnerLessons.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFDBE00),
                                    // Cambia el color del círculo si lo deseas
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                beginnerLessons[index].lesson_name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  _lessonTittle('Intermedio'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Dos círculos por fila
                      ),
                      itemCount: intermediateLessons.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFDBE00),
                                    // Cambia el color del círculo si lo deseas
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                beginnerLessons[index].lesson_name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  _lessonTittle('Avanzado'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Dos círculos por fila
                      ),
                      itemCount: advancedLessons.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFDBE00),
                                    // Cambia el color del círculo si lo deseas
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                beginnerLessons[index].lesson_name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is Error) {
          print(state.error);
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _lessonTittle(String tittle) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: Container(
            color: Colors.black,
            child: SizedBox(
              width: double.infinity,
              height: 2,
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: Text(
              tittle,
              style: TextStyle(
                  color: Color(0xFFFDBE00),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.black,
            child: SizedBox(
              width: double.infinity,
              height: 2,
            ),
          )),
        ],
      ),
    );
  }
}
