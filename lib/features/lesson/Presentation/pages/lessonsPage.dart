// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/pages/single_lesson_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late int stars = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LessonsBloc>(context)
        .add(GetLessonsByCourseID(id_lesson: widget.arg));
    // context
    //     .read<LessonsBloc>()
    //     .add(GetLessonsByCourseID(id_lesson: widget.arg));
    print(widget.arg);
    veirfy();
  }

  Future<void> veirfy() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('idprogress');
    print("Shared 1: " + id.toString());
    final api = "https://instrumaster.iothings.com.mx/api/v1/progress/$id";
    final dio = Dio();
    final Response response = await dio.get(api);

    if (response.statusCode == 200) {
      print(response.data);
      Map<String, dynamic> responseData = response.data;
      setState(() {
        stars = responseData['stars'];
      });
    } else {
      print("Failed to fetch data. Status code: ${response.statusCode}");
    }
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

          print("Hey" + intermediateLessons[0].lesson_name);
          int userStars = stars;

          Color begginerColor = Color(0xFFFDBE00);
          bool intermediatedlock = false;
          bool advancedlock = false;

          if (stars > 60) {
            intermediatedlock = true;
          }
          if (stars > 80) {
            advancedlock = true;
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(0xFFFDBE00),
                    title: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/guitar.svg',
                          width: 45,
                        ), // Icono a la izquierda
                        SizedBox(
                            width:
                                8.0), // Espacio entre el icono y el rectángulo
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  ), // Icono en el rectángulo
                                  SizedBox(
                                      width:
                                          4.0), // Espacio entre el icono y el texto
                                  Text(
                                    userStars.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ), // Texto en el rectángulo
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _lessonTittle('Principiante'),
                  _lessonBuild(beginnerLessons, true),
                  _lessonTittle('Intermedio'),
                  _lessonBuild(intermediateLessons, intermediatedlock),
                  _lessonTittle('Avanzado'),
                  _lessonBuild(advancedLessons, advancedlock),
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

  Widget _lessonBuild(lessons, islocked) {
    if (islocked == true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos círculos por fila
          ),
          itemCount: lessons.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SingleLessonPage(arg: lessons[index])));
              },
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
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SvgPicture.asset('assets/images/' +
                            lessons[index].lesson_icon +
                            ".svg"),
                      ),
                    ),
                  ),
                  Text(
                    lessons[index].lesson_name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos círculos por fila
          ),
          itemCount: lessons.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Center(
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFEE599),
                      // Cambia el color del círculo si lo deseas
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SvgPicture.asset(
                        'assets/images/' + lessons[index].lesson_icon + ".svg",
                        // ignore: deprecated_member_use
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
                Text(
                  lessons[index].lesson_name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            );
          },
        ),
      );
    }
  }
}
