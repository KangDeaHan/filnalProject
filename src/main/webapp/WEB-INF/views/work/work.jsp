<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근무</title>
<style>
    body {
        margin: 0;
        padding: 0;
    }

    body,
    html {
        height: 100%;
    }
  h1,h2,h3,h4,h5 {
    display: inline;
    white-space: nowrap;
    text-decoration: none;
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
/* .mbsc-calendar-wrapper { */
/*         display: none;  */
/* } */

#drF {
   color : gray;
}
#drFd {
   color : gray;
   text-weight : bold;
   font-size : small;
}
.event-color-c {
    display: flex;
    margin: 16px;
    align-items: center;
    cursor: pointer;
}

.event-color-label {
    flex: 1 0 auto;
}

.event-color {
    width: 30px;
    height: 30px;
    border-radius: 15px;
    margin-right: 10px;
    margin-left: 240px;
   background: #5ac8fa;
}

.crud-color-row {
    display: flex;
    justify-content: center;
    margin: 5px;
}

.crud-color-c {
    padding: 3px;
    margin: 2px;
}

.crud-color {
    position: relative;
    min-width: 46px;
    min-height: 46px;
    margin: 2px;
    cursor: pointer;
    border-radius: 23px;
   background: #5ac8fa;
}

.crud-color-c.selected,
.crud-color-c:hover {
    box-shadow: inset 0 0 0 3px #007bff;
    border-radius: 48px;
}

.crud-color:before {
    position: absolute;
    top: 50%;
    left: 50%;
    margin-top: -10px;
    margin-left: -10px;
    color: #f7f7f7;
    font-size: 20px;
    text-shadow: 0 0 3px #000;
    display: none;
}

.crud-color-c.selected .crud-color:before {
    display: block;
}

.mbsc-timeline-row-date {
   width: 192px;
   text-align: center;
}

.mbsc-ios.mbsc-segmented {
   display: none !important;
}
.mbsc-ios.mbsc-timeline-row-date {
   display: flex;
   justify-content: center;
   align-items: center;
}
.mbsc-timeline-header-column {
   font-weight : bold;
   color : black;
   text-align : center;
}
.mbsc-flex-1-1, .mbsc-timeline-header-column, .mbsc-ios mbsc-ltr {
   color:black;
}

.md-timeline-height, .mbsc-timeline-resource, .md-timeline-height, .mbsc-timeline-row {
   min-height: 30px;
}

.EachInsert {
   border-radius: 10px;
   background-color:white;
   padding: 10px 20px;
    color: #556372;
    cursor: pointer;
    border: 1px solid #EFEFEF;
    font-weight: 900;
}

.EachCheck {
   width : 95%;
    background: linear-gradient(to right, #3783C6, #39A4C5);
    border-radius: 10px;
    padding: 10px 20px;
    color: white;
    border: none;
    font-weight: 900;
    margin-bottom: 15px;
}

.newWorkInsertBtn {
   width : 95%;
   border-radius: 10px;
   background-color:white;
   padding: 10px 20px;
    color: #556372;
    border: 1px solid #EFEFEF;
    margin-left: 10px;
}

#mbsc-control-1 {
   display:none;
}
/* .mbsc-timeline-event-end, .mbsc-timeline-event-start { */
/*    opacity : 0.4; */
/* } */

</style>
</head>
<body>
   <div id="myWrap">
   <div class="d-flex flex-row bd-highlight mb-3" style="margin-top:5px;">
      <div class="myWork">
         <h1 style="margin-left: 25px;margin-top:5px;">내 근무</h1>
         <h4 style="display:none;">${empVO}</h4>
         <h4 style="display:none;">${list}</h4>
      </div>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <div class="flex-fill">
      
                  <c:set var="oneBreak" value="false" />
                  <c:forEach items="${authentication.authorities}" var="authority">
                      <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
                          <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 41 && oneBreak eq false}">
							      <a href="/work/member">
							         <h1 style="color: #CDD1D5;margin-top:5px;">구성원 근무</h1>
							      </a>
                              <c:set var="oneBreak" value="true" />
                          </c:if>
                      </c:forEach>
                  </c:forEach>

      </div>
      <div class="d-flex flex-row justify-content-end">
              <button type="button" class="EachInsert" data-toggle="modal" data-target=".modal-right"><span class="fe fe-calendar fe-16 mr-2"></span>근무 등록</button>
        </div>
     </div>
   <hr>
       </div>
   <div class="row">
      <div class="col-12 col-lg-12">
         <div class="card shadow mb-1">
            <div class="card-body">
               <!-- 수정됨 -->
                       <h4 id="weekTotal">0시간</h4>
               <h5 style="color: gray;">/ 52시간</h5>
               <div class="dropdown d-inline">
                   <button class="btn btn-sm p-0 dropdown-toggle" type="button"
                       id="dropdownMenuButton" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                       <span class="sr-only">우선순위 변경</span>
                   </button>
                   <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                       <div class="d-flex flex-column">
                           <div class="d-flex justify-content-between">
                               <div class="p-2 dropdown-item text-success">✔ 필수</div>
                               <!-- 수정됨 -->
                           <div class="d-flex dropdown-item justify-content-end" style="font-weight:bold;color:black;">
                                       <span id="weekTotalS">0</span>
                               시간 / 40시간
                           </div>
                           </div>
                           <div class="d-flex justify-content-between">
                               <div class="p-2 dropdown-item justify-content-start" id="drF">기본</div>
                               <div class="d-flex dropdown-item justify-content-end" id="weekTotalD" style="color:gray;">시간</div>
                           </div>
