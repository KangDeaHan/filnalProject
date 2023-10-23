<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈피드</title>
<style>
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

.mainBtn, .noticeSubmit, .noticeUpSubmit {
	background: linear-gradient(to right, #3783C6, #39A4C5);
	border-radius: 10px;
	padding: 10px 20px;
	color: white;
	border: none;
	font-weight: 900;
	margin-bottom: 15px;
}

.fe.fe-send {
	vertical-align: middle;
}

.full {
	width: 100%;
	height: 100%;
	border-top: 1px solid #EDEDEE;
}

.leftScreen {
	width: 70%;
	height: 100%;
	float: left;
	/*    border: 1px dotted yellow; */
	box-sizing: border-box;
}

.rightScreen {
	width: 30%;
	height: 100%;
	float: right;
	border-left: 1px solid #EDEDEE;
	box-sizing: border-box;
}

.topRight {
	height: 20%;
}

.BtmRight {
	height: 80%;
	border-top: 1px solid #EDEDEE;
}

.gotoWork {
	margin-bottom: 15px;
	width: 80%;
	background: white;
	border-radius: 10px;
	padding: 10px 20px;
	color: #556372;
	cursor: pointer;
	border: 1px solid #E9EAEA;
	font-weight: 900;
}

.gotoWork:hover, .leaveWork:hover {
	background: linear-gradient(to right, #3783C6, #39A4C5);
	cursor: pointer;
	color: white;
}

.leaveWork:hover::before {
	/*   content: "red"; hover시 텍스트 삽입*/
	
}

.gotoWork:disabled:hover {
	cursor: not-allowed; /* 클릭 불가 상태로 변경 */
	background: white;
	color: #556372;
}

.leaveWork {
	width: 80%;
	background: white;
	border-radius: 10px;
	padding: 10px 20px;
	color: #556372;
	cursor: pointer;
	border: 1px solid #E9EAEA;
	font-weight: 900;
}

#liveTime {
	padding: 10px;
	text-align: center;
}

.topRight {
	text-align: center;
}

.todoHeader, .noticeHeader {
	border-bottom: 1px solid #EDEDEE;
}

.justify-content-around {
	margin: 10px;
	color: gray;
	font-weight: bold;
}

.moreView {
	border-radius: 10px;
	background-color: white;
	color: #556372;
	border: 1px solid #EFEFEF;
	font-weight: 900;
}

#noticeTitle {
	color: black;
	font-weight: bold;
	margin-top: 30px;
	border: none;
}

#noticeTitle::placeholder {
	color: #CDD1D5;
}

#noticeTextArea::placeholder {
	color: #CDD1D5;
}

#noticeTextArea {
	width: 100%;
	height: 430px;
	font-weight: bold;
	border: none;
}

.fileUp {
	border-radius: 10px;
	background-color: white;
	padding: 10px 20px;
	color: #556372;
	cursor: pointer;
	border: 1px solid #EFEFEF;
	font-weight: 900;
}

.fileUp:hover {
	background-color: #f5f5f5; /* 배경 색상 */
	cursor: pointer;
}

.table-notice {
	font-size: 14px;
	background: white;
	border: none;
	width: 100%;
}

.notice-title {
	font-weight: 700;
	font-size: 16px;
	color: black;
	border: none;
}

.notice-time {
	font-weight: 700;
	font-size: 0.75rem;
	color: gray;
}

.notice-name {
	font-weight: 600;
	font-size: 0.9rem;
	color: gray;
}

table.table-notice tbody:hover {
	background-color: #f5f5f5;
}
table.table-hover tr:hover {
	background-color: #f5f5f5;
}

.noticeHeader {
	max-height: 95%; /* 최대 높이를 원하는 값으로 설정 */
	overflow: hidden;
	border-top : 1px solid #EDEDEE;
}

/* 웹킷 기반 브라우저 (Chrome, Safari) */
.noticeHeader::-webkit-scrollbar {
	width: 10px; /* 스크롤바의 너비 */
}

.noticeHeader::-webkit-scrollbar-thumb {
	background-color: #888; /* 스크롤바의 색상 */
	border-radius: 10px; /* 둥근 경계 적용 */
}

/* 파이어폭스 */
.noticeHeader {
	scrollbar-width: thin; /* 스크롤바의 너비 설정 */
}

.noticeHeader::-webkit-scrollbar-thumb {
	background-color: #888; /* 스크롤바의 색상 */
	border-radius: 10px; /* 둥근 경계 적용 */
}

.BtmRight {
	text-align: center;
	margin-top: 30px;
}

#calendarBtn {
	margin: -6px;
	background: #F3F4F5;
	padding: 5px;
	color: #4C5868;
	border-radius: 20px;
	border: 1px solid #E9EAEA;
	font-weight: bold;
}

#content {
	height: 70vh;
	border: none;
	border-radius: 50px;
	top: 100px;
}

/* 모비스크롤 캘린더 */
body {
	margin: 0;
	padding: 0;
}

body, html {
	height: 100%;
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
	background: #1A73E8;
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

.crud-color-c.selected, .crud-color-c:hover {
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

#mbsc-control-1 {
	display: none;
}

#calendarToday {
	color: #4C5868;
	font-weight: bold;
	margin-left: 120px;
	margin-right: 120px;
}

/* 모달 스타일 */
.custom-modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	justify-content: center;
	align-items: center;
	z-index: 1050;
	transition: opacity 0.3s ease-in-out; /* 트랜지션 효과 추가 */
	opacity: 0; /* 초기값을 0으로 설정 */
}

.custom-modal-content {
	background-color: white;
	width: 70%;
	height: 70vh;
	padding: 20px;
	border-radius: 50px;
	margin-left: 16%;
	margin-top: 6%;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.custom-close-btn {
	float: right;
	cursor: pointer;
}
/* 문서 스타일 */
#myChoice {
   margin: 0px 10px;
   display: none;
}

#borderStart {
	margin-left: -212px;
}

#borderEnd {
	margin-right: -175px;
}

.text-muted {
	font-weight: 700;
	font-size: 0.75rem;
	color: gray !important;
}
#weather{
	border: 1px solid #E9EAEA;
    width: 20vw;
    margin-left: 65px;
    border-radius: 22px;
    background: white;
    box-shadow: 0px 2px 2px #E9EAEA;
}
.my-swal-title {
  font-size: 27px; /* 원하는 글자 크기로 조절 */
}

.my-swal-content {
  font-size: 14px; /* 내용에 원하는 글자 크기로 조절 */
}
#myImg {
	margin-left : 150px;
}
tr:hover {
    background-color: #f5f5f5; /* 원하는 배경 색상으로 변경하세요 */
}
.autoWrite {
	background: white;
	border-radius: 10px;
	padding: 10px 20px;
	color: #556372;
	cursor: pointer;
	border: 1px solid #E9EAEA;
	font-weight: 900;
}
</style>
</head>
<%
	//세션에 설정된 유효시간 확인(기본 1800초(30*60초)).30분
	int time = session.getMaxInactiveInterval();//초단위
%>

<%
	//세션 유효 시간을 60 * 60(1시간)으로 설정
		session.setMaxInactiveInterval(60*60*6); //3600초
		time = session.getMaxInactiveInterval(); //초단위
