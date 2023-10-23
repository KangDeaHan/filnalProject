<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	 
	.gray-link {
	    color: #CDD1D5 !important;
	    text-decoration: none !important; 
	}

	div{
/* 		border: 1px solid blue; /* 항상 레이아웃을 눈으로 보면서 */ 
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
	.template {
	 	width: 200px; /* 너비 지정 */
        height: 200px; /* 높이 지정 */
        background-color: #3498db; /* 배경색 지정 */
        color: #fff; /* 텍스트 색상 지정 */
        text-align: center; /* 텍스트 가운데 정렬 */
        line-height: 200px; /* 수직 가운데 정렬 */
	}
</style>
<meta charset="UTF-8">
<title>정산 템플릿 목록</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
	
	//정산템플릿 삭제하기
	function deleteTmp(pThis){
		event.preventDefault(); // a tag 이동 막기
		
		console.log("$(pThis): ", $(pThis));
		
		var ptNoValue = $(pThis).closest('.card-body').children("[name=ptNo]").val();
		console.log("ptNoValue : " , ptNoValue);
		
		let rowList = document.querySelector("#rowList");
		let colmd3Div = $(pThis).closest(".col-md-3")[0];
		
		let data = {"ptNo" : ptNoValue}; //ptNo를 클릭한 애의 위치로 찾아서 변수에 담아야 함!
		
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
					rowList.removeChild(colmd3Div);
				}
			
			},
			error:function(xhr, status, error){
				console.log("code: " + xhr.status)
				console.log("message: " + xhr.responseText)
				console.log("error: " + error);
			}
		});
	}
	
	//북마크이미지변경 ////////////////////////////////////////////////////////////////////////
	function fImgChg(pThis){
		event.preventDefault(); // a tag 이동 막기
		
		console.log("dom",pThis);
		console.log("jQuery",$(pThis));

		var img = pThis.children[0]; // 이미지 엘리먼트 가져오기
		var ptNoValue = $(pThis).closest('.card-body').children("[name=ptNo]").val();
		console.log("ptNoValue: ",ptNoValue);
		console.log("img: ",img);
		
	    // 현재 이미지의 src 속성을 확인하여 red 또는 gray로 변경
	    if (img.src.endsWith("gray.png")) {
	    	// 데이터 변경
			updateBmkStatus(ptNoValue, img, "B0101"); // 북마크 상태를 Y("B0101")로 변경			
	    } else {
	    	// 데이터 변경
			updateBmkStatus(ptNoValue, img, "B0102"); // 북마크 상태를 N("B0102")으로 변경			
	    }
			
	}
	
	function updateBmkStatus(ptNoValue, img, newStatus){
		// AJAX 요청을 통해 서버로 북마크 상태 업데이트 요청 보내기
		
		console.log("img넘어왔닝?: ",img);
		
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
					if(result=="B0101"){
 						img.src = "/resources/images/salary/bookmark_red.png";
					}else{
 						img.src = "/resources/images/salary/bookmark_gray.png";
					}
				}
			},
			error:function(xhr, status, error){
				console.log("code: " + xhr.status)
				console.log("message: " + xhr.responseText)
				console.log("error: " + error);
			}
    	});
	}

	function addTmp() {
		location.href = "/salary/tmpInsert";
	}//addTmp()끝
	
	$(function(){
		const rowList = $("#rowList");	 // 결과를 추가할 div
		var str = "";
		
		$.ajax({
			
			url:"/salary/tmpListAjax",
			type:"get",
			dataType:"json",
			success:function(data){
				console.log("data:", data);
				
				
				$.each(data, function(index, item){ //item에 payTplVO 들어있음
					console.log(item);
					//console.log("index : " + index + ", str : " + JSON.stringify(str));
					
					//백틱이 있으면  달러 중괄호(EL표현) 앞에 \를 붙여야 한다.
					str+=` 
						<div class="col-md-3">
							<div class="card shadow mb-4">
								<div class="card-body text-center">
								
									<input type="hidden" name="ptNo" value="\${item.ptNo}" />
									
									<div class="row align-items-center justify-content-end">
										
										<div class="row align-items-center" style="margin-right:20px;">
											<div>`;
											
											if(item.ptBmkYn=="B0102"){
												str+=`<a href="#" style="margin-right: 10px;" onclick='fImgChg(this)'><img src="/resources/images/salary/bookmark_gray.png" /></a>`;											
											}else{
												str+=`<a href="#" style="margin-right: 10px;" onclick='fImgChg(this)'><img src="/resources/images/salary/bookmark_red.png" /></a>`;
											}
											
											str+=`</div>
										
											<div class="col-auto" style="padding: 0px;">
												<div class="file-action">
													<button type="button"
														class="btn btn-link dropdown-toggle more-vertical p-0 text-muted mx-auto"
														data-toggle="dropdown" aria-haspopup="true"
														aria-expanded="false">
														<span class="text-muted sr-only">Action</span>
													</button>
													<div class="dropdown-menu m-2">
														<a class="dropdown-item" href="/salary/tmpUpdate?ptNo=\${item.ptNo}">
															<i class="fe fe-edit fe-12 mr-4"></i>템플릿 수정하기</a> 
														<a class="dropdown-item" href="#" onclick="deleteTmp(this)">
															<i class="fe fe-delete fe-12 mr-4"></i>템플릿 삭제하기</a>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="card-text my-2">
										<strong class="card-title my-0">\${item.ptNm}</strong><br>
									</div>
										
									<div>
										<p class="small text-dark mb-0">\${item.ptEpn}</p>
									</div>
								</div>
								<!-- ./card-text -->
								<div class="card-footer" style="border-top:0px;">
									<div class="row align-items-center">
										<div class="col-auto">
											<span class="badge badge-pill badge-success">근로소득</span> 
										</div>
									</div>
								</div>
							</div>  
						</div>
					`;
					
					
				}); //$.each 끝
				
				rowList.html(str);

				
			}, //success 끝
			error:function(xhr, status, error){
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
			}
		});//ajax끝
		
	});//$(function()) 끝
</script>
</head>
<body>



<div id="container"> <!--wrapper-->
		<div id="header1">
			<div id="header2">
			
				<div id="header3">
					<h1><a href="/salary/home" class="aTag"  style="margin-left: 25px;">급여정산</a>&nbsp;&nbsp; <a href="#" class="gray-link">퇴직소득</a>&nbsp;&nbsp;</h1>
					<h1><a href="/salary/dataManagement" class="aTag gray-link">자료관리</a></h1>
				</div>
			</div>
			<hr>
				<div id="header3">
					<h4 style="margin-bottom: 2px;">
							<a href="/salary/home" class="aTag gray-link" style=" margin-left: 25px;">홈</a>&nbsp;&nbsp; 
							<a href="/salary/pastPayroll" class="aTag gray-link">지난 정산 내역</a>&nbsp;&nbsp; 
							<a href="/salary/tmpList" class="aTag">정산템플릿 목록</a>
					</h4>
				</div>
		
		</div>
		<hr>
	
	
	
	<button id="addTmp" type="button" class="btn mb-2 btn-primary" style="float:right;" onclick="addTmp()">+ 정산템플릿 추가</button>
	<br><br>
	
<!-- --------------------------------------------------------------------------------------------- -->
	<div id="rowList" class="row align-items-center" style="margin: 0px;">
		
	</div>	<!--전체 row 끝-->

</div>

</body>
</html>