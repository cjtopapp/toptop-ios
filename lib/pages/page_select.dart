import 'package:flutter/material.dart';
import 'toptop.dart';
import 'pro_home.dart';

class PageSelect extends StatelessWidget {
  const PageSelect({super.key});

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
            left: -5 * widthRatio,
            top: 370 * heightRatio,
            child: SizedBox(
              width: 380 * widthRatio,
              height: 300 * heightRatio,
              child: Image.asset(
                'assets/images/tophospital.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 40 * widthRatio,
            top: 120 * heightRatio,
            child: SizedBox(
              width: 300 * widthRatio,
              height: 100 * heightRatio,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProHome()),
                ),
                child: Image.asset(
                  'assets/images/bar_pro.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 40 * widthRatio,
            top: 240 * heightRatio,
            child: SizedBox(
              width: 300 * widthRatio,
              height: 100 * heightRatio,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page1()),
                ),
                child: Image.asset(
                  'assets/images/bar_simple.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 90 * widthRatio,
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