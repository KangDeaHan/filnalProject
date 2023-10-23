<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
div {
/* 	border: 1px solid blue; */
}

#steps {
	display: flex;
	height: 900px;
}

.step {
		display : flex;
		margin-bottom : 15px;
		margin-top : 15px;
	}

/* 테이블 전체 스타일 지정 */
table {
	border-collapse: collapse;
	width: 100%;
}

table tbody {
	height : 70%;
	overflow-y : auto;
}

/* 테이블 헤더 스타일 지정 */
.table thead th { 
 	background-color: #f2f2f2; 
 	text-align: center; 
 	color: #343a40 !important;
 	font-weight : bold !important;
/* 	padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */ 
 	border: 1px solid #ddd; /* 테두리 스타일 지정 */ 
/* 	height: 30px; */
 } 

/* 테이블 데이터 셀 스타일 지정 */
td {
	text-align: center;
	padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
	border: 1px solid #ddd; /* 테두리 스타일 지정 */
}

.nav-link {
	display: block;
	padding: 0.5rem 1rem;
}

.nav-link:hover, .nav-link:focus {
	text-decoration: none;
}

.nav-link.disabled {
	color: #6c757d;
	pointer-events: none;
	cursor: default;
}
.table-container {
  width: 1190px; /* 원하는 너비로 설정 */
  overflow-x: auto; /* 가로 스크롤이 필요한 경우 스크롤이 나타나도록 설정 */
}
#wageDetailsTable th {
	white-space: nowrap; /* 텍스트 줄 바꿈 금지 */
	padding-right : 20px;
	padding-left : 20px;
}
#wageDetailsTable td {
	white-space: nowrap; /* 텍스트 줄 바꿈 금지 */
	padding-right : 20px;
	padding-left : 20px;
}
</style>
<meta charset="UTF-8">
<title>정산하기 - 결과 미리보기</title>
</head>
<body>

<div id="steps">

	<div id="Aside" class="mr-3" style="width:10%;">
		<div style="margin-bottom:10px;">
			${SCVO.prStlNm}<br>
			지급일 ${SCVO.prPdate}
		</div>
		<div>
			<span class="badge badge-pill badge-success">근로소득</span> 
		</div>
		<div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/check.png">
					</div>
					<div>
						<strong>Step1<br> 정산대상자</strong>
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/check.png">
					</div>
					<div>
						Step2<br> 지급 항목
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/check.png">
					</div>
					<div>
						Step3<br> 공제 항목
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/result.png">
					</div>
					<div>
						Step4<br> 결과 미리보기
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/red-flag.png">
					</div>
					<div>
						Step5<br> 정산 완료
					</div>
				</div>
			</div>
	</div>
		<!-- ------------------------------------------------------------------------------------------------------------------------------------------>

		<div id="Bside" style="width: 90%;">

			<div class="row justify-content-center">
				<div class="col-12"
					style="margin-left: 0px; margin-right: 0px; margin-bottom: 10px;">
					<p class="card-text">${ptNm}
						/ <strong>${SCVO.prStlNm}</strong>
					</p>
					<h2 class="mb-2 page-title" style="display: inline-block">결과 미리보기</h2>
					<button id="wageFinBtn" onclick="wageFinAjax()" type="button"
						class="btn btn-success"
						style="float: right; color: white; margin-right: 145px;"> → 정산완료 </button>
				</div>
				
				<div class="mb-4" id="scroll" style="margin-right:130px;">
					<div class="card shadow">
						<div class="card-body" style="width: 1300px; height: 750px;"> <!-- height : 750 적당했음. -->
							<ul class="nav nav-pills nav-fill mb-4" id="pills-tab"
								role="tablist" style="width: 30%">
								<li class="nav-item itemNames"><a class="nav-link active" id="pills-etc-tab"
									data-toggle="pill" href="#pills-etc" role="tab" style="width:200px;"
									aria-controls="pills-etc" aria-selected="false">상세내역</a></li>
							</ul>
								<!-- ////////////// 상세내역 시작 //////////////////////////// -->
								<div class="tab-pane fade active show" id="pills-etc" role="tabpanel"
									aria-labelledby="pills-etc-tab">
								
								<div class="col-md-12 my-4">
					                  <div class="card shadow">
					                    <div class="card-body">
					                      <h5 class="card-title mb-3" style="display:inline-block">대상자</h5>
					                      <div class="table-container">
						                      <table id="wageDetailsTable" class="table table-bordered table-hover mb-0">
						                      
						                        <thead>
						                           <tr>
						                            	<th rowspan="2">사번</th>
							                            <th rowspan="2">이름</th>
							                            <th rowspan="2">계약유형</th>
							                            <th rowspan="2">조직</th>
							                            <th rowspan="2">직위</th>
							                            <th rowspan="2">직책</th>
							                            <th rowspan="2">직무</th>
							                            <th rowspan="2">재직상태</th>
							                            <th colspan="${payCount+1}">지급</th> <!-- 가로길이의 수 :  -->
							                            <th colspan="${dedCount+1}">공제</th>
							                            <th rowspan="2">실지급액</th>
						                          </tr>
						                          
						                          <tr>
						                          
						                          	<c:set var="empPayList" value="${empPayHList[0]}" />	
							                      	<c:forEach var="payVO" items="${empPayList}">	
						                          		<th>${payVO.pdNm}</th>
					                          	  	</c:forEach>
						                          	<th>계</th>
						                          	
						                          	<c:set var="empDedList" value="${empDedHList[0]}" />	
							                      	<c:forEach var="dedVO" items="${empDedList}">	
						                          		<th>${dedVO.pdNm}</th>
					                          	  	</c:forEach>
						                          	<th>계</th>
						                          </tr>
						                        </thead>
						                        
						                        <tbody>
						                        	<c:forEach var="empInfo" items="${empInfoList}" varStatus="stat">
							                          <tr>
							                            <td>${empInfo.empNo}</td>
							                            <td>${empInfo.empNm}</td>
							                            <td>${empInfo.ctrtCaseNm}</td>
							                            <td>${empInfo.deptVOList.dnm}</td>
							                            <td>${empInfo.ptnCodeNm}</td>
							                            <td>${empInfo.dtCodeNm}</td>
							                            <td>${empInfo.jcodeNm}</td>
							                            <td>${empInfo.stClfCdNm}</td>
													
														<c:forEach var="payVO" items="${empInfo.payHistoryVO}" varStatus="status">
															<td><fmt:formatNumber value="${payVO.pdAmt}" pattern="#,###" /></td>
														</c:forEach>
														
														<td><strong id="paySum"><fmt:formatNumber value="${empInfo.paySum}" pattern="#,###" /></strong></td>
														
														<c:forEach var="dedVO" items="${empInfo.dedHistoryVO}" varStatus="status">
															<td><fmt:formatNumber value="${dedVO.pdAmt}" pattern="#,###" /></td>
														</c:forEach>
														
														<td><strong id="dedSum"><fmt:formatNumber value="${empInfo.dedSum}" pattern="#,###" /></strong></td>
														
														<td><strong id="netAmt"><fmt:formatNumber value="${empInfo.paySum-empInfo.dedSum}" pattern="#,###" /></strong></td>
							                          </tr>
						                        	</c:forEach>
						                
						                        </tbody>
						                        
						                      </table>
						                	</div><!-- tableContainer 끝 -->      
					                    </div>
					                  </div>
					                </div>	
					                
								</div>
								<!-- ////////////// 상세내역 끝 //////////////////////////// -->
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<!-- bside -->

	</div>
	<!-- steps -->

