part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseEvent {}

class GetExercisesByLessonID extends ExerciseEvent {
  final String id_lesson;

  GetExercisesByLessonID({required this.id_lesson});
}
