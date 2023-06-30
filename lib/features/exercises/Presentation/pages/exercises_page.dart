import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/exercises/Presentation/bloc/exercise_bloc.dart';
import '../../../lesson/Presentation/widgets/bnavigationbar.dart';

class ExercisesPage extends StatefulWidget {
  final String arg;
  const ExercisesPage({super.key, required this.arg});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final MyController controller = MyController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExerciseBloc>(context)
        .add(GetExercisesByLessonID(id_lesson: widget.arg));
    // context
    //     .read<LessonsBloc>()
    //     .add(GetLessonsByCourseID(id_lesson: widget.arg));
    print(widget.arg);
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
          print(state.exercises);
          return SingleChildScrollView(
            child: Column(
                children: state.exercises.map((exercise) {
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
                    CheckboxListTile(
                      title: Text('Respuesta 1'),
                      value: controller.values.contains('Respuesta 1'),
                      onChanged: (bool? value) {
                        if (value != null) {
                          controller.updateValue('Respuesta 1', value);
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Respuesta 2'),
                      value: controller.values.contains('Respuesta 2'),
                      onChanged: (bool? value) {
                        if (value != null) {
                          controller.updateValue('Respuesta 2', value);
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        sendData(controller);
                      },
                      child: Text('Enviar Datos'),
                    ),
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

  void sendData(MyController controller) {
    print('Respuestas seleccionadas: ${controller.values}');
  }
}

class MyController {
  List<String> values = [];

  void updateValue(String value, bool checked) {
    if (checked) {
      addValue(value);
    } else {
      removeValue(value);
    }
  }

  void addValue(String value) {
    if (!values.contains(value)) {
      values.add(value);
    }
  }

  void removeValue(String value) {
    if (values.contains(value)) {
      values.remove(value);
    }
  }
}
