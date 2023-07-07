// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/pages/lessonPageTest.dart';
import '../bloc/courses_bloc.dart';

class CoursesPagePage extends StatefulWidget {
  const CoursesPagePage({super.key});

  @override
  State<CoursesPagePage> createState() => _CoursesPagePageState();
}

class _CoursesPagePageState extends State<CoursesPagePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    context.read<CoursesBloc>().add(GetCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFFDBE00),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_image1.png'),
                repeat: ImageRepeat.repeat)),
        child: SafeArea(
          child:
              BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Loaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(47.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Select your',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Instrument',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 24, left: 40, right: 40),
                        child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color:
                                  Colors.white, // Color del rectángulo blanco
                              borderRadius: BorderRadius.circular(
                                  10.0), // Ajusta el valor de borderRadius para obtener bordes más o menos suavizados
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(
                                      0.3), // Color y opacidad de la sombra
                                  spreadRadius:
                                      2, // Radio de expansión de la sombra
                                  blurRadius: 5, // Desenfoque de la sombra
                                  offset: Offset(0,
                                      3), // Desplazamiento de la sombra (eje x, eje y)
                                ),
                              ],
                            ),
                            child: Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Dos círculos por fila
                                  ),
                                  itemCount: state.courses.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          print(
                                              state.courses[index].course_logo);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LessonsPageTest(
                                                          arg: state
                                                              .courses[index].id
                                                              .toString())));
                                        },
                                        child: Center(
                                          child: Container(
                                            width: 400.0,
                                            height: 400.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFFDBE00),

                                              // Cambia el color del círculo si lo deseas
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: SvgPicture.network(
                                                    state.courses[index]
                                                        .course_logo,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is Error) {
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
      ),
    );
  }
}
