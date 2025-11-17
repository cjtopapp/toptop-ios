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
import 'pages/page_OS3.dart';   // 2.0.6

// 2.1.0~
import 'dart:io' show Platform;
import 'package:new_version_plus/new_version_plus.dart';
import 'package:version/version.dart' as v;
import 'package:in_app_update/in_app_update.dart';
import 'package:store_redirect/store_redirect.dart';
// ~2.1.0

void main() => runApp(const MyApp());

// 2.1.0~
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UpdateGate(
      androidId: 'com.cjtoph.app.cjtoph',
      iOSAppId: '6746877257',
      child: const PageOpening(),
    ),
  );
}
// ~2.1.0

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

// 2.1.0~
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PageSelect()),
      );
    });
  }
// ~2.1.0

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
            left: (375 * widthRatio - 160 * widthRatio) / 2,   // size box #3
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
              left: (375 * widthRatio - 288 * widthRatio) / 2,   // size box #3
              top: 250 * heightRatio,
              child: SizedBox(
                width: 288 * widthRatio,   // size box #3
                height: 162 * heightRatio,   // size box #3
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 288 * widthRatio,   // size box #3
                    height: 162 * heightRatio,   // size box #3
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

// 2.1.0~
class UpdateGate extends StatefulWidget {
  final Widget child;
  final String androidId;
  final String iOSAppId;
  const UpdateGate({
    super.key,
    required this.child,
    required this.androidId,
    required this.iOSAppId,
  });
  @override
  State<UpdateGate> createState() => _UpdateGateState();
}

class _UpdateGateState extends State<UpdateGate> {
  bool _block = false;

  @override
  void initState() {
    super.initState();
    _checkAndGate();
  }

  Future<void> _checkAndGate() async {
    if (Platform.isAndroid) {
      try {
        final info = await InAppUpdate.checkForUpdate();
        if (info.updateAvailability == UpdateAvailability.updateAvailable &&
            info.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        }
      } catch (_) {}
    }

    try {
      final nv = NewVersionPlus(
        androidId: widget.androidId,
        iOSId: widget.iOSAppId,
        iOSAppStoreCountry: 'kr',
      );
      final status = await nv.getVersionStatus();
      if (status == null) return;

      final current = v.Version.parse(status.localVersion);
      final store = v.Version.parse(status.storeVersion);
      if (current < store) {
        if (mounted) setState(() => _block = true);
      }
    } catch (_) {}
  }

  void _goStore() {
    if (Platform.isIOS) {
      StoreRedirect.redirect(iOSAppId: widget.iOSAppId);
    } else {
      StoreRedirect.redirect(androidAppId: widget.androidId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_block) return widget.child;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: AlertDialog(
            title: const Text('업데이트 필요'),
            content: const Text('앱 업데이트 후 사용하세요.'),
            actions: [
              TextButton(onPressed: _goStore, child: const Text('업데이트 이동')),
            ],
          ),
        ),
      ),
    );
  }
}
// ~2.1.0

// git config --global --add safe.directory C:/src -> terminal 오류 시

// 2.1.0 바꾼 것
// <manifest>
// android - app - src - main
//
// <build.gradle.kts>
// android - app
//
// <gradle.properties>
// android
//
// <setting.gradle.kts>
// android

// flutter run -d web-server