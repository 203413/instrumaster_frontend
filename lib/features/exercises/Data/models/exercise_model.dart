// ignore_for_file: non_constant_identifier_names

import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    required int id,
    required int id_lesson,
    required String multimedia,
    required String question,
    required int stars,
    required String exercise_order,
    List<Answer>? answers,
  }) : super(
          id: id,
          id_lesson: id_lesson,
          multimedia: multimedia,
          question: question,
          stars: stars,
          exercise_order: exercise_order,
          answers: answers,
        );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
        id: json['id'],
        id_lesson: json['id_lesson'],
        multimedia: json['multimedia'],
        question: json['question'],
        stars: json['stars'],
        exercise_order: json['exercise_order'],
        answers: json['answer']);
  }

  factory ExerciseModel.fromEntity(Exercise exercise) {
    return ExerciseModel(
        id: exercise.id,
        id_lesson: exercise.id_lesson,
        multimedia: exercise.multimedia,
        question: exercise.question,
        stars: exercise.stars,
        exercise_order: exercise.exercise_order,
        answers: exercise.answers);
  }
}
