<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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
	width: 15%;
	display: flex;
	align-items: center;
}

.inputConts {
	width: 85%;
}

label {
	margin: 0px;
}

.modal-content {
	margin: auto;
	width: 500px;
	height: 400px;
}

.modal-dialog {
	max-width: none;
}

#modalbody {
	width: 80%;
}

footer {
	float: right;
	position: relative;
}

#footer {
	width: 70%;
}

#modalbody22 {
	padding: 50px 15% 50px;
	width: 100%;
}

.paddingbody {
	padding: 50px 15% 50px;
}

/* 새모달 */
#cardBody {
	position: fixed;
	top: 0;
	left: 35%;
	width: 222mm;
	height: 247mm;
	overflow: auto;
}

#newbody {
	width: 100%;
	height: 100% overflow: auto;
}

/*드롭다운*/
#searchResults {
	position: absolute;
	z-index: 1;
	opacity: 1;
	background: white;
	width: 100%;
}

#searchResults :hover {
	background: silver;
}

#searchResults2 {
	position: absolute;
	z-index: 1;
	opacity: 1;
	background: white;
	width: 100%;
}

#searchResults2 :hover {
	background: silver;
}

.dropdown-content {
	display: none;
	max-height: 150px; /* 드롭다운 최대 높이 설정 */
	overflow-y: auto; /* 스크롤바 추가 */
	border: 1px solid #ddd;
}

#name, #name2 {
	color: black;
	font-weight: bold;
}

#cList {
	width: 100%;
	height: 100px;
	border: 1px #dee2e6 solid;
	max-height: 100px;
	overflow-y: auto;
}

.radio {
	display: inline-block;
	padding: 0px 10px 0px 0px;
}

#reasen {
	width: 100%;
}


