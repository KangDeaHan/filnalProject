<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<style>

 #header1 {
     height: 14vh;
 }
 #header2 {
     display: flex;
     align-items: center; /* 수직 정렬 중앙 정렬 */
     height: 60%; /* 부모 높이에 맞게 설정 */
 }
 #header2>div {
     display: flex;
     align-items: center; /* 수직 정렬 중앙 정렬 */
     height: 100%; /* 부모 높이에 맞게 설정 */
 }

div {
/*     	border: 1px solid blue; /* 항상 레이아웃을 눈으로 보면서 */      
 }
span {
/* 	border: 1px solid red; */
}
.gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important; 
}
.rounded-button {
	padding: 10px 20px; /* 버튼 내용과 여백 설정 */
	background-color: #ffffff; /* 버튼 배경색 */
	color: #76777c; /* 회색 글자색 */
	border: 1px solid #888888; /* 회색 테두리 */
	border-radius: 20px; /* 둥근 모서리 설정 */
	cursor: pointer; /* 커서 스타일 변경 (선택 사항) */
}
/* 링크 스타일 */
.aTag {
	text-decoration: none; /* 밑줄 제거 */
	margin-right: 20px; /* 각 링크 사이의 간격 조절 */
}

a:visited {
   color: black;
   text-decoration: none;
}

.col-md-3 {
	margin-right: 20px;
	flex: 1;
}

.inputNames {
	width : 15%;
	padding-left : 10px;
	display : flex;
	align-items : center;
}

.inputConts {
	width : 85%;
}

label {
	margin : 0px;
}

.modal-content {
	height : 350px;
}
</style>
<meta charset="UTF-8">
<title>급여정산 홈</title>
</head>
<body>

<div id="container"> <!--wrapper-->
		<div id="header1">
			<div id="header2">
			
				<div id="header3">
					<h1><a href="/salary/home" class="aTag"  style="margin-left: 25px;">급여정산</a>&nbsp;&nbsp; <a href="#" class="gray-link">퇴직소득</a>&nbsp;&nbsp;</h1>
					<h1><a href="/salary/dataManagement"  class="aTag gray-link">자료관리</a></h1>
				</div>
			</div>
			<hr>
				<div id="header3">
					<h4 style="margin-bottom: 2px;">
							<a href="/salary/home" class="aTag" style=" margin-left: 25px;">홈</a>&nbsp;&nbsp; 
							<a href="/salary/pastPayroll" class="aTag gray-link">지난 정산 내역</a>&nbsp;&nbsp; 
							<a href="/salary/tmpList" class="aTag gray-link">정산템플릿 목록</a>
					</h4>
				</div>
		
		</div>
		<hr>
		

	<div class="alert alert-success" role="alert" style="width: 85%; height: 200px;margin-left:50px;padding-left:50px;">
		<br> <br> 
		<span class="fe fe-24 fe-check-circle" style="display: inline-block;"></span>
		<h4 style="margin: 0px;display:inline-block;margin-bottom:20px;">우리 회사 급여 정산 준비를 시작해볼까요?</h4>
		<br>
		<button type="button" class="rounded-button" style="margin-right: 15px;">원천징수의무자 정보 확인하기</button>
		<button type="button" class="rounded-button" onclick="window.location.href='/salary/tmpList'">정산템플릿 수정하기</button>
	</div>
	
	<br><br>
	<h4 style="display:inline-block;margin-left:50px; margin-bottom:15px;">정산을 시작해볼까요?</h4>

	<div id="bmkList" class="row align-items-center" style="margin: 0px;">

	</div>	<!--전체 row 끝-->
</div>	
<!-- ---------------------------------------------------------------------------------------------------------- -->