%>
<body>
	<div id="myWrap">
		<div class="d-flex flex-row bd-highlight mb-3" id="header">
			<div class="myWork">
				<h1 style="margin-left: 25px; margin-top: 5px;">홈 피드</h1>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div class="flex-fill">
				<a href="/common/companyNews">
					<h1 style="color: #CDD1D5; margin-top: 5px;">회사 소식</h1>
				</a>
			</div>
			<div class="d-flex flex-row justify-content-end">
				<c:set var="oneBreak" value="false" />
				<c:forEach items="${authentication.authorities}" var="authority">
					<c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
						<c:if
							test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 21 && oneBreak eq false}">
							<button type="button" class="mainBtn" data-toggle="modal"
								data-target="#verticalModal">
								<span class="fe fe-plus-circle fe-16 mr-2"></span>공지사항 등록하기
							</button>
							<c:set var="oneBreak" value="true" />
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
		<!--    <hr> -->
	</div>
	<div class="full">
		<div class="leftScreen">
			<c:set var="oneBreak" value="false" />
			<c:forEach items="${authentication.authorities}" var="authority">
				<c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
					<c:if
						test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 23 && oneBreak eq false}">
						<div class="todoHeader">
							<div class="d-flex justify-content-around">
								<div id="borderStart">
									<span>해야할 일 </span>
								</div>
								<div id="border"></div>
								<div id="borderEnd">
									<button type="button" class="moreView"
										onclick="location.href='/approval/workflow'">더 보기</button>
								</div>
							</div>
						</div>
						<div id="todoTable"></div>
						<c:set var="oneBreak" value="true" />
					</c:if>
				</c:forEach>
			</c:forEach>
			<div class="noticeHeader" id="noticeHeader">
				<div class="d-flex justify-content-around">
					<div id="borderStart">
						<span>공지사항 (<span id="noticeCount">0</span>)
						</span>
					</div>
					<div id="border"></div>
					<div id="borderEnd">
						<button type="button" class="moreView"
							onclick="location.href='/common/companyNews'">더 보기</button>
					</div>
				</div>
				<div id="noticeTable"></div>
			</div>
		</div>

		<div class="rightScreen">
			<div class="topRight">
				<h4 id="liveTime"></h4>
				<button type="button" class="gotoWork">출근</button>
				<input type="hidden" id="gotoTime"> <br>
				<button type="button" class="leaveWork">퇴근</button>
				<input type="hidden" id="leaveTime">
			</div>
			<div class="BtmRight">
				<div style="padding: 25px;">
					<button id="todayPre" style="border: none; background: #F8F9FA;">
						<span class="fe fe-chevron-left fe-16 mr-2"></span>
					</button>
					<span id="calendarToday"></span>
					<button id="todayNext" style="border: none; background: #F8F9FA;">
						<span class="fe fe-chevron-right fe-16 mr-2"></span>
					</button>
					<br>
					<div style="margin: 30px;" id="todayList">
						<span class="fe fe-calendar fe-16 mr-2"
							style="font-size: 25px; color: #CACBCB;"></span><br> <span
							style="color: #CACBCB; font-weight: 700;">오늘은 예정된 일정이 없어요.</span><br>
					</div>
					<button type="button" class="calendarBtn" id="calendarBtn">
						달력 보기</button>
				</div>

				<!-- 캘린더 모달 -->
				<div class="custom-modal" id="customModal">
					<div class="custom-modal-content">
						<!-- 모비스크롤 시작 -->
						<div mbsc-page class="demo-create-read-update-delete-CRUD">
							<div style="height: 100%">
								<div id="demo-add-delete-event"></div>
								<div style="display: none">
									<div id="demo-add-popup">
										<div class="mbsc-form-group">
											<label> 일정명 <input mbsc-input id="event-title">
											</label> <label> 내용 <textarea mbsc-textarea id="event-desc"></textarea>
											</label>
										</div>
										<div class="mbsc-form-group">
											<label> 하루종일 <input mbsc-switch id="event-all-day"
												type="checkbox" />
											</label> <label> 시작일 <input mbsc-input id="start-input" />
											</label> <label> 종료일 <input mbsc-input id="end-input" />
											</label>
											<div id="event-date"></div>
											<div id="event-color-picker" class="event-color-c">
												<div class="event-color-label">색상</div>
												<div id="event-color-cont">
													<div id="event-color" class="event-color"
														style="background: #1A73E8;"></div>
												</div>
											</div>
											<label> Show as busy <input id="event-status-busy"
												mbsc-segmented type="radio" name="event-status" value="busy">
											</label> <label> Show as free <input id="event-status-free"
												mbsc-segmented type="radio" name="event-status" value="free">
											</label>
											<div class="mbsc-button-group">
												<button class="mbsc-button-block" id="event-delete"
													mbsc-button data-color="danger" data-variant="outline">일정
													삭제</button>
											</div>
										</div>
									</div>

									<div id="demo-event-color">
										<div class="crud-color-row">
											<div class="crud-color-c" data-value="#ffeb3c">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #ffeb3c"></div>
											</div>
											<div class="crud-color-c" data-value="#ff9900">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #ff9900"></div>
											</div>
											<div class="crud-color-c" data-value="#f44437">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #f44437"></div>
											</div>
											<div class="crud-color-c" data-value="#ea1e63">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #ea1e63"></div>
											</div>
											<div class="crud-color-c" data-value="#9c26b0">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #9c26b0"></div>
											</div>
										</div>
										<div class="crud-color-row">
											<div class="crud-color-c" data-value="#3f51b5">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #3f51b5"></div>
											</div>
											<div class="crud-color-c" data-value="#1A73E8">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #1A73E8;"></div>
											</div>
											<div class="crud-color-c" data-value="#009788">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #009788"></div>
											</div>
											<div class="crud-color-c" data-value="#4baf4f">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #4baf4f"></div>
											</div>
											<div class="crud-color-c" data-value="#7e5d4e">
												<div
													class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"
													style="background: #7e5d4e"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 모비스크롤 끝 -->
					</div>
				</div>
			</div>
			
			<hr/>
			<div style="text-align:center; margin-top:30px;">
			    <h2 style="margin-left:37px;margin-bottom:10px;font-size:25px;" id="todayWeather"></h2>
			    <div id="weather">
			    	<h3 class="add" style="margin:13px;">대전</h3>
				    <h3 class="icon">
				        <!-- <img src="https://openweathermap.org/img/wn/10d.png"> -->
				    </h3>
				    <h3 class="ctemp">현재기온 : </h3>
				    <h3 class="lowtemp" style="display:none;">최저기온 : </h3>
				    <h3 class="heighttemp" style="display:none;">최고기온 : </h3>
			    </div>
			</div>
			
			
			
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="verticalModal" tabindex="-1" role="dialog"
		aria-labelledby="verticalModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content"
				style="border-radius: 1.3rem; border: none;">
				<form id="noticeForm" enctype="multipart/form-data">
					<div class="modal-header">
						<br> <input type="hidden" name="postNo" id="postNo">
						<input class="form-control form-control-lg" id="noticeTitle"
							name="postTitle" type="text" placeholder="공지사항 제목"
							style="color: black; font-weight: bold;">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body" style="height: 55vh;">
						<textarea class="form-control" id="noticeTextArea" name="postCont"
							rows="4" placeholder="공지사항 내용을 작성해주세요."></textarea>
						<br>
						<div class="fileUp" id="fileUpBtn">
							<span class="fe fe-folder-plus fe-16 mr-2"></span> <span
								class="fileName"> 첨부파일 </span>
							<button type="button" class="close delete-schedule">
								<span>+</span>
							</button>
							<input type="file" id="fileInput" name="file"
								style="display: none;"> <input type="hidden"
								name="fileNo" id="fileNo">
						</div>
					</div>
					<div class="modal-footer" style="justify-content: center;">
						<button type="button" class="noticeSubmit" style="width: 95%;">
							<span class="fe fe-edit-2 fe-16 mr-2"></span>작성하기
						</button>
						<button type="button" class="noticeUpSubmit"
							style="width: 95%; display: none;">
							<span class="fe fe-edit-3 fe-16 mr-2"></span>수정하기
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog"
		aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content" id="content">
				<div class="modal-body"></div>
			</div>
		</div>
	</div>



