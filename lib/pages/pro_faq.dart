import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'page_select.dart';
import 'pro_home.dart';
import 'pro_hospital.dart';
import 'pro_adm.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'reservation_webview.dart';

class ProFaq extends StatefulWidget {
  const ProFaq({super.key});
  @override
  State<ProFaq> createState() => _ProFaqState();
}

class _ProFaqState extends State<ProFaq> {
  bool showScroll = true;
  bool _showNetworkWarning = false;
  bool _showNewsScroll = true; // A 스크롤 먼저 표시

  final ScrollController _newsController = ScrollController();
  final ScrollController _rpController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showScroll = false);
    });
  }

  @override
  void dispose() {
    _newsController.dispose();
    _rpController.dispose();
    super.dispose();
  }

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

  Widget banner(String asset, String url, double widthRatio, double heightRatio) => Padding(
    padding: EdgeInsets.only(bottom: 15 * heightRatio),
    child: GestureDetector(
      onTap: () => launchLink(url),
      child: SizedBox(
        width: 320 * widthRatio,
        height: 220 * heightRatio,
        child: Image.asset(asset, fit: BoxFit.contain),
      ),
    ),
  );

  Widget navIcon(String asset, VoidCallback onTap, double widthRatio, double heightRatio) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: 93 * widthRatio,
      height: 50 * heightRatio,
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
          // A 스크롤 아이콘 (뉴스) - 동적으로 이미지 변경
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,
            top: 120 * heightRatio,
            child: GestureDetector(
              onTap: () => setState(() => _showNewsScroll = true),
              child: SizedBox(
                width: 160 * widthRatio,
                height: 20 * heightRatio,
                child: Image.asset(
                  _showNewsScroll
                      ? 'assets/images/faq_news_color.png'
                      : 'assets/images/faq_news.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // B 스크롤 아이콘 (언론보도) - 동적으로 이미지 변경
          Positioned(
            left: 375 * widthRatio - (375 * widthRatio - 320 * widthRatio) / 2 - 160 * widthRatio,
            top: 120 * heightRatio,
            child: GestureDetector(
              onTap: () => setState(() => _showNewsScroll = false),
              child: SizedBox(
                width: 160 * widthRatio,
                height: 20 * heightRatio,
                child: Image.asset(
                  !_showNewsScroll
                      ? 'assets/images/faq_rp_color.png'
                      : 'assets/images/faq_rp.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // A 스크롤 (뉴스) - Offstage 사용
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,
            top: 150 * heightRatio,
            child: Offstage(
              offstage: !_showNewsScroll,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 410 * heightRatio,
                child: SingleChildScrollView(
                  controller: _newsController,
                  child: Column(
                    children: [
                      banner('assets/images/news_1.jpg', 'https://blog.naver.com/cjtop_hospital/224044556371', widthRatio, heightRatio),
                      banner('assets/images/news_2.jpg', 'https://blog.naver.com/cjtop_hospital/224026777698', widthRatio, heightRatio),
                      banner('assets/images/news_3.jpg', 'https://blog.naver.com/cjtop_hospital/224018407956', widthRatio, heightRatio),
                      banner('assets/images/news_4.jpg', 'https://blog.naver.com/cjtop_hospital/223991124968', widthRatio, heightRatio),
                      banner('assets/images/news_5.jpg', 'https://blog.naver.com/cjtop_hospital/223953847718', widthRatio, heightRatio),
                      banner('assets/images/news_6.jpg', 'https://blog.naver.com/cjtop_hospital/223942689302', widthRatio, heightRatio),
                      banner('assets/images/news_7.jpg', 'https://blog.naver.com/cjtop_hospital/223942623323', widthRatio, heightRatio),
                      banner('assets/images/news_8.jpg', 'https://blog.naver.com/cjtop_hospital/223909592134', widthRatio, heightRatio),
                      banner('assets/images/news_9.jpg', 'https://blog.naver.com/cjtop_hospital/223902028185', widthRatio, heightRatio),
                      banner('assets/images/news_10.jpg', 'https://blog.naver.com/cjtop_hospital/223894672436', widthRatio, heightRatio),
                      banner('assets/images/news_11.jpg', 'https://blog.naver.com/cjtop_hospital/223865161179', widthRatio, heightRatio),
                      banner('assets/images/news_12.jpg', 'https://blog.naver.com/cjtop_hospital/223865071096', widthRatio, heightRatio),
                      banner('assets/images/news_13.jpg', 'https://blog.naver.com/cjtop_hospital/223860320069', widthRatio, heightRatio),
                      banner('assets/images/news_14.jpg', 'https://blog.naver.com/cjtop_hospital/223844797660', widthRatio, heightRatio),
                      banner('assets/images/news_15.jpg', 'https://blog.naver.com/cjtop_hospital/223842467665', widthRatio, heightRatio),
                      banner('assets/images/news_16.jpg', 'https://blog.naver.com/cjtop_hospital/223828836640', widthRatio, heightRatio),
                      banner('assets/images/news_17.jpg', 'https://blog.naver.com/cjtop_hospital/223821044704', widthRatio, heightRatio),
                      banner('assets/images/news_18.jpg', 'https://blog.naver.com/cjtop_hospital/223802486324', widthRatio, heightRatio),
                      banner('assets/images/news_19.jpg', 'https://blog.naver.com/cjtop_hospital/223721348832', widthRatio, heightRatio),
                      SizedBox(height: 30 * heightRatio),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // B 스크롤 (언론보도) - Offstage 사용
          Positioned(
            left: (375 * widthRatio - 320 * widthRatio) / 2,
            top: 150 * heightRatio,
            child: Offstage(
              offstage: _showNewsScroll,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 410 * heightRatio,
                child: SingleChildScrollView(
                  controller: _rpController,
                  child: Column(
                    children: [
                      banner('assets/images/rp_1.jpg', 'https://www.hinews.co.kr/view.php?ud=2025062614511020466aa9cc43d0_48', widthRatio, heightRatio),
                      banner('assets/images/rp_2.jpg', 'https://www.biotimes.co.kr/news/articleView.html?idxno=21845', widthRatio, heightRatio),
                      banner('assets/images/rp_3.jpg', 'https://www.rapportian.com/news/articleView.html?idxno=221329', widthRatio, heightRatio),
                      banner('assets/images/rp_4.jpg', 'https://www.inews365.com/news/article.html?no=860117', widthRatio, heightRatio),
                      banner('assets/images/rp_5.jpg', 'https://n.news.naver.com/mnews/article/382/0001189090?sid=103', widthRatio, heightRatio),
                      banner('assets/images/rp_6.jpg', 'https://www.tourmagazine.co.kr/preview/322407', widthRatio, heightRatio),
                      banner('assets/images/rp_7.jpg', 'https://sports.donga.com/article/all/20241031/130337758/1', widthRatio, heightRatio),
                      banner('assets/images/rp_8.jpg', 'https://sports.donga.com/article/all/20241031/130337751/1', widthRatio, heightRatio),
                      banner('assets/images/rp_9.jpg', 'https://www.getnews.co.kr/news/articleView.html?idxno=684855', widthRatio, heightRatio),
                      banner('assets/images/rp_10.jpg', 'https://www.getnews.co.kr/news/articleView.html?idxno=683670', widthRatio, heightRatio),
                      banner('assets/images/rp_11.jpg', 'https://n.news.naver.com/mnews/article/144/0000975021?sid=103', widthRatio, heightRatio),
                      banner('assets/images/rp_12.jpg', 'https://sports.donga.com/article/all/20240707/125815021/1', widthRatio, heightRatio),
                      banner('assets/images/rp_13.jpg', 'https://sports.donga.com/article/all/20240707/125805714/1', widthRatio, heightRatio),
                      banner('assets/images/rp_14.jpg', 'https://mdtoday.co.kr/news/view/1065602921890913', widthRatio, heightRatio),
                      banner('assets/images/rp_15.jpg', 'https://www.biotimes.co.kr/news/articleView.html?idxno=15850', widthRatio, heightRatio),
                      banner('assets/images/rp_16.jpg', 'https://www.inews365.com/news/article.html?no=815668', widthRatio, heightRatio),
                      banner('assets/images/rp_17.jpg', 'https://biz.heraldcorp.com/article/3401032', widthRatio, heightRatio),
                      banner('assets/images/rp_18.jpg', 'http://www.sfnews.kr/news/277799', widthRatio, heightRatio),
                      SizedBox(height: 30 * heightRatio),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 로고
          Positioned(
            left: 40 * widthRatio,
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PageSelect()),
              ),
              child: SizedBox(
                width: 200 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
              ),
            ),
          ),

          // 예약 버튼
          Positioned(
            left: 250 * widthRatio,
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => _showReservationModal(context),
              child: SizedBox(
                width: 85 * widthRatio,
                height: 50 * heightRatio,
                child: Image.asset('assets/images/logo_toptop.png', fit: BoxFit.contain),
              ),
            ),
          ),

          // 스크롤 안내
          if (showScroll)
            Positioned(
              left: (375 * widthRatio - 150 * widthRatio) / 2,
              top: 330 * heightRatio,
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
              top: 330 * heightRatio,
              child: SizedBox(
                width: 150 * widthRatio,
                height: 150 * heightRatio,
                child: Image.asset('assets/images/scroll_network.png', fit: BoxFit.contain),
              ),
            ),

          // 하단 네비게이션
          Positioned(
            left: 0 * widthRatio,
            top: 605 * heightRatio,
            child: navIcon('assets/images/icon_home_basic.png', () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProHome())), widthRatio, heightRatio
            ),
          ),
          Positioned(
            left: 93 * widthRatio,
            top: 605 * heightRatio,
            child: navIcon('assets/images/icon_hos_basic.png', () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProHospital())), widthRatio, heightRatio
            ),
          ),
          Positioned(
            left: 186 * widthRatio,
            top: 605 * heightRatio,
            child: navIcon('assets/images/icon_adm_basic.png', () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProAdm())), widthRatio, heightRatio
            ),
          ),
          Positioned(
            left: 279 * widthRatio,
            top: 605 * heightRatio,
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