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
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
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
                <input type="text" name="wr_2" id="wr_2" placeholder="010-1234-5678" required="">
                
                <label for="wr_3" class="date-label tit">생년월일</label>
                <input type="text" name="wr_3" id="wr_3" class="datepicker" placeholder="1980년 1월 1일" readonly required="">
                <input type="hidden" id="wr_3_value" value="1980-01-01">
                
                <label for="wr_4" class="tit">진료 예약 내용</label>
                <textarea name="wr_4" id="wr_4" placeholder="진료 예약 내용을 입력하세요." required=""></textarea>
            </div>
            
            <div class="terms">
                <input type="checkbox" id="terms" name="agree_terms" class="terms_chk">
                <label for="terms" class="custom-checkbox">개인정보 수집 및 이용에 동의합니다.</label>
            </div>
        
            <p style="color: #db350b; font-size: 14px; font-weight: 500; margin: 10px 0;">※ 온라인 예약은 병원 콜센터 통화 후 완료됩니다.</p>
            <p style="color: #db350b; font-size: 14px; font-weight: 500; margin: 10px 0 20px 0;">※ 공휴일 및 일요일 상담신청 시 정상 근무시간에 순차적으로 연락드립니다.</p>
            
            <button type="submit">예약 신청</button>
        </form>
    </div>
</div>

<!-- 커스텀 한글 날짜 선택기 -->
<div id="datePickerModal" class="date-picker-modal" style="display: none;">
    <div class="date-picker-content">
        <div class="date-picker-header">
            <button type="button" class="date-picker-btn" onclick="closeDatePicker()">취소</button>
            <span>생년월일 선택</span>
            <button type="button" class="date-picker-btn primary" onclick="confirmDatePicker()">확인</button>
        </div>
        <div class="date-picker-body">
            <div class="picker-column">
                <div id="yearPicker" class="picker-scroll"></div>
            </div>
            <div class="picker-column">
                <div id="monthPicker" class="picker-scroll"></div>
            </div>
            <div class="picker-column">
                <div id="dayPicker" class="picker-scroll"></div>
            </div>
        </div>
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
    
    /* v2.1.4: 박스핏 레이아웃 + 하단 공백 최소화 */
    .modal-content {
        background-color: #ffffff;
        padding: 20px 20px 10px 20px;
        width: 100%;
        max-width: 100%;
        height: 85vh;
        max-height: 85vh;
        border-radius: 16px;
        box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.15);
        overflow-y: auto;
        position: relative;
        display: flex;
        flex-direction: column;
    }
    
    .modal-content h2 {
        color: #17449e;
        font-size: 20px;
        margin-bottom: 8px;
        padding-right: 30px;
        flex-shrink: 0;
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
        z-index: 10;
    }
    
    .close:hover { 
        color: #333; 
    }
    
    .form_item {
        flex: 1;
        overflow-y: auto;
        margin-bottom: 10px;
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
    
    /* v2.1.4: 예약 신청 버튼 크기 증가 + 중앙 정렬 */
    .form_item button,
    button[type="submit"] {
        background-color: #01b4ff;
        color: white;
        border: none;
        padding: 16px 20px;
        cursor: pointer;
        border-radius: 8px;
        font-size: 18px;
        font-weight: 700;
        width: 90%;
        max-width: 400px;
        margin: 15px auto 20px auto;
        display: block;
        transition: background-color 0.2s;
        flex-shrink: 0;
    }
    
    .form_item button:hover,
    button[type="submit"]:hover {
        background-color: #0282cc;
    }
    
    .form_item button:active,
    button[type="submit"]:active {
        transform: scale(0.98);
    }
    
    .terms {
        margin-top: 15px;
        margin-bottom: 10px;
        flex-shrink: 0;
    }
    
    .datepicker {
        cursor: pointer !important;
        background-color: white;
    }
    
    /* 스크롤바 스타일 */
    .modal-content::-webkit-scrollbar,
    .form_item::-webkit-scrollbar {
        width: 6px;
    }
    
    .modal-content::-webkit-scrollbar-track,
    .form_item::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }
    
    .modal-content::-webkit-scrollbar-thumb,
    .form_item::-webkit-scrollbar-thumb {
        background: #01b4ff;
        border-radius: 10px;
    }
    
    /* 한글 날짜 선택기 스타일 */
    .date-picker-modal {
        position: fixed;
        z-index: 200000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: flex-end;
        justify-content: center;
    }
    
    .date-picker-content {
        background-color: white;
        width: 100%;
        max-height: 50vh;
        border-radius: 16px 16px 0 0;
        overflow: hidden;
    }
    
    .date-picker-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 20px;
        border-bottom: 1px solid #ddd;
        font-weight: 600;
        font-size: 16px;
    }
    
    .date-picker-btn {
        background: none;
        border: none;
        color: #01b4ff;
        font-size: 16px;
        cursor: pointer;
        padding: 5px 10px;
    }
    
    .date-picker-btn.primary {
        font-weight: 600;
    }
    
    .date-picker-body {
        display: flex;
        padding: 20px 0;
        height: 250px;
        overflow: hidden;
    }
    
    .picker-column {
        flex: 1;
        overflow-y: auto;
        scroll-snap-type: y mandatory;
    }
    
    .picker-scroll {
        display: flex;
        flex-direction: column;
    }
    
    .picker-item {
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        cursor: pointer;
        scroll-snap-align: center;
    }
    
    .picker-item.selected {
        font-weight: 600;
        color: #01b4ff;
        font-size: 18px;
    }
    
    .picker-column::-webkit-scrollbar {
        width: 0;
    }
