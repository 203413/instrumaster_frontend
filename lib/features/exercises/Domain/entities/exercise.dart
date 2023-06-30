class Exercise {
  final String id;
  final String id_lesson;
  final String multimedia;
  final String question;
  final String answer;
  final int stars;
  final String exercise_order;

  Exercise({
    required this.id,
    required this.id_lesson,
    required this.multimedia,
    required this.question,
    required this.answer,
    required this.stars,
    required this.exercise_order,
  });

  getExerciseByLessonID(int id_lesson) {}
}
