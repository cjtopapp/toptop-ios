import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'page_select.dart';
import 'flask.dart';
import 'toptop.dart';

class Toptop extends StatefulWidget {
  const Toptop({super.key});
  @override
  State<Toptop> createState() => _ToptopState();
}

class _ToptopState extends State<Toptop> {
  bool isAnswered = false;
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();
  int remaining = 200;
  String? _imageUrl;

  List<Map<String, String>> conversationHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _controller.addListener(() {
      setState(() {
        remaining = 200 - _controller.text.length;
      });
    });
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('chat_history');
    if (historyJson != null) {
      conversationHistory = List<Map<String, String>>.from(
          (jsonDecode(historyJson) as List).map((item) => Map<String, String>.from(item))
      );
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    const int maxHistoryLength = 20;
    if (conversationHistory.length > maxHistoryLength) {
      conversationHistory = conversationHistory.sublist(conversationHistory.length - maxHistoryLength);
    }
    await prefs.setString('chat_history', jsonEncode(conversationHistory));
  }

  void launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    const baseWidth = 375;
    const baseHeight = 665;
    final widthRatio = MediaQuery.of(context).size.width / baseWidth;
    final heightRatio = MediaQuery.of(context).size.height / baseHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            _imageUrl == null
                ? Positioned(
              left: (375 * widthRatio - 200 * widthRatio) / 2,
              top: 40 * heightRatio,
              child: SizedBox(
                width: 200 * widthRatio,
                height: 200 * heightRatio,
                child: Image.asset('assets/images/toptop.png', fit: BoxFit.contain),
              ),
            )
                : Positioned(
              left: (375 * widthRatio - 335 * widthRatio) / 2,
              top: 40 * heightRatio,
              child: SizedBox(
                width: 335 * widthRatio,
                height: 200 * heightRatio,
                child: Image.network(_imageUrl!, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              left: (375 * widthRatio - 335 * widthRatio) / 2,
              top: 260 * heightRatio,
              child: SizedBox(
                width: 335 * widthRatio,
                height: 200 * heightRatio,
                child: Stack(
                  children: [
                    TextField(
                      controller: _controller,
                      maxLength: 200,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: isAnswered ? "" : "질문을 입력하세요   예시) 청주탑병원이 어디야?",
                        counterText: "",
                        contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF225095), width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF225095), width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF268eb0), width: 2.0),
                        ),
                      ),
                      readOnly: isAnswered,
                    ),
                    Positioned(
                      bottom: 8,
                      left: 12,
                      child: Text(
                        isAnswered ? "" : "($remaining / 200)",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 300 * widthRatio,
              top: 400 * heightRatio,
              child: GestureDetector(
                onTap: () async {
                  if (!isAnswered) {
                    if (_controller.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("질문을 입력해 주세요.")),
                      );
                      return;
                    }

                    final userQuestion = _controller.text;

                    setState(() {
                      isLoading = true;
                      conversationHistory.add({"role": "user", "content": userQuestion});
                    });

                    final result = await FlaskAPI.fetchToptopAnswer(userQuestion, conversationHistory);
                    final assistantAnswer = result['answer'];

                    setState(() {
                      _controller.text = assistantAnswer;
                      _imageUrl = result['image'];
                      isAnswered = true;
                      isLoading = false;
                      conversationHistory.add({"role": "assistant", "content": assistantAnswer});
                    });

                    await _saveHistory();

                  } else {
                    setState(() {
                      _controller.clear();
                      _imageUrl = null;
                      isAnswered = false;
                      remaining = 200;
                    });
                  }
                },
                child: SizedBox(
                  width: 50 * widthRatio,
                  height: 50 * heightRatio,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Image.asset(
                    isAnswered ? 'assets/images/text_esc.png' : 'assets/images/text_enter.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            Positioned(
              left: (375 * widthRatio - 340 * widthRatio) / 2,
              top: 470 * heightRatio,
              child: SizedBox(
                width: 340 * widthRatio,
                height: 175 * heightRatio,
                child: Image.asset('assets/images/doctors_new.png', fit: BoxFit.contain),
              ),
            ),

            // invincible_map (투명 버튼 - 지도)
            Positioned(
              left: 45 * widthRatio,
              top: 610 * heightRatio,
              child: GestureDetector(
                onTap: () => launchLink(
                  'https://map.naver.com/p/directions/-/14191664.3247314,4388614.527514,%EC%B2%AD%EC%A3%BC%ED%83%91%EB%B3%91%EC%9B%90,1445421759,PLACE_POI/-/transit?c=14190731.5541203%2C4388614.5275141%2C15.00%2C0%2C0%2C0%2Cdh',
                ),
                child: Container(
                  width: 140 * widthRatio,
                  height: 35 * heightRatio,
                  color: Colors.transparent,
                ),
              ),
            ),

            // invincible_call (투명 버튼 - 전화)
            Positioned(
              left: 185 * widthRatio,
              top: 610 * heightRatio,
              child: GestureDetector(
                onTap: () => launchLink('tel:0439008875'),
                child: Container(
                  width: 140 * widthRatio,
                  height: 35 * heightRatio,
                  color: Colors.transparent,
                ),
              ),
            ),

            Positioned(
              left: 10 * widthRatio,
              top: 40 * heightRatio,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PageSelect())),
                child: SizedBox(
                  width: 70 * widthRatio,
                  height: 70 * heightRatio,
                  child: Image.asset('assets/images/back_toptop.png', fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}