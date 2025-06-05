import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'page_select.dart';
import 'pro_hospital.dart';

bool showDetailOnly = false;

class PageNS1 extends StatefulWidget {
  const PageNS1({super.key});
  @override
  State<PageNS1> createState() => _PageNS1State();
}

class _PageNS1State extends State<PageNS1> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://res.cloudinary.com/dvax38khk/video/upload/v1737937800/NS1_intro_lf45bf.mp4',
    )..initialize().then((_) {
      setState(() {
        _videoController.play();
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void enterDetailMode() => setState(() => showDetailOnly = true);
  void exitDetailMode() => setState(() => showDetailOnly = false);

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
          if (!showDetailOnly)
            Positioned(
              left: 27.5 * widthRatio,
              top: 330 * heightRatio,
              child: SizedBox(
                width: 300 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset(
                  'assets/images/intro_NS1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          if (!showDetailOnly)
            Positioned(
              left: 20 * widthRatio,
              top: 510 * heightRatio,
              child: SizedBox(
                width: 270 * widthRatio,
                height: 80 * heightRatio,
                child: Image.asset(
                  'assets/images/time_NS1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Positioned(
            left: 27.5 * widthRatio,
            top: 120 * heightRatio,
            child: SizedBox(
              width: 320 * widthRatio,
              height: 180 * heightRatio,
              child: _videoController.value.isInitialized
                  ? FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  width: 320 * widthRatio,
                  height: 180 * heightRatio,
                  child: VideoPlayer(_videoController),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
          Positioned(
            left: 90 * widthRatio,
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PageSelect()),
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
            left: 290 * widthRatio,
            top: 580 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProHospital()),
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