<script>
	
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	
	var ptNo = "${SCVO.ptNo}";
	var prYr = "${SCVO.prYr}";
	var prMth = "${SCVO.prMth}";
	
	var DetailsTR = $("#wageDetailsTable tbody tr");
	
	console.log("DetailsTR : ", DetailsTR);
	
//////////////////////////////////////////////////////////////////////////////////	
	function wageFinAjax(){ //버튼 클릭시 ajax로 데이터 보내기 (지급총액, 공제총액, 실지급액 update 수행)
		
		
		//지급총액, 공제총액, 실지급액 update (ajax)  
		DetailsTR.each(function(idx, item){
				
			var empNo = $(item).find("td:eq(0)").text(); // 각 <tr>에서 첫 번째 <td>의 텍스트를 가져옴.
			console.log("empNo : ", empNo);
			
			var paySumText = $(item).find("#paySum").text();
			var dedSumText = $(item).find("#dedSum").text();
			var netAmtText = $(item).find("#netAmt").text();
			 
			console.log("paySum : ", paySumText);
			console.log("dedSum : ", dedSumText);
			console.log("netAmt : ", netAmtText);
			 
			// 천단위 구분기호(쉼표)를 제거하고 문자열을 숫자로 변환
			var pytlAmt = parseInt(paySumText.replace(/,/g, ''), 10);
			var ddtlAmt = parseInt(dedSumText.replace(/,/g, ''), 10);
			var netAmt = parseInt(netAmtText.replace(/,/g, ''), 10);

			console.log("pytlAmt : " + pytlAmt);
			console.log("ddtlAmt : " + ddtlAmt);
			console.log("netAmt : " + netAmt);
			 
			var data = {
						"empNo" : empNo,
						"ptNo" : ptNo,
						"prYr" : prYr,
						"prMth" : prMth,
						"pytlAmt" : pytlAmt,
						"ddtlAmt" : ddtlAmt,
						"netAmt" : netAmt
						};
			console.log("data : ", data);
			
			//지급총액, 공제총액, 실지급액 update
			$.ajax({
				url:"/salary/updateFinalAmt",
				contentType:"application/json;charset=UTF-8",
				data:JSON.stringify(data),
				type:"put",
				dataType:"text",
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token);
		    	},
				success:function(result){
					console.log("result : ", result);
					
					const Toast = Swal.mixin({
					      toast: true,
					      position: 'center-center',
					      showConfirmButton: false,
					      timer: 1000,
					      timerProgressBar: true,
					      didOpen: (toast) => {
					        toast.addEventListener('mouseenter', Swal.stopTimer)
					        toast.addEventListener('mouseleave', Swal.resumeTimer)
					      } 
					    })

					    Toast.fire({
					      icon: 'success',
					      title: '정산이 완료되었습니다.'
					    }).then(function () {
			                // 토스트가 보여진 후 이동할 URL 설정
					        location.href = "/salary/wageRes";
			            });
				},
				error:function(xhr, status, error){
				    console.log("code: " + xhr.status)
				    console.log("message: " + xhr.responseText)
				    console.log("error: " + error);
				}
			});//ajax끝
				
		});//DetailsTR 끝
		
	}//전체 function 끝
</script>

</body>
</html>