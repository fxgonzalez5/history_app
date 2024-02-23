import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:history_app/presentation/screens/gallery/gallery_page.dart';
import 'package:video_player/video_player.dart';

class FullVideoPage extends StatelessWidget {
  const FullVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>().videoController;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.screen_rotation_alt_outlined),
                  onPressed: () async {
                    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                    Get.back();
                  },
                ),
                
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                if (controller.value!.value.isPlaying) {
                  controller.value!.pause();
                } else {
                  controller.value!.play();
                }
              },
              child: Center(
                child: AspectRatio(
                  aspectRatio: controller.value!.value.aspectRatio,
                  child: VideoPlayer(controller.value!)
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}