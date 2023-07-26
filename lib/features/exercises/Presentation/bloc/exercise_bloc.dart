import 'package:bloc/bloc.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';
import 'package:meta/meta.dart';
import '../../Domain/usecases/get_exercisebylid_usecase.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final GetExerciseByLIdUsecase getExerciseByLIdUsecase;

  ExerciseBloc({required this.getExerciseByLIdUsecase})
      : super(InitialState()) {
    on<ExerciseEvent>((event, emit) async {
      if (event is GetExercisesByLessonID) {
        try {
          emit(Loading());
          List<Exercise> response =
              await getExerciseByLIdUsecase.execute(event.id_lesson);
          emit(Loaded(exercises: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