</style>

<script>
let selectedYear = 1980;
let selectedMonth = 1;
let selectedDay = 1;

const months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];

function closeModal() {
    if (window.FlutterClose) {
        FlutterClose.postMessage('close');
    }
}

function openDatePicker() {
    document.getElementById('datePickerModal').style.display = 'flex';
    initDatePicker();
}

function closeDatePicker() {
    document.getElementById('datePickerModal').style.display = 'none';
}

function confirmDatePicker() {
    const displayText = selectedYear + '년 ' + selectedMonth + '월 ' + selectedDay + '일';
    const valueText = selectedYear + '-' + String(selectedMonth).padStart(2, '0') + '-' + String(selectedDay).padStart(2, '0');
    
    document.getElementById('wr_3').value = displayText;
    document.getElementById('wr_3_value').value = valueText;
    closeDatePicker();
}

function initDatePicker() {
    const yearPicker = document.getElementById('yearPicker');
    const monthPicker = document.getElementById('monthPicker');
    const dayPicker = document.getElementById('dayPicker');
    
    // 연도 (1940 ~ 2024)
    yearPicker.innerHTML = '';
    for (let i = 1940; i <= 2024; i++) {
        const item = document.createElement('div');
        item.className = 'picker-item' + (i === selectedYear ? ' selected' : '');
        item.textContent = i + '년';
        item.onclick = () => selectYear(i);
        yearPicker.appendChild(item);
    }
    
    // 월
    monthPicker.innerHTML = '';
    months.forEach((month, index) => {
        const item = document.createElement('div');
        item.className = 'picker-item' + (index + 1 === selectedMonth ? ' selected' : '');
        item.textContent = month;
        item.onclick = () => selectMonth(index + 1);
        monthPicker.appendChild(item);
    });
    
    // 일
    updateDayPicker();
}

function selectYear(year) {
    selectedYear = year;
    initDatePicker();
}

function selectMonth(month) {
    selectedMonth = month;
    updateDayPicker();
    highlightMonth();
}

function selectDay(day) {
    selectedDay = day;
    highlightDay();
}

function highlightMonth() {
    document.querySelectorAll('#monthPicker .picker-item').forEach((item, index) => {
        item.className = 'picker-item' + (index + 1 === selectedMonth ? ' selected' : '');
    });
}

function highlightDay() {
    document.querySelectorAll('#dayPicker .picker-item').forEach((item, index) => {
        item.className = 'picker-item' + (index + 1 === selectedDay ? ' selected' : '');
    });
}

function updateDayPicker() {
    const dayPicker = document.getElementById('dayPicker');
    const daysInMonth = new Date(selectedYear, selectedMonth, 0).getDate();
    
    dayPicker.innerHTML = '';
    for (let i = 1; i <= daysInMonth; i++) {
        const item = document.createElement('div');
        item.className = 'picker-item' + (i === selectedDay ? ' selected' : '');
        item.textContent = i + '일';
        item.onclick = () => selectDay(i);
        dayPicker.appendChild(item);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    // 날짜 필드 클릭 시 한글 picker 열기
    const dateInput = document.getElementById('wr_3');
    if (dateInput) {
        dateInput.addEventListener('click', openDatePicker);
    }
    
    // 초기 날짜 설정
    document.getElementById('wr_3').value = '1980년 1월 1일';
    
    var reservationForm = document.getElementById('reservationForm');
    reservationForm.addEventListener('submit', function(event) {
        event.preventDefault();

        var name = document.getElementById('wr_name').value.trim();
        var phone = document.getElementById('wr_2').value.trim();
        var birth = document.getElementById('wr_3_value').value.trim();
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

        // 예약 신청 중 표시
        var submitBtn = document.querySelector('button[type="submit"]');
        var originalText = submitBtn.textContent;
        submitBtn.textContent = '예약 신청 중...';
        submitBtn.disabled = true;

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
            }
        })
        .then(function(response) {
            submitBtn.textContent = originalText;
            submitBtn.disabled = false;
            
            if (!response.ok) {
                throw new Error('HTTP ' + response.status);
            }
            return response.json();
        })
        .then(function(data) {
            if (data && data.success) {
                alert('✅ ' + (data.message || '예약 신청이 완료되었습니다.') + '\\n\\n직원이 근무시간에 순차적으로 연락드리겠습니다.');
                
                setTimeout(function() {
                    if (window.FlutterClose) {
                        FlutterClose.postMessage('close');
                    }
                }, 1000);
            } else {
                throw new Error(data.message || '예약 실패');
            }
        })
        .catch(function(error) {
            submitBtn.textContent = originalText;
            submitBtn.disabled = false;
            
            console.error('API 호출 오류:', error);
            alert('❌ 예약 신청 중 오류가 발생했습니다.\\n\\n잠시 후 다시 시도해주세요.\\n\\n(오류: ' + error.message + ')');
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