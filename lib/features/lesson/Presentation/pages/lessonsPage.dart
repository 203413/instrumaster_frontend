import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Data/models/lesson_model.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import '../../../exercises/Presentation/pages/exercises_page.dart';
import '../../Domain/entities/lesson.dart';
import '../widgets/bnavigationbar.dart';

class LessonsPage extends StatefulWidget {
  final String arg;
  const LessonsPage({required this.arg});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
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
              allLessons.where((lesson) => lesson.level == "1").toList();
          List<Lesson> intermediateLessons =
              allLessons.where((lesson) => lesson.level == "2").toList();
          List<Lesson> advancedLessons =
              allLessons.where((lesson) => lesson.level == "3").toList();

          print(advancedLessons[0].lesson_name);

          return SingleChildScrollView(
              // child: Column(
              //     children: state.lessons.map((lesson) {
              //   return Container(
              //     margin: EdgeInsets.all(5),
              //     padding: EdgeInsets.all(5),
              //     color: Colors.black12,
              //     child: Column(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) =>
              //                         ExercisesPage(arg: lesson.id)));
              //           },
              //           child: ListTile(
              //             leading: Text(lesson.id.toString()),
              //             title: Text(lesson.lesson_name),
              //             subtitle: Text('hola'),
              //           ),
              //         ),
              //         // Image.network(src)
              //       ],
              //     ),
              //   );
              // }).toList()),
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.black,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      child: Text('Principiante'),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.black,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dos círculos por fila
                    ),
                    itemCount: beginnerLessons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
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
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.black,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      child: Text('Intermedio'),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.black,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dos círculos por fila
                    ),
                    itemCount: intermediateLessons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
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
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.black,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                      ),
                      child: Text('Avanzado'),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.black,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dos círculos por fila
                    ),
                    itemCount: advancedLessons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
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
                        ),
                      );
                    }),
              ),
            ],
          ));
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
}
