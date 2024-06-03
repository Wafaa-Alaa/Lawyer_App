import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
class VideoPlayers extends StatefulWidget {
  const VideoPlayers({super.key});

  @override
  State<VideoPlayers> createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  late FlickManager filcManager;
  @override
  void initState() {
    super.initState();
    filcManager=FlickManager(videoPlayerController: VideoPlayerController.asset('assets/videos/Lawyer_video.mp4'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff8B5D49),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Video Player',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: Color(0xff66280E),
      ),
      body:Center(

        child: AspectRatio(
          aspectRatio: 16/10,
            child: FlickVideoPlayer(flickManager: filcManager,)),
      ) ,
    );
  }
}
