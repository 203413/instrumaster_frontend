import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:instrumaster_v1/features/exercises/Data/models/exercise_model.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/Exercise.dart';

abstract class ExerciseRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Exercise>> getExerciseByLessonID(String id_lesson);
}

class ExerciseRemoteDataSourceImp implements ExerciseRemoteDataSource {
  @override
  Future<List<ExerciseModel>> getExerciseByLessonID(String id_lesson) async {
    //print('DataSource');
    var url = Uri.http('35.168.88.197', '/exercise/lessonId/$id_lesson');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Datos de ejercicio recibidos');
      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['data'];
      print(results);
      if (results == null) {
        print('datos nulso');
      }
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      List<ExerciseModel> CoursesList = resultlist.map((result) {
        return ExerciseModel(
            id: result['id'].toString(),
            id_lesson: result['id_lesson'],
            multimedia: result['multimedia'],
            question: result['question'],
            answer: result['answer'],
            stars: result['stars'],
            exercise_order: result['exercise_order']);
      }).toList();
      print('Datos de ejercicios enviados');
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
