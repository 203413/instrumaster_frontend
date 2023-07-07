import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import '../models/course_model.dart';

abstract class CourseRemoteDataSource {
  // https://jsonplaceholder.typicode.com/posts
  Future<List<CourseModel>> getPosts();
}

class CourseRemoteDataSourceImp implements CourseRemoteDataSource {
  @override
  Future<List<CourseModel>> getPosts() async {
    //print('DataSource');

    var url = Uri.http('35.168.88.197', '/course');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('woooo');
      // return convert
      //     .jsonDecode(response.body)
      //     .map<CourseModel>((data) => CourseModel.fromJson(data))
      //     .toList();
      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['data'];
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      List<CourseModel> CoursesList = resultlist.map((result) {
        return CourseModel(
            id: result['id'],
            course_name: result['course_name'],
            course_logo: result['course_logo']);
      }).toList();
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