<!-- 모달 영역 밖으로 빼어 놓는게 좋음-->
<div class="modal fade" id="salaryModal" tabindex="-1" role="dialog" aria-labelledby="salaryModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
	    	<div class="modal-content">
		        <div class="modal-header" style="border:0px;">
		          <h5 class="modal-title" id="salaryModalTitle">정산 시작하기</h5>
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">×</span>
		          </button>
		        </div>
		        
			<form id="modalForm" action="/salary/startPR" method="post">
		        <div class="modal-body" style="width:90%;margin:0px auto;">
		        	<div>
		        		
		        		<input id="hiddenInput" type="hidden" name="ptNo" value="" />
		        		
						<div class="row align-items-center mb-3 mt-3">
							<div class="inputNames"><label for="prStlNm">이름</label></div>
							<div class="inputConts">
								<input type="text" id=prStlNm name="prStlNm" class="form-control" placeholder="ex) 1월 정기 급여" required /> <!-- value="${sessionScope.map.name}" -->
							</div><br/>
						</div>
						<div class="row align-items-center mb-1">
							<div class="inputNames"><label for="prYM">귀속월</label></div>
							<div class="inputConts">
								<input class="form-control" id="prYM" type="month" name="prYM" required />
							</div><br/>
						</div>
							<div style="text-align:center;"><span class="help-block"><small>기본근무 정산기간은 1일 ~ 30일 입니다.</small></span></div>
						<div class="row align-items-center mt-1">
							<div class="inputNames"><label for="prPdate">지급일</label></div>
							<div class="inputConts">
								<input class="form-control" id="prPdate" type="date" name="prPdate" required />
							</div><br/>
						</div>
					</div>
		        </div>
		        <div class="modal-footer mb-2" style="border:0px;">
       	            <button type="button" class="btn mr-3 btn-outline-dark " onclick ="autoWrite()">자동채우기</button>
		        	<button type="submit" class="btn btn-success mr-3" style="color:white;"> 정산 시작하기 → </button>
		        </div>
		        <sec:csrfInput/>
		    </form>
	      	</div>
	    </div>
	  </div>


<!-- ---------------------------------------------------------------------------------------------------------------------------------------------- -->		
<script>

	const bmkList = $("#bmkList"); //결과를 추가할 div
	var str = "";
	
	//체크된 북마크 리스트 불러오기
	$.ajax({
		
		url:"/salary/selectBmkOn",
		type:"get",
		dataType:"json",
		success:function(data){
			console.log("받아온 data 북마크리스트:", data);
			
			$.each(data, function(index, item){ //item에 payTplVO 들어있음
				console.log(item);
				//console.log("index : " + index + ", str : " + JSON.stringify(str));
				
				//백틱이 있으면  달러 중괄호(EL표현 (자바에서 받아온 값)) 앞에 \를 붙여야 한다.
				str+=`
					<div class="col-md-3" style="margin-left:36px;">
						<div class="card shadow mb-4">
							<div class="card-body text-center">
							
								<input type="hidden" name="ptNo" value="\${item.ptNo}" />
							
								<div class="row align-items-center justify-content-between" style="width:330px;margin-left:4px;">
									<div>
										<span class="badge badge-pill badge-success">근로소득</span> 
										<span class="badge badge-light text-muted">지급일</span>
									</div>

									<div style="display:flex;">
										<div>
											<a href="#" onclick="fRemove(this)"><img src="/resources/images/salary/bookmark_red.png" /></a>
										</div>
									
										<div class="col-auto" style="padding: 0px;">
											<div class="file-action">
												<button type="button"
													class="btn btn-link dropdown-toggle more-vertical p-0 text-muted mx-auto"
													data-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false">
													<span class="text-muted sr-only">Action</span>
												</button>
												<div class="dropdown-menu m-2">
													<a class="dropdown-item" href="/salary/tmpUpdate?ptNo=\${item.ptNo}" onclick="/salary/tmpUpdate?ptNo=\${item.ptNo}">
														<i class="fe fe-edit fe-12 mr-4"></i>템플릿 수정하기</a>
													<a class="dropdown-item" href="#" onclick="deleteTmp(this)">
														<i class="fe fe-delete fe-12 mr-4"></i>템플릿 삭제하기</a>
												</div>
											</div>
										</div>
									</div>
								</div>
									
								<div class="card-text my-2 mt-3">
									<strong class="card-title my-0" style="font-size:1.1rem">\${item.ptNm}</strong><br>
								</div>
								<div>
									<p class="small text-muted mb-0" style="font-size:0.9rem">\${item.ptEpn}</p>
								</div>
							</div>
							<!-- ./card-text -->
							<div class="card-footer" style="border-top:0px;padding-top:0px;">
								<div class="row align-items-center">
									<div class="col-auto">
										<button type="button" class="btn mb-2 btn-success startPRbtn" data-toggle="modal" data-target="#salaryModal"
											data-pt-no="\${item.ptNo}"  style="color: white" onclick="fStart(this)">정산하기</button>
									</div>
								</div>
							</div>
							<!-- /.card-footer -->
						</div>
					</div>
				`;
			}); //$.each

			bmkList.html(str);
			
		},//success
		error:function(xhr, status, error){
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
		}	

	});//$.ajax
	
	//////////////////////////////////////////////////////////////////////////////////////
	
	//정산템플릿 DB에서 삭제하기
	function deleteTmp(pThis){
		event.preventDefault(); // a tag 이동 막기
		
		console.log("$(pThis): ", $(pThis));
		
		var ptNoValue = $(pThis).closest('.card-body').children("[name=ptNo]").val();
		console.log("ptNoValue : " , ptNoValue);
		
		
		let data = {"ptNo" : ptNoValue}; //ptNo를 삭제하기 버튼 클릭한 위치를 찾아서 변수에 담아야 함!
		
		$.ajax({
			url: "/salary/tmpDelete", 
			type: "delete", 
			data: JSON.stringify(data), // 업데이트할 북마크 상태 데이터
			contentType:"application/json;charset=utf-8",
			dataType: "text",
			beforeSend:function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				  },
			success: function (result) {
				console.log("리스트 불러왔닝?:", result);
				if(result=="success"){
					fRemove(pThis); //화면에서도 삭제
				}
			
			},
			error:function(xhr, status, error){
				console.log("code: " + xhr.status)
				console.log("message: " + xhr.responseText)
				console.log("error: " + error);
			}
		});
	}
	////////////////////////////////////////////////////////////////////////////////
	
	
	//북마크 클릭시 템플릿  화면에서 삭제하기 & 템플릿의 북마크상태여부코드 DB변경
	function fRemove(pThis){

		console.log("돔객체",pThis);
		//let colmd3Div = document.querySelectorAll(".col-md-3");
		//console.log(colmd3Div);
		let rowDiv = document.querySelector(".row");
		console.log(rowDiv);
		console.log("자바스크립트객체",$(pThis));
		
		let colmd3Div = $(pThis).closest(".col-md-3")[0];
		
		rowDiv.removeChild(colmd3Div);//템플릿 삭제(부모에서 자식 찾아서 삭제)
		
		var ptNoValue = $(pThis).closest('.card-body').children("[name=ptNo]").val();//현재 선택값 기준 ptNo 찾기
		console.log("템플릿 몇번이야?", ptNoValue);
		
		updateBmkStatus(ptNoValue, "B0102");// 북마크 상태를 N("B0102")으로 변경
		
	}
	
	/////////////////////////////////////////////////////////////////////////////////
	
	function updateBmkStatus(ptNoValue, newStatus){
		// AJAX 요청을 통해 서버로 북마크 상태 업데이트 요청 보내기
		
		let data = { 
				"ptNo" : ptNoValue,		
				"ptBmkYn" : newStatus
		}
		
		console.log("보내는 데이터",data);
		
		$.ajax({
			url: "/salary/updateBmkStatus", 
			type: "put", 
			data: JSON.stringify(data), // 업데이트할 북마크 상태 데이터
			contentType:"application/json;charset=utf-8",
			dataType: "text",
			beforeSend:function(xhr){
				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				  },
			success: function (result) {
				console.log("북마크 상태 업데이트 성공:", result);
				
				if(result=="fail"){
					console.log("실패!");
				}else{//B0101, B0102
					console.log("성공!");
				}
			},
			error:function(xhr, status, error){
				console.log("code: " + xhr.status)
				console.log("message: " + xhr.responseText)
				console.log("error: " + error);
			}
    	});
	}

	
