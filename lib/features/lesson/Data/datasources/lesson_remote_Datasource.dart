import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:instrumaster_v1/features/lesson/Domain/entities/lesson.dart';
import '../models/lesson_model.dart';

abstract class LessonRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Lesson>> getLessonsByCourseID(String id_lesson);
}

class LessonRemoteDataSourceImp implements LessonRemoteDataSource {
  @override
  Future<List<LessonModel>> getLessonsByCourseID(String id_lesson) async {
    //print('DataSource');
    var url = Uri.http('35.168.88.197', '/lessons/Courseid/$id_lesson');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('wooooooooooooooooo');

      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['data'];
      print(results);
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      print('PRUEBA....................... 1');
      List<LessonModel> CoursesList = resultlist.map((result) {
        return LessonModel(
            id: result['id'].toString(),
            id_course: result['id_course'].toString(),
            lesson_name: result['lesson_name'].toString(),
            level: result['level'].toString(),
            stars: result['stars'].toString(),
            lesson_icon: result['lesson_icon'].toString(),
            difficult: result['difficult'].toString());
      }).toList();
      print('PRUEBA....................... 2');
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
