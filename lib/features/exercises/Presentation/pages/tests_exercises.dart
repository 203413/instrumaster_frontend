import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../../../lesson/Presentation/pages/quiztest.dart';
import '../../../lesson/Presentation/widgets/bnavigationbar.dart';

class ExercisesPage2 extends StatefulWidget {
  final Exercise arg;
  const ExercisesPage2({super.key, required this.arg});

  @override
  State<ExercisesPage2> createState() => _ExercisesPage2State();
}

class _ExercisesPage2State extends State<ExercisesPage2> {
  late String selectedOption = '';
  late int Size;
  int Correctones = 0;
  bool areEqual = false;
  late List<String> selectedOptions =
      []; // Lista para almacenar las opciones seleccionadas
  Color switchColor = Colors.black;
  String switchText = 'Verificar respuestas';

  bool printSelectedOption(String selectedOption, List<Answer> aux) {
    //print(selectedOption);
    bool grade = false;
    aux.asMap().forEach((index, value) {
      if (value.answer == selectedOption && value.is_correct == 1) {
        grade = true;
        Correctones++;
      }
    });
    if (grade == false) {
      if (Correctones != 0) {
        Correctones--;
      }
    }
    print(grade);
    return grade;
  }

  @override
  void initState() {
    super.initState();
    selectedOptions = List<String>.filled(4, '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Color(0xFFFDBE00),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: Colors.white,
        body:
            BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.exercises.length,
                      itemBuilder: (BuildContext context, int index) {
                        String selectedOption = selectedOptions[index];
                        Size = state.exercises.length;
                        return Column(
                          children: [
                            ListTile(
                              title: Text(state.exercises[index].question),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    state.exercises[index].answers!.length,
                                itemBuilder: (context, answerIndex) {
                                  String option = state.exercises[index]
                                      .answers![answerIndex].answer;
                                  return RadioListTile<String>(
                                      title: Text(option),
                                      value: option,
                                      groupValue: selectedOption,
                                      onChanged: (value) {
                                        //print('seleccionao');

                                        setState(() {
                                          selectedOptions[index] =
                                              value!; // Actualizar la opción seleccionada en la lista correspondiente al ejercicio
                                        });
                                        List<Answer>? aux =
                                            state.exercises[index].answers;
                                        String selectedOption = selectedOptions[
                                            index]; // Obtener la opción seleccionada correspondiente al ejercicio
                                        // ignore: unnecessary_null_comparison
                                        if (selectedOption != null) {
                                          // ignore: unused_local_variable
                                          bool verificador =
                                              printSelectedOption(
                                                  selectedOption, aux!);
                                        }
                                      });
                                }),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkEquality(state.exercises);
                      print(Correctones.toString() + "/" + Size.toString());
                      if (areEqual == true) {
                        setState(() {
                          switchColor = Colors.green;
                          switchText = 'Correcto';
                        });
                      } else {
                        setState(() {
                          switchColor = Colors.red;
                          switchText = 'Respuestas incorrectas';
                        });
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: switchColor),
                    child: Text(switchText),
                  ),
                ],
              ),
            );
          } else if (state is Error) {
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

  Future<void> checkEquality(List<Exercise> exercises) async {
    // print(exercises[0].question);
    // print(exercises[1].question);
    print('holaaaaaa');
    if (Size == Correctones) {
      print('dar estrellas');
      _verify(exercises);
      setState(() {
        areEqual = true;
      });
    } else {
      print('no dar');
    }
  }

  Future<void> _verify(List<Exercise> exercises) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('idprogress');
    final api = "https://instrumaster.iothings.com.mx/api/v1/progress/$id";
    final dio = Dio();
    final Response response = await dio.get(api);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      List<int> questionCompletedList =
          List<int>.from(responseData['question_completed']);

      int stars = responseData['stars'];

      print("Question Completed: $questionCompletedList");
      int aux = 0;
      exercises.forEach((element) {
        if (questionCompletedList.contains(element.id)) {
          aux++;
        }
      });
      print(aux);
      if (aux == 0) {
        exercises.forEach((element) async {
          int idApi = element.id;
          final api2 =
              "https://instrumaster.iothings.com.mx/api/v1/progress/complete/question/$id";
          final data = {
            "question_id": idApi,
          };
          final Response response2 = await dio.patch(api2, data: data);
          if (response2.statusCode == 200) {
            print(response.data);
          } else {
            print(response.statusCode);
          }
        });
        int userStars = stars + 10;
        final api3 = "https://instrumaster.iothings.com.mx/api/v1/progress/$id";
        final data2 = {
          "stars": userStars,
        };
        final Response response3 = await dio.patch(api3, data: data2);
        if (response3.statusCode == 200) {
          print(response.data);
        } else {
          print(response.data);
        }
      }

      // if (questionCompletedList.contains(widget.arg.id)) {
      //   print("No dar estrellas");
      // } else {
      //   print("Dar estrellas");
      //   final api2 =
      //       "https://instrumaster.iothings.com.mx/api/v1/progress/complete/question/$id";
      //   final data = {
      //     "question_id": widget.arg.id,
      //   };
      //   final Response response2 = await dio.patch(api2, data: data);
      //   if (response2.statusCode == 200) {
      //     print(response.data);
      //   } else {
      //     print(response.data);
      //   }
      // }
    } else {
      print("Failed to fetch data. Status code: ${response.statusCode}");
    }
  }
}
