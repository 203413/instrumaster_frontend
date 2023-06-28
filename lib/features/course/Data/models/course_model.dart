// ignore_for_file: non_constant_identifier_names

import '../../Domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel(
      {required int id,
      required String course_name,
      required String course_logo})
      : super(id: id, course_name: course_name, course_logo: course_logo);

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        id: json['id'],
        course_name: json['course_name'],
        course_logo: json['course_logo']);
  }

  factory CourseModel.fromEntity(Course course) {
    return CourseModel(
        id: course.id,
        course_name: course.course_name,
        course_logo: course.course_logo);
  }
}
