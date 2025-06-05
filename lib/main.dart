import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'pages/page_select.dart';
import 'pages/toptop.dart';
import 'pages/pro_home.dart';
import 'pages/page_dx.dart';
import 'pages/page_build.dart';
import 'pages/page_question.dart';
import 'pages/pro_hospital.dart';
import 'pages/pro_adm.dart';
import 'pages/pro_faq.dart';
import 'pages/page_NS1.dart';
import 'pages/page_NS2.dart';
import 'pages/page_OS1.dart';
import 'pages/page_OS2.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PageOpening(),
  );
}

class PageOpening extends StatefulWidget {
  const PageOpening({super.key});
  @override
  State<PageOpening> createState() => _PageOpeningState();
}

class _PageOpeningState extends State<PageOpening> {
  late VideoPlayerController _controller;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/opening.mp4')
      ..initialize().then((_) {
        setState(() {
          _videoInitialized = true;
          _controller.play();
        });
      });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PageSelect()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
          Positioned(
            left: 105 * widthRatio,
            top: 250 * heightRatio,
            child: SizedBox(
                width: 160 * widthRatio,
                height: 160 * heightRatio,
                child: Image.asset(
                  'assets/images/loading.png',
                  fit: BoxFit.contain,
                )
            ),
          ),
          if (_videoInitialized)
            Positioned(
              left: 28 * widthRatio,
              top: 242 * heightRatio,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 180 * heightRatio,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 320 * widthRatio,
                    height: 180 * heightRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}