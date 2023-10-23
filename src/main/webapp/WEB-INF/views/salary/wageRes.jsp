<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
div {
/*   	border: 1px solid blue;   */
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
#wageResTable td {
	white-space: nowrap; /* 텍스트 줄 바꿈 금지 */
	padding : 15px;
	padding-left : 40px;
	width : 600px;
	text-align : left;
}
.darkGray {
 	color : #343a40; 
	font-weight : bold;
 	font-size : 1.0rem; 
}
span {
	font-size: smaller;
}
h4 {
	margin : 0px;
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
						<img class="mt-2" src="/resources/images/salary/check.png">
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
					<h2 class="mb-2 page-title" style="display: inline-block;">정산을 완료했습니다 &nbsp;<img src="/resources/images/salary/success.png" style="margin-bottom: 10px;"></h2>
				</div>
				
				<div class="col-12 mb-4 mt-2" style="height:800px;overflow-y:auto">
				
					<div style="width: 70%;">	
						<div class="col-md-12" style="padding:0px;">
		                 	<div class="card shadow">
		                    	<div class="card-body" style="padding-left:70px;">
		                        	<div class="row">
		                        		<div id="left"">
				                    		<span class="badge badge-pill badge-secondary" style="font-size:smaller;margin-bottom:10px;margin-left:30px;margin-top:10px;">권한자</span><br>
				                        	<h5 class="card-title mb-3" style="display:inline-block;margin-left:30px;">정산결과 엑셀 다운로드</h5><br>
				                        	<button type="button" class="btn mb-2 btn-primary" style="margin-left:50px;" onclick="excelDown()">이체리스트 <img src="/resources/images/salary/download.png" style="height:12px;margin-bottom: 5px;"/></button><br>
		                        			<img style="width:250px;height:260px;margin-left:30px;" src="/resources/images/salary/salaryTransfer.png">
		                        		</div>
		                        		<div id="right" style="margin-left:190px;">
		                        			<div style="margin-top:30px;">
		                        				<p class="darkGray"><img src="/resources/images/salary/tax.png" style="margin-bottom:5px;">원천세 신고하기</p>
		                        				<p style="margin-bottom:50px;"><a href="https://www.hometax.go.kr" target="_blank" rel="noreferrer noopener" style="margin-right:20px;">홈택스</a> | <a href="https://www.wetax.go.kr" target="_blank" rel="noreferrer noopener" style="margin:20px;">위택스</a> | <a href="https://etax.seoul.go.kr" target="_blank" rel="noreferrer noopener" style="margin:20px;">ETAX</a></p>
		                        			</div>
		                        			<div>
		                        				<p class="darkGray"><img src="/resources/images/salary/health-insurance.png" style="margin-bottom:5px;width:20px;">사회보험 신고하기</p>
		                        				<p style="margin-bottom:50px;"><a href="https://edi.nhis.or.kr" target="_blank" rel="noreferrer noopener" style="margin-right:20px;">건강보험EDI</a> | <a href="https://total.comwel.or.kr" target="_blank" rel="noreferrer noopener" style="margin:20px;">고용·산재 토탈서비스</a></p>
		                        			</div>
		                        			<div>
		                        				<p class="darkGray"><img src="/resources/images/salary/salaryDownload.png" style="width:20px;">급여자료 다운로드</p>
		                        				<p style="margin-bottom:20px;"><a href="/salary/pastPayroll" style="margin-right:20px;">지난 정산 내역 →</a></p>
		                        			</div>
		                        		</div>
		                        	</div>
						  		</div>
		                  	</div>
		                </div>
					</div>
					<!-- ////////////// 요약 시작 //////////////////////////// -->
					<div style="width: 70%;">
					
						<div class="col-md-12 mt-4" style="padding:0px;">
		                  <div class="card shadow">
		                    <div class="card-body">
		                      <h5 class="card-title mb-3">급여대장 요약</h5>
		                      <table id="wageResTable" class="table table-hover mb-0">
		               			<c:set var="scSummary" value="${SCSummary}" />		
		               			<tr>
		               				<td>
		               					<p class="mb-3 darkGray">지급일</p>
		               					<p><h4>${scSummary.prPdateMth}월 ${scSummary.prPdateDay}일 &nbsp;<span class="badge badge-pill badge-secondary">${scSummary.prPdateWeekday}</span></h4></p>
		               					<span>지난 정산</span>
		               				</td>
		               				<td>
		               					<c:set var="wageEmpCnt" value="${empCnt}" />	
		               					<p class="mb-3 darkGray">정산대상자</p>
		               					<p><h4>${wageEmpCnt}명</h4></p>
		               					<span>지난 정산</span>
	               					</td>
		               				<td>
		               					<p class="mb-3 darkGray">정산완료일</p>
		               					<p><h4>${scSummary.prFdateMth}월 ${scSummary.prFdateDay}일</h4></p>
		               					<span>지난 정산</span>
		               				</td>
		               			</tr>
		               			<tr>
		               				<td>
		               					<p class="mb-3 darkGray">지급 계</p>
		               					<p><h4><fmt:formatNumber value="${scSummary.sumPytlAmt}" pattern="#,###" />원</h4></p>
		               					<span>지난 정산</span>
	               					</td>
		               				<td>
		               					<p class="mb-3 darkGray">공제 계</p>
		               					<p><h4><fmt:formatNumber value="${scSummary.sumDdtlAmt}" pattern="#,###" />원</h4></p>
		               					<span>지난 정산</span>
		               				</td>
		               				<td>
		               					<p class="mb-3 darkGray">실지급액</p>
		               					<p><h4><fmt:formatNumber value="${scSummary.sumNetAmt}" pattern="#,###" />원</h4></p>
		               					<span>지난 정산</span>
	               					</td>
		               			</tr>
		                      </table>
		                    </div>
		                  </div>
		                </div>	
					</div>
						
					<!-- ////////////// 요약 끝 //////////////////////////// -->
					
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
	console.log ("ptNo", ptNo);
	console.log ("prYr", prYr);
	console.log ("prMth", prMth);
	
	var DetailsTR = $("#wageDetailsTable tbody tr");
	
	console.log("DetailsTR : ", DetailsTR);
	
	//이체리스트 엑셀 다운로드
	function excelDown(){
		
		let data = {
						"ptNo" : ptNo,
						"prYr" : prYr,
						"prMth" : prMth
					}
		
		$.ajax({
				url : "/salary/excelDownPayroll",
				contentType : "application/json;charset=UTF-8",
				data : JSON.stringify(data),
			    xhrFields: {
			        responseType: "blob",
			    },
				type : "post",
			//	dataType : "text",
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token);
		    	},
				success : function(result){
					console.log("ppp",result);
					
					//var blob = new Blob([result], { type: "application/octetstream" });
				    var downloadUrl = URL.createObjectURL(result);
			        var a = document.createElement("a");
			            a.href = downloadUrl;
			            a.download = "salaryCert.xlsx";
			            document.body.appendChild(a);
			            a.click();
					//console.log("result : ", blob);
					
				},
				error:function(xhr, status, error){
				    console.log("code: " + xhr.status)
				    console.log("message: " + xhr.responseText)
				    console.log("error: " + error);
				}
			
		})//ajax
	}
	
	
	
</script>

</body>
</html>