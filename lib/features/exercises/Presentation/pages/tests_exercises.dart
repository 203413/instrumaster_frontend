import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
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
  late List<String> selectedOptions =
      []; // Lista para almacenar las opciones seleccionadas

  bool printSelectedOption(String selectedOption, List<Answer> aux) {
    print(selectedOption);
    bool grade = false;
    aux.asMap().forEach((index, value) {
      if (value.answer == selectedOption && value.is_correct == 1) {
        grade = true;
      }
    });
    return grade;
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ExerciseBloc>(context)
    //     .add(GetExercisesByLessonID(id_lesson: widget.arg));
    selectedOptions = List<String>.filled(4, '');
    //print(widget.arg);
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
              child: ListView.builder(
                itemCount: state.exercises.length,
                itemBuilder: (BuildContext context, int index) {
                  String selectedOption = selectedOptions[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(state.exercises[index].question),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.exercises[index].answers!.length,
                          itemBuilder: (context, answerIndex) {
                            String option = state
                                .exercises[index].answers![answerIndex].answer;
                            return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOptions[index] =
                                        value!; // Actualizar la opción seleccionada en la lista correspondiente al ejercicio
                                  });
                                });
                          }),
                      ElevatedButton(
                        child: Text('Enviar respuesta'),
                        onPressed: () {
                          //print(index);
                          List<Answer>? aux = state.exercises[index].answers;
                          String selectedOption = selectedOptions[
                              index]; // Obtener la opción seleccionada correspondiente al ejercicio
                          if (selectedOption != null) {
                            bool verificador =
                                printSelectedOption(selectedOption, aux!);
                          }
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
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

  // void printSelectedOption() {
  //   print(selectedOption);
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => quiz()));
  // }

  Widget _opcionesTile(String opcion) {
    return RadioListTile<String>(
      title: Text(opcion),
      value: opcion,
      groupValue: selectedOption,
      onChanged: (value) {
        setState(() {
          selectedOption = value!;
        });
      },
    );
  }
}
