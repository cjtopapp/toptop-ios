import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'page_select.dart';
import 'pro_adm.dart';
import 'pro_faq.dart';
import 'pro_hospital.dart';
import 'toptop.dart';

class ProHome extends StatefulWidget {
  const ProHome({super.key});
  @override
  State<ProHome> createState() => _ProHomeState();
}

class _ProHomeState extends State<ProHome> {
  late VideoPlayerController _videoController;
  bool showScroll = true;
  bool showImageSchedule = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
      'https://res.cloudinary.com/dvax38khk/video/upload/v1737937828/video_home_ruztav.mp4',
    )..initialize().then((_) {
      setState(() {
        _videoController.play();
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showScroll = false);
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void toggleImageSchedule() => setState(() => showImageSchedule = !showImageSchedule);

  void launchLink(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
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
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
            top: 120 * heightRatio,
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
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
            top: 310 * heightRatio,   // size box #3
            child: SizedBox(
              width: 320 * widthRatio,
              height: 240 * heightRatio,   // size box #3
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/4doc.png',
                        fit: BoxFit.contain,
                      ),
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
            left: 10 * widthRatio,
            top: 560 * heightRatio,
            child: GestureDetector(
              onTap: () => launchLink('tel:0439008875'),
              child: Image.asset(
                'assets/images/banner_call.png',
                width: 105 * widthRatio,
                height: 35 * heightRatio,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 135 * widthRatio,
            top: 560 * heightRatio,
            child: GestureDetector(
              onTap: toggleImageSchedule,
              child: Image.asset(
                'assets/images/banner_schedule.png',
                width: 105 * widthRatio,
                height: 35 * heightRatio,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 260 * widthRatio,
            top: 560 * heightRatio,
            child: GestureDetector(
              onTap: () => launchLink(
                'https://map.naver.com/p/directions/-/14191664.3247314,4388614.527514,%EC%B2%AD%EC%A3%BC%ED%83%91%EB%B3%91%EC%9B%90,1445421759,PLACE_POI/-/transit?c=14190731.5541203%2C4388614.5275141%2C15.00%2C0%2C0%2C0%2Cdh',
              ),
              child: Image.asset(
                'assets/images/banner_map.png',
                width: 105 * widthRatio,
                height: 35 * heightRatio,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 0 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: SizedBox(
              width: 93 * widthRatio,
              height: 50 * heightRatio,
              child: Image.asset(
                'assets/images/icon_home_color.png',
                fit: BoxFit.contain,
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
                child: Image.asset(
                  'assets/images/icon_hos_basic.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 186 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProAdm())),
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
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProFaq())),
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
          if (showImageSchedule)
            Positioned(
              left: (375 * widthRatio - 340 * widthRatio) / 2,   // size box #3
              top: 100 * heightRatio,   // size box #3
              child: GestureDetector(
                onTap: toggleImageSchedule,
                child: SizedBox(
                  width: 340 * widthRatio,   // size box #3
                  height: 500 * heightRatio,   // size box #3
                  child: Image.asset(
                    'assets/images/image_schedule.png',
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