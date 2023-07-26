import 'package:bloc/bloc.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import 'package:meta/meta.dart';
import '../../Domain/usecases/get_fouranswerbyeid_usecase.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final GetFourAnswerByEIdUsecase getFourAnswerByEIdUsecase;

  AnswerBloc({required this.getFourAnswerByEIdUsecase})
      : super(InitialState1()) {
    on<AnswerEvent>((event, emit) async {
      if (event is GetFourAnswerByExersiceID) {
        try {
          emit(Loading1());
          List<Answer> response =
              await getFourAnswerByEIdUsecase.execute(event.id_exercise);
          emit(Loaded1(answers: response));
        } catch (e) {
          emit(Error1(error: e.toString()));
        }
      }
    });
  }
}
