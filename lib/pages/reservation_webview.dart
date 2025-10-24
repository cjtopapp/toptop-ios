import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReservationWebView extends StatefulWidget {
  const ReservationWebView({super.key});
  @override
  State<ReservationWebView> createState() => _ReservationWebViewState();
}

class _ReservationWebViewState extends State<ReservationWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterClose',
        onMessageReceived: (JavaScriptMessage message) {
          if (message.message == 'close') {
            Navigator.of(context).pop();
          }
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) => setState(() => _isLoading = false),
        ),
      )
      ..loadHtmlString(_getReservationHtml());
  }

  String _getReservationHtml() {
    return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta charset="UTF-8">
</head>
<body style="margin:0; padding:0; background-color: rgba(0, 0, 0, 0.5);">

<div id="reservationModal" class="modal" style="display: block;">
    <div class="modal-content">
        <span class="close" id="closeModalBtn" onclick="closeModal()">×</span>
        <h2>온라인 간편 예약 신청</h2>
        <p class="pb_10">아래 정보를 입력 후 예약을 신청하세요.</p>
        <form id="reservationForm">
            <div class="form_item">
                <label for="wr_name" class="tit">이름</label>
                <input type="text" name="wr_name" id="wr_name" placeholder="홍길동" required="">
                
                <label for="wr_2" class="tit">연락처</label>
                <input type="tel" name="wr_2" id="wr_2" placeholder="010-1234-5678" required="">
                
                <label for="wr_3" class="date-label tit">생년월일</label>
                <input type="date" name="wr_3" id="wr_3" class="datepicker" value="1980-01-01" required="">
                
                <label for="wr_4" class="tit">진료 예약 내용</label>
                <textarea name="wr_4" id="wr_4" placeholder="진료 예약 내용을 입력하세요." required=""></textarea>
            </div>
            
            <div class="terms">
                <input type="checkbox" id="terms" name="agree_terms" class="terms_chk">
                <label for="terms" class="custom-checkbox">개인정보 수집 및 이용에 동의합니다.</label>
            </div>
        
            <p style="color: #db350b; font-size: 14px; font-weight: 500; margin: 10px 0;">※ 온라인 예약은 병원 콜센터 통화 후 완료됩니다.</p>
            <p style="color: #db350b; font-size: 14px; font-weight: 500; margin: 10px 0;">※ 공휴일 및 일요일 상담신청 시 정상 근무시간에 순차적으로 연락드립니다.</p>
            
            <button type="submit">예약 신청</button>
        </form>
    </div>
</div>

<style>
    * { 
        box-sizing: border-box; 
        margin: 0;
        padding: 0;
    }
    
    body {
        font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    }
    
    .terms_chk { 
        display: none; 
    }
    
    .tit { 
        font-size: 15px; 
        font-weight: 600; 
        color: #17449e; 
        display: block; 
        margin-top: 12px;
        margin-bottom: 5px;
    }
    
    .pb_10 { 
        padding-bottom: 10px;
        color: #666;
        font-size: 14px;
    }
    
    .custom-checkbox {
        position: relative;
        padding-left: 40px;
        font-size: 14px;
        letter-spacing: -0.5px;
        font-weight: 500;
        cursor: pointer;
        display: flex;
        align-items: center;
        color: #333;
        user-select: none;
    }
    
    .custom-checkbox::before {
        content: "";
        position: absolute;
        left: 0;
        width: 28px;
        height: 28px;
        background-color: #f8f9fa;
        border: 2px solid #999;
        border-radius: 4px;
        transition: all 0.2s;
    }
    
    .terms_chk:checked + .custom-checkbox::before {
        background-color: #01b4ff;
        border: 2px solid #01b4ff;
    }
    
    .terms_chk:checked + .custom-checkbox::after {
        content: "✓";
        position: absolute;
        left: 7px;
        top: 2px;
        color: white;
        font-size: 20px;
        font-weight: bold;
    }

    .modal {
        display: flex;
        align-items: center;
        justify-content: center;
        position: fixed;
        z-index: 100000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
    }
    
    .modal-content {
        background-color: #ffffff;
        padding: 25px;
        width: 92%;
        max-width: 480px;
        border-radius: 16px;
        box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.15);
        max-height: 90vh;
        overflow-y: auto;
        position: relative;
    }
    
    .modal-content h2 {
        color: #17449e;
        font-size: 20px;
        margin-bottom: 8px;
        padding-right: 30px;
    }
    
    .close {
        position: absolute;
        right: 20px;
        top: 20px;
        font-size: 32px;
        font-weight: 300;
        cursor: pointer;
        color: #999;
        line-height: 1;
        transition: color 0.2s;
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .close:hover { 
        color: #333; 
    }
    
    .form_item input, 
    .form_item textarea {
        width: 100%;
        padding: 12px;
        margin: 0;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-family: inherit;
        font-size: 14px;
        transition: border-color 0.2s;
    }
    
    .form_item input:focus,
    .form_item textarea:focus {
        outline: none;
        border-color: #01b4ff;
    }
    
    .form_item textarea {
        min-height: 100px;
        resize: vertical;
        font-family: inherit;
    }
    
    .form_item button {
        background-color: #01b4ff;
        color: white;
        border: none;
        padding: 14px 20px;
        cursor: pointer;
        border-radius: 8px;
        font-size: 16px;
        margin-top: 20px;
        width: 100%;
        font-weight: 600;
        transition: background-color 0.2s;
    }
    
    .form_item button:hover {
        background-color: #0282cc;
    }
    
    .form_item button:active {
        transform: scale(0.98);
    }
    
    .terms {
        margin-top: 15px;
        margin-bottom: 10px;
    }
    
    .datepicker {
        cursor: pointer !important;
    }
    
    /* 스크롤바 스타일 */
    .modal-content::-webkit-scrollbar {
        width: 6px;
    }
    
    .modal-content::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }
    
    .modal-content::-webkit-scrollbar-thumb {
        background: #01b4ff;
        border-radius: 10px;
    }
