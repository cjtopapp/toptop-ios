import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'page_select.dart';
import 'pro_home.dart';
import 'pro_hospital.dart';
import 'pro_adm.dart';
import 'toptop.dart';
import 'package:connectivity_plus/connectivity_plus.dart';   // 2.0.5_g

class ProFaq extends StatefulWidget {
  const ProFaq({super.key});
  @override
  State<ProFaq> createState() => _ProFaqState();
}

class _ProFaqState extends State<ProFaq> {
  late VideoPlayerController _controller;
  bool showScroll = true;
  bool _showNetworkWarning = false;   // 2.0.5_g

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://res.cloudinary.com/dvax38khk/video/upload/v1737938458/video_confer_u4aph6.mp4',
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

// 2.0.5_g
  void launchLink(String url) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    final isConnected = connectivityResult.contains(ConnectivityResult.mobile) ||
                        connectivityResult.contains(ConnectivityResult.wifi);
    if (isConnected) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } else {
      setState(() {
        _showNetworkWarning = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showNetworkWarning = false;
          });
        }
      });
    }
  }
// 2.0.5_g

  Widget banner(String asset, String url) => GestureDetector(
    onTap: () => launchLink(url),
    child: Image.asset(asset, fit: BoxFit.contain),
  );

  Widget navIcon(String asset, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 93 * MediaQuery.of(context).size.width / 375,
      height: 50 * MediaQuery.of(context).size.height / 665,
      child: Image.asset(asset, fit: BoxFit.contain),
    ),
  );   // 네비게이션 아이콘 크기 -> 근데 왜 여기로 왔는지...

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
            left: (375 * widthRatio - 320 * widthRatio) / 2,   // size box #3
            top: 310 * heightRatio,   // size box #3
            child: SizedBox(
              width: 320 * widthRatio,
              height: 250 * heightRatio,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    banner('assets/images/banner_hompage.png', 'https://cjtop-hospital.com/'),
                    banner('assets/images/banner_blog.png', 'https://blog.naver.com/cjtop_hospital'),
                    banner('assets/images/banner_youtube.png', 'https://www.youtube.com/channel/UCkEK-5VniGe-onsYYgQ3NPg'),
                    banner('assets/images/banner_NS1.png', 'https://blog.naver.com/cjtoph-ns'),
                    banner('assets/images/banner_OS2.png', 'https://blog.naver.com/slam0828'),
                    const SizedBox(height: 30),
                  ],
                ),
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

          if (showScroll)
            Positioned(
              left: (375 * widthRatio - 150 * widthRatio) / 2,   // sizebox #3
              top: 330 * heightRatio,
              child: SizedBox(
                width: 150 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset('assets/images/scroll_updown.png', fit: BoxFit.contain),
              ),
            ),

          // 2.0.5_g
          if (_showNetworkWarning)
            Positioned(
              left: (375 * widthRatio - 150 * widthRatio) / 2,
              top: 330 * heightRatio,
              child: SizedBox(
                width: 150 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset('assets/images/scroll_network.png', fit: BoxFit.contain),
              ),
            ),
          // 2.0.5_g  

          Positioned(
            left: 0 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: navIcon('assets/images/icon_home_basic.png', () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProHome()))
            ),
          ),
          Positioned(
            left: 93 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: navIcon('assets/images/icon_hos_basic.png', () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProHospital()))
            ),
          ),
          Positioned(
            left: 186 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: navIcon('assets/images/icon_adm_basic.png', () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProAdm()))
            ),
          ),
          Positioned(
            left: 279 * widthRatio,
            top: 605 * heightRatio,  // size mix
            child: SizedBox(
              width: 93 * widthRatio,
              height: 50 * heightRatio,
              child: Image.asset('assets/images/icon_faq_color.png', fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}