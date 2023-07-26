import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class audio extends StatefulWidget {
  const audio({super.key});

  @override
  State<audio> createState() => _audioState();
}

class _audioState extends State<audio> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  late File audiopath;

  @override
  void initState() {
    super.initState();

    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Nopi';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(microseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);

    print(audioFile);
    setState(() {
      audiopath = audioFile;
    });
    _sendAudioToApi(path);
  }

  Future<void> _sendAudioToApi(String recordingPath) async {
    var apiUrl = Uri.http(
        '6b63-2806-262-3404-a3-75ee-e9cd-e336-1267.ngrok-free.app',
        '/api/model/');
    String ip =
        'https://6b63-2806-262-3404-a3-75ee-e9cd-e336-1267.ngrok-free.app/';
    final dio = Dio();
    try {
      File audioFile = File(recordingPath);
      List<int> bytes = await audioFile.readAsBytes();
      String base64Audio = base64Encode(bytes);

      // Map<String, String> headers = {
      //   'Content-Type': 'audio/wav',
      // };

      // Map<String, dynamic> data = {
      //   'wav_file': base64Audio,
      // };
      print('hola1');
      final formData = FormData.fromMap({
        'wav_file': MultipartFile.fromBytes(
          await audioFile.readAsBytes(),
          filename: 'audio.wav',
        ),
      });

      //final response = await http.post(apiUrl, body: formData);
      dio.options.baseUrl = ip;
      final response = await dio.post('api/model/', data: formData);
      print('hola2');
      if (response.statusCode == 200) {
        print('Audio enviado exitosamente a la API.');
        print(response.data);
      } else {
        print(
            'Error al enviar el audio a la API. Código de estado: ${response.statusCode}');
        print(response.data);
      }
    } catch (e) {
      print('Error al enviar el audio a la API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Icon(recorder.isRecording ? Icons.stop : Icons.mic),
          onPressed: () async {
            if (recorder.isRecording) {
              await stop();
            } else {
              await record();
            }

            setState(() {});
          },
        ),
      ),
    );
  }
}
