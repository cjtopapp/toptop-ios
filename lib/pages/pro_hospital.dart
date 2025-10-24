import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'page_select.dart';
import 'pro_home.dart';
import 'pro_adm.dart';
import 'pro_faq.dart';
import 'page_NS1.dart';
import 'page_NS2.dart';
import 'page_OS1.dart';
import 'page_OS2.dart';
import 'page_OS3.dart';
import 'page_mri.dart';
import 'page_pt.dart';
import 'toptop.dart';
import 'reservation_webview.dart';

class ProHospital extends StatefulWidget {
  const ProHospital({super.key});
  @override
  State<ProHospital> createState() => _ProHospitalState();
}

class _ProHospitalState extends State<ProHospital> {
  late VideoPlayerController _controller;
  bool showScroll = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://res.cloudinary.com/dvax38khk/video/upload/v1737937808/video_hospital_pmfs2g.mp4',
    )..initialize().then((_) {
      setState(() {
        _controller.play();
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => showScroll = false);
      }
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
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
            top: 120 * heightRatio,
            child: _controller.value.isInitialized
                ? FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 180 * heightRatio,
                child: VideoPlayer(_controller),
              ),
            )
                : const SizedBox.shrink(),
          ),
          Positioned(
            left: 0 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProHome()),
              ),
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset(
                  'assets/images/icon_home_basic.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 93 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: SizedBox(
              width: 93 * widthRatio,
              height: 50 * heightRatio,
              child: Image.asset(
                'assets/images/icon_hos_color.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 186 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProAdm()),
              ),
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset(
                  'assets/images/icon_adm_basic.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 279 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProFaq()),
              ),
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset(
                  'assets/images/icon_faq_basic.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
            top: 310 * heightRatio,   // size box #3
            child: SizedBox(
              width: 320 * widthRatio,
              height: 250 * heightRatio,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageNS1())),
                      child: Image.asset('assets/images/open_NS1.png', fit: BoxFit.contain),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageOS2())),
                      child: Image.asset('assets/images/open_OS2.png', fit: BoxFit.contain),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageOS1())),
                      child: Image.asset('assets/images/open_OS1.png', fit: BoxFit.contain),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageNS2())),
                      child: Image.asset('assets/images/open_NS2.png', fit: BoxFit.contain),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageOS3())),
                      child: Image.asset('assets/images/open_OS3.png', fit: BoxFit.contain),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageMri())),
                      child: Image.asset('assets/images/open_mri.png', fit: BoxFit.contain),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PagePt())),
                      child: Image.asset('assets/images/open_pt.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          if (showScroll)
            Positioned(
              left: (375 * widthRatio - 150 * widthRatio) / 2,   // size box #3
              top: 330 * heightRatio,
              child: SizedBox(
                width: 150 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset(
                  'assets/images/scroll_updown.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}