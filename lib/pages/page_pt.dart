import 'package:flutter/material.dart';
import 'page_select.dart';
import 'pro_hospital.dart';

class PagePt extends StatefulWidget {
  const PagePt({super.key});
  @override
  State<PagePt> createState() => _PagePtState();
}

class _PagePtState extends State<PagePt> {
  bool showScroll = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => showScroll = false);
    });
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
            left: 90 * widthRatio,
            top: 40 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PageSelect()),
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
            left: (375 * widthRatio - 350 * widthRatio) / 2,
            top: 120 * heightRatio,
            child: SizedBox(
              width: 350 * widthRatio,
              height: 450 * heightRatio,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Image.asset(
                  'assets/images/image_pt.png',
                  width: 350 * widthRatio,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
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
          if (showScroll)
            Positioned(
              left: 120 * widthRatio,
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