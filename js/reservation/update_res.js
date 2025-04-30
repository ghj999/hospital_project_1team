var availableDays = window.availableDays || [];
var professor = window.professor || {};
var holidays = window.holidays || [];
var resIdx = window.res_idx || 0; // 기본값 설정

document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');
    var timeSlotsEl = document.getElementById('timeSlots');

    // 필수 DOM 요소 확인
    if (!calendarEl || !timeSlotsEl) {
        console.error("#calendar 또는 #timeSlots 요소를 찾을 수 없습니다.");
        return;
    }

    // 데이터 초기화
    if (!Array.isArray(availableDays) || !Array.isArray(holidays) || typeof professor !== 'object') {
        console.error("필수 데이터(availableDays, professor, holidays)가 유효하지 않습니다.");
        return;
    }

    var today = new Date();

    // 진료 가능한 요일 추출
    var availableWeekdays = availableDays.map(function (day) {
        return day.weekday;
    });

    // 예약 가능한 날짜 생성
    function generateAvailableDates(year, month, weekdays) {
        var dates = [];
        var date = new Date(year, month, 1);

        while (date.getMonth() === month) {
            if (weekdays.includes(date.getDay()) && date >= today) {
                dates.push(new Date(date));
            }
            date.setDate(date.getDate() + 1);
        }
        return dates;
    }

    // 예약 가능한 시간 생성
   function generateTimeSlots() {
       var slots = [];
       for (var hour = 9; hour <= 12; hour++) {
           slots.push((hour < 10 ? '0' + hour : hour) + ":00"); // 시간 정규화
           if (hour !== 12) slots.push((hour < 10 ? '0' + hour : hour) + ":30"); // 시간 정규화
       }
       for (var hour = 14; hour <= 17; hour++) {
           slots.push((hour < 10 ? '0' + hour : hour) + ":00"); // 시간 정규화
           if (hour !== 17) slots.push((hour < 10 ? '0' + hour : hour) + ":30"); // 시간 정규화
       }
       return slots;
   }

    // 캘린더 이벤트 생성
    function generateEvents(year, month) {
        var availableDates = generateAvailableDates(year, month, availableWeekdays);
        var events = [];

        availableDates.forEach(function (date) {
            var dateStr = date.toISOString().split("T")[0];
            if (!holidays.includes(dateStr)) {
                events.push({
                    title: "진료 가능",
                    start: dateStr,
                    display: "background",
                    classNames: "available-date"
                });
            }
        });

        holidays.forEach(function (holiday) {
            var holidayDate = new Date(holiday);
            if (holidayDate.getFullYear() === year && holidayDate.getMonth() === month) {
                events.push({
                    title: "휴진",
                    start: holiday,
                    display: "background",
                    classNames: "holiday"
                });
            }
        });

        return events;
    }
    
    
    // 독립적인 sendRequest 함수 추가
   function sendRequest(url, params, callback) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log('xhr.readyState:', xhr.readyState);
            console.log('XHR Status:', xhr.status);
            if (xhr.status === 200) {
                try {
                    callback(xhr.responseText);
                } catch (error) {
                    console.error('Error processing response:', error);
                    alert('서버 응답 처리 중 오류가 발생했습니다.');
                }
            } else {
                console.error('Request failed. Status:', xhr.status);
                alert('리소스를 불러오지 못했습니다: ' + xhr.status + ' ' + xhr.statusText);
            }
        }
    };

    console.log('Sending Request to:', url);
    console.log('With Parameters:', params);

    xhr.send(params); // POST 본문에 파라미터 전송
   }


