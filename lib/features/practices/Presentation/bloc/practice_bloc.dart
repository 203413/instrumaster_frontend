import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../Domain/entities/practice.dart';
import '../../Domain/usecases/get_practicebylid_usecase.dart';

part 'practice_event.dart';
part 'practice_state.dart';

class PracticeBloc extends Bloc<PracticeEvent, PracticeState> {
  final GetPracticeByLIdUsecase getPracticeByLIdUsecase;

  PracticeBloc({required this.getPracticeByLIdUsecase})
      : super(InitialStateP()) {
    on<PracticeEvent>((event, emit) async {
      if (event is GetPracticeByLessonID) {
        try {
          emit(LoadingP());
          List<Practice> response =
              await getPracticeByLIdUsecase.execute(event.id_lesson);
          emit(LoadedP(practices: response));
        } catch (e) {
          emit(ErrorP(error: e.toString()));
        }
      }
    });
  }
}
