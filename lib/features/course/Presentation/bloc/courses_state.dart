part of 'courses_bloc.dart';

@immutable
abstract class CoursesState {}

class InitialState extends CoursesState {}

class Loading extends CoursesState {}

class Loaded extends CoursesState {
  final List<Course> courses;

  Loaded({required this.courses});
}

class Error extends CoursesState {
  final String error;

  Error({required this.error});
}
