import 'package:cmt_projekt/model/streammodel.dart';
import 'package:cmt_projekt/api/streamclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

typedef Fn = void Function();

class StreamViewModel with ChangeNotifier {
  StreamModel sModel = StreamModel();

  void startup(context) {
    if (kIsWeb) {
      sModel.c = Client.fromClient(sModel.webPlayer);
    } else {
      sModel.c = Client(sModel.player);
    }
    init().then((value) {
      sModel.isInited = true;
      sModel.c.listen(context);
    });
  }


  Future<bool> closeClient() async {
    sModel.player!.stopPlayer();
    sModel.recorder!.stopRecorder();
    sModel.c.stopSound();
    sModel.isInited = false;

    sModel.c.client.sink.close();
    return true;
  }

  Future<void> init() async {
    if (kIsWeb) {
      await sModel.webPlayer.play();
    } else {
      await sModel.recorder!.openAudioSession(
        device: AudioDevice.blueToothA2DP,
        audioFlags: allowHeadset | allowEarPiece | allowBlueToothA2DP,
        category: SessionCategory.playAndRecord,
      );
      await sModel.player!.openAudioSession(
        device: AudioDevice.blueToothA2DP,
        audioFlags: allowHeadset | allowEarPiece | allowBlueToothA2DP,
        category: SessionCategory.playAndRecord,
      );
      await sModel.player!.startPlayerFromStream(
        codec: Codec.pcm16,
        numChannels: 1,
        sampleRate: 44000,
      );
    }
  }

  Future<void> release() async {
    await stopPlayer();
    await sModel.player!.closeAudioSession();
    sModel.player = null;

    await stopRecorder();
    await sModel.recorder!.closeAudioSession();
    sModel.recorder = null;
  }

  @override
  void dispose() {
    release();
    super.dispose();
  }

  Future<void>? stopRecorder() {
    if (sModel.recorder != null) {
      return sModel.recorder!.stopRecorder();
    }
    return null;
  }

  Future<void>? stopPlayer() {
    if (sModel.player != null) {
      return sModel.player!.stopPlayer();
    }
    return null;
  }

  //Placeholder för funktion som tar in channelID när man trycker på enskild kanal
  /*
  void hostJoin() {
    Prefs().storedData.setString("joinChannelID", tx.value.text);
    print("HostID/Value/Text: " +
        tx.value.text);
    Prefs().storedData.setString("intent", "j");
  }
   */

  Future<void> record() async {
    await sModel.recorder!.startRecorder(
      codec: Codec.pcm16,
      toStream: sModel
          .c.foodStreamController!.sink, // ***** THIS IS THE LOOP !!! *****
      sampleRate: 44000,
      numChannels: 1,
    );
    notifyListeners();
  }

  Future<void> stop() async {
    if (sModel.recorder != null) {
      await sModel.recorder!.stopRecorder();
    }
    if (sModel.player != null) {
      //   await _player!.stopPlayer();
    }
    notifyListeners();
  }

  void getRecFn() {
    if (!sModel.isInited) {
      return null;
    }
    print("hello" + " " + "${sModel.recorder!.isRecording}");
    if (sModel.recorder!.isRecording) {
      stop();
    } else {
      record();
    }

    ;
  }
}
