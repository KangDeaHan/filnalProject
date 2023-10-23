<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구성원 근무</title>
<style>
body {
    margin: 0;
    padding: 0;
}

body,
html {
    height: 100%;
}

.md-work-week-cont {
    position: relative;
    padding-left: 50px;
}

.md-work-week-avatar {
    position: absolute;
    max-height: 40px;
    max-width: 40px;
    top: 21px;
    -webkit-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    left: 20px;
}

.md-work-week-name {
    font-size: 16px;
}

.md-work-week-title {
    font-size: 12px;
    margin-top: 0px;
    color : gray;
}
.event-title {
	font-size: 12px;
    margin-top: 0px;
}

.md-switching-timeline-view-cont .mbsc-segmented {
    max-width: 350px;
    margin: 0 auto;
    padding: 1px;
}

.md-work-week-picker {
    flex: 1 0 auto;
}

.md-work-week-nav {
    width: 200px;
}

.md-switching-timeline-view-cont .mbsc-timeline-resource {
    display: flex;
    align-items: center;
}

.md-switching-timeline-view-cont .mbsc-timeline-resource-col {
    width: 205px;
}

@supports (overflow:clip) {
    .md-switching-timeline-view-cont.mbsc-ltr .mbsc-schedule-event-inner {
        left: 205px;
    }
    .md-switching-timeline-view-cont.mbsc-rtl .mbsc-schedule-event-inner {
        right: 205px;
    }
}

/* material header order */

.mbsc-material.md-work-week-prev {
    order: 1;
}

.mbsc-material.md-work-week-next {
    order: 2;
}

.mbsc-material.md-work-week-nav {
    order: 3;
}

.mbsc-material .md-work-week-picker {
    order: 4;
}

.mbsc-material .md-work-week-today {
    order: 5;
}

/* windows header order */

.mbsc-windows.md-work-week-nav {
    order: 1;
}

.mbsc-windows.md-work-week-prev {
    order: 2;
}

.mbsc-windows.md-work-week-next {
    order: 3;
}

.mbsc-windows .md-work-week-picker {
    order: 4;
}

.mbsc-windows .md-work-week-today {
    order: 5;
}
/* 여기까지가 mobiscroll css */

.input-group-text {
	border : 1px;
	background-color: white;
}
a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a {
	text-decoration-line: none;
}

