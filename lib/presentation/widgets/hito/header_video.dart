import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_app/presentation/screens/gallery/gallery_page.dart';
import 'package:video_player/video_player.dart';

class HeaderVideo extends StatefulWidget {
  final String video;
  
  const HeaderVideo(this.video, {
    super.key,
  });

  @override
  State<HeaderVideo> createState() => _HeaderVideoState();
}

class _HeaderVideoState extends State<HeaderVideo> {
  final _controller = Get.find<GalleryController>().videoController;

  @override
  void initState() {
    super.initState();
    _controller.value = VideoPlayerController.networkUrl(Uri.parse(widget.video));
  }

  @override
  void dispose() {
    _controller.value!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _controller.value!.initialize(),
      builder: (context,  snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return GestureDetector(
          onTap: () {
            if (_controller.value!.value.isPlaying) {
              _controller.value!.pause();
            } else {
              _controller.value!.play();
            }
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller.value!.value.aspectRatio,
              child: VideoPlayer(_controller.value!)
            ),
          )
        );
      },
    );
  }
}