</body>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script>
//업데이트 함수 정의
function updateTodayList(dateString) {
	console.log("왔다, myData.length : " + myData.length + ", dateString : " + dateString);
    // 오늘 날짜에 맞는 해당 사원의 일정만 추가
    let updatedList = ""; // 빈 문자열로 초기화
    let hasItems = false; // 일정이 있는지 여부 확인용 변수
    for (let i = 0; i < myData.length; i++) {
        let item = myData[i];
        // empNo와 날짜 조건을 만족하는 경우에만 리스트에 추가
        if (item.bbsStimeFormatted <= dateString && item.bbsEtimeFormatted >= dateString || item.bbsStimeFormatted === dateString) {
            updatedList += "<table><tr>";
            updatedList += "<td style='background: " + item.color + ";width: 3px;height: 30px;border: none;border-radius: 50px;'></td>";
            updatedList += "<td style='background: white;border: 1px solid #E9EAEA;width: 100%;'>";
            updatedList += "<div style='font-size: 15px;font-weight: bold;text-align: initial;height:20px;padding:2px;'>" + item.title + "</div>";
            
            if (item.allDay === "true") {
                updatedList += "<div style='font-size: 13px;text-align: initial;padding:2px;'>하루종일</div>";
            } else {
                updatedList += "<div style='font-size: 13px;text-align: initial;padding:2px;'>" + item.bbsStimeKo + " - " + item.bbsEtimeKo + "</div>";
            }
            
            updatedList += "</td></tr></table>";
            hasItems = true; // 일정이 있는 경우 true로 설정
            console.log("item : ", item);
        }
    }

    if (!hasItems) {
        updatedList = `<span class="fe fe-calendar fe-16 mr-2" style="font-size: 25px;color:#CACBCB;"></span><br>` +
                      `<span style="color:#CACBCB;font-weight:700;">오늘은 예정된 일정이 없어요.</span><br>`;
    }

    $("#todayList").html(updatedList); // 업데이트된 리스트 적용
}

