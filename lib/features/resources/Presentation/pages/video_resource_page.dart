import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
}
