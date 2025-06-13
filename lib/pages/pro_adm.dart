import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'pro_home.dart';
import 'pro_hospital.dart';
import 'pro_faq.dart';
import 'pro_adm.dart';
import 'page_dx.dart';
import 'page_build.dart';
import 'page_question.dart';
import 'page_select.dart';

class ProAdm extends StatefulWidget {
  const ProAdm({super.key});
  @override
  State<ProAdm> createState() => _ProAdmState();
}

class _ProAdmState extends State<ProAdm> {
  bool showLay2 = false;
  bool showScroll = true;
  bool showTimeDc = false;
  bool showTimeOp = false;
  bool showTimeAdm1 = false;
  bool showTimeAdm2 = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    showLay2 = true;
    _controller = VideoPlayerController.network(
      'https://res.cloudinary.com/dvax38khk/video/upload/v1737937820/video_adm_hrus68.mp4',
    )..initialize().then((_) {
      setState(() {
        _controller.play();
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showScroll = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleTimeDc() => setState(() => showTimeDc = !showTimeDc);
  void toggleTimeOp() => setState(() => showTimeOp = !showTimeOp);

  void toggleTimeAdm() => setState(() {
    if (!showTimeAdm1 && !showTimeAdm2) {
      showTimeAdm1 = true;
    } else if (showTimeAdm1) {
      showTimeAdm1 = false;
      showTimeAdm2 = true;
    } else if (showTimeAdm2) {
      showTimeAdm2 = false;
    }
  });

  @override
  Widget build(BuildContext context) {
    const baseWidth = 375;
    const baseHeight = 665;
    final widthRatio = MediaQuery.of(context).size.width / baseWidth;
    final heightRatio = MediaQuery.of(context).size.height / baseHeight;

    Widget timeImage(String asset, VoidCallback onTap) => Positioned(   // time_image 표시되는 곳
      left: (375 * widthRatio - 340 * widthRatio) / 2,   // size box #3
      top: 110 * heightRatio,   // size box #3
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 340 * widthRatio,
          height: 490 * heightRatio,   // size box #3
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: (375 * widthRatio - 200 * widthRatio) / 2,   // sizebox #3
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageSelect())),
              child: SizedBox(
                width: 200 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // sizebox #3
            top: 120 * heightRatio,
            child: SizedBox(
              width: 320 * widthRatio,
              height: 180 * heightRatio,
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
          ),
          if (showLay2)
            Positioned(
              left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
              top: 310 * heightRatio,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 250 * heightRatio,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),   // ### size mix
                      GestureDetector(
                        onTap: toggleTimeAdm,
                        child: Image.asset('assets/images/pro_adm.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 20),   // ### size mix
                      GestureDetector(
                        onTap: toggleTimeOp,
                        child: Image.asset('assets/images/pro_op.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 20),   // ### size mix
                      GestureDetector(
                        onTap: toggleTimeDc,
                        child: Image.asset('assets/images/pro_dc.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 20),   // ### size mix
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageDx())),
                        child: Image.asset('assets/images/pro_dx.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 20),   // ### size mix
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageBuild())),
                        child: Image.asset('assets/images/open_build.png', fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 20),   // ### size mix
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PageQuestion())),
                        child: Image.asset('assets/images/open_question.png', fit: BoxFit.contain),
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
                child: Image.asset('assets/images/scroll_updown.png', fit: BoxFit.contain),
              ),
            ),
          if (showTimeDc) timeImage('assets/images/time_dc.png', toggleTimeDc),
          if (showTimeOp) timeImage('assets/images/time_op.png', toggleTimeOp),
          if (showTimeAdm1) timeImage('assets/images/time_adm_1.png', toggleTimeAdm),
          if (showTimeAdm2) timeImage('assets/images/time_adm_2.png', toggleTimeAdm),
          Positioned(
            left: 0 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProHome())),
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/icon_home_basic.png', fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            left: 93 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProHospital())),
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/icon_hos_basic.png', fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            left: 186 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () {}, // 현재 페이지
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/icon_adm_color.png', fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            left: 279 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProFaq())),
              child: SizedBox(
                width: 93 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/icon_faq_basic.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}