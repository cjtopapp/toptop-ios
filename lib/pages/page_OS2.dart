import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'page_select.dart';
import 'pro_hospital.dart';
import 'toptop.dart';
import 'reservation_webview.dart';

bool showDetailOnly = false;

class PageOS2 extends StatefulWidget {
  const PageOS2({super.key});
  @override
  State<PageOS2> createState() => _PageOS2State();
}

class _PageOS2State extends State<PageOS2> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://res.cloudinary.com/dvax38khk/video/upload/v1737937802/OS2_intro_oiuqd0.mp4',
    )..initialize().then((_) {
      setState(() {
        _videoController.play();
      });
    });
  }

// reserve   // 2.1.2
  void _showReservationModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: const ReservationWebView(),
        );
      },
    );
  }
// reserve   // 2.1.2

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
              left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
              top: 330 * heightRatio,
              child: SizedBox(
                width: 320 * widthRatio,   // size box #3
                height: 240 * heightRatio,   // size box #3
                child: Image.asset(
                  'assets/images/intro_OS2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          // if (!showDetailOnly)
          //   Positioned(
          //     left: 20 * widthRatio,
          //     top: 510 * heightRatio,
          //     child: SizedBox(
          //       width: 270 * widthRatio,
          //       height: 80 * heightRatio,
          //       child: Image.asset(
          //         'assets/images/time_OS2.png',
          //         fit: BoxFit.contain,
          //       ),
          //     ),
          //   ),
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
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
            left: 40 * widthRatio,   // size box toptop
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(   // size box toptop
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

// reserve   // 2.1.2
          Positioned(
            left: 250 * widthRatio,   // size box toptop
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => _showReservationModal(context),  // ← 변경됨
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
// reserve   // 2.1.2

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