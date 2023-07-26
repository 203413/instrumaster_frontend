part of 'answer_bloc.dart';

@immutable
abstract class AnswerState {}

class InitialState1 extends AnswerState {}

class Loading1 extends AnswerState {}


class Loaded1 extends AnswerState {
  final List<Answer> answers;

  Loaded1({required this.answers});
}

class Error1 extends AnswerState {
  final String error;

  Error1({required this.error});
}
