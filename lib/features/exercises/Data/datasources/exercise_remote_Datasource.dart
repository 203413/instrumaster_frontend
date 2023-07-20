import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:instrumaster_v1/features/exercises/Data/models/answer_model.dart';
import 'package:instrumaster_v1/features/exercises/Data/models/exercise_model.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/exercise.dart';

import '../../../../baseURL.dart';

abstract class ExerciseRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Exercise>> getExerciseByLessonID(String id_lesson);
}

class ExerciseRemoteDataSourceImp implements ExerciseRemoteDataSource {
  @override
  Future<List<ExerciseModel>> getExerciseByLessonID(String id_lesson) async {
    //print('DataSource');
    var url = Uri.http(serverURL, '/exercise/lessonId/$id_lesson');
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
        List<Answer> answers = (result['answers'] as List)
            .map((answer) => Answer(
                  id: answer['id'],
                  id_exercise: answer['id_exercise'],
                  multimedia: answer['multimedia'],
                  answer: answer['answer'],
                  is_correct: answer['is_correct'],
                ))
            .toList();
        return ExerciseModel(
          id: result['id'],
          id_lesson: result['id_lesson'],
          multimedia: result['multimedia'],
          question: result['question'],
          stars: result['stars'],
          exercise_order: result['exercise_order'],
          answers: answers,
        );
      }).toList();

      // CoursesList.asMap().forEach((index, exercise) async {
      //   var url =
      //       Uri.http('35.168.88.197', '/answer/four/' + exercise.id.toString());
      //   var response = await http.get(url);

      //   if (response.statusCode == 200) {
      //     List<Map<String, dynamic>> resultlist = [];
      //     var jsonResponse = convert.jsonDecode(response.body);
      //     var results1 = jsonResponse['data'];
      //     var results = results1['answer'];

      //     resultlist.addAll(List<Map<String, dynamic>>.from(results));
      //     List<AnswerModel> CoursesList2 = resultlist.map((result) {
      //       return AnswerModel(
      //           id: result['id'],
      //           id_exercise: result['id_exercise'],
      //           multimedia: result['multimedia'],
      //           answer: result['answer'],
      //           is_correct: result['is_correct']);
      //     }).toList();

      //     exercise.answers?.add(CoursesList2 as Answer);
      //   }
      // });
      print(CoursesList[0].answers);
      print('Datos de ejercicios enviados');

      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
