part of 'lesson_bloc.dart';

@immutable
abstract class LessonStatet {}


class InitialState extends LessonStatet {}

class Loading extends LessonStatet {}

class Loaded extends LessonStatet {
  final List<Lesson> lessons;

  Loaded({required this.lessons});
}

class Error extends LessonStatet {
  final String error;

  Error({required this.error});
}
