import 'package:flutter/material.dart';
import 'page_select.dart';

class PageDx extends StatefulWidget {
  const PageDx({super.key});
  @override
  State<PageDx> createState() => _PageDxState();
}

class _PageDxState extends State<PageDx> {
  bool showTimeButtons = false;
  String? visibleTime;
  String? visibleTimeButton;

  void showBarUpper() => setState(() {
    visibleTime = 'bar_upper.png';
    visibleTimeButton = 'time_dx.png';
    showTimeButtons = true;
  });

  void showBarBack() => setState(() {
    visibleTime = 'bar_back.png';
    visibleTimeButton = 'time_back.png';
    showTimeButtons = true;
  });

  void showBarJp() => setState(() {
    visibleTime = 'bar_jp.png';
    visibleTimeButton = 'time_jp.png';
    showTimeButtons = true;
  });

  void hideVisibleTime() => setState(() {
    visibleTime = null;
    visibleTimeButton = null;
    showTimeButtons = false;
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
            left: (375 * widthRatio - 200 * widthRatio) / 2,   // sizebox #3
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
            left: 290 * widthRatio,
            top: 580 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
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
          Positioned(
            left: (375 * widthRatio - 300 * widthRatio) / 2,   // sizebox #3
            top: 200 * heightRatio,
            child: GestureDetector(
              onTap: showBarUpper,
              child: SizedBox(
                width: 300 * widthRatio,
                height: 40 * heightRatio,
                child: Image.asset(
                  'assets/images/bar_upper.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: (375 * widthRatio - 300 * widthRatio) / 2,   // sizebox #3
            top: 275 * heightRatio,
            child: GestureDetector(
              onTap: showBarBack,
              child: SizedBox(
                width: 300 * widthRatio,
                height: 40 * heightRatio,
                child: Image.asset(
                  'assets/images/bar_back.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: (375 * widthRatio - 300 * widthRatio) / 2,   // sizebox #3
            top: 350 * heightRatio,
            child: GestureDetector(
              onTap: showBarJp,
              child: SizedBox(
                width: 300 * widthRatio,
                height: 40 * heightRatio,
                child: Image.asset(
                  'assets/images/bar_jp.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          if (visibleTime != null)
            Positioned(
              left: (375 * widthRatio - 320 * widthRatio) / 2,   // sizebox #3
              top: 100 * heightRatio,   // sizebox #3
              child: GestureDetector(
                onTap: hideVisibleTime,
                child: SizedBox(
                  width: 320 * widthRatio,   // sizebox #3
                  height: 460 * heightRatio,   // sizebox #3
                  child: Image.asset(
                    'assets/images/$visibleTime',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          if (showTimeButtons && visibleTimeButton != null)
            Positioned(
              left: (375 * widthRatio - 320 * widthRatio) / 2,   // sizebox #3
              top: 100 * heightRatio,   // sizebox #3
              child: GestureDetector(
                onTap: hideVisibleTime,
                child: SizedBox(
                  width: 320 * widthRatio,   // sizebox #3
                  height: 460 * heightRatio,   // sizebox #3
                  child: Image.asset(
                    'assets/images/$visibleTimeButton',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}