<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<html>
<head>
<style>
div {
/*     	border: 1px solid blue; /* 항상 레이아웃을 눈으로 보면서 */      */
 }
span {
/* 	border: 1px solid red; */
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
a {
	text-decoration: none; /* 밑줄 제거 */
	color: #333; /* 일반 텍스트 색상 */
	margin-right: 20px; /* 각 링크 사이의 간격 조절 */
}

/* 활성 링크 스타일 */
a:hover {
	color: #007bff; /* 호버 시 텍스트 색상 변경 */
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



#myFullsizeModal{
    position : fixed;
    left : 0px;
    top : 0px;
	width: 100%;
	height: 100%;
}
.modal-dialog {
	max-width: none;
	
}

.modal-dialog.modal-fullsize2 {
  width: auto%;
  min-height: 100%;
  margin: 0;
  padding: 0;
}

.modal-content.modal-fullsize2 {
  height: 100%;
  min-height: 100%;
  border-radius: 0;
  overflow: auto;
}


footer
{
  float : right;
  position : relative;
}

</style>

<meta charset="UTF-8">
<title>급여정산 홈</title>
<script src="/resources/js/jspdf.min.js"></script>
<script src="/resources/js/html2canvas.js"></script>
</head>
<body>

<div id="container"> <!--wrapper-->

	<h2>
		<a href="/salary/home">급여정산</a>&nbsp;&nbsp; 
		<a href="#">퇴직소득</a>&nbsp;&nbsp; 
		<a href="/salary/dataManagement">자료관리</a>
	</h2>
	<hr>
	<h5>
		<a href="/salary/dataManagement">증명서 발급</a>&nbsp;&nbsp; 

	</h5>
	<hr>
	
	
	<div id="bmkList" class="row align-items-center" style="margin: 30px; margin-top: 50px;">
	

	<div class="col-md-3">
			<div class="card shadow mb-4">
				<div class="card-body text-center">
				
				
					<div class="card-text my-2 mt-3">
						<strong class="card-title my-0" style="float: left;">급여 명세서</strong><br>
					</div>
					
					<div class="row align-items-center justify-content-between" style="width:330px;margin-left:4px;">
						<div>
							<span class="badge badge-pill badge-success">근로소득</span> 
						</div>
					</div>
					
				</div>
				<!-- ./card-text -->
				<div class="card-footer" style="border-top:0px;padding-top:0px;">
					<div class="row align-items-center">
						<div class="col-auto">
							<button type="button" class="btn mb-2 btn-primary" data-toggle="modal" data-target="#salaryModal"
								 style="color: white; vertical-align: middle;" onclick="fStart(this)"><span class="fe fe-24 fe-arrow-down-circle" style="vertical-align: middle;"></span> 발급하기</button>
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
						<strong class="card-title my-0" style="float: left;">소득세 원천징수확인서</strong><br>
					</div>
					
					<div class="row align-items-center justify-content-between" style="width:330px;margin-left:4px;">
						<div>
							<span class="badge badge-pill badge-success">근로소득</span> 
						</div>
					</div>
					
				</div>
				<!-- ./card-text -->
				<div class="card-footer" style="border-top:0px;padding-top:0px;">
					<div class="row align-items-center">
						<div class="col-auto">
							<button type="button" class="btn mb-2 btn-primary" data-toggle="modal" data-target="#salaryModal2"
								 style="color: white; vertical-align: middle;" onclick="fStart(this)"><span class="fe fe-24 fe-arrow-down-circle" style="vertical-align: middle;"></span> 발급하기</button>
						</div>
					</div>
				</div>
				<!-- /.card-footer -->
			</div>
		</div>
		
		
		
		
	</div>
	<hr>
			<div class="h5 mb-0 page-title">발급내역</div>
			<div>
				발급내역 테이블!!!
				<table class="table datatables dataTable no-footer" id="dataTable-1" role="grid" aria-describedby="dataTable-1_info" border="1">
		      				<thead>
                        	<tr role="row">
		                        <th width="10%">발급일</th>
		                        <th width="15%">사번</th>
		                        <th width="15%">대상자</th>
		                        <th width="30%">이메일</th>
		                        <th width="15%">증명서</th>
		                        <th width="15%">발급사유</th>
	                    	</tr>
                        </thead>
                        <tbody>
			      	
		         				<tr role="row">
			                        <td>1</td>
			                        <td>200505055</td>
			                        <td>실험징어</td>
			                        <td>1970-01-01</td>
			                        <td>재직중</td>
			                        <td>null</td>

			                   	</tr>
		         				<tr role="row">

			                        <td>2</td>
			                        <td>201202021</td>
			                        <td>실험용</td>
			                        <td>1970-01-01</td>
			                        <td>재직중</td>
			                        <td>null</td>

			                   	</tr>
						         				
				  		</tbody>
            	</table>
			</div>
	
	
	
	
	
	



	
</div>




	
	
<!-- 모달 시작 ! @@@@ -->
	<div class="modal fade" id="salaryModal" tabindex="-1" role="dialog" aria-labelledby="salaryModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px;">
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
		        		
		        		<input id="hiddenInput" type="text" name="ptNo" value="" />
		        		
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
		        	<button type="submit" class="btn btn-success mr-3" style="color:white;"> 정산 시작하기 → </button>
		        </div>
		        <sec:csrfInput/>
		    </form>
	      	</div>
	    </div>
	  </div>
	  
	  <!-- 두번째!! 원천징수 -->
	<div class="modal fade" id="salaryModal2" tabindex="-1" role="dialog" aria-labelledby="salaryModalTitle2" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 500px;">
	    	<div class="modal-content">
		        <div class="modal-header" style="border:0px;">
		          <h5 class="modal-title" id="salaryModalTitle2">헤헤헤</h5>
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">×</span>
		          </button>
		        </div>
		        
			<form id="modalForm" action="/salary/startPR" method="post">
		        <div class="modal-body" style="width:90%;margin:0px auto;">
		        	<div>
		        		
		        		<input id="hiddenInput" type="text" name="ptNo" value="" />
		        		
						<div class="row align-items-center mb-3 mt-3">
							<div class="inputNames"><label for="prStlNm">이름222</label></div>
							<div class="inputConts">
								<input type="text" id=prStlNm name="prStlNm" class="form-control" placeholder="ex) 1월 정기 급여" required /> <!-- value="${sessionScope.map.name}" -->
							</div><br/>
						</div>
						<div class="row align-items-center mb-1">
							<div class="inputNames"><label for="prYM">귀속월22</label></div>
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
		        	<button type="submit" class="btn btn-success mr-3" style="color:white;"> 정산 시작하기 → </button>
		        </div>
		        <sec:csrfInput/>
		    </form>
	      	</div>
	    </div>
	  </div>
<!-- 모달 끝!@@@@ -->

<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myFullsizeModal">
  Fullsize Modal
</button>
<!-- 급여명세서 모달 시작! -->
			
<div class="modal fade" id="myFullsizeModal" tabindex="-1" role="dialog" aria-labelledby="myFullsizeModalLabel">
  <div class="modal-dialog modal-fullsize2" role="document" style="width: 100%;">
    <div class="modal-content modal-fullsize2">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel"><img src="/resources/images/pay/glasses.png" style="width: 30px; height: 30px;">급여 명세서 미리보기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
        <hr>
      <div class="modal-body" id="modalbody" style="padding: 50px 15% 50px;">
        <button class="btn mb-2 btn-secondary" >귀속월</button>
        &nbsp;&nbsp;<span>날짜!~~하하 좋아여!! 좋았쓰</span><br><br>
        <h2 style="display: inline;">급여명세서!! </h2><span style="float: right; font-size: 20px;">이름 | 생년월일 | 사번 | 부서 </span>
        <br><br><br>
        
        <div style="border-top : 1px solid black;  padding: 5px; padding-bottom: 70px;">
		  <h3 style="display: inline-block; margin-top: 50px;"><strong>실수령액</strong> &nbsp;&nbsp;
		  2023.10.25지급 &nbsp;&nbsp;--------------------------------------------------------------------------------- &nbsp;&nbsp;2,000,031원</h3> 
		</div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 3px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " ><h3 class="title">지급내역</h3>
	        	</div>
	        	<div class="historyRight" style="float: right; "><h3 class="title">금액</h3></div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 3px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " ><h3 class="title">공제내역</h3></div>
	        	<div class="historyRight" style="float: right; "><h3 class="title">금액</h3></div>
	        </div>
        </div>
		
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
        
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >초과 근무 수당</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >지방 소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
        
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >초과 근무 수당</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >지방 소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
        
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >초과 근무 수당</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >지방 소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
        
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >초과 근무 수당</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >지방 소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		
		<div>
	        <div style="float: left; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;">
	        	<div class="historyLeft" style="float: left; " >기본급</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        
	        </div>
	        
	        <div style="float: right; width: 45%; border-bottom: 1px black solid; margin : 5px 20px 5px;" >
	        	<div class="historyLeft" style="float: left; " >소득세</div>
	        	<div class="historyRight" style="float: right; ">금액</div>
	        </div>
        </div>
		

        


        
        
        
      </div>
        
        
      <div  id="wrapper">
        
      </div>
      <footer class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-primary" id="savePdfButton">PDF다운로드</button>
		</footer>
    </div>
  </div>
</div>
			

<!-- 급여명세서 모달 끝!   -->





</body>

<script>
document.getElementById('savePdfButton').addEventListener('click', function() {
  // 화면을 캡처할 요소를 선택합니다. 여기에서는 body를 선택했습니다.
  const captureElement = document.querySelector('#modalbody');
//   const captureElement = document.body;.
  
  // 화면을 캡처하고 이미지 데이터를 생성합니다.
  html2canvas(captureElement).then(canvas => {
    // PDF 문서를 생성합니다.
    const pdf = new jsPDF('p', 'mm', 'a4');
    
    // 캡처한 이미지를 PDF에 추가합니다.
    pdf.addImage(canvas.toDataURL('image/jpeg'), 'JPEG', 0, 0, 210, 297); // A4 페이지 크기
    
    // PDF를 저장합니다. 파일 이름을 'saved.pdf'로 지정할 수 있습니다.
    pdf.save('saved.pdf');
  });
});
</script>
</html>