import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'page_select.dart';
import 'pro_adm.dart';
import 'toptop.dart';

class PageBuild extends StatefulWidget {
  const PageBuild({super.key});
  @override
  State<PageBuild> createState() => _PageBuildState();
}

class _PageBuildState extends State<PageBuild> {
  String? currentVideo;
  late VideoPlayerController _controller;
  bool videoVisible = false;
  bool buttonsVisible = true;
  bool showCloseButton = false;

  void playVideo(String videoFile) {
    setState(() {
      videoVisible = true;
      buttonsVisible = false;
      showCloseButton = true;
      currentVideo = videoFile;
      _controller = VideoPlayerController.asset('assets/videos/$videoFile')
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
    });
  }

  void closeVideo() {
    _controller.pause();
    _controller.dispose();
    setState(() {
      videoVisible = false;
      buttonsVisible = true;
      showCloseButton = false;
      currentVideo = null;
    });
  }

  @override
  void dispose() {
    if (videoVisible) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const baseWidth = 375;
    const baseHeight = 665;
    final widthRatio = MediaQuery.of(context).size.width / baseWidth;
    final heightRatio = MediaQuery.of(context).size.height / baseHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (videoVisible && currentVideo != null)
            Positioned(
              left: (375 * widthRatio - 300 * widthRatio) / 2,   // sizebox #3 
              top: 150 * heightRatio,
              child: SizedBox(
                width: 300 * widthRatio,
                height: 300 * heightRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          if (buttonsVisible)
            Positioned(
              left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
              top: 150 * heightRatio,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 320 * heightRatio,   // ### size box
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var entry in {
                        'button_rest.png': 'video_rest.mp4',
                        'button_tang.png': 'video_tang.mp4',
                        'button_shampoo.png': 'video_shampoo.mp4',
                        'button_dirty.png': 'video_dirty.mp4',
                        'button_tmen.png': 'video_men.mp4',
                        'button_women.png': 'video_women.mp4',
                        'button_smoke.png': 'video_smoke.mp4',
                      }.entries)
                        Padding(
                          padding: EdgeInsets.only(bottom: 30 * heightRatio),
                          child: GestureDetector(
                            onTap: () => playVideo(entry.value),
                            child: SizedBox(
                              width: 300 * widthRatio,
                              height: 40 * heightRatio,
                              child: Image.asset(
                                'assets/images/${entry.key}',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          if (showCloseButton)
            Positioned(
              left: (375 * widthRatio - 200 * widthRatio) / 2,   // sizebox #3
              top: 480 * heightRatio,
              child: GestureDetector(
                onTap: closeVideo,
                child: SizedBox(
                  width: 200 * widthRatio,
                  height: 50 * heightRatio,
                  child: Image.asset('assets/images/close_video.png', fit: BoxFit.cover),
                ),
              ),
            ),

          Positioned(
            left: 40 * widthRatio,   // size box toptop
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PageSelect()),
              ),
              child: SizedBox(
                width: 200 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Positioned(
            left: 250 * widthRatio,   // size box toptop
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Toptop()),   // size box toptop
              ),
              child: SizedBox(
                width: 85 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset(
                  'assets/images/logo_toptop.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          Positioned(
            left: 290 * widthRatio,
            top: 580 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProAdm()),
              ),
              child: SizedBox(
                width: 70 * widthRatio,
                height: 70 * heightRatio,
                child: Image.asset(
                  'assets/images/back.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}