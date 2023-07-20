import 'package:instrumaster_v1/features/users/Domain/entities/progress.dart';

class ProgressModel extends Progress {
  ProgressModel({
    required int id,
    required int id_course,
    required String course_name,
    required int level,
    required int stars,
    required int user,
  }) : super(
          id: id,
          id_course: id_course,
          course_name: course_name,
          level: level,
          stars: stars,
          user: user,
        );

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['id'],
      id_course: json['id_course'],
      course_name: json['course_name'],
      level: json['level'],
      stars: json['stars'],
      user: json['user'],
    );
  }

  factory ProgressModel.fromEntity(Progress lesson) {
    return ProgressModel(
        id: lesson.id,
        id_course: lesson.id_course,
        course_name: lesson.course_name,
        level: lesson.level,
        stars: lesson.stars,
        user: lesson.user);
  }
}
