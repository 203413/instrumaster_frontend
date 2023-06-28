part of 'lesson_bloc.dart';

@immutable
abstract class LessonEvent {}

class GetLessonsByCourseID extends LessonEvent {
  final int id_lesson;

  GetLessonsByCourseID({required this.id_lesson});
}
