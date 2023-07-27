import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../baseURL.dart';
import '../../Domain/entities/practice.dart';
import '../models/practice_model.dart';

abstract class PracticeRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Practice>> getPracticeByLessonID(String id_lesson);
}

class PracticeRemoteDataSourceImp implements PracticeRemoteDataSource {
  @override
  Future<List<PracticeModel>> getPracticeByLessonID(String id_lesson) async {
    //print('DataSource');
    var url = Uri.http(serverURL, '/api/practica/bylesson/$id_lesson');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Datos de reeeeeecursos recibidos');
      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse;
      print(results);
      if (results == null) {
        print('datos nulso');
      }
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      List<PracticeModel> CoursesList = resultlist.map((result) {
        return PracticeModel(
          id: result['id'],
          id_lesson: result['id_lesson'],
          acordeATocar: utf8.decode(result['acordeATocar'].codeUnits),
        );
      }).toList();
      print('Datos de recursos enviados');
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
