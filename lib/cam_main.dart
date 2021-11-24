import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/html.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  late CameraController test;

  late VideoPlayerController vidController;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    test = CameraController(controller.description, ResolutionPreset.low);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream((CameraImage img) {
        //print(img.planes[0].bytes);
        Uint8List buffer = img.planes[0].bytes;


      });
      setState(() {});
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized && !test.value.isInitialized) {
      return Container();
    }
    return MaterialApp(

      home: Column(
        children: [
          VideoPlayer(vidController),
          CameraPreview(test),
        ],
      ),

    );
  }
}