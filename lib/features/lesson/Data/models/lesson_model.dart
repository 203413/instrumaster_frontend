// ignore_for_file: non_constant_identifier_names

import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';

class LessonModel extends Lesson {
  LessonModel({
    required int id,
    required int id_lesson,
    required String lesson_name,
    required String level,
    required String star,
    required String lesson_icon,
  }) : super(
            id: id,
            id_lesson: id_lesson,
            lesson_name: lesson_name,
            level: level,
            star: star,
            lesson_icon: lesson_icon);

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
        id: json['id'],
        id_lesson: json['id_lesson'],
        lesson_name: json['lesson_name'],
        level: json['level'],
        star: json['star'],
        lesson_icon: json['lesson_icon']);
  }

  factory LessonModel.fromEntity(Lesson lesson) {
    return LessonModel(
      id: lesson.id,
      id_lesson: lesson.id_lesson,
      lesson_name: lesson.lesson_name,
      level: lesson.level,
      star: lesson.star,
      lesson_icon: lesson.lesson_icon,
    );
  }
}
