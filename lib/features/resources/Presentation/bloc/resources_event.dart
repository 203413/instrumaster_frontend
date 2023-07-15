part of 'resources_bloc.dart';

@immutable
abstract class ResourceEvent {}

class GetResourceByLessonID extends ResourceEvent {
  final String id_lesson;

  GetResourceByLessonID({required this.id_lesson});
}