.excelBtn {
	border-radius: 10px;
	background-color:white;
	padding: 10px 20px;
    color: #556372;
    cursor: pointer;
    border: 1px solid #EFEFEF;
    font-weight: 900;
}
</style>
</head>
<body>
	<div id="myWrap">
		<div class="d-flex flex-row bd-highlight mb-3">
            <div class="myWork">
                <a href="/work/work">
                    <h1 style="color: #CDD1D5;margin-left: 25px;margin-top:5px;">내 근무</h1>
				</a>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div class="flex-fill">
                <h1 style="margin-top:5px;">구성원 근무</h1>
			</div>
			<div class="d-flex flex-row justify-content-end">
                <!--엑셀로 내보내기 버튼 추가 예정 -->
				<button type="button" class="excelBtn"
                data-toggle="modal" data-target=".modal-right">
                <span class="fe fe-download fe-16 mr-2"></span>
                근무 리포트
            </button>
        </div>
    </div>
    <hr>
	<div mbsc-page class="demo-switching-day-week-work-week-timeline">
        <div style="height:100%">
                <div id="demo-day-work-week-view" class="md-switching-timeline-view-cont"></div>
            </div>
        </div>
    </div>
    <script>

    $(() => {
        countEMP();
        workOneSelect();
        });
    
    const header = '${_csrf.headerName}';
    const token =  '${_csrf.token}';
    $(".excelBtn").on("click",function(){
        // 사용자에게 다운로드를 시작할 것인지 묻는 메시지 표시
        if (confirm("전체 데이터를 다운로드하시겠습니까?")) {
            // 사용자가 동의한 경우 서버로 요청을 보내 파일 다운로드 시작
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/work/downloadExcel", true);
          	xhr.setRequestHeader(header,token);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                   console.log(xhr.responseText);
                    //요청이 완료되면 다운로드 링크를 생성하고 클릭
                    var downloadLink = document.createElement("a");
//                    downloadLink.href = "data:application/octet-stream;base64," + xhr.responseText;
                    downloadLink.href = xhr.responseText;
                    downloadLink.download = "전체사원.xlsx";
                    //downloadLink.style.display = "none";
                    //document.body.appendChild(downloadLink);
                    downloadLink.click();
                    //document.body.removeChild(downloadLink);
                }
            };
            xhr.send();
        }
    });
    
        
    var eventData = [];
    var myResources = [];
    var calendar;
	// add event
    const workOneSelect = function() {
        let xhr = new XMLHttpRequest();
        xhr.open("get", "/work/workOneSelect", true);
        xhr.onreadystatechange = function() {
           if(xhr.readyState == 4 && xhr.status == 200) {
//               console.log("근무일정 불러오기", JSON.parse(xhr.responseText));
              let result = JSON.parse(xhr.responseText);
              
              for(let i=0; i<result.length; i++) {
                 let item = result[i];
                 let event = {
                         start: item.waStime,
                         end: item.waEtime,
                         allDay: item.waAllday,
                         title: item.waType,
                         resource: item.waAper,
                         color: item.wkColor, 
                         ewApst : item.ewApst,
                         apbPro : item.apbPro
                     };
                 eventData.push(event);
              };
              calendar.addEvent(eventData);
              console.log("eventData : ", eventData);
           }
          }
          xhr.send();
    };
    
    // resource에 사원목록 출력
    const countEMP = function() {
        let url = "/work/countEMP";
        $.ajax({
            url: url,
            type: "GET",
            dataType: "json",
            success: function (result) {
                console.log("countEMP 불러오기", result);

                for (let i = 0; i < result.length; i++) {
                    let item = result[i];
                    let resource = {
                       		id: item.empNo,
                            name: item.empNm,
                            color: '#009788',
                            title : item.dnm,
                            img : item.empImg
                         };
                    myResources.push(resource);
                };

                console.log("myResources 내부에서 확인 : ", myResources);
                handleResources(myResources);
            },
            error: function (xhr, status, error) {
                console.error("AJAX 요청 실패: " + error);
            },
        });
    };
    function handleResources(resources) {
        console.log("myResources를 활용한 작업:", resources);
        
     	// dateformat 초기화
        var formatDate = mobiscroll.util.datetime.formatDate;
    	calendar = mobiscroll.eventcalendar('#demo-day-work-week-view', {
        view: {
            timeline: {
                type: 'week',
                eventList: true,
                startDay : 1,
				endDay : 0
            }
        },
        data: eventData,
        resources: myResources,
        // 캘린더 헤더설정
        renderHeader: function () {
            return '<div mbsc-calendar-nav class="md-work-week-nav"></div>' +
                '<div class="md-work-week-picker">' +
                '<label>일<input mbsc-segmented type="radio" name="view" value="day" class="md-view-change"></label>' +
                '<label>주<input mbsc-segmented type="radio" name="view" value="week" class="md-view-change" checked></label>' +
                '<label>월<input mbsc-segmented type="radio" name="view" value="month" class="md-view-change"></label>' +
                '</div>' +
                '<div mbsc-calendar-prev class="md-work-week-prev"></div>' +
                '<div mbsc-calendar-today class="md-work-week-today"></div>' +
                '<div mbsc-calendar-next class="md-work-week-next"></div>';
        },
        renderWeek: function (day) {
            var date = day.date;
            return `<div>`+ formatDate('MMMM DD', date) +`</div>`;
        },
        renderDay: function(day) {
            var date = day.date;
            var today = new Date(); // 현재 날짜

            var isToday = date.getDate() === today.getDate() &&
                date.getMonth() === today.getMonth() &&
                date.getFullYear() === today.getFullYear();

            // 오늘 날짜인 경우, <span class="dot dot-lg bg-success"></span> 추가
            var dotElement = isToday ? '<span class="dot dot-lg bg-success"></span>' : '';

            var dayOfWeek = date.getDay(); // 0 (일요일)부터 6 (토요일)까지의 값을 반환합니다.
            
            // 요일에 따라 글자 색상을 조절
            var dayText = '';
            if (dayOfWeek === 0) { // 일요일
                dayText = '<span style="color: red;">' + formatDate('DD DDD ', date) + '</span>';
            } else if (dayOfWeek === 6) { // 토요일
                dayText = '<span style="color: red;">' + formatDate('DD DDD ', date) + '</span>';
            } else {
                dayText = formatDate('DD DDD ', date);
            }

            return '<div class="mbsc-timeline-header-date-text mbsc-ios" style="font-weight: bold;display:flex;align-items:center;text-align:center;">'
                + '<div class="mbsc-timeline-header-date-text mbsc-ios" style="text-align: center;"></div>'
                + '<div>'
                + dayText                                                                                                      
                + dotElement
                + '</div>' + '</div>';
        },
        renderResource: function (resource) {  // More info about renderResource: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-renderResource
        	return '<div class="md-work-week-cont ">' +
            '<div class="md-work-week-name">' + resource.name + '</div>' +
            '<div class="md-work-week-title">' + resource.title + '</div>' +
            '<a href="/work/detailWork/' + resource.id + '"><img class="md-work-week-avatar" ' +
            'onerror="this.src=\'/resources/images/insight-basic50x50.png\'" src="' + resource.img + '"/></a>' +
            '</div>';
        },
        renderScheduleEventContent : function(
                args) {
        	// "대기" 상태일 때 배경색을 투명하게 설정
        	if (args.original.apbPro !== '승인') {
			    var hexColor = args.original.color; // 16진수 색상값
			    var r = parseInt(hexColor.slice(1, 3), 16); // 16진수를 10진수로 변환
			    var g = parseInt(hexColor.slice(3, 5), 16);
			    var b = parseInt(hexColor.slice(5, 7), 16);
			    args.style.background = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.4)';
			}
                return '<div class="event-title">'
                    + args.title + "　" + args.start + " - " + args.end +  '</div>';
                }
    	});
    	// 일별 , 주별 , 월별 설정
        document.querySelectorAll('.md-view-change').forEach(function (elm) {
            elm.addEventListener('change', function (ev) {
                switch (ev.target.value) {
                    case 'week':
                        calendar.setOptions({
                            view: {
                                timeline: {
                                    type: 'week',
                                    eventList: true,
                                    startDay : 1,
                    				endDay : 0,
                                }
                            }
                        })
                        break;
                    case 'month':
                        calendar.setOptions({
                            view: {
                                timeline: {
                                    type: 'month',
                                    eventList: true
                                }
                            }
                        })
                        break;
                    case 'day':
                        calendar.setOptions({
                            view: {
                                timeline: {
                                    type: 'day',
                                    eventList: true,
                                    weekNumbers: false,
                                    currentTimeIndicator: true,
                                }
                            }
                        })
                        break;
                }
            });
        });
    }
    console.log("밖에서 나와서 리소스 : ",myResources);
    
    //옵션 (언어, 테마, light/dark 모드)
    mobiscroll.setOptions({
        locale: mobiscroll.localeKo,
        theme: 'material',
        themeVariant: 'light'
    });
    
    </script>
</body>
</html>
