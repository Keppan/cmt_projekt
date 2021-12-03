// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
//
// class ExampleVideo extends StatefulWidget {
//   @override
//   _ExampleVideoState createState() => _ExampleVideoState();
// }
//
// class _ExampleVideoState extends State<ExampleVideo> {
//   final String urlToStreamVideo = 'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4';
//   final VlcPlayerController controller = VlcPlayerController.network(
//     'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4',
//     autoPlay: true,
//
//   );
//   final int playerWidth = 640;
//   final int playerHeight = 360;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SizedBox(
//             height: playerHeight,
//             width: playerWidth,
//             child: new VlcPlayer(
//               aspectRatio: 16 / 9,
//               url: urlToStreamVideo,
//               controller: controller,
//               placeholder: Center(child: CircularProgressIndicator()),
//             )
//         )
//     );
//   }
// }