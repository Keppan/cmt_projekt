import 'package:cmt_projekt/viewmodel/stream_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class WebChannelPage extends StatefulWidget {
  @override
  _WebChannelPageState createState() => _WebChannelPageState();
}

class _WebChannelPageState extends State<WebChannelPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: context
          .read<StreamViewModel>()
          .closeClient,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Column(
              children: [Text('COMMENT'), Text('Demo')],
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black,
                        Colors.blueAccent,
                      ])),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.blueAccent,
                ],
              )),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFAF0E6),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 3,
                  ),
                ),
                child: Text(
                    context
                        .watch<StreamViewModel>()
                        .sModel
                        .recorder!
                        .isRecording
                        ? 'Playback to your headset!'
                        : 'Recorder is stopped'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
              context
                  .watch<StreamViewModel>()
                  .sModel
                  .recorder!
                  .isRecording
                  ? Icons.mic
                  : Icons.mic_off),
          onPressed: () {
            context.read<StreamViewModel>().getRecFn();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}