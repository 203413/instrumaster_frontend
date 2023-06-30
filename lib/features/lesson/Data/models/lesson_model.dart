// ignore_for_file: non_constant_identifier_names

import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';

class LessonModel extends Lesson {
  LessonModel({
    required String id,
    required String id_course,
    required String lesson_name,
    required String level,
    required String stars,
    required String lesson_icon,
  }) : super(
            id: id,
            id_course: id_course,
            lesson_name: lesson_name,
            level: level,
            stars: stars,
            lesson_icon: lesson_icon);

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
        id: json['id'],
        id_course: json['id_course'],
        lesson_name: json['lesson_name'],
        level: json['level'],
        stars: json['stars'],
        lesson_icon: json['lesson_icon']);
  }

  factory LessonModel.fromEntity(Lesson lesson) {
    return LessonModel(
      id: lesson.id,
      id_course: lesson.id_course,
      lesson_name: lesson.lesson_name,
      level: lesson.level,
      stars: lesson.stars,
      lesson_icon: lesson.lesson_icon,
    );
  }
}
