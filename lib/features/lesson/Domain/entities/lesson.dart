class Lesson {
  final String id;
  final String id_course;
  final String lesson_name;
  final String level;
  final String stars;
  final String lesson_icon;
  final String difficult;

  Lesson({
    required this.id,
    required this.id_course,
    required this.lesson_name,
    required this.level,
    required this.stars,
    required this.lesson_icon,
    required this.difficult,
  });

  getLessonsByCourseID(int id_course) {}
}
