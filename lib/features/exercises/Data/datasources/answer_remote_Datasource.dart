import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../../../../baseURL.dart';
import '../../Domain/entities/answer.dart';
import '../models/answer_model.dart';

abstract class AnswerRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Answer>> getFourAnswerByExersiceID(String id_exercise);
}

class AnswerRemoteDataSourceImp implements AnswerRemoteDataSource {
  @override
  Future<List<AnswerModel>> getFourAnswerByExersiceID(
      String id_exercise) async {
    //print('DataSource');
    var url = Uri.http(serverURL, '/answer/four/$id_exercise');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Datos de respuestassssssssssssssssssssss recibidos');
      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results1 = jsonResponse['data'];
      var results = results1['answer'];
      print(results);
      if (results == null) {
        print('datos nulso');
      }
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      List<AnswerModel> CoursesList = resultlist.map((result) {
        return AnswerModel(
            id: result['id'],
            id_exercise: result['id_exercise'],
            multimedia: result['multimedia'],
            answer: result['answer'],
            is_correct: result['is_correct']);
      }).toList();
      print('Datos de respuestas enviados');
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
