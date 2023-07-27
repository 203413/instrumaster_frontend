import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instrumaster_v1/features/practices/Domain/entities/practice.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PracticePage extends StatefulWidget {
  final Practice arg;
  const PracticePage({super.key, required this.arg});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  String switchText = 'Presiona para grabar';
  final recorder = FlutterSoundRecorder();
  bool isTrue = false;
  bool isRecorderReady = false;
  bool sended = false;
  late File audiopath;
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
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
    String ip = 'https://instrumaster.iothings.com.mx/';
    final dio = Dio();
    try {
      File audioFile = File(recordingPath);
      List<int> bytes = await audioFile.readAsBytes();
      String base64Audio = base64Encode(bytes);
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
        //String jsonString = response.data;
        Map<String, dynamic> parsedJson = response.data;
        String prediccionValue = parsedJson['Prediccion'];
        print(prediccionValue);

        if (prediccionValue == widget.arg.acordeATocar.toString()) {
          print('coincideen');
          setState(() {
            switchText = 'Correcto!';
            isTrue = true;
          });
        } else {
          setState(() {
            switchText = 'Vuelva a intentarlo';
            isTrue = false;
            sended = true;
          });
        }
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
                      "Acorde a tocar: " + widget.arg.acordeATocar,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: GestureDetector(
                    onTap: () async {
                      print('object');
                      if (recorder.isRecording) {
                        await stop();
                      } else {
                        await record();
                      }

                      setState(() {});
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFDBE00),
                        // Cambia el color del círculo si lo deseas
                      ),
                      child: Icon(
                        recorder.isRecording ? Icons.stop : Icons.mic,
                        size: 150,
                      ),
                    )),
              ),
            ),
            _resultText()
          ],
        ),
      ),
    );
  }

  Widget _resultText() {
    if (isTrue == false) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          switchText,
          style: TextStyle(fontSize: 30),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineIcons.checkCircle,
              color: Color(0xFFFDBE00),
              size: 50,
            ),
            Text(
              switchText,
              style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFDBE00),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }
}
