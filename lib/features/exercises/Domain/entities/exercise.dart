// ignore_for_file: non_constant_identifier_names
import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';

class Exercise {
  final int id;
  final int id_lesson;
  final String question;
  final int stars;
  final String multimedia;
  final String exercise_order;
  final List<Answer>? answers;

  Exercise(
      {required this.id,
      required this.id_lesson,
      required this.question,
      required this.stars,
      required this.multimedia,
      required this.exercise_order,
      this.answers});

  getExerciseByLessonID(int id_lesson) {}
}
