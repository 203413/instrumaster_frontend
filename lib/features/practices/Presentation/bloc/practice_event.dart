part of 'practice_bloc.dart';

@immutable
abstract class PracticeEvent {}

class GetPracticeByLessonID extends PracticeEvent {
  final String id_lesson;

  GetPracticeByLessonID({required this.id_lesson});
}
