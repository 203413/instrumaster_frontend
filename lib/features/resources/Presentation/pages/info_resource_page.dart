import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/entities/resources.dart';

class InfoResourcesPage extends StatefulWidget {
  final Resource arg;
  const InfoResourcesPage({super.key, required this.arg});

  @override
  State<InfoResourcesPage> createState() => _InfoResourcesPageState();
}

class _InfoResourcesPageState extends State<InfoResourcesPage> {
  @override
  void initState() {
    super.initState();
    print(widget.arg.multimedia);
    _verify();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFFFDBE00),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Icon(
                    LineIcons.infoCircle,
                    size: 75,
                    color: Color(0xFFFDBE00),
                  ),
                  Expanded(
                    child: Text(
                      widget.arg.name,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.arg.description,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Image.network(widget.arg.multimedia)
          ],
        ),
      ),
    );
  }

  Future<void> _verify() async {
    try {
      print(widget.arg.id);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? id = prefs.getInt('idprogress');
      final api = "https://instrumaster.iothings.com.mx/api/v1/progress/$id";
      final dio = Dio();
      final Response response = await dio.get(api);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<int> recoursesCompletedList =
            List<int>.from(responseData['recourses_completed']);
        List<int> questionCompletedList =
            List<int>.from(responseData['question_completed']);

        int stars = responseData['stars'];

        print("Recourses Completed: $recoursesCompletedList");
        print("Question Completed: $questionCompletedList");

        if (recoursesCompletedList.contains(widget.arg.id)) {
          print("No dar estrellas");
        } else {
          print("Dar estrellas");
          final api2 =
              "https://instrumaster.iothings.com.mx/api/v1/progress/complete/resource/$id";
          final data = {
            "resource_id": widget.arg.id,
          };
          final Response response2 = await dio.patch(api2, data: data);
          if (response2.statusCode == 200) {
            print(response.data);
            int userStars = stars + 10;
            final api3 =
                "https://instrumaster.iothings.com.mx/api/v1/progress/$id";
            final data2 = {
              "stars": userStars,
            };
            final Response response3 = await dio.patch(api3, data: data2);
            if (response3.statusCode == 200) {
              print(response.data);
            } else {
              print(response.data);
            }
          } else {
            print(response.data);
          }
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
