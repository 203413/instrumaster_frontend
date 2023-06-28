import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import '../models/lesson_model.dart';

abstract class LessonRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Lesson>> getLessonsByCourseID(int id_lesson);
}

class LessonRemoteDataSourceImp implements LessonRemoteDataSource {
  @override
  Future<List<LessonModel>> getLessonsByCourseID(int id_lesson) async {
    //print('DataSource');
    var url = Uri.https(
        'c8f7-2806-262-3404-a3-d05-ea1f-a256-8683.ngrok-free.app',
        '/lesson/Courseid/$id_lesson');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('wooooooooooooooooo');

      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['data'];
      print(results);
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      List<LessonModel> CoursesList = resultlist.map((result) {
        return LessonModel(
            id: result['id'],
            id_lesson: result['id_lesson'],
            lesson_name: result['lesson_name'],
            level: result['level'],
            star: result['star'],
            lesson_icon: result['lesson_icon']);
      }).toList();

      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
