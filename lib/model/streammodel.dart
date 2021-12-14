import 'package:cmt_projekt/api/streamclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:just_audio/just_audio.dart';

class StreamModel {
  ///App-specific
  FlutterSoundPlayer? player = FlutterSoundPlayer();
  FlutterSoundRecorder? recorder = FlutterSoundRecorder();

  ///Web-Specific
  AudioPlayer webPlayer = AudioPlayer();

  TextEditingController hostID = TextEditingController();

  bool isInited = false;

  late Client c;
}
