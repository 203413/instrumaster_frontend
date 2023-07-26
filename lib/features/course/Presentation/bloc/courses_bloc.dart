import 'package:bloc/bloc.dart';
import 'package:instrumaster_v1/features/course/Domain/entities/course.dart';
import 'package:meta/meta.dart';

import '../../Domain/usecases/get_courses_usercase.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCoursesUsecase getCoursesUsecase;

  CoursesBloc({required this.getCoursesUsecase}) : super(InitialState()) {
    on<CoursesEvent>((event, emit) async {
      if (event is GetCourses) {
        try {
          emit(Loading());
          List<Course> response = await getCoursesUsecase.execute();
          emit(Loaded(courses: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
