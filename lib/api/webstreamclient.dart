import 'dart:async';
import 'package:cmt_projekt/server/streamserver.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constants.dart';

class Client {

  late WebSocketChannel client;
  late AudioPlayer? _ap;
  StreamController<Food>? foodStreamController = StreamController<Food>.broadcast();

  Client(FlutterSoundPlayer? ap) {
    _ap = AudioPlayer();
    print("Player created");
    client = WebSocketChannel.connect(Uri.parse(serverConnection));
    print("Client connected");

    foodStreamController!.stream.listen((event) {
      sendData(event);
    });

  }

  void listen(context) {
  print("Am I listening on web?");
    client.stream.listen((event) {
      playSound(event);
    });
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
