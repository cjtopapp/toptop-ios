import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page_select.dart';
import 'flask.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool isAnswered = false;
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();
  int remaining = 200;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        remaining = 200 - _controller.text.length;
      });
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
        body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
        children: [
          _imageUrl == null
              ? Positioned(
            left: (375 * widthRatio - 200 * widthRatio) / 2,   // size box #3
            top: 40 * heightRatio,
            child: SizedBox(
              width: 200 * widthRatio,
              height: 200 * heightRatio,
              child: Image.asset('assets/images/toptop.png', fit: BoxFit.contain),
            ),
          )
              : Positioned(
            left: (375 * widthRatio - 335 * widthRatio) / 2,   // size box #3
            top: 40 * heightRatio,
            child: SizedBox(
              width: 335 * widthRatio,
              height: 200 * heightRatio,
              child: Image.network(_imageUrl!, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: (375 * widthRatio - 335 * widthRatio) / 2,   // size box #3
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
                      hintText: isAnswered ? "" : "질문을 입력하세요",
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
                      const SnackBar(
                        content: Text("질문을 입력해 주세요."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  setState(() => isLoading = true);
                  final result = await FlaskAPI.fetchToptopAnswer(_controller.text);
                  setState(() {
                    _controller.text = result['answer'];
                    _imageUrl = result['image'];
                    isAnswered = true;
                    isLoading = false;
                  });
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
            left: (375 * widthRatio - 340 * widthRatio) / 2,   // size box #3
            top: 470 * heightRatio,   // size box #3
            child: SizedBox(
              width: 340 * widthRatio,   // size box #3
              height: 200 * heightRatio,   // size box #3
              child: Image.asset('assets/images/doctors.png', fit: BoxFit.contain),
            ),
          ),
          Positioned(
            left: 290 * widthRatio,
            top: 580 * heightRatio,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PageSelect())),
              child: SizedBox(
                width: 70 * widthRatio,
                height: 70 * heightRatio,
                child: Image.asset('assets/images/back.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),),
    );
  }
}