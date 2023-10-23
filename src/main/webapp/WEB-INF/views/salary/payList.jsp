<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
	div {
	/* 	border: 1px solid blue; */
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
		margin-left: 10px;
		margint-right: 10px;
	}
	
	.card-body {
		height: 150px;
	}
	.gray-link {
	    color: #CDD1D5 !important;
	    text-decoration: none !important; 
	}
</style>
<meta charset="UTF-8">
<title>지급 항목</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
	//페이지 로드 되자마자 실행
	var insertResult = "${insertResult}";
	
	$(function(){

		console.log("insertResult : " + insertResult);
	
		if(insertResult==1){
			Swal.fire({
				title:'등록 완료!', // Alert 제목
		  		icon:'success'   // Alert 타입
			});
		};
		
//////////////////////////////////////////////////////////////////////////

		//토글키 on,off이벤트
		
		// 토글 버튼 클릭 이벤트 핸들러
		$('.custom-control-input').on('change', function() {
	 	    var pdNo = $(this).attr('id'); // 토글 버튼의 id 값을 가져옴
	 	    var isChecked = $(this).prop('checked'); // 토글 버튼의 상태 (체크 여부) 가져옴
	 	    let ptNo = "${param.ptNo}";
	 	    console.log("pdNo : " + pdNo);
	 	    console.log("ptNo : " + ptNo);
	 	    console.log("isChecked : " + isChecked);
	 	    
	 	    var toggleData = {"pdNo":pdNo, "isChecked":isChecked, "ptNo":ptNo }; // 서버에 전달할 데이터 (ptNo 추가)
	 	    //toggleData : {"pdNo":"3","isChecked":true,"ptNo":"2"}
	 	    console.log("toggleData : " + JSON.stringify(toggleData));
		    
		    // Ajax 요청을 서버로 보냄
	 	    $.ajax({
	 	        url: '/salary/togglePDItem', // 서버의 요청 처리 URL
	 	        contentType:"application/json;charset=utf-8",
	 	        type: 'post',  //입력, 삭제인데 위의 걸로 가능? 그럼 걍 post로 해야하나? 입력은 post, 삭제는 delete인데.....
	 	        data: JSON.stringify(toggleData), 
	 	        dataType:"text",
	 	        beforeSend:function(xhr){
	 			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	 			},
	 	        success: function(response) {
	 	            if (response == 'success') {
	 	                // 성공적으로 처리되면 console.log
	 	                console.log("템플릿 구성 추가/삭제 완료")
		                
	 	            } else {
	 	                // 실패 시 알림 표시
	 	               console.log("템플릿 구성  추가/삭제 실패")
	 	            }
	 	        },
	 	        error:function(xhr, status, error){
					console.log("code: " + xhr.status)
					console.log("message: " + xhr.responseText)
					console.log("error: " + error);
				}
	 	    });
		});
	
	})//$(function)끝
	
	/////////////////////////////////////////////////////////////////////
	//지급항목 삭제하기
	function deletePay(pThis){
		event.preventDefault(); // a tag 이동 막기
		
// 		console.log("$(pThis): ", $(pThis));
// 		var $button = $(pThis); // 클릭한 버튼을 jQuery 객체로 변환
// 		var $checkbox = $button.closest('.card').find('.custom-control-input'); // 부모 엘리먼트에서 체크박스 엘리먼트 찾기
// 	    var pdNo = $checkbox.attr('id'); // 체크박스의 id 속성 가져오기
		
 		var pdNo = $(pThis).closest('.row').find('.custom-control-input').attr('id');
		
		console.log("확인1:", $(pThis).closest('.row')[0]);
		
// 		console.log("pdNo 값 : " , pdNo);
		
		let AddedList = document.querySelector("#AddedList");
		let colmd3Div = $(pThis).closest(".col-md-3")[0];
		
		let data = {"pdNo" : pdNo}; //ptNo를 클릭한 애의 위치로 찾아서 변수에 담아야 함!
		
		$.ajax({
			url: "/salary/payDelete", 
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
					AddedList.removeChild(colmd3Div);
				}
			
			},
			error:function(xhr, status, error){
				console.log("code: " + xhr.status)
				console.log("message: " + xhr.responseText)
				console.log("error: " + error);
			}
		});
	}
	
	//////////////////////////////////////////////////////////////////
	
	//지급항목 추가 화면으로 이동
	function addPay() {
		location.href = "/salary/payInsert?ptNo=${param.ptNo}";
	}//addPay()끝
	
	/////////////////////////////////////////////////////////////////////////////////
	//result값이 넘어오면 1이면 등록성공 alert, 0이면 등록 실패 alert 띄우기
	//insert 성공 여부 결과 alert창 출력
	var insertRes = "${insertRes}"; //EL변수 -> J/S변수 받으려면 이렇게 해야함
	
	if (insertRes == "insert 성공") {
	    Swal.fire({
	    	title: '등록 성공',
	    	icon : 'success'
	    });
	} else if (insertRes == "insert 실패") {
		Swal.fire({
	    	title: '등록 실패',
	    	icon : 'error'
	    });
	}
	
	//update 성공 여부 결과 alert창 출력
	var updateRes = "${updateRes}";
	
	if (updateRes == "update 성공") {
	    Swal.fire({
	    	title: '수정 성공',
	    	icon : 'success'
	    });
	} else if (updateRes == "update 실패") {
		Swal.fire({
	    	title: '수정 실패',
	    	icon : 'error'
	    });
	}
	
	
