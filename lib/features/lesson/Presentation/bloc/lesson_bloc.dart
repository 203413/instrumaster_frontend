import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:instrumaster_v1/features/course/Domain/entities/course.dart';
import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import 'package:meta/meta.dart';

import '../../../course/Presentation/bloc/courses_bloc.dart';
import '../../Domain/usecases/get_lessonsbycid_usecase.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonsBloc extends Bloc<LessonEvent, LessonStatet> {
  final GetLessonByCIdUsecase getLessonByCIdUsecase;

  LessonsBloc({required this.getLessonByCIdUsecase}) : super(Loading()) {
    on<LessonEvent>((event, emit) async {
      if (event is GetLessonsByCourseID) {
        try {
          List<Lesson> response =
              await getLessonByCIdUsecase.execute(event.id_lesson);
          emit(Loaded(lessons: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
