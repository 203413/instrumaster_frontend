import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import 'package:instrumaster_v1/features/exercises/Domain/repositories/answer_repository.dart';

class GetFourAnswerByEIdUsecase {
  final AnswerRepository answerRepository;

  GetFourAnswerByEIdUsecase(this.answerRepository);

  Future<List<Answer>> execute(String id_exercise) async {
    return await answerRepository.getFourAnswerByExersiceID(id_exercise);
  }
}