</style>

<script>
function closeModal() {
    if (window.FlutterClose) {
        FlutterClose.postMessage('close');
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const dateInput = document.querySelector('.datepicker');
    if (dateInput) {
        dateInput.addEventListener('focus', function() {
            try {
                this.showPicker();
            } catch(e) {
                console.log('showPicker not supported');
            }
        });
    }
    
    var reservationForm = document.getElementById('reservationForm');
    reservationForm.addEventListener('submit', function(event) {
        event.preventDefault();

        var name = document.getElementById('wr_name').value.trim();
        var phone = document.getElementById('wr_2').value.trim();
        var birth = document.getElementById('wr_3').value.trim();
        var content = document.getElementById('wr_4').value.trim();
        var agreeTerms = document.getElementById('terms').checked;

        if (!name) { 
            alert('이름을 입력해주세요.'); 
            return; 
        }
        if (!phone) { 
            alert('연락처를 입력해주세요.'); 
            return; 
        }
        if (!birth) { 
            alert('생년월일을 입력해주세요.'); 
            return; 
        }
        if (!content) { 
            alert('진료예약 내용을 입력해주세요.'); 
            return; 
        }
        if (!agreeTerms) { 
            alert('개인정보 수집 및 이용에 동의해주세요.'); 
            return; 
        }

        var apiUrl = 'https://cjtoph.mycafe24.com/proxy.php';
        var queryParams = 'name=' + encodeURIComponent(name) +
                          '&phone=' + encodeURIComponent(phone) +
                          '&birth=' + encodeURIComponent(birth) +
                          '&content=' + encodeURIComponent(content);

        fetch(apiUrl + '?' + queryParams, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            mode: 'no-cors'
        })
        .then(function() {
            alert('예약 신청이 완료되었습니다.\\n직원이 근무시간에 순차적으로 연락드리겠습니다.');
            
            setTimeout(() => {
                if (window.FlutterClose) {
                    FlutterClose.postMessage('close');
                }
            }, 1000);
        })
        .catch(function(error) {
            console.error('API 호출 오류:', error);
            alert('예약 신청 중 오류가 발생했습니다.\\n잠시 후 다시 시도해주세요.');
        });
    });
});
</script>

</body>
</html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF01b4ff),
          ),
        )
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}