//////////////////////////////////////////////////////////
</script>
</head>
<body>

	<h5 style="margin-left:25px;">
		<a href="/salary/tmpList" class="aTag"><span class="fe fe-24 fe-chevron-left"></span></a>&nbsp
		<a href="/salary/tmpList" class="aTag">정산템플릿 설정</a>
	</h5>
	<hr>
	<h5 style="margin-left:25px;">
		<a href="/salary/tmpUpdate?ptNo=${param.ptNo}" class="aTag gray-link">기본 설정</a>&nbsp;&nbsp; 
		<a href="/salary/payList?ptNo=${param.ptNo}" class="aTag">지급 항목</a>&nbsp;&nbsp; 
		<a href="/salary/dedList?ptNo=${param.ptNo}" class="aTag gray-link">공제 항목</a>
	</h5>
	<hr>

	<button type="button" class="btn mb-2 btn-outline-primary"
		style="float: right; margin-bottom: 60px;" onclick="addPay()">
		+ 지급항목 추가</button>
	<br>
	<br>

	<div style="position: relative;">
		<div class="mb-4" style="width: 7%">법정필수 항목</div>
		<hr class="secondary"
			style="position: absolute; top: 50%; right: 0; width: 93%; margin-top: 0;">
	</div>

	<!-- 토글키 새로 추가할때마다 id 다르게 부여해야 함!! -->
	<!-- /////////////// 법정필수 항목 시작 ////////////////////////// -->
	
	<div id="MandatoryList" class="row"> <!-- 결과값 넣을 div -->
		
		<c:forEach var="lawPay" items="${LawPayList}" varStatus="stat">
			<div class="col-md-3">
				<div class="card shadow mb-4">
					<div class="card-body text-center">
						<div class="card-text my-2 ml-1 mr-1 row justify-content-between">
							<div>
								<strong class="card-title my-0">${lawPay.pdNm} </strong>
							</div>
								<div class="custom-control custom-switch">
									<input type="checkbox" class="custom-control-input lawPd"
										id="${lawPay.pdNo}"> 
									<label class="custom-control-label" for="${lawPay.pdNo}"></label>
								</div>
						</div>
						<br /> <br />
						<div class="text-left">
							<span class="badge badge-pill badge-danger bg-danger-dark">
								법정필수
