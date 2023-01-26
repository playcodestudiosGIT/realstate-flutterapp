import 'package:flutter/cupertino.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerYoutube extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerYoutube({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<VideoPlayerYoutube> createState() => _VideoPlayerYoutubeState();
}

class _VideoPlayerYoutubeState extends State<VideoPlayerYoutube> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoUrl,
      autoPlay: true,
      params: const YoutubePlayerParams(showFullscreenButton: false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          child: YoutubePlayer(
            controller: controller,
            aspectRatio: 16 / 9,
            
          ),
        )
      ],
    );
  }
}
