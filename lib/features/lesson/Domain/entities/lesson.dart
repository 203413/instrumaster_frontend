class Lesson {
  final int id;
  final int id_lesson;
  final String lesson_name;
  final String level;
  final String star;
  final String lesson_icon;

  Lesson({
    required this.id,
    required this.id_lesson,
    required this.lesson_name,
    required this.level,
    required this.star,
    required this.lesson_icon,
  });

  getLessonsByCourseID(int id_course) {}
}
