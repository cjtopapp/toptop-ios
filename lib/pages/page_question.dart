import 'package:flutter/material.dart';
import 'pro_adm.dart';
import 'page_select.dart';

class PageQuestion extends StatefulWidget {
  const PageQuestion({super.key});
  @override
  State<PageQuestion> createState() => _PageQuestionState();
}

class _PageQuestionState extends State<PageQuestion> {
  String? visibleImage;
  bool showLay2 = false;
  bool showScroll = true;
  bool showScrollLeftRight = false;
  bool showCloseManual = false;

  void showImage(String imageName) {
    setState(() {
      visibleImage = imageName;
      showLay2 = true;
      showScroll = false;
      showScrollLeftRight = true;
      showCloseManual = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showScrollLeftRight = false);
    });
  }

  void hideImage() => setState(() {
    visibleImage = null;
    showLay2 = false;
    showScroll = true;
    showScrollLeftRight = false;
    showCloseManual = false;
  });

  void hideManual() => setState(() {
    visibleImage = null;
    showLay2 = false;
    showScroll = true;
    showCloseManual = false;
  });

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
            left: 90 * widthRatio,
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
          Positioned(
            left: 290 * widthRatio,
            top: 580 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProAdm()),
              ),
              child: SizedBox(
                width: 70 * widthRatio,
                height: 70 * heightRatio,
                child: Image.asset('assets/images/back.png', fit: BoxFit.contain),
              ),
            ),
          ),
          if (!showLay2)
            Positioned(
              left: 27.5 * widthRatio,
              top: 80 * heightRatio,
              child: SizedBox(
                width: 320 * widthRatio,
                height: 500 * heightRatio,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => showImage('op_OS2.png'),
                        child: SizedBox(
                          width: 300 * widthRatio,
                          height: 150 * heightRatio,
                          child: Image.asset('assets/images/OS2.png', fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(height: 10 * heightRatio),
                      GestureDetector(
                        onTap: () => showImage('op_OS1.png'),
                        child: SizedBox(
                          width: 300 * widthRatio,
                          height: 150 * heightRatio,
                          child: Image.asset('assets/images/OS1.png', fit: BoxFit.contain),
                        ),
                      ),
                      SizedBox(height: 10 * heightRatio),
                      GestureDetector(
                        onTap: () => showImage('op_NS.png'),
                        child: SizedBox(
                          width: 300 * widthRatio,
                          height: 150 * heightRatio,
                          child: Image.asset('assets/images/NS.png', fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (showLay2 && visibleImage != null)
            Positioned(
              left: 20,
              top: 100,
              bottom: 200,
              child: GestureDetector(
                onTap: hideImage,
                child: SizedBox(
                  width: 375 * widthRatio,
                  height: 665 * heightRatio,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Image.asset('assets/images/$visibleImage', fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
          if (showLay2 && showScrollLeftRight)
            Positioned(
              left: 100 * widthRatio,
              top: 150 * heightRatio,
              child: SizedBox(
                width: 200 * widthRatio,
                height: 200 * heightRatio,
                child: Image.asset('assets/images/scroll_leftright.png', fit: BoxFit.contain),
              ),
            ),
          if (showCloseManual)
            Positioned(
              left: 90 * widthRatio,
              top: 480 * heightRatio,
              child: GestureDetector(
                onTap: hideManual,
                child: SizedBox(
                  width: 200 * widthRatio,
                  height: 50 * heightRatio,
                  child: Image.asset('assets/images/close_manual.png', fit: BoxFit.cover),
                ),
              ),
            ),
        ],
      ),
    );
  }
}