<%-- 								<c:if test="${lawPD.pdLawYn=='B0101'}">법정필수</c:if> --%>
<%-- 								<c:if test="${lawPD.pdLawYn!='B0101'}">기타수당</c:if>  --%>
							</span>
						</div>
					</div>
					<!-- ./card-text -->
				</div>
			</div>
		</c:forEach>
	</div>
	<!-- /////////////// 법정필수 항목 끝 ////////////////////////// -->

	<br />
	<br />
	<div style="position: relative;">
		<div class="mb-4" style="width: 7%">추가한 항목</div>
		<hr class="secondary"
			style="position: absolute; top: 50%; right: 0; width: 93%; margin-top: 0;">
	</div>
	
	<!-- /////////////// 추가한 항목 시작 ////////////////////////// -->
	<div id="AddedList" class="row">
		<!-- 결과값 넣을 div -->
		
		<c:forEach var="AddedPay" items="${AddedPayList}" varStatus="stat">
		
		<div class="col-md-3">
			<div class="card shadow mb-4">
				<div class="card-body" style="height: 200px;">
					<div
						class="card-text ml-1 mr-1 mb-4 row justify-content-between">
						<div>
							<strong class="card-title my-0"> ${AddedPay.pdNm} </strong>
						</div>
						<div class="row">

							<div class="custom-control custom-switch mr-3">
								<input type="checkbox" class="custom-control-input"
									id="${AddedPay.pdNo}"> 
								<label class="custom-control-label" for="${AddedPay.pdNo}"></label>
							</div>

							<div class="file-action mr-3">
								<button type="button"
									class="btn btn-link dropdown-toggle more-vertical p-0 text-muted mx-auto"
									data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">
									<span class="text-muted sr-only">Action</span>
								</button>
								<div class="dropdown-menu m-2">
									<a class="dropdown-item" href="/salary/payUpdate?ptNo=${param.ptNo}&pdNo=${AddedPay.pdNo}"> 
										<i class="fe fe-edit fe-12 mr-4"></i>지급항목 수정
									</a> 
									<a class="dropdown-item" href="#" onclick="deletePay(this)"> 
										<i class="fe fe-delete fe-12 mr-4"></i>지급항목 삭제
									</a>
								</div>
							</div>

						</div>
					</div>
					<div class="mt-2 mb-3">
						<strong><fmt:formatNumber type="number" value="${AddedPay.pdAmt}" pattern="#,###" />원</strong> <!-- 천단위 구분 -->
					</div>
					<div class="mt-3 mb-3" style="font-size: 0.8rem;">
						${AddedPay.pdEpn}
					</div>
<!-- 					<div class="mt-2 mb-2" style="font-size: 0.8rem;"> -->
<%-- <%-- 						<h4>확인용 : ${AddedPD.pdEpn}</h4> --%> 
<%-- 						<c:if test="${AddedPay.pdFml=='' || AddedPay.pdFml == null }">산출식 :&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp ━ </c:if> --%>
<%-- 						<c:if test="${AddedPay.pdFml!='' && AddedPay.pdFml != null}">산출식 : ${AddedPay.pdFml}</c:if> --%>
<!-- 					</div> -->
					<div class="text-left">
						<span class="badge badge-light text-muted mr-1 mt-2">
							기타수당
						</span> 
						<span class="badge badge-light text-muted mt-2">
							<c:if test="${AddedPay.pdTaxYn=='B0101'}">과세</c:if>
							<c:if test="${AddedPay.pdTaxYn!='B0101'}">비과세</c:if> 
						</span>
					</div>
				</div>
				<!-- ./card-text -->
			</div>
		</div>
		</c:forEach>
		<!-- .col -->

	</div>
	<!-- /////////////// 추가한 항목 끝 ////////////////////////// -->


<script>
$.ajax({
	url:"/salary/payListAjax",
	data :"ptNo="+"${param.ptNo}",
	type:"get",
	dataType:"json",
	success:function(result){
		console.log("result : ", result);
		
		for(let i=0; i<result.length; i++){
			$(`[id=\${result[i].pdNo}]`).prop("checked",true);
		}
	},
	error:function(xhr, status, error){
		console.log("code: " + xhr.status)
		console.log("message: " + xhr.responseText)
		console.log("error: " + error);
	}
});
	
</script>
</body>
</html>