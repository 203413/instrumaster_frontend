// ignore_for_file: non_constant_identifier_names

import 'package:instrumaster_v1/features/exercises/Domain/entities/Exercise.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    required String id,
    required String id_lesson,
    required String multimedia,
    required String question,
    required String answer,
    required int stars,
    required String exercise_order,
  }) : super(
            id: id,
            id_lesson: id_lesson,
            multimedia: multimedia,
            question: question,
            answer: answer,
            stars: stars,
            exercise_order: exercise_order);

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
        id: json['id'],
        id_lesson: json['id_lesson'],
        multimedia: json['multimedia'],
        question: json['question'],
        answer: json['answer'],
        stars: json['stars'],
        exercise_order: json['exercise_order']);
  }

  factory ExerciseModel.fromEntity(Exercise exercise) {
    return ExerciseModel(
      id: exercise.id,
      id_lesson: exercise.id_lesson,
      multimedia: exercise.multimedia,
      question: exercise.question,
      answer: exercise.answer,
      stars: exercise.stars,
      exercise_order: exercise.exercise_order,
    );
  }
}