<!--                            <div class="d-flex justify-content-between"> -->
<!--                                <div class="p-2 dropdown-item" id="drF">연차</div> -->
<!--                                <div class="d-flex dropdown-item justify-content-end" id="drF">0시간</div> -->
<!--                            </div> -->
                           <span style="color:gray;">　─────────────────── </span>
                           <div class="d-flex justify-content-between">
                               <div class="p-2 dropdown-item text-danger">🔴 초과</div>
                               <div class="d-flex dropdown-item justify-content-end" style="font-weight:bold;color:black;">
                                        <span id="overtime">0</span>
                                  시간 / 12시간</div>
                           </div>
                           <div class="d-flex justify-content-between">
                               <div class="p-2 dropdown-item" id="drF">연장</div>
                               <div class="d-flex dropdown-item justify-content-end" id="overtimeDiv" style="color:gray;">시간</div>
                           </div>
                           <div class="d-flex justify-content-between">
                               <div class="p-2 dropdown-item" id="drF">야간</div>
                               <div class="d-flex dropdown-item justify-content-end" id="NightTime" style="color:gray;">0시간</div>
                           </div>
                        <p class="p-2 dropdown-item mt-2" id="drFd" style="display:none;">◼ 휴가는 근무 시간에 포함되지 않기 때문에, 휴가를 사용한<br> 4시간 만큼 추가로 근무가 가능해요</p>
                       </div>
                   </div>
               </div>
            </div>
            <!-- .card-body -->
         </div>
         <!-- .card -->
      </div>
      <!-- .col-md-->
   </div>
   <!-- .row -->
   <div class="d-flex justify-content-center">
      <span style="color:gray;text-weight:bold;">🔷<strong>결재처리 중인 일정은 그래프가 투명하게 표시됩니다.</strong></span>
   </div>
   <!-- 반복일정 등록 모달 -->
   <!-- Slide Modal -->
   <div class="modal fade modal-right modal-slide" tabindex="-1"
      role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="defaultModalLabel">근무 일정 등록</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
               <form id="repForm">
                  <div class="modal-body">
                        <div class="form-group col-md-12">
                           <label for="example-select" style="font-weight: bold;">반복
                              기간</label> <select class="form-control" id="example-select">
                              <option value="1">1주</option>
                              <option value="2">2주</option>
                              <option value="3">3주</option>
                              <option value="4">한달</option>
                           </select>
                        </div>
                        <!-- form-group -->
                        <div class="form-group col-md-12">
                        <div class="d-flex bd-highlight">
                           <label for="message-text" class="col-form-label p-2 flex-grow-1 bd-highlight"
                              style="font-weight: bold;">등록 요일</label>
                              <div class="custom-control custom-switch p-2 bd-highlight">
                                       <input type="checkbox" class="custom-control-input" id="customSwitch1" >
                                       <label class="custom-control-label" for="customSwitch1">평일에만 적용</label>
                                     </div> 
                              </div>
                              <select class="form-control select2-multi" id="multi-select2">
                              <option value="1">월</option>
                              <option value="2">화</option>
                              <option value="3">수</option>
                              <option value="4">목</option>
                              <option value="5">금</option>
                              <option value="6">토</option>
                              <option value="0">일</option>
                           </select>
                        </div>
                        <div class="form-group col-md-12">
                           <label for="message-text" class="col-form-label"
                              style="font-weight: bold;">일정 입력 
						<!--  <span class="badge badge-pill badge-success">8시간</span> -->
                              </label>
                        </div>
                           <div id="repSch">
                              
                           </div>
                        <button type="button" class="newWorkInsertBtn"
                           style="font-weight: bold;" data-toggle="modal"
                           data-target="#varyModal" data-whatever="@mdo">새 일정 추가하기</button>
                  </div>
                  <div class="modal-footer">
                     <button class="EachCheck"
                        style="font-weight: bold; color: white;margin-right: 7px;"><span class="fe fe-check-circle fe-16 mr-2"></span> 등록하기</button>
                  </div>
               </form>
         </div>
      </div>
   </div>
   <div class="modal fade" id="varyModal" tabindex="-1" role="dialog"
      aria-labelledby="varyModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="varyModalLabel">새 일정 추가</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <form id="plusWork">
                  <div class="form-group">
                     <label for="newWorkType">분류</label> 
                     <select class="form-control" id="newWorkType" value="" required>
                        <option value="근무">근무</option>
                         <option value="연장근무">연장근무</option>
                         <option value="야간근무">야간근무</option>
                         <option value="외근">외근</option>
                         <option value="재택근무">재택근무</option>
                         <option value="출장">출장</option>
                         <option value="휴가">휴가</option>
                     </select>
                  </div>
                  <div class="form-group">
                     <label for="time-input2">시간 설정</label>
                          <div class="input-group">
<!--                             <input type="text" class="form-control time-input" id="newStartTime" placeholder="시작 시간" aria-describedby="button-addon2" required> -->
                            <input class="form-control" id="newStartTime" type="time" name="time" placeholder="시작 시간">
                            <span class="fe fe-minus fe-16" id="timeTest" style="display:flex;align-items:center;"></span>
                            <input class="form-control" id="newEndTime" type="time" name="time" placeholder="종료 시간">
<!--                             <input type="text" class="form-control time-input" id="newEndTime" placeholder="종료 시간" aria-describedby="button-addon2" required> -->
                          </div>
                  </div>
            </div>
            <div class="modal-footer">
               <button class="EachCheck"
                  style="font-weight: bold;margin-right: 10px;" id="plusWor">추가</button>
            </div>
               </form>
         </div>
      </div>
   </div>
   <!-- 새 일정 추가하기 모달 끝 -->

   <!-- 타임라인 API -->
   <div mbsc-page class="demo-create-read-update-delete-CRUD">
        <div style="height:80vh;">
                <div id="demo-add-delete-event"></div>
    
    <div style="display: none">
    <div id="demo-add-popup">
        <div class="mbsc-form-group">
           <label for="mySelect">
              근무유형
             <input mbsc-input id="event-title" data-dropdown="true" placeholer="선택해주세요"/>
         </label>
         <select id="mySelect">
             <option value="근무">근무</option>
             <option value="연장근무">연장근무</option>
             <option value="야간근무">야간근무</option>
             <option value="외근">외근</option>
             <option value="재택근무">재택근무</option>
             <option value="출장">출장</option>
             <option value="휴가">고객 상담</option>
         </select>
