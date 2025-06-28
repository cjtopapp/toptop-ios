import 'package:flutter/material.dart';
import 'page_select.dart';
import 'pro_home.dart';
import 'toptop.dart';

class PageTable extends StatefulWidget {
  const PageTable({super.key});
  @override
  State<PageTable> createState() => _PageTableState();
}

class _PageTableState extends State<PageTable> {
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
            left: (375 * widthRatio - 350 * widthRatio) / 2,
            top: 120 * heightRatio,
            child: SizedBox(
              width: 350 * widthRatio,
              height: 450 * heightRatio,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Image.asset(
                  'assets/images/image_table.png',
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
                MaterialPageRoute(builder: (_) => const ProHome()),
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