/* <!-- 한글css --> */
body {margin:0;padding-left:0;padding-right:0;padding-bottom:0;padding-top:0mm;}
.hce {margin:0;padding:0;position:absolute;overflow:hidden;}
.hme {margin:0;padding:0;position:absolute;}
.hhe {margin:0;padding:0;position:relative;}
.hhi {display:inline-block;margin:0;padding:0;position:relative;background-size:contain;}
.hls {margin:0;padding:0;position:absolute;}
.hfS {margin:0;padding:0;position:absolute;}
.hcD {margin:0;padding:0;position:absolute;}
.hcI {margin:0;padding:0;position:absolute;}
.hcS {margin:0;padding:0;position:absolute;}
.hfN {margin:0;padding:0;position:relative;}
.hmB {margin:0;padding:0;position:absolute;}
.hmO {margin:0;padding:0;position:absolute;}
.hmT {margin:0;padding:0;position:absolute;}
.hpN {display:inline-block;margin:0;padding:0;position:relative;white-space:nowrap;}
.htC {display:inline-block;margin:0;padding:0;position:relative;vertical-align:top;overflow:hidden;}
.haN {display:inline-block;margin:0;padding:0;position:relative;}
.hdu {margin:0;padding:0;position:relative;}
.hdS {margin:0;padding:0;position:absolute;}
.hsC {margin:0;padding:0;position:absolute;}
.hsR {margin:0;padding:0;position:absolute;}
.hsG {margin:0;padding:0;position:absolute;}
.hsL {margin:0;padding:0;position:absolute;}
.hsT {margin:0;padding:0;position:absolute;overflow:hidden;}
.hsE {margin:0;padding:0;position:absolute;overflow:hidden;}
.hsA {margin:0;padding:0;position:absolute;overflow:hidden;}
.hsP {margin:0;padding:0;position:absolute;overflow:hidden;}
.hsV {margin:0;padding:0;position:absolute;overflow:hidden;}
.hsO {margin:0;padding:0;position:absolute;}
.hsU {margin:0;padding:0;position:absolute;overflow:hidden;}
.hpi {margin:0;padding:0;position:absolute;}
.hch {margin:0;padding:0;position:absolute;}
.hcG {margin:0;padding:0;position:absolute;}
.heq {margin:0;padding:0;position:absolute;}
.heG {margin:0;padding:0;position:absolute;}
.htA {margin:0;padding:0;position:absolute;}
.hvi {margin:0;padding:0;position:absolute;}
.htb {margin:0;padding:0;position:absolute;}
.htG {margin:0;padding:0;position:absolute;}
.hfJ {margin:0;padding:0;position:absolute;}
.hfG {margin:0;padding:0;position:absolute;}
.hfB {margin:0;padding:0;position:absolute;}
.hfR {margin:0;padding:0;position:absolute;}
.hfC {margin:0;padding:0;position:absolute;}
.hfO {margin:0;padding:0;position:absolute;}
.hfL {margin:0;padding:0;position:absolute;}
.hfM {margin:0;padding:0;position:absolute;}
.hfE {margin:0;padding:0;position:absolute;}
.hpl {margin:0;padding:0;position:absolute;}
.hs {margin:0;padding:0;position:absolute;overflow:visible;}
.hpa {position:relative;padding:0;overflow:hidden;margin-left:2mm;margin-right:0mm;margin-bottom:2mm;margin-top:2.5mm;border:1px black solid;box-shadow:1mm 1mm 0 #AAAAAA;}
.hpa::after {content:'';position:absolute;margin:0;padding:0;left:0;right:0;top:0;bottom:0;background-color:white;z-index:-2;}
.hrt {display:inline-block;margin:0;padding:0;position:relative;white-space:inherit;vertical-align:middle;line-height:1.1;}
.hco {display:inline-block;margin:0;padding:0;position:relative;white-space:inherit;}
.hcc {margin:0;padding:0;position:absolute;}
.hls {clear:both;}
[onclick] {cursor:pointer;}
.cs0 {font-size:10pt;color:#000000;font-family:"함초롬돋움";}
.cs1 {font-size:9pt;color:#000000;font-family:"함초롬돋움";}
.cs2 {font-size:9pt;color:#000000;font-family:"함초롬바탕";}
.cs3 {font-size:9pt;color:#000000;font-family:"함초롬돋움";letter-spacing:-0.03em;}
.cs4 {font-size:16pt;color:#2E74B5;font-family:"함초롬돋움";}
.cs5 {font-size:11pt;color:#000000;font-family:"함초롬돋움";}
.cs6 {font-size:10pt;color:#000000;font-family:"함초롬바탕";}
.cs7 {font-size:8pt;color:#000000;font-family:"함초롬바탕";}
.cs8 {font-size:6pt;color:#000000;font-family:"함초롬바탕";}
.cs9 {font-size:4pt;color:#000000;font-family:"함초롬바탕";}
.cs10 {font-size:1pt;color:#000000;font-family:"함초롬바탕";}
.ps0 {text-align:justify;}
.ps1 {text-align:justify;}
.ps2 {text-align:justify;}
.ps3 {text-align:justify;}
.ps4 {text-align:justify;}
.ps5 {text-align:justify;}
.ps6 {text-align:justify;}
.ps7 {text-align:justify;}
.ps8 {text-align:justify;}
.ps9 {text-align:justify;}
.ps10 {text-align:justify;}
.ps11 {text-align:left;}
.ps12 {text-align:left;}
.ps13 {text-align:left;}
.ps14 {text-align:left;}
.ps15 {text-align:left;}
.ps16 {text-align:justify;}
.ps17 {text-align:justify;}
.ps18 {text-align:justify;}
.ps19 {text-align:center;}
.ps20 {text-align:right;}
@media print {
.hpa {margin:0;border:0 black none;box-shadow:none;}
body {padding:0;}

}



</style>

<meta charset="UTF-8">
<title>급여정산 홈</title>

</head>
<body>

	<div id="container">
		<!--wrapper-->
		<div id="header1">
			<div id="header2">
			
				<div id="header3">
					<h1><a href="/salary/home" class="aTag gray-link" style="margin-left: 25px;">급여정산</a>&nbsp;&nbsp; <a href="#" class="gray-link">퇴직소득</a>&nbsp;&nbsp;</h1>
					<h1><a href="/salary/dataManagement" class="aTag" >자료관리</a></h1>
				</div>
			</div>
			<hr>
				<div id="header3">
					<h4 style="margin-bottom: 2px;"><a class="aTag" style=" margin-left: 25px;" href="/salary/dataManagement">증명서 발급</a>&nbsp;&nbsp;</h4>
				</div>
		
		</div>
		<hr>


		<div id="bmkList" class="row align-items-center"
			style="margin: 30px; margin-top: 50px;">


			<div class="col-md-3">
				<div class="card shadow mb-4">
					<div class="card-body text-center">


						<div class="card-text my-2 mt-3">
							<strong class="card-title my-0" style="float: left;">급여
								명세서</strong><br>
						</div>

						<div class="row align-items-center justify-content-between"
							style="width: 330px; margin-left: 4px;">
							<div>
								<span class="badge badge-pill badge-success">근로소득</span>
							</div>
						</div>

					</div>
					<!-- ./card-text -->
					<div class="card-footer" style="border-top: 0px; padding-top: 0px;">
						<div class="row align-items-center">
							<div class="col-auto">
								<button type="button" class="btn mb-2 btn-primary"
									data-toggle="modal" data-target="#salaryModal"
									style="color: white; vertical-align: middle;"
									> <!-- onclick="fStart(this)" -->
									<span class="fe fe-24 fe-arrow-down-circle"
										style="vertical-align: middle;"></span> 발급하기
								</button>
							</div>
						</div>
					</div>
					<!-- /.card-footer -->
				</div>
			</div>
			<div class="col-md-3">
				<div class="card shadow mb-4">
					<div class="card-body text-center">


						<div class="card-text my-2 mt-3">
							<strong class="card-title my-0" style="float: left;">소득세
								원천징수확인서</strong><br>
						</div>

						<div class="row align-items-center justify-content-between"
							style="width: 330px; margin-left: 4px;">
							<div>
								<span class="badge badge-pill badge-success">근로소득</span>
							</div>
						</div>

					</div>
					<!-- ./card-text -->
					<div class="card-footer" style="border-top: 0px; padding-top: 0px;">
						<div class="row align-items-center">
							<div class="col-auto">
								<button type="button" class="btn mb-2 btn-primary"
									data-toggle="modal" data-target="#salaryModal2"
									style="color: white; vertical-align: middle;">
									<span class="fe fe-24 fe-arrow-down-circle"
										style="vertical-align: middle;"></span> 발급하기
								</button>
							</div>
						</div>
					</div>
					<!-- /.card-footer -->
				</div>
			</div>
		</div>
		<hr>
		
		<div class="my-4" style="margin-left:30px;width:60%">
                  <div class="card shadow mb-4">
                    <div class="card-body">
                      <h5 class="h5 mb-3 card-title">발급내역</h5>
                      <table class="table table-bordered table-hover mb-0">
                        <thead>
                          <tr role="row">
                          	<th width="10%" style="color:black;">발급일</th>
							<th width="15%" style="color:black;">사번</th>
							<th width="15%" style="color:black;">대상자</th>
							<th width="30%" style="color:black;">이메일</th>
							<th width="15%" style="color:black;">증명서</th>
							<th width="15%" style="color:black;">발급사유</th>
                          </tr>
                        </thead>
                        
                        <tbody>
							<c:forEach var="scIssue" items="${scIssueList}" varStatus="stat">	                        
	                          <tr role="row">
	                          	<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">${scIssue.scIsDate}</td>
								<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">${scIssue.empNo}</td>
								<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">${scIssue.empNm} <span class="badge badge-pill badge-success">${scIssue.stClfCdNm}</span></td>
								<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">${scIssue.empMail} </td>
							<c:if test="${scIssue.scType=='sc1'}">	
								<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">${scIssue.prMth}월 급여명세서</td>
							</c:if>	
							<c:if test="${scIssue.scType=='sc2'}">
								<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">갑근세원천징수확인서</td>
							</c:if>
								<td style="white-space: nowrap;padding-left:20px;padding-right:20px;">${scIssue.scIsRsn}</td>
	                          </tr>
                          </c:forEach>
                        
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
	</div>



	<!-- 급여명세서 모달-->
	<div class="modal fade" id="salaryModal" tabindex="-1" role="dialog"
		aria-labelledby="salaryModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header" style="border: 0px;">
					<h5 class="modal-title" id="salaryModalTitle">급여명세서 발급</h5>
					<span class="badge badge-pill badge-success"
						style="margin: 3px 0px 0px 3px;">근로소득</span>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>

				<form id="modalForm" action="" method="post">
					<div class="modal-body"
						style="width: 90%; margin: 0px auto; padding-top: 0px;">
						<div>


							<div class="row align-items-center mb-3 mt-3">
								<div class="inputNames">
									<label for="selectName">대상자</label>
								</div>
								<div class="inputConts">

									<div class="dropdown">
										<input type="hidden" name="empNo" placeholder="번호!!">
										<input type="hidden" name="scType" value="sc1"/>	
										<input type="text" class="form-control" id="selectName"
											placeholder="검색을 해주세요" style="position: relative;">
										<div id="searchResults" class="dropdown-content">
										</div>
									</div>

								</div>
								<br />
							</div>

							<div class="row align-items-center mb-1">
								<div>발급할 증명서 선택</div>
								<div id="cList">
								</div>
							</div>
							<br>

							<div class="row align-items-center mb-1">
								<div>발급사유</div>
								<div id="reasen">
									<div class="radio">
										<input type="radio" name="scIsRsn" value="금융기관제출">금융기관제출
									</div>
									<div class="radio">
										<input type="radio" name="scIsRsn" value="관공서제출">관공서제출
									</div>
									<div class="radio">
										<input type="radio" name="scIsRsn" value="학교제출">학교제출
									</div>
									<div class="radio">
										<input type="radio" name="scIsRsn" value="기타">기타
									</div>
								</div>
							</div>
							
						</div>
					</div>

					<div class="modal-footer mb-3" style="border: 0px;padding-top:0px;">
<!-- 					<button type="button" class="btn mt-3 mr-3 btn-outline-dark mb-3" style="float:right;" onclick ="autoWritepay()">자동채우기</button> -->
						<button type="submit" class="btn btn-success mr-3"
							data-toggle="modal" data-target=".bd-example-modal-xl"
							style="color: white;">발급하기</button>
					</div>
					<sec:csrfInput />
				</form>
			</div>
		</div>
	</div>
	<!-- 급여명세서 모달 1 끝 -->
	<!-- 급여명세서 모달 2 -->
	<div class="modal fade" id="salaryModal2" tabindex="-1" role="dialog"
		aria-labelledby="salaryModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content" style="height:95%">
				<div class="modal-header" style="border: 0px;">
					<h5 class="modal-title" id="salaryModalTitle">갑종근로소득에 대한 소득세 원천징수확인서 </h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>

				<form id="modalForm2" action="" method="post">
					<div class="modal-body" style="width: 90%; margin: 0px auto;">
						<div>
							
							<div class="row align-items-center mb-3 mt-3">
								<div class="inputNames">
									<label for="selectName2">대상자</label>
								</div>
								
								
								<div class="inputConts">

									<div class="dropdown">
										<input type="hidden" name="empNo2" placeholder="번호!!">
										<input type="hidden" name="scType2" value="sc2"/>	
										<input type="text" class="form-control" id="selectName2" name="empNm"
											placeholder="검색을 해주세요" style="position: relative;">
										<div id="searchResults2" class="dropdown-content">
										</div>
									</div>

								</div>
								<br />
							</div>
							
							<div class="row align-items-center mb-3">
								<div class="inputNames">
									<label for="prYM">정산기간</label>
								</div>
								<div class="form-group mb-3 mr-2" style="width:42%;">
			                        <label for="sdate">시작일</label>
			                        <input class="form-control" id="sdate" type="date" name="sdate">
		                      	</div>
								<div class="form-group mb-3" style="width:41%">
			                        <label for="edate">종료일</label>
			                        <input class="form-control" id="edate" type="date" name="edate">
		                      	</div>
							</div>
							
							<div class="row align-items-center mb-1">
								<div>발급사유</div>
								<div id="reasen">
									<div class="radio">
										<input type="radio" name="incIsRsn" value="금융기관제출">금융기관제출
									</div>
									<div class="radio">
										<input type="radio" name="incIsRsn" value="관공서제출">관공서제출
									</div>
									<div class="radio">
										<input type="radio" name="incIsRsn" value="학교제출">학교제출
									</div>
									<div class="radio">
										<input type="radio" name="incIsRsn" value="기타">기타
									</div>
								</div>
							</div>
							
						</div>
					</div>

					
					<div class="modal-footer mb-2" style="border: 0px;">
						<button type="button" class="btn mt-3 mr-3 btn-outline-dark mb-3" style="float:right;" onclick ="autoWrite()">자동채우기</button>
						<button type="submit" class="btn btn-success mr-3"
						data-toggle="modal"	data-target=".bd-example-modal-xl2"
							style="color: white;">발급하기</button>
					</div>
					<sec:csrfInput />
				</form>
			</div>
		</div>
	</div>
	<!-- 급여명세서 모달 2끝 -->




<!-- 	<!-- 급여 명세서 모달 1번발급!! -->
<!-- 	<button type="button" class="btn mb-2 btn-primary" data-toggle="modal" -->
<!-- 		data-target=".bd-example-modal-xl">1번발급</button> -->



	<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog"
		aria-labelledby="myExtraLargeModalLabel" style="display: none;"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content" id="cardBody">
				<!-- //////////////// newbody 시작 ///////////////// -->
				<div class="modal-body" id="newbody">

				</div>
				<!-- //////////////// newbody 끝 ///////////////// -->
				<div style="margin: 15px;">
					<button style="float: right;" type="button" class="btn btn-primary"
						id="savePdfButton2" onclick="pdfPrint()">PDF다운로드</button>
				</div>

			</div>
		</div>
	</div>
	
	
	
	
	<!-- 급여 명세서 모달 2번발급!! -->
<!-- 	<button type="button" class="btn mb-2 btn-primary" data-toggle="modal" -->
<!-- 		data-target=".bd-example-modal-xl2">2번발급</button> -->

	<div class="modal fade bd-example-modal-xl2" tabindex="-1" role="dialog"
		aria-labelledby="myExtraLargeModalLabel" style="display: none;"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content" id="cardBody" style="padding-bottom:30px;">
				<!-- //////////////// newbody 시작 ///////////////// -->
				<div class="modal-body" id="newbody2" style="width: 100%; height: 100%" >
				</div>
				<!-- //////////////// newbody 끝 ///////////////// -->
			</div>
		</div>
	</div>




</body>

<script>
// 모달 닫으면 초기화
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

	function reset(){
		$(this).find('form')[0].reset();
		$(".dropdown-content").css("display", "none");
	}

	$('#defaultModal').on('hidden.bs.modal', reset);
	$('#salaryModal').on('hidden.bs.modal', reset);	
	$('#salaryModal2').on('hidden.bs.modal', reset);
//모달 닫으면 초기화 

let lssued;
//발급하기 누르면
lssued = document.querySelector("#modalForm")
lssued.addEventListener("submit",issueSC);

lssued = document.querySelector("#modalForm2")
lssued.addEventListener("submit",issueIncCert);

//소득세원천징수확인서 발급하기 버튼
function issueIncCert(){
	event.preventDefault();
	$('#salaryModal2').modal('hide');
	
	let empNo = $("input[name='empNo2']").val();
	let sdate = $("#sdate").val();
	let edate = $("#edate").val();
	let scIsRsn = $("input[name='incIsRsn']:checked").val();
	let scType = $("input[name='scType2']").val();
	
	let data = {
		"empNo" : empNo,
		"sdate" : sdate,
		"edate" : edate,
		"scIsRsn" : scIsRsn,
		"scType" : scType
	}
	
	console.log("data : " + JSON.stringify(data));
	
	
	$.ajax({
		url : "/salary/issueIncCert",
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
        beforeSend:function(xhr){
			  xhr.setRequestHeader(header,token);
		},
		success : function(data){
			console.log("성공::" , data)
			console.log("첫줄나오닝?" , data[0])
			
			let sumTotalTaxAmt = 0;
			let sumWhdTaxAmt = 0;
			for (let i=0; i<5 ; i++){
				sumTotalTaxAmt += data.totalTaxAmtList[i].totalTaxAmt;	
				sumWhdTaxAmt += data.taxAmtList[i].whdTaxAmt;
			}
			
			str = ""
			str +=`
				<div class="hpa" style="width:210mm;height:296.99mm;">
				<div class="hcD" style="left:10mm;top:15mm;">
					<div class="hcI">
						<div class="hls ps0" style="line-height:2.79mm;white-space:nowrap;left:0mm;top:-0.18mm;height:3.53mm;width:0mm;">
						</div>
					</div>
				</div>
				<div class="htb" style="left:11mm;width:188.93mm;top:16mm;height:265.69mm;">
					<svg class="hs" viewbox="-2.50 -2.50 193.93 270.69" style="left:0;top:0;width:193.93mm;height:270.69mm;"><path d="M0,0 L0,263.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.80,14.35 L15.80,54.15" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.80,61.33 L15.80,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.80,241.47 L15.80,250.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M46.73,0 L46.73,14.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M46.73,54.15 L46.73,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M70.10,14.35 L70.10,54.15" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M70.10,61.33 L70.10,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M70.10,241.47 L70.10,250.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M90.95,54.15 L90.95,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M108.01,14.35 L108.01,21.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M108.01,28.70 L108.01,35.88" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M108.01,45.38 L108.01,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M108.01,245.91 L108.01,250.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M133.90,0 L133.90,14.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M133.90,54.15 L133.90,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M152.22,14.35 L152.22,21.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M152.22,28.70 L152.22,35.88" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M152.22,45.38 L152.22,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M152.22,245.91 L152.22,250.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M186.93,0 L186.93,263.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,0 L187,0" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,7.18 L46.80,7.18" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M133.84,7.18 L187,7.18" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,14.35 L187,14.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.74,21.53 L187,21.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,28.70 L187,28.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.74,35.88 L187,35.88" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.74,45.38 L187,45.38" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,54.15 L187,54.15" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,61.33 L187,61.33" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,68.83 L187,68.83" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,76.01 L187,76.01" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,83.18 L187,83.18" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,90.36 L187,90.36" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,97.53 L187,97.53" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,104.71 L187,104.71" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,111.88 L187,111.88" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,119.06 L187,119.06" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,126.23 L187,126.23" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,133.41 L187,133.41" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,140.59 L187,140.59" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,147.76 L187,147.76" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,154.94 L187,154.94" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,162.11 L187,162.11" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,169.29 L187,169.29" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,176.46 L187,176.46" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,183.64 L187,183.64" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,190.81 L187,190.81" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,197.99 L187,197.99" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,205.16 L187,205.16" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,212.34 L187,212.34" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,228.06 L187,228.06" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,241.47 L187,241.47" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M15.74,245.91 L187,245.91" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,250.35 L187,250.35" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,263.69 L187,263.69" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M186.93,0 L186.93,263.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M0,0 L0,263.70" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,263.69 L187,263.69" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path><path d="M-0.06,0 L187,0" style="stroke:#000000;stroke-linecap:butt;stroke-width:0.12;"></path></svg>
					<div class="hce" style="left:0mm;top:2.5mm;width:46.73mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:1.68mm;">
								<div class="hls ps19" style="line-height:2.17mm;white-space:nowrap;left:0mm;top:-0.14mm;height:2.82mm;width:43.12mm;">
									<span class="hrt cs7">발급 번호</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:2.5mm;width:87.16mm;height:14.35mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:3.08mm;">
								<div class="hls ps19" style="line-height:2.48mm;white-space:nowrap;left:0mm;top:-0.16mm;height:3.17mm;width:83.57mm;">
									<span class="hrt cs2">갑종근로소득에 대한 소득세원천징수확인서</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:4.97mm;height:2.12mm;width:83.57mm;">
									<span class="hrt cs8">(</span><span class="hrt cs9">■</span><span class="hrt cs10">&nbsp;</span><span class="hrt cs8">매월 신고 납부 대상자 확인&nbsp;</span><span class="hrt cs9">□</span><span class="hrt cs8">반기별 신고 납부 대상자 확인)</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:2.5mm;width:53.04mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:1.68mm;">
								<div class="hls ps19" style="line-height:2.17mm;white-space:nowrap;left:0mm;top:-0.14mm;height:2.82mm;width:49.43mm;">
									<span class="hrt cs7">처리기간</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:7.18mm;width:46.73mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:1.68mm;">
								<div class="hls ps19" style="line-height:2.17mm;white-space:nowrap;left:0mm;top:-0.14mm;height:2.82mm;width:43.12mm;">
									<span class="hrt cs7">J-2023101701</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:7.18mm;width:53.04mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:1.68mm;">
								<div class="hls ps19" style="line-height:2.17mm;white-space:nowrap;left:0mm;top:-0.14mm;height:2.82mm;width:49.43mm;">
									<span class="hrt cs7">즉 시</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:14.35mm;width:15.80mm;height:14.35mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.23mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">납</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:3.28mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">세</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:6.67mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">자</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:14.35mm;width:54.30mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">①성명</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:14.35mm;width:37.91mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:34.30mm;">
									<span class="hrt cs8">\${data.taxpayerInfo.empNm}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:14.35mm;width:44.21mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:40.61mm;">
									<span class="hrt cs8">②주민등록번호</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:14.35mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
									<span class="hrt cs8">\${data.taxpayerInfo.regn}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:21.53mm;width:54.30mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">③주소 또는 거소</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:21.53mm;width:116.83mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:113.23mm;">
									<span class="hrt cs8">\${data.taxpayerInfo.empAddr2} \${data.taxpayerInfo.empAddr3}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:28.70mm;width:15.80mm;height:25.45mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:4.40mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">징</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:3.28mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">수</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:6.67mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">의</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:10.05mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">무</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:13.44mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">자</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:28.70mm;width:54.30mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">④상호 또는 명칭</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:28.70mm;width:37.91mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:34.30mm;">
									<span class="hrt cs8">\${data.companyInfo.coNm}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:28.70mm;width:44.21mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:40.61mm;">
									<span class="hrt cs8">⑤사업자등록번호</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:28.70mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
									<span class="hrt cs8">\${data.companyInfo.coRegno}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:35.88mm;width:54.30mm;height:9.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:3.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">⑥사업장 소재지</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:35.88mm;width:116.83mm;height:9.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:3.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:113.23mm;">
									<span class="hrt cs8">\${data.companyInfo.coAddr} \${data.companyInfo.coAddr2}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:45.38mm;width:54.30mm;height:8.77mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.83mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">⑦대표자</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:45.38mm;width:37.91mm;height:8.77mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.83mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:34.30mm;">
									<span class="hrt cs8">\${data.companyInfo.empNm}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:45.38mm;width:44.21mm;height:8.77mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.83mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:40.61mm;">
									<span class="hrt cs8">⑧주민(법인) 등록번호</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:45.38mm;width:34.71mm;height:8.77mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.83mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
									<span class="hrt cs8">\${data.companyInfo.corRegno}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:56.65mm;width:46.73mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:43.12mm;">
									<span class="hrt cs8">⑨확인서의 사용 목적</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:56.65mm;width:44.21mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:40.61mm;">
									<span class="hrt cs8">\${data.scIsInfo.scIsRsn}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:56.65mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
									<span class="hrt cs8">⑩제출처</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:56.65mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:56.65mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
									<span class="hrt cs8">⑪소요수량</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:56.65mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
									<span class="hrt cs8">1통</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:63.83mm;width:15.80mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">연월</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:63.83mm;width:30.93mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
									<span class="hrt cs8">⑫급여액</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:63.83mm;width:23.37mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
									<span class="hrt cs8">⑬세액</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:63.83mm;width:20.85mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.50mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">⑭납부(예정)</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:3.28mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">연월일</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:63.83mm;width:17.06mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
									<span class="hrt cs8">연월</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:63.83mm;width:25.89mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
									<span class="hrt cs8">급여액</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:63.83mm;width:18.32mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
									<span class="hrt cs8">세액</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:63.83mm;width:34.71mm;height:7.50mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.19mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
									<span class="hrt cs8">⑭납부(예정) 연월일</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:68.83mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">\${data.taxAmtList[0].prYr}-\${data.taxAmtList[0].prMth}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:68.83mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
									<span class="hrt cs8">\${data.totalTaxAmtList[0].totalTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:68.83mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
									<span class="hrt cs8">\${data.taxAmtList[0].whdTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:68.83mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">\${data.taxAmtList[0].taxDate}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:68.83mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:68.83mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:68.83mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:68.83mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:76.01mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								<span class="hrt cs8">\${data.taxAmtList[1].prYr}-\${data.taxAmtList[1].prMth}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:76.01mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
									<span class="hrt cs8">\${data.totalTaxAmtList[1].totalTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:76.01mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
									<span class="hrt cs8">\${data.taxAmtList[1].whdTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:76.01mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">\${data.taxAmtList[1].taxDate}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:76.01mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:76.01mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:76.01mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:76.01mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:83.18mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								<span class="hrt cs8">\${data.taxAmtList[2].prYr}-\${data.taxAmtList[2].prMth}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:83.18mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
									<span class="hrt cs8">\${data.totalTaxAmtList[2].totalTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:83.18mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
									<span class="hrt cs8">\${data.taxAmtList[2].whdTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:83.18mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">\${data.taxAmtList[2].taxDate}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:83.18mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:83.18mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:83.18mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:83.18mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:90.36mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">\${data.taxAmtList[3].prYr}-\${data.taxAmtList[3].prMth}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:90.36mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
									<span class="hrt cs8">\${data.totalTaxAmtList[3].totalTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:90.36mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
									<span class="hrt cs8">\${data.taxAmtList[3].whdTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:90.36mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">\${data.taxAmtList[3].taxDate}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:90.36mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:90.36mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:90.36mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:90.36mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:97.53mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">\${data.taxAmtList[4].prYr}-\${data.taxAmtList[4].prMth}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:97.53mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
									<span class="hrt cs8">\${data.totalTaxAmtList[4].totalTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:97.53mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
									<span class="hrt cs8">\${data.taxAmtList[4].whdTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:97.53mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
									<span class="hrt cs8">\${data.taxAmtList[4].taxDate}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:97.53mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:97.53mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:97.53mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:97.53mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:104.71mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:104.71mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:104.71mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:104.71mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:104.71mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:104.71mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:104.71mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:104.71mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:111.88mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:111.88mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:111.88mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:111.88mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:111.88mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:111.88mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:111.88mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:111.88mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:119.06mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:119.06mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:119.06mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:119.06mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:119.06mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:119.06mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:119.06mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:119.06mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:126.23mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:126.23mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:126.23mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:126.23mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:126.23mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:126.23mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:126.23mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:126.23mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:133.41mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:133.41mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:133.41mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:133.41mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:133.41mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:133.41mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:133.41mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:133.41mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:140.59mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:140.59mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:140.59mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:140.59mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:140.59mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:140.59mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:140.59mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:140.59mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:147.76mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:147.76mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:147.76mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:147.76mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:147.76mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:147.76mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:147.76mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:147.76mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:154.94mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:154.94mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:154.94mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:154.94mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:154.94mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:154.94mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:154.94mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:154.94mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:162.11mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:162.11mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:162.11mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:162.11mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:162.11mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:162.11mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:162.11mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:162.11mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:169.29mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:169.29mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:169.29mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:169.29mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:169.29mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:169.29mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:169.29mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:169.29mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:176.46mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:176.46mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:176.46mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:176.46mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:176.46mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:176.46mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:176.46mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:176.46mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:183.64mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:183.64mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:183.64mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:183.64mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:183.64mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:183.64mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:183.64mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:183.64mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:190.81mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:190.81mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:190.81mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:190.81mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:190.81mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:190.81mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:190.81mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:190.81mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:197.99mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:197.99mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:197.99mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:197.99mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:197.99mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:197.99mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:197.99mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:197.99mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:205.16mm;width:15.80mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:205.16mm;width:30.93mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:27.33mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:49.23mm;top:205.16mm;width:23.37mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:19.77mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:205.16mm;width:20.85mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:17.24mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:93.45mm;top:205.16mm;width:17.06mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:13.46mm;">
									<span class="hrt cs8">계</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:205.16mm;width:25.89mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:22.28mm;">
									<span class="hrt cs8">\${sumTotalTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:136.40mm;top:205.16mm;width:18.32mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:14.72mm;">
									<span class="hrt cs8">\${sumWhdTaxAmt.toLocaleString()}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:205.16mm;width:34.71mm;height:7.18mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.03mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:212.34mm;width:186.93mm;height:15.72mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.92mm;">
								<div class="hls ps0" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;발급일 현재 위와 같이 원천 징수하였음을 확인하여 주시기 바랍니다</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:3.28mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">\${data.scIsInfo.scIsDate}</span>
								</div>
								<div class="hls ps20" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:6.67mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">신청인 &nbsp;&nbsp; \${data.taxpayerInfo.empNm} &nbsp;&nbsp;(서명 또는 인)</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:2.5mm;top:230.56mm;width:186.93mm;height:13.40mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:1.76mm;">
								<div class="hls ps0" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;위와 같이 원천 징수하였음을 확인합니다</span>
								</div>
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:3.28mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">\${data.scIsInfo.scIsDate}</span>
								</div>
								<div class="hls ps20" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:6.67mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">확인자(원천징수의무자)&nbsp;&nbsp; \${data.companyInfo.coNm} &nbsp;&nbsp;(서명 또는 인)</span>
									<img src='\${data.companyInfo.svfiName}' style="width: 60px; height: 60px; position: absolute; left: 167mm; bottom:-10px; z-index: 2">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:243.97mm;width:15.80mm;height:8.88mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:2.89mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:12.19mm;">
									<span class="hrt cs8">확인자</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:243.97mm;width:54.30mm;height:4.44mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.66mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">사업장 소재지</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:243.97mm;width:116.83mm;height:4.44mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.66mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:113.23mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:18.30mm;top:248.41mm;width:54.30mm;height:4.44mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.66mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:50.70mm;">
									<span class="hrt cs8">세무사 등록번호</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:72.60mm;top:248.41mm;width:37.91mm;height:4.44mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.66mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:34.30mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:108.01mm;top:248.41mm;width:44.21mm;height:4.44mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.66mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:40.61mm;">
									<span class="hrt cs8">전화번호</span>
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:152.22mm;top:248.41mm;width:34.71mm;height:4.44mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:0.66mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:31.11mm;">
								</div>
							</div>
						</div>
					</div>
					<div class="hce" style="left:0mm;top:252.85mm;width:186.93mm;height:13.35mm;">
						<div class="hcD" style="left:1.80mm;top:0.50mm;">
							<div class="hcI" style="top:1.73mm;">
								<div class="hls ps19" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:-0.11mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">위와 같이 원청징수의무자가 원천징수하였음을 확인합니다.</span>
								</div>
								<div class="hls ps20" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:3.28mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">년 &nbsp;&nbsp;&nbsp;월 &nbsp;&nbsp;&nbsp;일</span>
								</div>
								<div class="hls ps20" style="line-height:1.59mm;white-space:nowrap;left:0mm;top:6.67mm;height:2.12mm;width:183.33mm;">
									<span class="hrt cs8">세무사 &nbsp;&nbsp;(인)</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

									<!-- 한글코드 끝 -->


							</div>
							<div style="margin-bottom: 30px; margin-top: 30px;">
								<button style="float: right;margin-bottom: 30px;" type="button" class="btn btn-primary"
									id="savePdfButton2" onclick="pdfPrint2()">PDF다운로드</button>
							</div>

		`;
			$("#newbody2").html(str);
		},
		error:function(request,status,error){
			  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
}

//급여명세서 발급	
function issueSC(){
	event.preventDefault();
	$('#salaryModal').modal('hide');
	
	let scNo = $("input[name='scNo']:checked").val();
	let scIsRsn = $("input[name='scIsRsn']:checked").val();
	let empNo = $("input[name='empNo']").val();
	let scType = $("input[name='scType']").val();
	
	let data = {
		"scIsRsn" : scIsRsn,
		"empNo" : empNo,
		"scNo" : scNo,
		"scType" : scType
	}
	
	console.log("data : " + JSON.stringify(data));
	
	
	$.ajax({
		url : "/salary/issueSC",
		type : "post",
		data : JSON.stringify(data),
		contentType: "application/json;charset=utf-8",
		dataType:"json",
        beforeSend:function(xhr){
			  xhr.setRequestHeader(header,token);
		},
		success : function(data){
			console.log("성공::" , data)
			console.log("첫줄나오닝?" , data[0])
			
			str = ""
			str +=`
				<button class="btn mb-2 btn-secondary">귀속월</button>
				&nbsp;&nbsp;<span>\${data[0].prYr}. \${data[0].prMth}</span><br> <br>
				<h2 style="display: inline;">급여명세서</h2>
				<span style="float: right; font-size: 20px;color:black;">\${data[0].empNm} | \${changeBirthFormat(data[0].empBrdt)} | \${data[0].empNo}
					| \${data[0].dnm} </span> <br> <br> <br>

				<div
					style="border-top: 1px solid black; padding: 5px; padding-bottom: 70px;">
					<h3 style="display: inline-block; margin-top: 50px;">
						<strong>실수령액</strong> &nbsp;&nbsp; <span style="font-size:18px;font-weight:normal">\${data[0].prPdate}&nbsp;지급</span> 
						&nbsp;---------------------------------- &nbsp;&nbsp;\${addCommasToNumber(data[0].netAmt)}원
					</h3>
				</div>
			
				<div>
					<div
						style="float: left; width: 44.5%; border-bottom: 3px black solid; margin: 5px 20px 5px;">
						<div class="historyLeft" style="float: left;">
							<h3 class="title">지급내역</h3>
						</div>
						<div class="historyRight" style="float: right;">
							<h3 class="title">\${addCommasToNumber(data[0].pytlAmt)}원</h3>
						</div>
	
					</div>

					<div
						style="float: right; width: 44.5%; border-bottom: 3px black solid; margin: 5px 20px 5px;">
						<div class="historyLeft" style="float: left;">
							<h3 class="title">공제내역</h3>
						</div>
						<div class="historyRight" style="float: right;">
							<h3 class="title">\${addCommasToNumber(data[0].ddtlAmt)}원</h3>
						</div>
					</div>
				</div>
				
				<div>
					<div style="float: left;width: 44.5%; margin: 5px 20px 5px;"">
						<table style="width:100%;">
							<tbody id="payItem">
							</tbody>
						</table>
					</div>
					
					<div style="float: right;width: 44.5%; margin: 5px 20px 5px;"">
						<table style="width:100%;">
							<tbody id="dedItem">
							</tbody>	
						</table>
					</div>
				</div>
				
				<div style="margin-top: 500px;">
					<div>
						● 기본시급 = 연봉 포함 통상임금 ÷ 월소정근무시간, 기본급과 미달 근무 차감금에 활용합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;기본시급은 소수점 첫째 자리에서 올림표기합니다
					</div>
					<div>● 기본 근무 산정기간(\${data[0].prYr}년 \${data[0].prMth}월)의 기본 시급은
						\${addCommasToNumber(data[0].basicHourWage)}원입니다.</div>
					<div>
						● 초과근무 산정기간(\${data[0].prYr}년 \${data[0].prMth}월)의 기본 시급은 \${addCommasToNumber(data[0].basicHourWage)}원입니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp; 초과근무수당은 기본시급에 초과한 가산율(%)을 곱한 금액으로 계산되어
						지급됩니다.
					</div>

				</div>
				<div style="margin-top: 120px;">
					<table style="display: inline-block;">
						<tr>
							<td style="padding-right: 70px;color:black;">발급일</td>
							<td style="padding-right: 40px;color:black;">회사명</td>
							<td style="padding-right: 40px;color:black;">대표이사</td>
						</tr>
						<tr>
							<td style="padding-right: 70px;color:black;">\${data[0].scIsDate}</td>
							<td style="padding-right: 40px;color:black;">인사이트</td>
							<td style="padding-right: 40px;color:black;">임민우</td>
						</tr>
					</table>
					<div
						style="display: inline-block; float: right; margin-right: 70px">
						<span style="position: relative; z-index: 2">(서명 인)</span> 
							<img src="\${data[0].svfiName}"
							style="width: 60px; height: 60px; position: absolute; left: 179mm; bottom: 10mm; z-index: 2">
					</div>



				</div>
			`;
		$("#newbody").html(str);
		
		str = "";
		
			for(let i=0; i<data.length; i++){
				if(data[i].pdType == 'B0401'){
					str += `
							<tr>
								<td style="font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${data[i].pdNm}</td>
								<td style="text-align: right; font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${addCommasToNumber(data[i].pdAmt)}</td>
							</tr>
							`;
				}
			}
			$("#payItem").html(str);
			
		str = "";
			for(let i=0; i<data.length; i++){
				if(data[i].pdType == 'B0402'){
					str += `
							<tr>
								<td style="font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${data[i].pdNm}</td>
								<td style="text-align: right; font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${addCommasToNumber(data[i].pdAmt)}</td>
							</tr>
							`;
				}
			}
			$("#dedItem").html(str);
		},
		error:function(request,status,error){
			  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
}//oneIssued 끝

//숫자에 천단위 구분 기호(쉼표)를 추가하는 함수
function addCommasToNumber(number) {
	// 숫자를 문자열로 변환
    let numberString = number ? number.toString() : '0'; // number가 null인 경우 0으로 대체
    
    // 천단위 구분 기호(쉼표) 추가
    numberString = numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    
    return numberString;
}

// alert(addCommasToNumber(1123456780));

// 생년월일 형태의 문자열을 "yyyy.mm.dd" 형태로 바꾸는 함수
function changeBirthFormat(empBrdt) {
	 if (empBrdt === null) {
	        return '1990.01.01';
	    }
	    
	    // 원하는 포맷으로 변경
	    let formattedEmpBrdt = empBrdt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');

	    return formattedEmpBrdt;
}


//검색 부분
	$(document).on("keyup", "#selectName", function(e){
		
		var name = $("#selectName").val();
		var content = $(".dropdown-content");

		console.log(name + " : " + content);
		
		if(name == null || name ==""){
			console.log("널값")
			$(".dropdown-content").css("display", "none");
		} else{
			console.log("있어용!!")
			$(".dropdown-content").css("display", "inline");
		}
		console.log("검색" + name)
		$.ajax({
			type : "get",
			url : "/salary/empMember/?name="+name,
			success: function (suc){
 				console.log("성공" , suc);
 				str ="";
 				
		        for (var i = 0; i < suc.length; i++) {
		            str += "<div onclick='check(this)'>" + "<span id='name'>" +suc[i].empNm + "</span>" + " - " + "<span id='empNo'>" +suc[i].empNo+ "</span>"  + "</div>";
		        }
 				
 				$("#searchResults").html(str);
 				
			},
			error:function(request,status,error){
			  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
			
		})
		
		
		
	})
	
	$(document).on("keyup", "#selectName2", function(e){
		
		var name = $("#selectName2").val();
		var content = $(".dropdown-content");

		console.log(name + " : " + content);
		
		if(name == null || name ==""){
			console.log("널값")
			$(".dropdown-content").css("display", "none");
		} else{
			console.log("있어용!!")
			$(".dropdown-content").css("display", "inline");
		}
		console.log("검색" + name)
		$.ajax({
			type : "get",
			url : "/salary/empMember/?name="+name,
			success: function (suc){
 				console.log("성공" , suc);
 				str ="";
 				
		        for (var i = 0; i < suc.length; i++) {
		            str += "<div onclick='check2(this)'>" + "<span id='name2'>" +suc[i].empNm + "</span>" + " - " + "<span id='empNo2'>" +suc[i].empNo+ "</span>"  + "</div>";
		        }
 				
 				$("#searchResults2").html(str);
 				
			},
			error:function(request,status,error){
			  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	})
	
	function check2(pThis){
		console.log("ddd"+$(pThis).find("span").text());

	 	var schName2 = $(pThis).find("#name2").text();
		var schNo2 = $(pThis).find("#empNo2").text();
		
		var empNm2 = $("#selectName2").val();
		var empNo2 = $("input[name='empNo2']").val();
		
		console.log("나오니111" , schName2)
		console.log("나오니222" , schNo2)
		
		$("#selectName2").val(schName2);
		$("input[name='empNo2']").val(schNo2);
		
		
		$(".dropdown-content").css("display", "none");
		
	}
	
	
	function check(pThis){
		console.log("헤헤", pThis);
		
		console.log("ddd"+$(pThis).find("span").text());
		
		var schName = $(pThis).find("#name").text();
		var schNo = $(pThis).find("#empNo").text();
		
		console.log("schName", schName);
		console.log("schNo", schNo);
		
		$("#selectName").val( schName );
		$("input[name='empNo']").val( schNo );
		
		var empNm = $("#selectName").val();
		var empNo = $("input[name='empNo']").val();
		
		console.log("empNm", empNm);
		console.log("empNo", empNo);
		
		$(".dropdown-content").css("display", "none");
		
		let data = { "empNo" : empNo };
		
		$.ajax({
			url: "/salary/SCList",
			contentType: "application/json;charset=UTF-8",
			data: JSON.stringify(data),
			type: "post",
			dataType : "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader(header,token);
			},
			success:function(result){
				console.log("result : ", result);

				var str = "";

				for (let i=0; i<result.length; i++){
				str += ` 
					<div>
						<input type="radio" value="\${result[i].scNo}" name="scNo" style="margin-left:20px;"/>
						<span style="color:black;">\${result[i].prYr}년 \${result[i].prMth}월 급여명세서 \${result[i].prPdate} 지급</span>
					</div><hr>	
				`;
				}
				
				$("#cList").html(str);
				
				
			},
			error:function(xhr, status, error){
			    console.log("code: " + xhr.status)
			    console.log("message: " + xhr.responseText)
			    console.log("error: " + error);
			}
		});//ajax
	}



//화면 캡처 (급여명세서)
     let jsPDF = jspdf.jsPDF;
	 function pdfPrint(){
	  	console.log("함수 실행")
	      html2canvas($('#newbody').get(0), {
		    scale: 2 // 캔버스 해상도를 2배로 설정합니다.
		  }).then(function (canvas) {
	        // 캔버스를 이미지로 변환
	        console.log("변환 전")
	        const imgData = canvas.toDataURL("image/png");
			console.log("변환 후")
	        const imgWidth = 210; // 가로(mm) (A4)
	        const pageHeight = imgWidth * 1.414; // 세로 길이 (A4)
	        const imgHeight = (canvas.height * imgWidth) / canvas.width;
	
	        const doc = new jsPDF({
	           orientation: "p",
	           unit: "mm",
	           format: "a4",
	        });
	
	        let heightLeft = imgHeight;
	        let position = 0;
	
	        // 첫 페이지 출력
	        doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
	        heightLeft -= pageHeight;
	
	        // 한 페이지 이상일 경우 루프 돌면서 출력
	        while (heightLeft >= 20) {
	           position = heightLeft - imgHeight;
	           doc.addPage();
	           doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
	           heightLeft -= pageHeight;
	        }
	
	        // 파일 저장
	        doc.save('급여명세서.pdf');
	        
	        location.href="/salary/dataManagement";
	  });
	}
	 
//화면 캡처2 (소득세원천징수확인서)
     
	 function pdfPrint2(){
	  	console.log("함수 실행")
	     	      html2canvas($('.hpa').get(0), {
		    scale: 3 // 캔버스 해상도를 2배로 설정합니다.
		  }).then(function (canvas) {
	    	 
	        // 캔버스를 이미지로 변환
	        console.log("변환 전2")
	        const imgData = canvas.toDataURL("image/png");
			console.log("변환 후2")
	        const imgWidth = 210; // 가로(mm) (A4)
	        const pageHeight = imgWidth * 1.414; // 세로 길이 (A4)
	        const imgHeight = (canvas.height * imgWidth) / canvas.width;
	
	        const doc = new jsPDF({
	           orientation: "p",
	           unit: "mm",
	           format: "a4",
	        });
	
	        let heightLeft = imgHeight;
	        let position = 0;
	
	        // 첫 페이지 출력
	        doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
	        heightLeft -= pageHeight;
	
	        // 한 페이지 이상일 경우 루프 돌면서 출력
	        while (heightLeft >= 20) {
	           position = heightLeft - imgHeight;
	           doc.addPage();
	           doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
	           heightLeft -= pageHeight;
	        }
	
	        // 파일 저장
	        doc.save('원천징수확인서.pdf');
	        
	        location.href="/salary/dataManagement";
	  });
	}

	//자동채우기 (급여명세서)
	function autoWritepay(){
		
	   let empNo = "202005017";
	   let empNm = "박서준";
	   

	   let scIsRsn = "관공서제출";
	   
	   $("input[name='empNo']").val(empNo);
	   $("#selectName").val(empNm);
	    
	    let data = { "empNo" : empNo };
		$.ajax({
			url: "/salary/SCList",
			contentType: "application/json;charset=UTF-8",
			data: JSON.stringify(data),
			async : false,
			type: "post",
			dataType : "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader(header,token);
			},
			success:function(result){
				console.log("result : ", result);

				var str = "";

				for (let i=0; i<result.length; i++){
				str += ` 
					<div>
						<input type="radio" value="\${result[i].scNo}" name="scNo" style="margin-left:20px;"/>
						<span style="color:black;">\${result[i].prYr}년 \${result[i].prMth}월 급여명세서 \${result[i].prPdate} 지급</span>
					</div><hr>	
				`;
				}
				
				$("#cList").html(str);
				
				
			},
			error:function(xhr, status, error){
			    console.log("code: " + xhr.status)
			    console.log("message: " + xhr.responseText)
			    console.log("error: " + error);
			}
		});//ajax
	   
	   
	   

	   // 라디오 버튼 선택
	   $('input[name="scIsRsn"][value="' + scIsRsn + '"]').prop("checked", true);
	   $('input[name="scNo"][value="33"]').prop("checked", true);
	}	
	
	//자동채우기
	function autoWrite(){
		
// 	   let empNo = "202005017";
	   let sdate = "2023-06-01";
	   let edate = "2023-10-31";
	   let incIsRsn = "관공서제출";
	   
// 	   $("input[name='empNo2']").val(empNo);
	   $("#sdate").val(sdate);
	   $("#edate").val(edate);
	   // 라디오 버튼 선택
	    $('input[name="incIsRsn"][value="' + incIsRsn + '"]').prop("checked", true);
	}	

</script>
</html>