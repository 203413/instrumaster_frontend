// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../lesson/Presentation/pages/lessonsPage.dart';
import '../bloc/courses_bloc.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
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
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 24, left: 40, right: 40),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // Color del rectángulo blanco
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
                          child: SingleChildScrollView(
                            child: Column(
                                children: state.courses.map((course) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                color: Colors.black12,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LessonsPage(
                                                        arg: course.id
                                                            .toString())));
                                      },
                                      // child: ListTile(
                                      //   leading: Text(course.id.toString()),
                                      //   title: Text(course.course_name),
                                      //   subtitle: Text(course.course_logo),
                                      // ),
                                      child: Center(
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors
                                                .red, // Cambia el color del círculo si lo deseas
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Image.network(src)
                                  ],
                                ),
                              );
                            }).toList()),
                          ),
                        ),
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
