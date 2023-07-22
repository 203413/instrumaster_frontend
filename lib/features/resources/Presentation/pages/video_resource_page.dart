import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/entities/resources.dart';
import 'package:video_player/video_player.dart';

class VideoResourcesPage extends StatefulWidget {
  final Resource arg;
  const VideoResourcesPage({super.key, required this.arg});

  @override
  State<VideoResourcesPage> createState() => _VideoResourcesPageState();
}

class _VideoResourcesPageState extends State<VideoResourcesPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
    _verify();
  }

  loadVideoPlayer() {
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.arg.multimedia));
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
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
                    LineIcons.playCircle,
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
            Container(
                child: Column(children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
              Container(
                  child: VideoProgressIndicator(controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        backgroundColor: Colors.redAccent,
                        playedColor: Colors.green,
                        bufferedColor: Colors.purple,
                      ))),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }

                          setState(() {});
                        },
                        icon: Icon(controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow)),
                    IconButton(
                        onPressed: () {
                          controller.seekTo(Duration(seconds: 0));

                          setState(() {});
                        },
                        icon: Icon(Icons.stop))
                  ],
                ),
              )
            ])),
            Text(widget.arg.description)
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

        int stars = responseData['stars'];

        print("Recourses Completed: $recoursesCompletedList");

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
