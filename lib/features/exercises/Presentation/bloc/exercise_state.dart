part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState {}

class Loading extends ExerciseState {}

class Loaded extends ExerciseState {
  final List<Exercise> exercises;

  Loaded({required this.exercises});
}

class Error extends ExerciseState {
  final String error;

  Error({required this.error});
}
