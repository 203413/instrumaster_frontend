import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import 'package:instrumaster_v1/features/lesson/Presentation/bloc/lesson_bloc.dart';
import '../../Domain/usecases/get_lessonsbycid_usecase.dart';
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
          print('...............................');
          print(state.lessons);
          return SingleChildScrollView(
            child: Column(
                children: state.lessons.map((course) {
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
                                    LessonsPage(arg: course.id)));
                      },
                      child: ListTile(
                        leading: Text(course.id.toString()),
                        title: Text(course.lesson_name),
                        subtitle: Text('hola'),
                      ),
                    ),
                    // Image.network(src)
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
}