$(() => {
  	// 오늘 날짜 표기
	let today = new Date();
	let year = today.getFullYear();
	let month = ('0' + (today.getMonth() + 1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	
	// 요일 가져오기
	let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
	let dayOfWeek = daysOfWeek[today.getDay()]; // 현재 요일
	
	let dateString = year + "." + month + "." + day + " (" + dayOfWeek + ")";
	let weatherToday = month + "월 " + day + "일 날씨";
	$("#todayWeather").text(weatherToday);
	console.log(dateString);
	$("#calendarToday").text(dateString);
	
	// "todayPre" 버튼 클릭 시
	$("#todayPre").on("click", () => {
	    today.setDate(today.getDate() - 1); // 하루 이전 날짜로 설정
	    year = today.getFullYear();
	    month = ('0' + (today.getMonth() + 1)).slice(-2);
	    day = ('0' + today.getDate()).slice(-2);
	    dayOfWeek = daysOfWeek[today.getDay()]; // 변경된 요일
	    dateString = year + "." + month + "." + day + " (" + dayOfWeek + ")";
	    $("#calendarToday").text(dateString);
	    updateTodayList(dateString); // 날짜가 변경될 때 업데이트 함수 호출
	});

	// "todayNext" 버튼 클릭 시
	$("#todayNext").on("click", () => {
	    today.setDate(today.getDate() + 1); // 하루 다음 날짜로 설정
	    year = today.getFullYear();
	    month = ('0' + (today.getMonth() + 1)).slice(-2);
	    day = ('0' + today.getDate()).slice(-2);
	    dayOfWeek = daysOfWeek[today.getDay()]; // 변경된 요일
	    dateString = year + "." + month + "." + day + " (" + dayOfWeek + ")";
	    $("#calendarToday").text(dateString);
	    updateTodayList(dateString); // 날짜가 변경될 때 업데이트 함수 호출
	});
	
	var temperatures = [];

	// API 요청을 보냅니다.
	$.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Daejeon&appid=5e03beaf9a463a6a18177ee740bbe6aa&units=metric', function(result) {
	    console.log("날씨 정보 result ", result);
	    // 온도 값을 실제 API 응답에서 가져와서 온도 배열을 채웁니다.
	    temperatures = [
	        { label: '<span style="font-size: 0.7em;">🟢</span> 현재기온', value: result.main.temp.toFixed(1) },
	        { label: '<span style="font-size: 0.7em;">🔵</span> 최저기온', value: (result.main.temp_min - 6.01).toFixed(1) },
	        { label: '<span style="font-size: 0.7em;">🔴</span> 최고기온', value: (result.main.temp_max + 3.2).toFixed(1) }
	    ];

	    // 초기 온도를 표시합니다.
	    displayTemperature(temperatures[0]);
	    
	    var currentIndex = 0;
	    setInterval(function() {
	        currentIndex = (currentIndex + 1) % temperatures.length;
	        displayTemperature(temperatures[currentIndex]);
	    }, 3000);
	});

	// 온도를 표시하는 함수입니다.
	function displayTemperature(temperature) {
	    $('.ctemp').html(temperature.label + ' : ' + temperature.value);
	}
	

    // 페이지 로드 시에도 업데이트 함수 호출
    updateTodayList(dateString);

	BbsSelect();
    notiList();
    workInfoSelect();
    myDocList();
})
		
		
		   // 캘린더 저장 버튼 이벤트
		   $("#saveBtn").on("click", function () {
			    Swal.fire({
			        title: '✅저장 완료',
			        text: '',
			        customClass: {
			            title: 'my-swal-title',
			            content: 'my-swal-content'
			        },
			        confirmButtonText: '확인', // "확인" 버튼 추가
			    }).then(function () {
			        location.href = 'http://localhost/common/home'; // "확인"을 클릭한 후 실행
			    });
			});
		   
		    // 캘린더 닫기 버튼 이벤트
			$("#cancelBtn").on("click", function (event) {
			    customModal.style.opacity = "0"; // 트랜지션 시작
			    setTimeout(function () {
			        customModal.style.display = "none";
			        customModal.style.opacity = "0"; // 초기화
			    }, 300); // 트랜지션 지연 시간
			});
		
		   //승인/반려/중요 버튼 생성/히든
		   $(document).on("mouseover",".myAop",function(){
		      let myChoice = $(this).find("#myChoice")[0]
		      let aopImg = $(this).find("#myImg")[0]
		      myChoice.style.display="block";
		      aopImg.style.display="none";
		   })
		   
		   //승인/반려/중요 버튼 생성/히든
		   $(document).on("mouseout",".myAop",function(){
		      let myChoice = $(this).find("#myChoice")[0]
		      let aopImg = $(this).find("#myImg")[0]
		      myChoice.style.display="none";
		      aopImg.style.display="block";
		   })
		   
		   //승인 및 반려 및 중요 클릭시
		   $(document).on("click",".myAopImgs",function(){
		      let apbPro = $(this).val(); //진행여부
		      let mydftNo = $(this).siblings(".mydftNo")[0].value;
		      let rejRsn = $("input[name='rejRsn']").val();
		      
		      let apboxVO = {};
		      
		      if(apbPro=="반려"){
		         apboxVO = {
		            "apbPro" : apbPro,
		            "dftNo" : mydftNo,
		            "rejRsn" : rejRsn
		         }
		      }else{
		         apboxVO = {
		            "apbPro" : apbPro,
		            "dftNo" : mydftNo,
		         }
		      }
		      
		      console.log(apboxVO);
		      Swal.fire({
		      title: "'"+apbPro+"'처리 하시겠습니까?!!",
		      text: "한번 더 확인해 주세요!",
		      icon: 'warning',
		      showCancelButton: true,
		      confirmButtonColor: '#3085d6',
		      cancelButtonColor: '#b3b3b3',
		      confirmButtonText: 'save'
		      }).then((result) => {
		         if (result.isConfirmed) {
		            $.ajax({
		               url : "/approval/updateApbox",
		               data : JSON.stringify(apboxVO),
		               dataType : "text",
		               type : "put",
		               contentType : "application/json; charset:utf-8",
		               beforeSend:function(xhr){
		                  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		               },
		               success : function(result){
		                  console.log("result", result);
		                  if(result > 0){
		                     Swal.fire({
		                     position: 'top-end',
		                     icon: 'success',
		                     title: '정상 처리 되었습니다.',
		                     showConfirmButton: false,
		                     timer: 1500
		                  })
		                  myDocList();
		                     
		                  let myName = "${empVO.empNm}";
		                  let myMassage = "결제 성공";
		                  let myData = "결제";
		                  messageVO = {
		                     setter:myName,
		                     massage:myMassage,
		                     data:myData
		                  };
		                    webSocket.send(JSON.stringify(messageVO));                         
		                  }
		               }
		            });
		         }
		      })
		   });
		
  		//나의문서 가져오기
		function myDocList(){
		   $.ajax({
		      url:"/approval/myDocList",
		      dataType:"json",
		      type:"get",
		      success:function(result){
		         let DateSort = result.sort(function(a,b){
		            return b.applicationDate - a.applicationDate;
		         });
		         console.log("ArraySort된 result값들",result)
		         let htmlCode = "<table class='table table-hover' style='margin:0;'>";
		            for(let i=0; i<5; i++){
		            const timeResult = convertTimeToRelative(result[i].applicationDate)
		            
		               if(result[i].apbPro == '진행중' && result[i].dockind=='비품신청'){
		                  htmlCode +=`<tr class="myAop" style="border-bottom: 1px solid #EDEDEE;background:white;">
		                           <td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
		                           <td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
		                              <span class="h5 mb-3">\${result[i].subject}</span> 
		                              <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span> <span class="text-muted">\${timeResult}</span> <br/>
		                              <span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
		                              <input type="hidden" class="children" value="\${result[i].dftNo}">
		                           </td>
		                           <td style="width:300px;"><div id="myImg">`;
		                  $.each(result[i].apboxEmpList, function(idx, apbox){
		                     if(apbox.myImg == null || !apbox.myImg){
		                        htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
		                     }else{
		                        htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
		                     }
		                  });
		                  htmlCode +=`</div>
		                              <div id="myChoice" style="margin-left: 135px;">
		                                 <input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
		                                 <input class="btn btn-success myAopImgs" type="button" value="승인" style="border-radius:30px;color:white;font-weight:bold;"/>
		                                 <input class="btn btn-danger myAopImgs" type="button" value="반려" style="border-radius:30px;color:white;font-weight:bold;"/>
		                              </div>
		                           </td>
		                           </tr>`;
		               }else if(result[i].apbPro == '진행중' && result[i].dockind=='휴가신청'){
		                  htmlCode +=`<tr class="myAop" style="border-bottom: 1px solid #EDEDEE;background:white;">
		                     <td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
		                     <td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
		                        <span class="h5 mb-3">\${result[i].vacTypeName}</span> 
		                        <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>  <span class="text-muted">\${timeResult}</span> <br/>
		                        <span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
		                        <input type="hidden" class="children" value="\${result[i].dftNo}">
		                     </td>
		                     <td style="width:300px;"><div id="myImg">`;
		                  $.each(result[i].apboxEmpList, function(idx, apbox){
		                     if(apbox.myImg == null || !apbox.myImg){
		                        htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
		                     }else{
		                        htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
		                     }
		                  });
		                  htmlCode +=`</div>
		                     <div id="myChoice" style="margin-left: 135px;">
		                        <input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
                                <input class="btn btn-success myAopImgs" type="button" value="승인" style="border-radius:30px;color:white;font-weight:bold;"/>
                                <input class="btn btn-danger myAopImgs" type="button" value="반려" style="border-radius:30px;color:white;font-weight:bold;"/>
		                     </div>
		                  </td>
		                  </tr>`;
		               }else if(result[i].apbPro == '진행중' && result[i].dockind=='근무신청'){
		                  htmlCode +=`<tr class="myAop" style="border-bottom: 1px solid #EDEDEE;background:white;" >
		                     <td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
		                     <td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
		                        <span class="h5 mb-3">\${result[i].waType}</span>
		                        <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>  <span class="text-muted">\${timeResult}</span>  <br/>
		                        <span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
		                        <input type="hidden" class="children" value="\${result[i].dftNo}">
		                     </td>
		                     <td style="width:300px;"><div id="myImg">`;
		                  $.each(result[i].apboxEmpList, function(idx, apbox){
		                     if(apbox.myImg == null || !apbox.myImg){
		                        htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
		                     }else{
		                        htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
		                     }
		                  });
		                  htmlCode +=`</div>
		                     <div id="myChoice" style="margin-left: 135px;">
		                        <input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
                                <input class="btn btn-success myAopImgs" type="button" value="승인" style="border-radius:30px;color:white;font-weight:bold;"/>
                                <input class="btn btn-danger myAopImgs" type="button" value="반려" style="border-radius:30px;color:white;font-weight:bold;"/>
		                     </div>
		                  </td>
		                  </tr>`;
		               }
		            }
		            htmlCode +=   "</table>";
		            $("#todoTable").html(htmlCode);
		      }
		   })
		}
  		
  		
  	  	// 오늘 날짜 표기
		let today = new Date();
		let year = today.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		
		// 요일 가져오기
		let daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
		let dayOfWeek = daysOfWeek[today.getDay()]; // 현재 요일
		
		let dateString = year + "." + month + "." + day + " (" + dayOfWeek + ")";
		console.log(dateString);
		$("#calendarToday").text(dateString);
		
		//버튼 클릭 시 모달 열기
		var openCustomModalBtn = document.getElementById("calendarBtn");
		var customModal = document.getElementById("customModal");
		
		openCustomModalBtn.addEventListener("click", function () {
		    customModal.style.display = "block";
		    setTimeout(function () {
		        customModal.style.opacity = "1"; // 트랜지션 시작
		    }, 0);
		});


		// 모달 외부 클릭 시 모달 닫기
        window.addEventListener("click", function (event) {
            if (event.target === customModal) {
                customModal.style.opacity = "0"; // 트랜지션 시작
                setTimeout(function () {
                    customModal.style.display = "none";
                    customModal.style.opacity = "0"; // 초기화
                }, 300); // 트랜지션 지연 시간
            }
        });
		
		// 일정 삭제
        const BbsDelete = function(event) {
            let xhr = new XMLHttpRequest();
            let url = "/common/BbsDelete/" + event.no;
            console.log("url : " + url);
            console.log("delEvent에 넘어온 event.no", event.no);
            xhr.open("delete", url, true);
            // csrf 토큰 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.onreadystatechange = function() {
               if(xhr.readyState == 4 && xhr.status == 200) {
                  console.log("일정삭제체크", xhr.responseText); // delete 된 행의 개수
                  updateTodayList(dateString);
               }
            }
            xhr.send();
         }
		
		// 일정 수정
	    const BbsUpdate = function(event) {
        let bbsVO = {
        		bbsNo : event.no,
        		bbsTitle : event.title,
        		bbsCont : event.description,
        		bbsStime : event.start,
        		bbsEtime : event.end,
        		bbsColor : event.color,
        		bbsAllday : event.allDay
        }
        console.log("BbsUpdate ", bbsVO);
        let xhr = new XMLHttpRequest();
        xhr.open("put", "/common/BbsUpdate", true)
        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
        // csrf 토큰 설정
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        xhr.onreadystatechange = function() {
           if(xhr.readyState == 4 && xhr.status == 200) {
              console.log("일정수정 체크", xhr.responseText); // update 된 행의 수
           }
        }
        xhr.send(JSON.stringify(bbsVO));
     }
		
	 // 사원별 일정 출력
	    const myData = [];
	    const BbsSelect = function() {
	        let url = "/common/BbsSelect/" + ${empVO.empNo};
	        let xhr = new XMLHttpRequest();
	        xhr.open("get", url, true);
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState == 4 && xhr.status == 200) {
	                console.log("BbsSelect 불러오기", JSON.parse(xhr.responseText));
	                let result = JSON.parse(xhr.responseText);

	                for (let i = 0; i < result.length; i++) {
	                    let item = result[i];

	                    // dateString과 겹치는 일정이면 해당 일정을 #todayList에 추가
	                    let bbsStimeDate = new Date(item.bbsStime);
	                    let bbsEtimeDate = new Date(item.bbsEtime);

	                    let bbsStimeFormatted = bbsStimeDate.getFullYear() + "." +
	                        ('0' + (bbsStimeDate.getMonth() + 1)).slice(-2) + "." +
	                        ('0' + bbsStimeDate.getDate()).slice(-2) +
	                        " (" + daysOfWeek[bbsStimeDate.getDay()] + ")";
	                    
	                    let bbsEtimeFormatted = bbsEtimeDate.getFullYear() + "." +
	                        ('0' + (bbsEtimeDate.getMonth() + 1)).slice(-2) + "." +
	                        ('0' + bbsEtimeDate.getDate()).slice(-2) +
	                        " (" + daysOfWeek[bbsEtimeDate.getDay()] + ")";
	                    
	                    // 시작 시간 변환
	                    let bbsStimeKo = ('0' + bbsStimeDate.getHours()).slice(-2) + ":" +
	                                            ('0' + bbsStimeDate.getMinutes()).slice(-2);

	                    // 종료 시간 변환
	                    let bbsEtimeKo= ('0' + bbsEtimeDate.getHours()).slice(-2) + ":" +
	                                            ('0' + bbsEtimeDate.getMinutes()).slice(-2);

	                    let dataItem = {
	                        no: item.bbsNo,
	                        title: item.bbsTitle,
	                        description: item.bbsCont,
	                        start: item.bbsStime, // 원본 시간 값 유지
	                        end: item.bbsEtime,   // 원본 시간 값 유지
	                        bbsStimeKo: bbsStimeKo, // 변환된 시간 값 추가
	                        bbsEtimeKo: bbsEtimeKo, // 변환된 시간 값 추가
	                        allDay: item.bbsAllday,
	                        color: item.bbsColor,
	                        bbsStimeFormatted: bbsStimeFormatted,
	                        bbsEtimeFormatted: bbsEtimeFormatted
	                    }
	                    myData.push(dataItem);
	                };

	                console.log("BbsSelect 체크 : ", myData);
	                
	             	// 페이지 로드 시에도 업데이트 함수 호출***
	                calendar.addEvent(myData);
	                updateTodayList(dateString);
	            }//end if
	        }
	        xhr.send();
	    };

       // 일정 등록
       const BbsInsert = function(event) {
    	// 넘길 데이터
           let bbsVO = {
    			   empNo : ${empVO.empNo},
        		   bbsTitle: event.title,
        		   bbsCont: event.description,
        		   bbsStime: event.start,
        		   bbsEtime: event.end,
        		   bbsColor: event.color,
        		   bbsAllday: event.allDay,
        		   free: false
           };
           console.log("insert event: ", event);
           console.log("insert VO: ", bbsVO);
           
            let xhr = new XMLHttpRequest();
            xhr.open('post', "/common/BbsInsert", true);
            xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
         	// csrf 토큰 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.onreadystatechange = function() {
               if(xhr.readyState == 4 && xhr.status == 200) {
                  if(xhr.responseText) {
                     console.log("일정 등록 성공");
                     updateTodayList(dateString);
                   } else {
                      console.log("일정 등록 실패");
                   }
                  console.log("일정등록체크: ", xhr.responseText); // insert된 행 개수
               }
             }
          xhr.send(JSON.stringify(bbsVO)); // json으로 변경 후 전송
        }
		
    <!-- 모비스크롤 시작 -->
	mobiscroll.setOptions({
	    locale: mobiscroll.localeKo,
	    theme: 'material',		// theme: 'ios' or "windows" or "material"
	    themeVariant: 'light'
	});
	
	var oldEvent,
	    tempEvent = {},
	    deleteEvent,
	    restoreEvent,
	    colorPicker,
	    tempColor,
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
// 	,
// 	    myData = [{
// 	        id: 1,
// 	        start: '2023-10-08T13:00',
// 	        end: '2023-10-08T13:45',
// 	        title: 'Lunch @ Butcher\'s',
// 	        description: '',
// 	        allDay: false,
// 	        free: true,
// 	        color: '#009788'
// 	    }];
	
	function createAddPopup(elm) {
	    // hide delete button inside add popup
	    deleteButton.style.display = 'none';
	
	    deleteEvent = true;
	    restoreEvent = false;
	
	    // set popup header text and buttons for adding
	    popup.setOptions({
	        headerText: '일정 등록',
	        buttons: ['cancel', {
	            text: '등록',
	            keyCode: 'enter',
	            handler: function () {
	                calendar.updateEvent({
	                    id: tempEvent.id,
	                    title: tempEvent.title,
	                    description: tempEvent.description,
	                    allDay: tempEvent.allDay,
	                    start: tempEvent.start,
	                    end: tempEvent.end,
	                    color: tempEvent.color,
	                });
	                BbsInsert(tempEvent);
	                calendar.updateEvent(tempEvent);
	                calendar.navigateToEvent(tempEvent);
	                deleteEvent = false;
	                popup.close();
	            },
	            cssClass: 'mbsc-popup-button-primary'
	        }]
	    });
	
	    // fill popup with a new event data
	    mobiscroll.getInst(titleInput).value = '';
	    mobiscroll.getInst(descriptionTextarea).value = '';
	    mobiscroll.getInst(allDaySwitch).checked = true;
	    range.setVal([tempEvent.start, tempEvent.end]);
	    mobiscroll.getInst(busySegmented).checked = true;
	    range.setOptions({ controls: ['date'], responsive: datePickerResponsive });
	    pickedColor.style.background = '';
	
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
	        headerText: '일정 수정',
	        buttons: ['cancel', {
	            text: '수정',
	            keyCode: 'enter',
	            handler: function () {
	                var date = range.getVal();
	                var eventToSave = {
	                    id: ev.id,
	                    no : ev.no,
	                    title: titleInput.value,
	                    description: descriptionTextarea.value,
	                    allDay: mobiscroll.getInst(allDaySwitch).checked,
	                    start: date[0],
	                    end: date[1],
	                    free: mobiscroll.getInst(freeSegmented).checked,
	                    color: ev.color,
	                };
	                BbsUpdate(eventToSave);
	                calendar.updateEvent(eventToSave);
	                calendar.navigateToEvent(eventToSave);
	                restoreEvent = false;
	                popup.close();
	            },
	            cssClass: 'mbsc-popup-button-primary'
	        }]
	    });
	
	    // fill popup with the selected event data
	    mobiscroll.getInst(titleInput).value = ev.title || '';
	    mobiscroll.getInst(descriptionTextarea).value = ev.description || '';
	    mobiscroll.getInst(allDaySwitch).checked = ev.allDay || false;
	    range.setVal([ev.start, ev.end]);
	    pickedColor.style.background = ev.color || '';
	
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
	
	var calendar = mobiscroll.eventcalendar('#demo-add-delete-event', {
	    clickToCreate: 'double',
	    dragToCreate: true,
	    dragToMove: true,
	    dragToResize: true,
	    view: {
	        calendar: { labels: true }
	    },
	    data: myData,
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
	    onEventDeleted: function () {
	        mobiscroll.snackbar({ 
	            button: {
	                action: function () {
	                    calendar.addEvent(args.event);
	                },
	                text: 'Undo'
	            },
	            message: 'Event deleted'
	        });
	    }
	});
	
	var popup = mobiscroll.popup('#demo-add-popup', {
	    display: 'bottom',
	    contentPadding: false,
	    fullScreen: true,
	    onClose: function () {
	        if (deleteEvent) {
	            calendar.removeEvent(tempEvent);
	        } else if (restoreEvent) {
	            calendar.updateEvent(oldEvent);
	        }
	    },
	    responsive: {
	        medium: {
	            display: 'anchored',
	            width: 400,
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
	
	var range = mobiscroll.datepicker('#event-date', {
	    controls: ['date'],
	    select: 'range',
	    startInput: '#start-input',
	    endInput: '#end-input',
	    showRangeLabels: false,
	    touchUi: true,
	    responsive: datePickerResponsive,
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
	    
	    // save a local reference to the deleted event
	    var deletedEvent = tempEvent;
	    BbsDelete(tempEvent);
	    
	    popup.close();
	
	    mobiscroll.toast({ 
	        button: {
	            action: function () {
	                calendar.addEvent(deletedEvent);
	            }
	    /* ,
	            text: 'Undo' */
	        },
	        message: '삭제 완료',
	        color : 'secondary'
	    });
	});
	
	colorPicker = mobiscroll.popup('#demo-event-color', {
	    display: 'bottom',
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
	    responsive: {
	        medium: {
	            display: 'anchored',
	            anchor: document.getElementById('event-color-cont'),
	            buttons: {}
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
	        pickedColor.style.background = color || '';
	    }
	}
	
	function setSelectedColor() {
	    tempEvent.color = tempColor;
	    pickedColor.style.background = tempColor;
	    colorPicker.close();
	}
	
	colorSelect.addEventListener('click', function () {
	    selectColor(tempEvent.color || '');
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
	});
<!-- 모비스크롤 끝 -->

const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';
const $tempFile = $("input[name='arrayFile']"); //직인파일

    // Sweet alert Toast 설정
	const Toast = Swal.mixin({
	    toast: true,
	    position: 'top-right',
	    showConfirmButton: false,
	    timer: 1500,
	    timerProgressBar: true,
	    didOpen: (toast) => {
	        toast.addEventListener('mouseenter', Swal.stopTimer)
	        toast.addEventListener('mouseleave', Swal.resumeTimer)
	    }
	})

   function dateChange(timestamp) {
	   const date = new Date(timestamp);
	   const formattedDate = date.toLocaleString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit', hour: 'numeric', minute: '2-digit', hour12: false });
	   const timeOnly = formattedDate.split(' ')[1];
	   return timeOnly;
	}
   
   // 출퇴근 정보 1개 SELECT
   const workInfoSelect = function() {
	   let url = "/common/commuteSelect/" + ${empVO.empNo};
	   $.ajax({
	          url: url,
	           type: "get",
	           dataType:"json",
	           beforeSend: function (xhr) {
	               xhr.setRequestHeader(header, token);
	           },
	           success: function (result) {
	              console.log("출퇴근 select 체크 : ", result);
	              const startTime = dateChange(result.whStime);
	              const endTime = dateChange(result.whEtime);
	              if(result.whStime != null) {
	               		$(".gotoWork").text("출근 " + startTime);
	               		$(".gotoWork").prop("disabled", true);
	              }
	               if(result.whEtime != null) {
	               		$(".leaveWork").text("퇴근 " + endTime);
	               }
	           }
	       });
   }
   
   // 퇴근버튼 클릭 이벤트
   $(".leaveWork").on("click",function(){
       $.ajax({
          url: "/common/leaveWork",
           type: "put",
           dataType:"json",
           beforeSend: function (xhr) {
               xhr.setRequestHeader(header, token);
           },
           success: function (result) {
              console.log("퇴근등록 체크 : ", result);
              Toast.fire({
          	    icon: 'success',
          	    title: '퇴근 등록'
          	})
              workInfoSelect();
           },
           error: function (xhr, status, error) {
               console.error("AJAX 요청 실패: " + error);
           },
       });
   })
   
   // 출근버튼 클릭 이벤트
   $(".gotoWork").on("click",function(){
      let url = "/common/gotoWork";
       let workVal = {
             empNo : ${empVO.empNo},
             wkCode : "E0101"
       };
       let gotoTime = $("#gotoTime");
       $.ajax({
           url: url,
           data: JSON.stringify(workVal),
           type: "post",
           dataType: "json",
           contentType: "application/json;charset=utf-8",
           beforeSend: function (xhr) {
               xhr.setRequestHeader(header, token);
           },
           success: function (result) {
               console.log("출근등록 체크", result);
               Toast.fire({
            	    icon: 'success',
            	    title: '출근 등록'
            	})
               workInfoSelect();
           },
           error: function (xhr, status, error) {
               console.error("AJAX 요청 실패: " + error);
           },
       });
   })
   
   
   let timeout;

    // 스크롤 이벤트 리스너를 추가
    document.getElementById('noticeHeader').addEventListener('scroll', function () {
        clearTimeout(timeout); // 타임아웃 초기화
        const noticeHeader = this;

        // 0.5초 후에 스크롤바를 숨김
        timeout = setTimeout(function () {
            noticeHeader.style.overflow = 'hidden';
        }, 500);
    });

    // 마우스 휠 이벤트 리스너를 추가
    document.getElementById('noticeHeader').addEventListener('wheel', function () {
        const noticeHeader = this;
        noticeHeader.style.overflow = 'auto'; // 스크롤바 표시
        clearTimeout(timeout); // 타임아웃 초기화
    });

   // 등록일자 시간 나타내기
   function convertTimeToRelative(timeInMilliseconds) {
    const currentTime = new Date().getTime();
    const timeDifference = currentTime - timeInMilliseconds;

    const seconds = Math.floor(timeDifference / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);

       if (days > 0) {
           return days + "일 전";
       } else if (hours > 0) {
           return hours + "시간 전";
       } else if (minutes > 0) {
           return minutes + "분 전";
       } else {
           return "방금 전";
       }
   }

   
	// 공지사항 리스트 불러오기
   const notiList = function() {
       let url = "/common/notiList";
       $.ajax({
           url: url,
           type: "get",
           beforeSend: function (xhr) {
               xhr.setRequestHeader(header, token);
           },
           success: function (res) {
               console.log("공지사항 리스트 ", res);
               const noticeCount = res.length;
               
               let str = "<table class='table-notice'>";
               for (let i = 0; i < res.length; i++) {
                   const relativeTime = convertTimeToRelative(res[i].wriDate);
                   
                   
                   // 파일 다운로드 링크 생성
                   const fileDownloadLink = res[i].svfiName; // 첨부 파일의 경로
                   
                   str += `<tbody id="noticeTable" style="border-bottom: 1px solid #EDEDEE;">
                   <tr>
                       <td style='width:70px; height:70px;'>
                           <img src="/resources/images/insight-basic50x50.png">
                       </td>
                       <td>
                           <div>
                               <span class="notice-title">\${res[i].postTitle}</span>&nbsp;&nbsp;
                               <span class="notice-time">\${relativeTime}</span>&nbsp;&nbsp;
                               <c:set var="oneBreak" value="false" />
                                   <c:forEach items="${authentication.authorities}" var="authority">
                                       <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
                                           <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 22 && oneBreak eq false}">
                               <span>
                                   <button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
                                   <div class="dropdown-menu dropdown-menu-left">
                                       <button class="dropdown-item" onclick="noticeSelect(\${res[i].postNo})">수정</button>
                                       <button class="dropdown-item" onclick="deleteNotice(\${res[i].postNo})" style="color:red;">삭제</button>
                                   </div>
                               </span>
                               <c:set var="oneBreak" value="true" />
                                   </c:if>
                               </c:forEach>
                           </c:forEach>
                           </div>
                           <div>
                               <span class="notice-name">\${res[i].empNm}님</span><br>
                               
                           </div>
                       </td>
                   </tr>
                   <tr>
                       <td style="border:none;"></td>
                       <td style="border-top:none;">\${res[i].postCont}</td>
                   </tr>
                   <td></td>
                   <td style="padding: 20px 0;border: none;">
                   \${res[i].fileNo ? `<span class="fe fe-paperclip fe-16 mr-2" style="font-weight: 700;font-size: 0.85rem;color: black;"><a style="margin-left:-9px;" href="\${fileDownloadLink}" download="\${res[i].orfiName}">
            			    <button type="button" style="border:none;background:none;">
            		        <span style="font-weight: 700;font-size: 0.75rem;color: gray;">\${res[i].orfiName}</span>
            		    </button>
            		</a></span>` : ''}
                   </td>
                   </tbody>`;
               }
               str += "</table>";
               $("#noticeTable").html(str);
               $("#noticeCount").text(noticeCount);
           },
           error: function (xhr, status, error) {
               console.error("AJAX 요청 실패: " + error);
           },
       });
   }

   // 공지사항 1개 조회
   const noticeSelect = function(postNo){
       console.log("1개조회버튼 클릭", postNo);
       console.log("파일value ? ", fileInput.value);
       $("#verticalModal").modal("show");
       $(".noticeSubmit").css("display", "none");
       $(".noticeUpSubmit").css("display", "block");

       $.ajax({
           url: "/common/notiSelect/" + postNo,
           type: "get",
           dataType: "json",
           contentType: "application/json;charset=utf-8",
           beforeSend: function (xhr) {
               xhr.setRequestHeader(header, token);
           },
           success: function (result) {
               console.log("select 체크", result);

               // 조회된 공지사항 내용에서 <br> 태그를 \n으로 변환
               let formattedContent = result.postCont.replace(/<br>/g, "\n");

               // 모달 창 내의 입력 필드에 기존 값 설정
               $("#noticeTitle").val(result.postTitle);
               $("#noticeTextArea").val(formattedContent); // .val() 메서드를 사용하여 값을 설정
               $("#postNo").val(result.postNo);
               $("#fileNo").val(result.fileNo);
               if (result.orfiName === null) {
            	    $(".fileName").text("첨부파일");
            	} else {
            	    $(".fileName").text(result.orfiName);
            	    const closeButton = document.querySelector('.delete-schedule');
                    closeButton.innerHTML = '<span>×</span>';
            	}
           },
           error: function (xhr, status, error) {
               console.error("AJAX 요청 실패: " + error);
           },
       });
   }

	   // 공지사항 수정
	   $(".noticeUpSubmit").on("click", function () {
	    let postNo = $("#postNo").val();
	    let title = $("#noticeTitle").val();
	    let contentValue = noticeCnt.val();
	    let fileNo = $("#fileNo").val();
	    let formattedContent = contentValue.replace(/\n/g, "<br>");

	    if (!title || !formattedContent) {
	    	Swal.fire({
	    		  title: '제목과 내용은 필수 입력 사항 입니다.',
	    		  text: '',
	    		  customClass: {
	    		    title: 'my-swal-title',
	    		    content: 'my-swal-content'
	    		  }
	    		});
	        return;
	    }

	    let url = "/common/notiUpdate";
	    let formData = new FormData();

	    // 파일이 존재하는 경우에만 추가
	    if ($("#fileInput")[0].files.length > 0) {
	        formData.append("file", $("#fileInput")[0].files[0]); // 파일 업로드 처리
	    }
	
        formData.append("wriNo", ${empVO.empNo});
	    formData.append("postNo", postNo);
	    formData.append("fileNo", fileNo);
	    formData.append("postTitle", title);
	    formData.append("postCont", formattedContent);

	    $.ajax({
	        url: url,
	        data: formData,
	        type: "put",
	        processData: false,
	        contentType: false,
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success: function (result) {
	            console.log("공지수정 체크", result);
	            console.log("수정데이터 체크", formData);
	            Swal.fire({
	                position: 'top-end',
	                icon: 'success',
	                title: '수정 완료',
	                showConfirmButton: false,
	                timerProgressBar: true,
	                timer: 1500
	            })
	            $("#verticalModal").modal("hide");
	            notiList();
	        },
	        error: function (xhr, status, error) {
	            console.error("AJAX 요청 실패: " + error);
	        },
	    });
	})

   

   // 공지사항 삭제
   const deleteNotice = function(postNo){
       console.log("삭제버튼");
       $.ajax({
           url: "/common/notiDelete/" + postNo,
           type: "delete",
           dataType: "json",
           contentType: "application/json;charset=utf-8",
           beforeSend: function (xhr) {
               xhr.setRequestHeader(header, token);
           },
           success: function (result) {
               console.log("공지삭제 체크", result);
               Swal.fire({
                     position: 'top-end',
                     icon: 'success',
                     title: '삭제 완료',
                     showConfirmButton: false,
                     timerProgressBar: true,
                     timer: 1500
                   })
               notiList();
           },
           error: function (xhr, status, error) {
               console.error("AJAX 요청 실패: " + error);
           },
       });
   }
   
   const noticeTitle = $("#noticeTitle");
   const noticeCnt = $("#noticeTextArea");
   
   
   // 공지사항 등록
   $(".noticeSubmit").on("click", function () {
    let titleValue = noticeTitle.val();
    let contentValue = noticeCnt.val();
    let formattedContent = contentValue.replace(/\n/g, "<br>");

    if (!titleValue || !formattedContent) {
    	Swal.fire({
    		  title: '제목과 내용은 필수 입력 사항 입니다.',
    		  text: '',
    		  customClass: {
    		    title: 'my-swal-title',
    		    content: 'my-swal-content'
    		  }
    		});
        return;
    }

    let url = "/common/notiInsert";
    let formData = new FormData();

    // 파일이 존재하는 경우에만 추가
    if ($("#fileInput")[0].files.length > 0) {
        formData.append("file", $("#fileInput")[0].files[0]); // 파일 업로드 처리
    }

    formData.append("wriNo", ${empVO.empNo});
    formData.append("postTitle", titleValue);
    formData.append("postCont", formattedContent);

    $.ajax({
        url: url,
        data: formData,
        type: "post",
        processData: false,
        contentType: false,
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (result) {
            console.log("공지등록 체크", result);
            Swal.fire({
                position: 'top-end',
                icon: 'success',
                title: '등록 완료',
                showConfirmButton: false,
                timerProgressBar: true,
                timer: 1500
            })
            $("#verticalModal").modal("hide");
            notiList();
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 실패: " + error);
        },
    });
});

	// 공지사항 등록하기 버튼 클릭이벤트
	$(".mainBtn").on("click",function(){
	    $(".noticeUpSubmit").css("display", "none");
	    $(".noticeSubmit").css("display", "block");
	})

   // 모달 닫히면 값 초기화   
   $('#verticalModal').on('hidden.bs.modal', function () {
       $('#noticeTitle').val(''); // 공지사항 제목 초기화
       $('#noticeTextArea').val(''); // 공지사항 내용 초기화
       resetFileUpload(); // input file 초기화
   });
   
   //div 요소를 클릭하면 input 태그를 클릭하도록
   const fileUpBtn = document.getElementById("fileUpBtn");
   const fileInput = document.getElementById("fileInput");
   
   fileUpBtn.addEventListener("click", function() {
       fileInput.click();
   });
   
   // 파일 선택을 완료 이벤트
   fileInput.addEventListener("change", function() {
       const selectedFiles = fileInput.files;
       if (selectedFiles.length > 0) {
           // 첫 번째 파일 이름을 .fileName 요소에 표시
           const fileNameElement = document.querySelector('.fileName');
           fileNameElement.textContent = selectedFiles[0].name;

           // 버튼 요소의 내용을 "×"로 변경
           const closeButton = document.querySelector('.delete-schedule');
           closeButton.innerHTML = '<span>×</span>';

           // 나머지 파일 개수 표시
           const fileCount = selectedFiles.length - 1; // 첫 번째 파일을 제외
           if (fileCount > 0) {
               fileNameElement.textContent += ` 외 \${fileCount}개`;
           }
       }
   });

   
   // x 버튼 클릭시 input file 초기화
   const closeButton = document.querySelector('.delete-schedule');
   closeButton.addEventListener('click', function() {
      resetFileUpload();
   });
   
   // 초기화 이벤트
   function resetFileUpload() {
       // input 태그의 값을 초기화합니다.
       fileInput.value = '';
		
       $("#fileNo").val('');
       
       // 파일 이름 초기화
       const fileNameElement = document.querySelector('.fileName');
       fileNameElement.textContent = '첨부파일';

       // "×" 버튼을 다시 "+"로 변경
       closeButton.innerHTML = '<span>+</span>';
   }
   
   // "×" 버튼을 클릭할 때 input 태그의 이벤트 핸들러를 제거
   closeButton.addEventListener('click', function(e) {
       e.stopPropagation();
   });
   
   // 현재시간 초단위 나타내기
   function liveTime() {
      //<h3>태그 select(object)
      let time = document.querySelector("#liveTime");
      
      let today = new Date();
      let year = today.getFullYear();
      let month = ('0' + (today.getMonth() + 1)).slice(-2);
      let day = ('0' + today.getDate()).slice(-2);
      
      let dateString = year + "-" + month + "-" + day;
      
   //    console.log("dateString : " + dateString);
      
      let hours =    ('0' +   today.getHours()).slice(-2);
      let minutes = ('0' + today.getMinutes()).slice(-2);
      let seconds = ('0' + today.getSeconds()).slice(-2);
      
      let timeString = hours + ":" + minutes + ":" + seconds;
      
   //    console.log("result : " + dateString + " " + timeString);
      time.innerHTML = "현재 시간 : "  + " " + timeString;
   }
   setInterval(liveTime,1000); //1초마다 liveTime함수를 요청
   
   
   $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Daejeon&appid=5e03beaf9a463a6a18177ee740bbe6aa&units=metric',function(result){
       console.log("날씨정보 resutl ", result);
	   //현재온도
       $('.ctemp').append(result.main.temp);
       //최저온도
       $('.lowtemp').append(result.main.temp_min - 2.01);
       //최고온도
       $('.heighttemp').append(result.main.temp_max + 3.2);
       //icon출력
       //result.weather[0].icon
       var wiconUrl = '<img style="width:100px; height:100px;" src="https://openweathermap.org/img/wn/' 
       					+ result.weather[0].icon +'.png" alt="'+result.weather[0].desciption+'">'
       $('.icon').html(wiconUrl);

       var ct = result.dt
       function convertTime(t){
           var ot = new Date(t*1000);
           //Mon May 29 2023 17:39:13 GMT+0900 (한국 표준시)
           var hr = ot.getHours();
           var m = ot.getMinutes();
           var s = ot.getSeconds();
           return hr+":"+m+":"+s
       }


       var currentTime = convertTime(ct)
       $('.time').append(currentTime);
   })
   
</script>
</html>