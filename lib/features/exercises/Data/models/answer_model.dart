import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';

class AnswerModel extends Answer {
  AnswerModel({
    required int id,
    required int id_exercise,
    required String multimedia,
    required String answer,
    required int is_correct,
  }) : super(
            id: id,
            id_exercise: id_exercise,
            multimedia: multimedia,
            answer: answer,
            is_correct: is_correct);

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'],
      id_exercise: json['id_exercise'],
      multimedia: json['multimedia'],
      answer: json['answer'],
      is_correct: json['is_correct'],
    );
  }

  factory AnswerModel.fromEntity(Answer exercise) {
    return AnswerModel(
      id: exercise.id,
      id_exercise: exercise.id_exercise,
      multimedia: exercise.multimedia,
      answer: exercise.answer,
      is_correct: exercise.is_correct,
    );
  }
}
