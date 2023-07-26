import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../baseURL.dart';
import '../../Domain/entities/resources.dart';
import '../models/resources_model.dart';

abstract class ResourceRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<Resource>> getResourceByLessonID(String id_lesson);
}

class ResourceRemoteDataSourceImp implements ResourceRemoteDataSource {
  @override
  Future<List<ResourceModel>> getResourceByLessonID(String id_lesson) async {
    //print('DataSource');
    var url = Uri.http(serverURL, '/api/v1/resources/bylesson/$id_lesson');
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
      List<ResourceModel> CoursesList = resultlist.map((result) {
        return ResourceModel(
            id: result['id'],
            id_lesson: result['id_lesson'],
            name: utf8.decode(result['name'].codeUnits),
            resource_type: result['resource_type'],
            description: utf8.decode(result['description'].codeUnits),
            multimedia: result['multimedia']);
      }).toList();
      print('Datos de recursos enviados');
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