<!--             <label> -->
<!--                 제목 -->
<!--                 <input mbsc-input id="event-title"> -->
<!--             </label> -->
            <label>
                신청내용
                <textarea mbsc-textarea id="event-desc"></textarea>
            </label>
        </div>
        <div class="mbsc-form-group">
            <label>
                하루종일
                <input mbsc-switch id="event-all-day" type="checkbox"/>
            </label>
            <label>
                시작일
                <input mbsc-input id="start-input" />
            </label>
            <label>
                종료일
                <input mbsc-input id="end-input" />
            </label>
            <div id="event-date"></div>
            <div id="event-color-picker" class="event-color-c">
                <div class="event-color-label">색상</div>
                <div id="event-color-cont">
                    <div id="event-color" class="event-color"></div>
                </div>
            </div>
            <label>
                Show as busy
                <input id="event-status-busy" mbsc-segmented type="radio" name="event-status" value="busy" stlye="display:none;">
            </label>
            <label>
                Show as free
                <input id="event-status-free" mbsc-segmented type="radio" name="event-status" value="free" stlye="display:none;">
            </label>
            <div class="mbsc-button-group">
                <button class="mbsc-button-block" id="event-delete" mbsc-button data-color="danger" data-variant="outline">삭제</button>
            </div>
        </div>
    </div>
    
    <div id="demo-event-color">
        <div class="crud-color-row">
            <div class="crud-color-c" data-value="#ffeb3c">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ffeb3c"></div>
            </div>
            <div class="crud-color-c" data-value="#ff9900">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ff9900"></div>
            </div>
            <div class="crud-color-c" data-value="#f44437">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#f44437"></div>
            </div>
            <div class="crud-color-c" data-value="#ea1e63">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ea1e63"></div>
            </div>
            <div class="crud-color-c" data-value="#9c26b0">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#9c26b0"></div>
            </div>
        </div>
        <div class="crud-color-row">
            <div class="crud-color-c" data-value="#3f51b5">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#3f51b5"></div>
            </div>
            <div class="crud-color-c" data-value="#5ac8fa">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#5ac8fa"></div>
            </div>
            <div class="crud-color-c" data-value="#009788">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#009788"></div>
            </div>
            <div class="crud-color-c" data-value="#4baf4f">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#4baf4f"></div>
            </div>
            <div class="crud-color-c" data-value="#7e5d4e">
                <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#7e5d4e"></div>
            </div>
        </div>
    </div>
    </div>
        </div>
    </div>

    <script>
    const header = '${_csrf.headerName}';
    const token =  '${_csrf.token}';
    
    $(() => {
        getEmpSelect();
        workTypeList();
    });
    	
    $("#newStartTime").on("change", function() {
    	let start = $("#newStartTime").val();
    	let end = $("#newEndTime").val();
    	console.log("newStartTime : " + start);
    	console.log("newEndTime : " + end);
    })
    
    $(".newWorkInsertBtn").on("click",function() {
    	$("#newWorkType").val('');
		$("#newStartTime").val('');
		$("#newEndTime").val('');
    })
    
		// 근무유형 리스트
		const workTypeList = function() {
		    let url = "/work/workTypeList";
		    $.ajax({
		        url: url,
		        type: "get",
		        dataType: "json",
		        beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token);
		        },
		        success: function(result) {
		            console.log("근무유형 List Check : ", result);
		            
		            // 첫 번째 select 요소에 근무 유형 리스트 추가
		            let selectElement1 = document.getElementById("newWorkType");
		            selectElement1.innerHTML = "";
		            
		            for (let i = 0; i < result.length; i++) {
		                let type = result[i];
		                
		                let option = document.createElement("option");
		                option.value = type.wkNm;
		                option.textContent = type.wkNm;
		                
		                selectElement1.appendChild(option);
		            }
		            
		            // "newWorkType" 드롭다운의 "change" 이벤트 리스너 등록
		            document.getElementById("newWorkType").addEventListener("change", function() {
		                let work = $("#newWorkType").val();
		                let newStartTime = document.getElementById("newStartTime");
		                let newEndTime = document.getElementById("newEndTime");
		
		                // 근무 유형에 따라 시작 시간과 종료 시간 설정
		                for (let i = 0; i < result.length; i++) {
		                    let type = result[i];
		                    console.log("시작시간 : " + type.wkStime);
		                    console.log("종료시간 : " + type.wkEtime);
		                    if (work === type.wkNm) {
		                        newStartTime.value = type.wkStime;
		                        newEndTime.value = type.wkEtime;
		                        break;
		                    }
		                }
		                
		                console.log("찍혔나 ?", work);
		            })
		        }
		    });
		}
    
    
        $('#repForm').submit(function(event) {
            event.preventDefault();

            var gigan = parseInt($("#example-select").val(), 10);
            var select = $("#multi-select2").val();

            // 선택된 요일 배열을 가져옵니다.
            var selectedDays = select.map(function(value) {
                return parseInt(value, 10);
            });

            // 각 newScheduleBox의 정보를 순회하면서 가져오기
            $('#repSch .alert').each(function() {
                var workType = $(this).find('.work-type').text();
                var time = $(this).find('.time').text();
                var sTime = time.substr(0, 5);
                var eTime = time.substr(8, 12);

                console.log("workType: ", workType);
                console.log("start : ", sTime);
                console.log("end : ", eTime);

                // 기간에 따라 날짜 및 시간 정보를 계산합니다.
                var dates = [];

                if (gigan === 1 || gigan === 2 || gigan === 3 || gigan === 4) {
                    // 'gigan' 값에 따라 해당 주와 그 다음 주, 다다음 주, 한 달까지의 날짜를 가져옴
                    if (gigan === 1) {
                        dates = calculateDatesWithDuration(7, sTime, eTime, selectedDays);
                    } else if (gigan === 2) {
                        dates = calculateDatesWithDuration(14, sTime, eTime, selectedDays);
                    } else if (gigan === 3) {
                        dates = calculateDatesWithDuration(21, sTime, eTime, selectedDays);
                    } else if (gigan === 4) {
                        // 'gigan'이 4이면 한 달 동안의 날짜와 시간 정보를 가져옴
                        var today = new Date();
                        var nextMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                        var daysInMonth = nextMonth.getDate();
                        dates = calculateDatesWithDuration(daysInMonth, sTime, eTime, selectedDays);
                    }
                }

                console.log(dates);

                // 필요한 데이터를 workEachInsert 함수로 전달
                workEachInsert(workType, dates);
            });
        });

        // 날짜 배열에 날짜와 시간 정보를 함께 저장하는 함수
        function calculateDatesWithDuration(duration, startTime, endTime, selectedDays) {
            var dates = [];
            var currentDate = new Date();
            var endDate = new Date(currentDate);

            endDate.setDate(currentDate.getDate() + duration); // 계산할 기간을 추가하여 종료일 설정

            while (currentDate < endDate) {
                var year = currentDate.getFullYear();
                var month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
                var day = ('0' + currentDate.getDate()).slice(-2);
                var formattedDate = year + '-' + month + '-' + day;
                var dayOfWeek = currentDate.getDay(); // 요일 가져오기 (0 = 일요일, 1 = 월요일, ... 6 = 토요일)

                // Check if the current date exists among the selected days
                if (selectedDays.includes(dayOfWeek)) {
                    // 시작 시간과 종료 시간을 날짜에 추가
                    var startDateWithTime = formattedDate + 'T' + startTime;
                    var endDateWithTime = formattedDate + 'T' + endTime;

                    // 시작 시간과 종료 시간을 배열에 추가
                    dates.push(startDateWithTime);
                    dates.push(endDateWithTime);
                }

                currentDate.setDate(currentDate.getDate() + 1);
            }

            return dates;
        }

        
        const workEachInsert = function(workType, dates) {
            let wkapVOList = [];
            for (let i = 0; i < dates.length; i += 2) {
                let wkapVO = {
                    waAper: ${empVO.empNo},
                    waType: workType,
                    waArsn : workType + " 신청합니다.",
                    waStime: new Date(dates[i]),
                    waDate: new Date(dates[i]),
                    waEtime: new Date(dates[i + 1]),
                    waAllday: "false",
                    ewApst : "대기"
                };

                console.log("insert VO: ", wkapVO);

                // // Ajax
                // let xhr = new XMLHttpRequest();
                // xhr.open("post", "/work/test", true);
                // xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");

                // // csrf 토큰 설정
                // xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");

                // xhr.onreadystatechange = function() {
                //     if (xhr.readyState == 4) {
                //         if (xhr.status == 200) {
                //             console.log("insert체크 : ", xhr.responseText);
                //             let myName = "${empVO.empNm}";
              //          let myMassage = "근무 신청";
              //          let myData = "근무";
              //          messageVO = {
              //             setter:myName,
              //             massage:myMassage,
              //             data:myData
              //          };
              //            webSocket.send(JSON.stringify(messageVO));   
                //         } else {
                //             alert("등록 실패");
                //         }
                //     }
                // };
                // xhr.send(JSON.stringify(wkapVO));
                wkapVOList.push(wkapVO);
            }
            console.log(wkapVOList);
            // Ajax
            let xhr = new XMLHttpRequest();
            xhr.open("post", "/work/test", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");

            // csrf 토큰 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");

            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log("insert체크 : ", xhr.responseText);
                        let result = parseInt(xhr.responseText);
                        if(result >= 3){
                           
                           let myName = "${empVO.empNm}";
                        let myMassage = "근무 신청";
                        let myData = "근무";
                        messageVO = {
                           setter:myName,
                           massage:myMassage,
                           data:myData
                        };
                        Swal.fire({
                	    	title: '등록 성공',
                	    	icon : 'success'
                	    }) .then(function(){
	                       webSocket.send(JSON.stringify(messageVO));   
                	        location.href = "/work/work";
                        });
//                       location.reload();
                       
                        }else {
                        alert("등록 실패");
                    }
                }
            };
            xhr.send(JSON.stringify(wkapVOList));
        };





    
       $(document).ready(function () {
           // 체크박스를 클릭할 때마다 select 요소를 업데이트
           $('#customSwitch1').change(function () {
               var checked = $(this).is(':checked'); // 체크박스 상태 확인
   
               // select 요소
               var $select = $('#multi-select2');
   
               // 월, 화, 수, 목, 금 옵션들
               var workdays = [1, 2, 3, 4, 5];
   
               if (checked) {
                   // 체크박스가 선택된 경우, 모든 요일을 선택
                   $select.val(workdays);
               } else {
                   // 체크박스가 해제된 경우, 선택된 모든 옵션을 해제
                   $select.val(null);
               }
   
               // select2 업데이트 (선택한 옵션을 반영)
               $select.trigger('change');
           });
       });
    
       const workPlus = document.querySelector("#plusWork");
       workPlus.addEventListener("submit", fAjax);
       function fAjax() {
   
      // built-in 기능 막기
        event.preventDefault();
        
        // 분류와 시간 설정 값을 가져오기
        var workType = $('#newWorkType').val();
        var startTime = $('#newStartTime').val();
        var endTime = $('#newEndTime').val();

        // 분류 별 아이콘 설정
        var iconClass = '';
        if (workType === '근무') {
            iconClass = 'fe-watch';
        } else if (workType === '휴가') {
            iconClass = 'fe-battery-charging';
        } else if (workType === '연장근무') {
            iconClass = 'fe-sunset';
        } else if (workType === '외근') {
            iconClass = 'fe-log-out';
        } else if (workType === '재택근무') {
            iconClass = 'fe-home';
        } else if (workType === '출장') {
            iconClass = 'fe-send';
        } else if (workType === '야간근무') {
            iconClass = 'fe-moon';
        }

        // 12시간을 더한 값을 계산하여 설정
        startTime = add12HoursIfPM(startTime);
        endTime = add12HoursIfPM(endTime);
        
        // AM 또는 PM을 제거
        startTime = removeAMPM(startTime);
        endTime = removeAMPM(endTime);

        // 분류, 시간 div > span 태그로
      // newScheduleBox를 고유한 컨테이너로 감싸기
      var newScheduleBox = $('<div class="alert alert-light" style="text-align:center;border:1px solid #EFEFEF;border-radius: 10px;"></div>');
      newScheduleBox.append('<span class="fe ' + iconClass + ' fe-16 mr-2"></span>');
      newScheduleBox.append('<span class="work-type">' + workType + '</span>&nbsp;&nbsp;');
      newScheduleBox.append('<span class="time">' + startTime + ' - ' + endTime + '</span>');
      newScheduleBox.append('<button class="close delete-schedule"><span>×</span></button>');


        console.log("startTime : ", startTime);
        console.log("EndTime : ", endTime);

        // div에 append
        $('#repSch').append(newScheduleBox);

        $('#newWorkType').val('');
        $('#newStartTime').val('');
        $('#newEndTime').val('');

        // 모달 close
        $('#varyModal').modal('hide');
    };
    
    // 삭제 버튼 클릭 이벤트 처리
    $('#repSch').on('click', '.delete-schedule', function () {
        $(this).closest('.alert').remove(); // 클릭한 삭제 버튼의 가장 가까운 .alert 요소를 제거
    });
 
    // AM 또는 PM을 제거하는 함수
    function removeAMPM(timeString) {
        return timeString.replace(/(AM|PM)/g, '').trim();
    }
    
    // 12시간을 더하는 함수
    function add12HoursIfPM(timeString) {
        if (timeString.includes("PM")) {
            var timeParts = timeString.split(":");
            var hours = parseInt(timeParts[0]);
            var minutes = timeParts[1].split(" ")[0];
            if (hours !== 12) {
                hours += 12;
            }
            return hours.toString().padStart(2, "0") + ":" + minutes;
        }
        return timeString;
    }

    //일정등록
    const workInsert = function(event) {
        // 넘길 data
        let wkapVO = {
           waAper : ${empVO.empNo},
           waType: event.title,
            waArsn: event.description,
            waStime: event.start,
            waDate : event.start,
            waEtime: event.end,
            wkColor: event.color,
            waAllday: event.allDay
            ,ewApst : "대기"
        };

        console.log("insert VO: ", wkapVO);
        
        // Ajax
        let xhr = new XMLHttpRequest();
        xhr.open("post", "/work/workInsert", true);
        xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
        
        // csrf 토큰 설정
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
               Swal.fire({
                 position: 'top-end',
                 icon: 'success',
                 title: '등록 완료',
                 showConfirmButton: false,
                 timerProgressBar: true,
                 timer: 1500
               })
                    console.log("insert체크 : ", xhr.responseText);
               
               let myName = "${empVO.empNm}";
               let myMassage = "근무 신청";
               let myData = "근무";
               messageVO = {
                  setter:myName,
                  massage:myMassage,
                  data:myData
               };
                 webSocket.send(JSON.stringify(messageVO));   
//                 getEmpSelect();
                } else {
                    alert("등록 실패");
                }
            }
        };
        
        xhr.send(JSON.stringify(wkapVO)); // 문자열롱
    }
    
    // 수정
    const workUpdate = function(event) {
       // 넘길 data
        let wkapVO = {
             waNo : event.no,
             waType : event.title,
             waArsn : event.description,
             waStime : event.start,
             waEtime : event.end,
             wkColor : event.color,
             waAllday : event.allDay
        }
        console.log("updateEvent", wkapVO);
        let xhr = new XMLHttpRequest();
        xhr.open("put", "/work/test", true)
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        // csrf 토큰 설정
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        xhr.onreadystatechange = function() {
           if(xhr.readyState == 4 && xhr.status == 200) {
              console.log("일정수정 체크", xhr.responseText); // update 된 행의 수
//               getEmpSelect();
           }
        }
        xhr.send(JSON.stringify(wkapVO));
     }
    
    const workDelete = function(event) {
        let xhr = new XMLHttpRequest();
        let url = "/work/test/" + event.no;
        console.log("url : " + url);
        console.log("delEvent에 넘어온 event.no", event.no);
        xhr.open("delete", url, true);
        // csrf 토큰 설정
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        xhr.onreadystatechange = function() {
           if(xhr.readyState == 4 && xhr.status == 200) {
              console.log("일정삭제체크", xhr.responseText); // delete 된 행의 개수
//               getEmpSelect();
           }
        }
        xhr.send();
     }

    // 특정 사원 리스트 출력
    let waTlTimeArray = []; // 함수 바깥에서 사용할 배열을 먼저 선언

   const getEmpSelect = function() {
       let url = "/work/test/" + ${empVO.empNo};
       let xhr = new XMLHttpRequest();
       xhr.open("get", url, true);
       xhr.onreadystatechange = function() {
           if (xhr.readyState == 4 && xhr.status == 200) {
               console.log("getEmpSelect 불러오기", JSON.parse(xhr.responseText));
               let result = JSON.parse(xhr.responseText);
               let myData = [];
   
               for (let i = 0; i < result.length; i++) {
                   let item = result[i];
                   let waTlTime = item.waTltime;
                   waTlTimeArray.push(waTlTime); // 함수 바깥에 선언한 배열에 추가
   
                   let dataItem = {
                       no: item.waNo,
                       title: item.waType,
                       description: item.waArsn,
                       start: item.waStime,
                       end: item.waEtime,
                       allDay: item.waAllday,
                       color: item.wkColor,
                       waTlTime: waTlTime,
                       waExtime : item.waExtime,
                       waNightime : item.waNightime,
                       ewApst : item.ewApst,
                       hdtime : item.hdtime,
                       apbPro : item.apbPro
                   }
                   myData.push(dataItem);
               };
   
//                console.log("waTlTime 배열:", waTlTimeArray); // 함수 바깥에서 사용할 수 있는 배열
               console.log("체크 : ", myData);
               calendar.addEvent(myData);
           }
       }
       xhr.send();
   };
   
   // 함수 바깥에서도 waTlTimeArray를 사용할 수 있음
