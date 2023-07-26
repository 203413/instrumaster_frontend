import 'package:bloc/bloc.dart';
import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import 'package:meta/meta.dart';
import '../../Domain/usecases/get_lessonsbycid_usecase.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonsBloc extends Bloc<LessonEvent, LessonStatet> {
  final GetLessonByCIdUsecase getLessonByCIdUsecase;

  LessonsBloc({required this.getLessonByCIdUsecase}) : super(InitialState()) {
    on<LessonEvent>((event, emit) async {
      if (event is GetLessonsByCourseID) {
        try {
          emit(Loading());
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
