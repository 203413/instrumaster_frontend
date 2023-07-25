import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/answer_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import '../../../lesson/Presentation/pages/quiztest.dart';
import '../../../lesson/Presentation/widgets/bnavigationbar.dart';

class ExercisesPage extends StatefulWidget {
  final String arg;
  const ExercisesPage({super.key, required this.arg});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  late String selectedOption = '';
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExerciseBloc>(context)
        .add(GetExercisesByLessonID(id_lesson: widget.arg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Loaded) {
          return SingleChildScrollView(
            child: Column(
                children: state.exercises.map((exercise) {
              BlocProvider.of<AnswerBloc>(context).add(
                  GetFourAnswerByExersiceID(
                      id_exercise: exercise.id.toString()));
              print(exercise.id.toString());
              print('holaaaaa');
              return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                color: Colors.black12,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(exercise.id.toString()),
                      title: Text(exercise.question),
                      subtitle: Text('hola'),
                    ),
                    BlocBuilder<AnswerBloc, AnswerState>(
                        builder: (context, state) {
                      if (state is Loading1) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is Loaded1) {
                        print(state.answers[0].id.toString());
                        print('holaaaaa2');
                        return Column(
                          children: [Text(state.answers[1].id.toString())],
                        );
                      } else if (state is Error1) {
                        print(state.error);
                        return Center(
                          child: Text(state.error,
                              style: const TextStyle(color: Colors.red)),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              );
            }).toList()),
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

  void printSelectedOption() {
    print(selectedOption);
    Navigator.push(context, MaterialPageRoute(builder: (context) => quiz()));
  }

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
