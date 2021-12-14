import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cmt_projekt/api/prefs.dart';
import 'package:cmt_projekt/model/streammessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';

import '../constants.dart';

class Client {
  late WebSocketChannel client;
  late FlutterSoundPlayer? _player;
  late AudioPlayer? _audioPlayer;

  StreamController<Food>? foodStreamController = StreamController<Food>.broadcast();

  Client.fromClient(AudioPlayer? audioPlayer){

  }

  Client(FlutterSoundPlayer? player) {
    _player = player;
    client = WebSocketChannel.connect(Uri.parse(serverConnection));

    if(Prefs().getIntent() == "j") {
      print(Prefs().getIntent().toString());
      client.sink.add(jsonEncode(StreamMessage.join(
          uid: Prefs().storedData.get("uid").toString(), channelType: "a", hostId: Prefs().storedData.get("joinChannelID").toString())));
    } else {
      client.sink.add(jsonEncode(StreamMessage.host(uid: Prefs().storedData.get("uid").toString(), channelType: "a")));
    }
    foodStreamController!.stream.listen((event) {
      sendData(event);
    });
  }
  void listen(context) {
  print("Am i listening????");
    client.stream.listen((event) {
      playSound(event);
    },onDone: () {
      print(client.closeReason);
      Navigator.popUntil(context, ModalRoute.withName(demo));
    });
  }

  Future<void> stopSound() async {
   await _player!.stopPlayer();
  }

  Future <void> playSound(event) async {
    print("play data");
    Uint8List list = Uint8List.sublistView(event);
    _player!.foodSink!.add(FoodData(list));
  }


  void sendData(data) {
    print("You alive?1");
    //print(data.runtimeType);
    FoodData fd = data;
    client.sink.add(fd.data);
  }
}

void main() {
}
