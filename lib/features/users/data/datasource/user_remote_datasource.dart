import 'dart:convert';

import 'package:instrumaster_v1/features/users/Data/models/profile_model.dart';
import 'package:instrumaster_v1/features/users/Data/models/progress_model.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/authentication.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../../baseURL.dart';
import '../../Domain/entities/progress.dart';
import '../../Domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<Authentication> login(String username, String password);
  Future<void> logout(User user);
  Future<void> register(User user);
  Future<void> updateInfo(User user);
  Future<ProfileModel> viewProfile(int userId);
  Future<List<ProgressModel>> getProgressByUserID(int userId);
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  String ip = serverURL;

  @override
  Future<Authentication> login(String username, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Entro exitosamente al metodo login");
      var url = Uri.http(ip, '/api/v1/login/');
      var body = {'username': username, 'password': password};
      var headers = {'Content-Type': 'application/json'};
      var res = await http.post(url,
          body: convert.jsonEncode(body), headers: headers);
      var responseJson = convert.jsonDecode(res.body);
      var authentication = Authentication(
          token: responseJson['token'], user_id: responseJson['id'].toString());
      await prefs.setString("Token", authentication.token);
      await prefs.setString("user_id", authentication.user_id);
      print("HOL;A MIRASAJDA FASJDA S: " + authentication.user_id);
      print(
          'PREFERENCIAS COMPARTIDAS PRUEBA' + prefs.getString('id').toString());
      return authentication;
    } catch (e) {
      print(e);
      throw Exception('Failed to log in');
    }
  }

  Future<void> logout(User user) async {}
  Future<void> register(User user) async {
    print("Entro exitosamente al metodo register");
    var url = Uri.https(ip, '/api/v1/register/');
    var body = {
      'username': user.username,
      'email': user.email,
      'password': user.password
    };
    var headers = {'Content-Type': 'application/json'};
    var response = await http
        .post(url, body: convert.jsonEncode(body), headers: headers)
        .then((response) => {print(response.body)});
  }

  Future<void> updateInfo(User user) async {}

  Future<ProfileModel> viewProfile(int userId) async {
    print('entrando al metodo viewprofile');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('Token');
    final int? user_id = prefs.getInt('user_id');

    var headers = {'Authorization': 'Token $token'};
    var url = Uri.http(ip, '/api/v1/profiles/$user_id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Datos de perfil recibidos');
      //List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse;
      ;
      if (results == null) {
        print('datos nulso');
      }
      print('Paso1');
      Map user = results['id_user'];
      print(user['username']);
      User users = User(
          id_user: user['id'],
          username: user['username'],
          email: user['email']);
      print('Paso2');
      Map iconprofile = results['icon'];
      print(iconprofile['image']);
      IconProfile icons = IconProfile(
          id: iconprofile['id'],
          name: iconprofile['name'],
          image: iconprofile['image']);
      print('Paso3');
      return ProfileModel(id: results['id'], id_user: users, icon: icons);
    } else {
      throw Exception();
    }
  }

  Future<List<ProgressModel>> getProgressByUserID(int userId) async {
    print('metodo get progress');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? user_id = prefs.getInt('user_id');
    var url = Uri.http(
        'instrumaster.iothings.com.mx', '/api/v1/progress/byuser/$user_id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> resultlist = [];
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse;
      resultlist.addAll(List<Map<String, dynamic>>.from(results));
      print('PRUEBA....................... 1');
      List<ProgressModel> CoursesList = resultlist.map((result) {
        return ProgressModel(
          id: result['id'],
          id_course: result['id_course'],
          course_name: utf8.decode(result['course_name'].codeUnits),
          level: result['level'],
          stars: result['stars'],
          user: result['user'],
        );
      }).toList();
      print('PRUEBA....................... 2');
      return CoursesList;
    } else {
      throw Exception();
    }
  }
}
