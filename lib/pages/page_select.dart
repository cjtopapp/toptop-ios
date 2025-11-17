import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'toptop.dart';
import 'pro_home.dart';

class PageSelect extends StatefulWidget {
  const PageSelect({super.key});

  @override
  State<PageSelect> createState() => _PageSelectState();
}

class _PageSelectState extends State<PageSelect> {
  int _currentIndex = 0;
  Timer? _autoScrollTimer;
  final int _totalImages = 5;
  bool showScroll = true;
  bool _showNetworkWarning = false;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showScroll = false);
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _totalImages;
        });
      }
    });
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _totalImages) % _totalImages;
    });
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _totalImages;
    });
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

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

  Widget banner(String asset, String url) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: GestureDetector(
      onTap: () => launchLink(url),
      child: Image.asset(asset, fit: BoxFit.contain),
    ),
  );

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
          // 이미지 슬라이더
          Positioned(
            left: (375 * widthRatio - 340 * widthRatio) / 2,
            top: 120 * heightRatio,
            child: SizedBox(
              width: 340 * widthRatio,
              height: 200 * heightRatio,
              child: Stack(
                children: [
                  // 이미지
                  Image.asset(
                    'assets/images/tophospital_${_currentIndex + 1}.png',
                    width: 340 * widthRatio,
                    height: 200 * heightRatio,
                    fit: BoxFit.contain,
                  ),

                  // 왼쪽 화살표
                  Positioned(
                    left: 10 * widthRatio,
                    top: (200 * heightRatio - 20 * heightRatio) / 2,
                    child: GestureDetector(
                      onTap: _previousImage,
                      child: Container(
                        width: 20 * widthRatio,
                        height: 20 * heightRatio,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ),
                  ),

                  // 오른쪽 화살표
                  Positioned(
                    right: 10 * widthRatio,
                    top: (200 * heightRatio - 20 * heightRatio) / 2,
                    child: GestureDetector(
                      onTap: _nextImage,
                      child: Container(
                        width: 20 * widthRatio,
                        height: 20 * heightRatio,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 스크롤 배너 목록
          Positioned(
            left: (375 * widthRatio - 300 * widthRatio) / 2,
            top: 340 * heightRatio,
            child: SizedBox(
              width: 300 * widthRatio,
              height: 285 * heightRatio,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 앱 소개
                    SizedBox(
                      width: 300 * widthRatio,
                      height: 54 * heightRatio,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProHome()),
                        ),
                        child: Image.asset(
                          'assets/images/select_app.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 탑탑
                    SizedBox(
                      width: 300 * widthRatio,
                      height: 40 * heightRatio,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Toptop()),
                        ),
                        child: Image.asset(
                          'assets/images/select_toptop.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 배너들
                    banner('assets/images/select_homepage.png', 'https://cjtop-hospital.com/'),
                    banner('assets/images/select_blog.png', 'https://blog.naver.com/cjtop_hospital'),
                    banner('assets/images/select_youtube.png', 'https://www.youtube.com/channel/UCkEK-5VniGe-onsYYgQ3NPg'),
                    banner('assets/images/select_NS1.png', 'https://blog.naver.com/cjtoph-ns'),
                    banner('assets/images/select_OS2.png', 'https://blog.naver.com/slam0828'),
                  ],
                ),
              ),
            ),
          ),

          // 스크롤 안내
          if (showScroll)
            Positioned(
              left: (375 * widthRatio - 150 * widthRatio) / 2,
              top: 400 * heightRatio,
              child: SizedBox(
                width: 150 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset('assets/images/scroll_updown.png', fit: BoxFit.contain),
              ),
            ),

          // 네트워크 경고
          if (_showNetworkWarning)
            Positioned(
              left: (375 * widthRatio - 150 * widthRatio) / 2,
              top: 400 * heightRatio,
              child: SizedBox(
                width: 150 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset('assets/images/scroll_network.png', fit: BoxFit.contain),
              ),
            ),

          // 로고
          Positioned(
            left: (375 * widthRatio - 200 * widthRatio) / 2,
            top: 40 * heightRatio,
            child: SizedBox(
              width: 200 * widthRatio,
              height: 50 * heightRatio,
              child: Image.asset(
                'assets/images/logo_main.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}