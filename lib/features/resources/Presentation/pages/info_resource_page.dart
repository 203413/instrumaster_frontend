import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../Domain/entities/resources.dart';
import 'package:video_player/video_player.dart';

class InfoResourcesPage extends StatefulWidget {
  final Resource arg;
  const InfoResourcesPage({super.key, required this.arg});

  @override
  State<InfoResourcesPage> createState() => _InfoResourcesPageState();
}

class _InfoResourcesPageState extends State<InfoResourcesPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.arg.multimedia);
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
}
