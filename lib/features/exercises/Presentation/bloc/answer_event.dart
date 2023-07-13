part of 'answer_bloc.dart';

@immutable
abstract class AnswerEvent {}

class GetFourAnswerByExersiceID extends AnswerEvent {
  final String id_exercise;

  GetFourAnswerByExersiceID({required this.id_exercise});
}