//    console.log("바깥에서 사용:", waTlTimeArray);

    
        
    mobiscroll.setOptions({
        locale: mobiscroll.localeKo,
        theme: 'material',                                                 // Specify theme like: theme: 'ios' or omit setting to use default
        themeVariant: 'light'
    });
    
    var calendar,
        popup,
        range,
        oldEvent,
        tempEvent = {},
        deleteEvent,
        restoreEvent,
        colorPicker,
        tempColor,
        mySelect = document.getElementById('mySelect'),
        selectInput = document.getElementById('my-input'),
        titleInput = document.getElementById('event-title'),
        descriptionTextarea = document.getElementById('event-desc'),
        allDaySwitch = document.getElementById('event-all-day'),
        freeSegmented = document.getElementById('event-status-free'),
        busySegmented = document.getElementById('event-status-busy'),
        deleteButton = document.getElementById('event-delete'),
        colorSelect = document.getElementById('event-color-picker'),
        pickedColor = document.getElementById('event-color'),
        colorElms = document.querySelectorAll('.crud-color-c'),
        datePickerResponsive = {
            medium: {
                controls: ['calendar'],
                touchUi: false
            }
        },
        datetimePickerResponsive = {
            medium: {
                controls: ['calendar', 'time'],
                touchUi: false
            }
        }
    
    var myResources = [{
       id: 1,
        name: '근무',
        color: '#009788'
    }];
    
    function createAddPopup(elm) {
        // hide delete button inside add popup
        deleteButton.style.display = 'none';
    
        deleteEvent = true;
        restoreEvent = false;
    
        // set popup header text and buttons for adding
        popup.setOptions({
            headerText: '근무 등록',
            buttons: [
                'cancel',
                {
                    text: '등록',
                    keyCode: 'enter',
                    handler: function () {
                  console.log("calendar.updateEvent : ",calendar.updateEvent);
                       workInsert(tempEvent);
                        calendar.updateEvent(tempEvent);
                        deleteEvent = false;
                        calendar.navigateToEvent(tempEvent);
                        popup.close();
                    },
                    cssClass: 'mbsc-popup-button-primary'
                }
            ]
        });
    
        // fill popup with a new event data
//         mobiscroll.getInst(selectInput).value = "선택";
        mobiscroll.getInst(titleInput).value = '';
        mobiscroll.getInst(descriptionTextarea).value = '';
        mobiscroll.getInst(allDaySwitch).checked = tempEvent.allDay;
        range.setVal([tempEvent.start, tempEvent.end]);
        mobiscroll.getInst(busySegmented).checked = true;
        range.setOptions({
            controls: tempEvent.allDay ? ['date'] : ['datetime'],
            responsive: tempEvent.allDay ? datePickerResponsive : datetimePickerResponsive
        });
        selectColor(getResource(tempEvent.resource).color, true);
    
        // set anchor for the popup
        popup.setOptions({ anchor: elm });
    
        popup.open();
    }
    
    function createEditPopup(args) {
        var ev = args.event;
    
        // show delete button inside edit popup
        deleteButton.style.display = 'block';
    
        deleteEvent = false;
        restoreEvent = true;
    
        // set popup header text and buttons for editing
        popup.setOptions({
            headerText: '상세정보',
            buttons: [
                'cancel',
                {
                    text: '수정',
                    keyCode: 'enter',
                    handler: function () {
                        var date = range.getVal();
                        var eventToSave = {
                            no: ev.no,
                            title: titleInput.value,
                            description: descriptionTextarea.value,
                            allDay: mobiscroll.getInst(allDaySwitch).checked,
                            start: date[0],
                            end: date[1],
//                             free: mobiscroll.getInst(freeSegmented).checked,
                            color: ev.color,
//                             color: "#94f1e8",
//                             resource: ev.resource
                        };
                        console.log("edit 팝업!! :", eventToSave);
                        workUpdate(eventToSave);
                        calendar.updateEvent(eventToSave);
                        calendar.navigateToEvent(eventToSave);
                        restoreEvent = false;
                        popup.close();
                    },
                    cssClass: 'mbsc-popup-button-primary'
                }
            ]
        });
        
        // fill popup with the selected event data
        mobiscroll.getInst(titleInput).value = ev.title || '';
        mobiscroll.getInst(descriptionTextarea).value = ev.description || '';
        mobiscroll.getInst(allDaySwitch).checked = ev.allDay || false;
        range.setVal([ev.start, ev.end]);
        selectColor(ev.color || getResource(ev.resource).color, true);
    
        if (ev.free) {
            mobiscroll.getInst(freeSegmented).checked = true;
        } else {
            mobiscroll.getInst(busySegmented).checked = true;
        }
    
        // change range settings based on the allDay
        range.setOptions({
            controls: ev.allDay ? ['date'] : ['datetime'],
            responsive: ev.allDay ? datePickerResponsive : datetimePickerResponsive
        });
    
        // set anchor for the popup
        popup.setOptions({ anchor: args.domEvent.currentTarget });
        popup.open();
    }
    
    var formatDate = mobiscroll.util.datetime.formatDate;
    calendar = mobiscroll.eventcalendar('#demo-add-delete-event', {
        clickToCreate: 'double',
        dragToCreate: true,
        dragToMove: false,
        dragToResize: false, 
        view: {
            timeline: { 
                type: 'week',
                startDay : 1,
            endDay : 0,
                resolutionHorizontal : 'hour',
                resolutionVertical : 'day',
                currentTimeIndicator: false
              }
        },
//         data: myData,
        resources: myResources,       
        renderDay: function (day) {
            var date = day.date;
            var today = new Date(); // 현재 날짜

            var isToday =
                date.getDate() === today.getDate() &&
                date.getMonth() === today.getMonth() &&
                date.getFullYear() === today.getFullYear();

            var isWeekend = date.getDay() === 0 || date.getDay() === 6; // 0은 일요일, 6은 토요일

            // 오늘 날짜인 경우, <span class="dot dot-lg bg-success"></span> 추가
            var dotElement = isToday ? '<span class="dot dot-lg bg-success"></span>' : '';

            // 주말인 경우, 글자색을 빨간색으로 설정
            var fontColorStyle = isWeekend ? 'color: red;' : '';

            // 추가한 스타일: 폰트 크기 14px
            var fontSizeStyle = 'font-size: 14px;';

            return (
                '<div class="mbsc-timeline-header-date-text mbsc-ios" style="padding: 30px 0; font-weight: bold;">' +
                '<div class="mbsc-timeline-header-date-text mbsc-ios" style="text-align: center;">' +
                '<span style="' + fontColorStyle + fontSizeStyle + '">' +
                formatDate('M. DD DDD ', date) +
                '</span>' +
                dotElement +
                '</div>' +
                '</div>'
            );
        },
        renderScheduleEventContent: function(args) {
           // "대기" 상태일 때 배경색을 투명하게 설정
           if (args.original.apbPro === '진행중') {
             var hexColor = args.original.color; // 16진수 색상값
             var r = parseInt(hexColor.slice(1, 3), 16); // 16진수를 10진수로 변환
             var g = parseInt(hexColor.slice(3, 5), 16);
             var b = parseInt(hexColor.slice(5, 7), 16);
             args.style.background = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.4)';
         }

            return '<div class="md-timetable-event-title">'
                + args.title + '</div>';
        },
        onEventClick: function (args) { 
            oldEvent = Object.assign({}, args.event);
            tempEvent = args.event;
    
            if (!popup.isVisible()) {
                createEditPopup(args);
            }
        },
        onEventCreated: function (args) {
            popup.close();
            // store temporary event
            tempEvent = args.event;
            createAddPopup(args.target);
        },
        onEventDeleted: function (args) {
            mobiscroll.snackbar({ 
                button: {
                    action: function () {
                        calendar.addEvent(args.event);
                    },
                    text: 'Undo'
                },
                message: 'Event deleted'
            });
        },
        onPageLoaded: function(event, inst) {
           let total = document.querySelector("#weekTotal");
           let totalSpan = document.querySelector("#weekTotalS");
           let totalDiv = document.querySelector("#weekTotalD");
           const weekTotalElement = document.querySelector("#weekTotal");
           const weekTotalSpan = document.querySelector("#weekTotalS");
           const weekTotalD = document.querySelector("#weekTotalD");
           const overTime = document.querySelector("#overtime");
           const overtimeDiv = document.querySelector("#overtimeDiv");
           const NightTime = document.querySelector("#NightTime");
           total.textContent = "0시간";
           totalSpan.textContent = "0";
           totalDiv.textContent = "0시간";
           overTime.textContent = "0";
            overtimeDiv.textContent = "0시간";
           
           let rangeData = [];

           if (calendar.getEvents(event.firstDay, event.lastDay).length === 0 || calendar.getEvents(event.firstDay, event.lastDay) === "") {
               console.log("null", calendar.getEvents(event.firstDay, event.lastDay));
           } else {
               rangeData = calendar.getEvents(event.firstDay, event.lastDay);
               console.log("null 아님: ", rangeData);
            
               let sum = 0;
               let aum = 0;
               let overtimeSum = 0;
               let ext = 0;
               let nit = 0;
               let ewVal = "";
               const typeArray = rangeData.map(item => item.title);
               const waArray = rangeData.map(item => item.waTlTime);
               const waExArr = rangeData.map(item => item.waExtime);
               const waNiArr = rangeData.map(item => item.waNightime);
               
               // rangeData 배열에서 ewApst 값을 추출하여 새로운 배열을 생성
               const ewApsArr = rangeData.map(item => item.ewApst);
               
               /* console.log("waTlTime 배열dddddddd: ", waArray);
               console.log("typeArray : ", typeArray);
               console.log("연장시간 배열 : ", waExArr);
               console.log("야간시간 배열 : ", waNiArr); */
               
               for (let i = 0; i < rangeData.length; i++) {
                   let start = rangeData[i].start;
                   let end = rangeData[i].end;
                   let waTime = waArray[i];
                   let workType = typeArray[i];
                   let exTime = waExArr[i];
                   let niTime = waNiArr[i];
                   let ewApstVal = ewApsArr[i];
                   
                   start = new Date(start);
                   end = new Date(end);

                   const timeDiff = end - start;
                   const hours = Math.floor(timeDiff / 3600000); // 밀리초를 시간으로 변환 (1시간 = 3600000 밀리초)
                   const minutes = Math.floor((timeDiff % 3600000) / 60000); // 밀리초를 분으로 변환 (1분 = 60000 밀리초)
                   const workTime = hours - waTime;
                   
                   overtimeSum += exTime + niTime;
                   ext += exTime;
                   nit += niTime;
               sum += hours;
               aum += workTime;
               ewVal += ewApstVal;
               console.log("hours - waTime값 : ", workTime);
               console.log("근무타입 + 근무시간 : ", workType + " " + workTime);
               
               }
               console.log("총 시간 : ", sum);
               console.log("휴게시간 제외 총 시간 : ", aum);
//                console.log("결재상태 : ", ewVal);
               
            // 현재 표시된 값 가져오기
            const currentText = weekTotalElement.textContent;

            if (aum === null || aum === undefined || aum === 0 || rangeData === null || rangeData === undefined || rangeData.length === 0) {
                // aum 값이 null, undefined, 또는 0인 경우에만 업데이트
                if (currentText !== "0시간") {
                    weekTotalElement.textContent = "0시간";
                    weekTotalSpan.textContent = "0";
                    overtimeDiv.textContent = "0시간"; // overtimeDiv에도 값을 설정
                } else {
                    overtimeDiv.textContent = ""; // aum이 0시간이며 다른 값이 이미 없는 경우 빈 문자열로 설정
                }
                // 나머지 경우에도 overTime 요소에 aum 값을 설정
                overTime.textContent = aum + "시간";
            } else {
                // aum 값이 null, undefined, 또는 0이 아닌 경우에 업데이트
                if (currentText !== aum + "시간") {
                    // aum이 40 이상인 경우 40으로 제한
                    const displayAum = Math.min(aum, 40);

                    weekTotalElement.textContent = aum + "시간";
                    weekTotalD.textContent = displayAum + "시간";
                    weekTotalSpan.textContent = displayAum;

                    overTime.textContent = overtimeSum;
                    overtimeDiv.textContent = ext + "시간";
                    NightTime.textContent = nit + "시간";
                }
                
            }
            console.log("aum : ", aum);
           }
//          console.log("0번째", rangeData[0]);
        }
    });
    
    popup = mobiscroll.popup('#demo-add-popup', {
        display: 'bottom',                                            // Specify display mode like: display: 'bottom' or omit setting to use default
        contentPadding: false,
        fullScreen: true,
        onClose: function () {                                        // More info about onClose: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#event-onClose
            if (deleteEvent) {
                calendar.removeEvent(tempEvent);
            } else if (restoreEvent) {
                calendar.updateEvent(oldEvent);
            }
        },
        responsive: {                                                 // More info about responsive: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-responsive
            medium: {
                display: 'anchored',                                  // Specify display mode like: display: 'bottom' or omit setting to use default
                width: 400,                                           // More info about width: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-width
                fullScreen: false,
                touchUi: false
            }
        }
    });
    
    titleInput.addEventListener('input', function (ev) {
        // update current event's title
        tempEvent.title = ev.target.value;
    });
    
    descriptionTextarea.addEventListener('change', function (ev) {
        // update current event's title
        tempEvent.description = ev.target.value;
    });
    
    allDaySwitch.addEventListener('change', function () {
        var checked = this.checked
        // change range settings based on the allDay
        range.setOptions({
            controls: checked ? ['date'] : ['datetime'],
            responsive: checked ? datePickerResponsive : datetimePickerResponsive
        });
    
        // update current event's allDay property
        tempEvent.allDay = checked;
    });
    
    range = mobiscroll.datepicker('#event-date', {
        controls: ['date'],
        select: 'range',
        startInput: '#start-input',
        endInput: '#end-input',
        showRangeLabels: false,
        touchUi: true,
        responsive: datePickerResponsive,                             // More info about responsive: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-responsive
        onChange: function (args) {
            var date = args.value;
            // update event's start date
            tempEvent.start = date[0];
            tempEvent.end = date[1];
        }
    });
    
    document.querySelectorAll('input[name=event-status]').forEach(function (elm) {
        elm.addEventListener('change', function () {
            // update current event's free property
            tempEvent.free = mobiscroll.getInst(freeSegmented).checked;
        });
    });

    deleteButton.addEventListener('click', function () {
        // delete current event on button click
        calendar.removeEvent(tempEvent);
        popup.close();
    
        // save a local reference to the deleted event
        var deletedEvent = tempEvent;
        workDelete(tempEvent); // 일정
    
        mobiscroll.toast({ 
            button: {
                action: function () {
//                     calendar.addEvent(deletedEvent);
                    calendar.addEvent(updateEvent);
                }
        /* ,
                text: 'Undo' */
            },
            message: '삭제 완료',
            color : 'secondary'
        });
    });
    
    colorPicker = mobiscroll.popup('#demo-event-color', {
        display: 'bottom',                                            // Specify display mode like: display: 'bottom' or omit setting to use default
        contentPadding: false,
        showArrow: false,
        showOverlay: false,
        buttons: [
            'cancel',
            {
                text: 'Set',
                keyCode: 'enter',
                handler: function (ev) {
                    setSelectedColor();
                },
                cssClass: 'mbsc-popup-button-primary'
            }
        ],
        responsive: {                                                 // More info about responsive: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-responsive
            medium: {
                display: 'anchored',                                  // Specify display mode like: display: 'bottom' or omit setting to use default
                anchor: document.getElementById('event-color-cont'),  // More info about anchor: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-anchor
                buttons: [],                                          // More info about buttons: https://docs.mobiscroll.com/5-26-2/javascript/eventcalendar#opt-buttons
            }
        }
    });
    
    function selectColor(color, setColor) {
        var selectedElm = document.querySelector('.crud-color-c.selected');
        var newSelected = document.querySelector('.crud-color-c[data-value="' + color + '"]');
    
        if (selectedElm) {
            selectedElm.classList.remove('selected')
        }
        if (newSelected) {
            newSelected.classList.add('selected')
        }
        if (setColor) {
            pickedColor.style.background = color;
        }
    }
    
    function setSelectedColor() {
        tempEvent.color = tempColor;
        pickedColor.style.background = tempColor;
        colorPicker.close();
    }
    
    function getResource(res) {
        return myResources.find(function (r) { return r.id == res })
    }
    
    colorSelect.addEventListener('click', function () {
        selectColor(tempEvent.color || getResource(tempEvent.resource).color);
        colorPicker.open();
    });
    
    colorElms.forEach(function (elm) {
        elm.addEventListener('click', function () {
            tempColor = elm.getAttribute('data-value');
            selectColor(tempColor);
    
            if (!colorPicker.s.buttons.length) {
                setSelectedColor();
            }
        });
        
        mySelect.addEventListener('click', function() {
            var thisSelect = this.value;
            console.log("select 값: ", thisSelect);
            var thisResource = myResources.find(function(resource) {
                return resource.id == thisSelect;
            });
            
            if (thisResource) {
                tempEvent.color = thisResource.color;
            }
        });
        
        mobiscroll.select('#mySelect', {
            inputElement: document.getElementById('event-title'),
            touchUi: false
        });
    });
</script>
</body>
</html>