/////////////////////////////////////////////////////////////////////////////////////////////////////

// 버튼 클릭 이벤트 핸들러 (동적 바인딩)
function fStart(pThis) {
    var ptNo = $(pThis).data("pt-no"); // data-pt-no 속성의 값을 가져옴
    console.log("this 값 :", pThis);
    console.log("ptNo", ptNo);
    
    
    var hiddenInput = $("#hiddenInput"); // 해당 모달 내의 hiddenInput 요소를 찾음
    console.log("hiddenInput : ", hiddenInput[0]);
    
    hiddenInput.val(ptNo); // 모달 창의 input type="hidden" 요소에 값을 설정
    
    $("#prStlNm").val("");
    $("#prYM").val("");
    $("#prPdate").val("");
}

//자동채우기
function autoWrite(){
	   let prStlNm = "10월 정기급여";
	   let prYM = "2023-10";
	   let prPdate = "2023-10-31";
	   
	   $("#prStlNm").val(prStlNm);
	   $("#prYM").val(prYM);
	   $("#prPdate").val(prPdate);
	   
	}
/*      var modal = document.querySelector("#salaryModal");
        var openModalButton = document.querySelector("#openModalButton");
        var closeModalButton = document.querySelector(".close");

        // 모달 열기 버튼 클릭 시 모달 열기
        openModalButton.addEventListener("click", function () {
            modal.style.display = "block"; // 모달 표시
        });

        // 모달 닫기 버튼 클릭 시 모달 숨기기
        closeModalButton.addEventListener("click", function () {
            modal.style.display = "none"; // 모달 숨기기
        });
*/   
	
</script>
</body>
</html>