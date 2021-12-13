import 'dart:async';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';

import '../constants.dart';

class Client {

//  late WebSocketChannel client;
late AudioPlayer ap;
//  StreamController<Food>? foodStreamController = StreamController<Food>.broadcast();

  Client(FlutterSoundPlayer? player) {

  }
  void listen(context) {

  }

  Future<void> stopSound() async {

  }

  Future <void> playSound(event) async {
    print("play data");

  }


  void sendData(data) {
    print("You alive?1");
    //print(data.runtimeType);

  }
}

void main() {
}
