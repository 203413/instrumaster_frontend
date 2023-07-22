// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../lesson/Presentation/pages/lessonsPage.dart';
import '../../Data/models/course_model.dart';
import '../bloc/courses_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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

  _verify(CourseModel state) async {
    int idSelected = state.id;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? user_id = prefs.getInt('user_id');
    var url = Uri.http(
        'instrumaster.iothings.com.mx', '/api/v1/progress/byuser/$user_id');
    var response = await http.get(url);
    bool isRegistred = false;
    final parsedResponse = jsonDecode(response.body);
    var matchingCourses =
        parsedResponse.where((index) => index['id_course'] == idSelected);
    if (matchingCourses.isNotEmpty) {
      isRegistred = true;
    }
    print(isRegistred);
    if (isRegistred == false) {
      var url2 = Uri.https('instrumaster.iothings.com.mx', '/api/v1/progress/');
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      Map<String, dynamic> postData = {
        "id_course": idSelected,
        "course_name": state.course_name.toString(),
        "stars": 0,
        "level": 1,
        "user": user_id
      };
      var body = jsonEncode(postData);
      var response2 = await http.post(url2, body: body, headers: headers);
      if (response2.statusCode == 201) {
        print('Respuesta del servidor: ${response2.body}');
        //print(response2.body['id']);
        var jsonResponse = json.decode(response2.body);
        int aux = jsonResponse['id'];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("idprogress", aux);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LessonsPage(arg: idSelected.toString())));
      } else {
        print('Error en la solicitud: ${response2.body}');
      }
    } else {
      showSnackbar();
    }
  }

  void showSnackbar() {
    Fluttertoast.showToast(
        msg: "Ya estás en este curso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFFFDBE00),
        textColor: Colors.black,
        fontSize: 16.0);
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
                  // ℹ️ Se agregó el widget Expanded para solucionar el desbordamiento
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, left: 40, right: 40),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.courses.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                _verify(state.courses[index] as CourseModel);
                                //print(state.courses[index].course_logo);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LessonsPageTest(
                                //             arg: state.courses[index].id
                                //                 .toString())));
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFFDBE00),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: SvgPicture.asset(
                                              'assets/images/' +
                                                  state.courses[index]
                                                      .course_logo +
                                                  ".svg"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    state.courses[index].course_name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          },
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