function showTimeSlots(selectedDate) {
    timeSlotsEl.innerHTML = ''; // 초기화
    var allSlots = generateTimeSlots();
    var url = 'hos/getReservedTime2.do';
    var params = 'date=' + selectedDate + '&pro_idx=' + professor.pro_idx;

    console.log('Sending Request to: ' + url);
    console.log('With Parameters: ' + params);
    
    sendRequest(url, params, function (response) {
        try {
            var reservedTimes = JSON.parse(response);
            console.log('Reserved times:', reservedTimes);

            allSlots.forEach(function (time) {
                var button = document.createElement('button');
                button.textContent = time;
                button.classList.add('time-slot');

                if (reservedTimes.includes(time)) {
                    button.disabled = true;
                    button.classList.add('reserved');
                } else {
                    button.addEventListener('click', function () {
                        reserveTime(selectedDate, time, button);
                    });
                }

                timeSlotsEl.appendChild(button);
            });
        } catch (error) {
            console.error('JSON 파싱 오류:', error);
            alert('서버에서 받은 데이터 처리 중 오류가 발생했습니다.');
        }
    }, 'POST');
}

    
    //콜백 method
    function showTimeSlotsCallback(response) {
    if (!response) {
        console.error("Response is empty or null.");
        alert("서버에서 데이터를 가져오는 데 실패했습니다.");
        return;
    }

    try {
        var reservedTimes = JSON.parse(response); // JSON 파싱
        console.log("Reserved times:", reservedTimes);

        var allSlots = generateTimeSlots(); // Time slots 초기화
        allSlots.forEach(function (time) {
            var button = document.createElement("button");
            button.textContent = time;
            button.classList.add("time-slot");

            if (reservedTimes.includes(time)) {
                button.disabled = true;
                button.classList.add("reserved");
            } else {
                button.addEventListener("click", function () {
                    reserveTime(selectedDate, time, button);
                });
            }

            timeSlotsEl.appendChild(button);
        });
    } catch (error) {
           console.error("JSON 파싱 오류:", error);
           alert("서버 응답 처리 중 문제가 발생했습니다.");
       }
   }

    // FullCalendar 설정
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        headerToolbar: {
            left: '',
            center: 'title',
            right: 'prev,next today'
        },
        events: generateEvents(today.getFullYear(), today.getMonth()),
        navLinks: true,
        dateClick: function (info) {
            var selectedDate = info.dateStr;

            if (new Date(selectedDate) < today) {
                alert("이미 지난 날짜는 선택할 수 없습니다.");
                return;
            }

            if (holidays.includes(selectedDate)) {
                alert("공휴일에는 예약할 수 없습니다.");
                return;
            }

            var availableDates = generateAvailableDates(info.date.getFullYear(), info.date.getMonth(), availableWeekdays)
                .map(function (date) {
                    return date.toISOString().split("T")[0];
                });

            if (!availableDates.includes(selectedDate)) {
                alert("진료 가능한 날짜가 아닙니다.");
                return;
            }

            showTimeSlots(selectedDate); // 선택된 날짜의 시간 슬롯 표시
        },
        datesSet: function (info) {
            var newEvents = generateEvents(info.view.currentStart.getFullYear(), info.view.currentStart.getMonth());
            calendar.removeAllEvents();
            calendar.addEventSource(newEvents);
        }
    });

    calendar.render();
    
    // 예약 처리
      function reserveTime(selectedDate, selectedTime, button) {
           // 예약 확인 창
          var confirmation = confirm("예약 하시겠습니까?");
          
          // 사용자가 취소를 누르면 함수 종료
          if (!confirmation) {
              return;
          }
         
          var url = 'updateReservation.do'; // URL은 항상 절대 경로로 처리
          var params = "res_idx=" + res_idx +
             "&pat_idx=" + window.pat_idx +
             "&pro_idx=" + professor.pro_idx +
             "&res_time=" + encodeURIComponent(selectedDate + " " + selectedTime);
             console.log("Request Params:", params);
             
      
          sendRequest(url, params, function (response) {
         if (response === "success") {
                 alert("예약이 수정되었습니다!");
                 button.disabled = true;
                 button.classList.add("reserved");
                 location.href = "mypage_reservation_list.do?pat_idx=" + window.pat_idx;
             } else {
                 alert("예약 수정 실패. 다시 시도해주세요.");
             }
         }, 'POST');
      }
});