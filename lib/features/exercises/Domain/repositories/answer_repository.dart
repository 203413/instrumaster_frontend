import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';

abstract class AnswerRepository {
  Future<List<Answer>> getFourAnswerByExersiceID(String id_exercise);
}
