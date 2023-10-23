<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>
	.pdItem {
		margin-right: 20px;
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

	.input-container { 
		display: flex; 
		align-items: center;
	}

    .input-text { 
        flex: 1; 
   } 

    .input-image {
        width: 100px; /* 이미지의 너비 조절 */
        height: auto; /* 이미지의 높이 자동으로 조절 */
    }
    .card{
    	width : 600px;
		height : 300px;
		margin: 0 auto; 
    }
    input {
    	width : 500px;
    	margin : 10px;
    	height : 40px;
    }   
    .spanTag {
    	margin-right : 10px;
    }
    .icon1 { 
    	background-image : url(/resources/images/salary/pen.png);
    	background-repeat: no-repeat;
    	background-position: 10px center;
    	padding-left: 40px;
    	box-sizing: border-box;
    	background-size: 14px 14px; /* 원하는 가로 및 세로 크기로 설정합니다. */
    }
    .icon2 {
    	background-image : url(/resources/images/salary/speech-bubble.png);
    	background-repeat: no-repeat;
    	background-position: 10px center;
    	padding-left: 40px;
    	box-sizing: border-box;
    	background-size: 14px 14px; /* 원하는 가로 및 세로 크기로 설정합니다. */
    }
    .gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important; 
	}
</style>
<meta charset="UTF-8">
<title>정산템플릿 추가</title>
</head>
<body>

	<h5>
		<a href="/salary/tmpList" class="aTag"><span class="fe fe-24 fe-chevron-left spanTag"></span></a>&nbsp
		<a href="/salary/tmpList" class="aTag">정산템플릿 설정</a>
	</h5>
	<hr>
	<h5>
		<a href="/salary/tmpInsert" class="aTag">기본 설정</a>&nbsp;&nbsp; 
		<span class="pdItem gray-link spanTag" >지급 항목</span>&nbsp;&nbsp; 
		<span class="pdItem gray-link spanTag">공제 항목</span>
	</h5>
	<hr>

<form id="tmpForm" action="/salary/tmpInsert" method="post">
	<div class="row justify-content-end" style="margin-top:70px;margin-bottom:30px;">
		<button type="reset" id="tmpReset" class="btn mb-2 btn-outline-secondary">취소</button>&nbsp&nbsp&nbsp
		<button type="submit" id="tmpInsert" class="btn mb-2 btn-success"
										style="color: white;margin-right:30px;">✓ 저장하기</button>
	</div>


	<div class="card shadow mb-4">
		<div class="card-body">
	    	<h5 style="display:inline-block;margin-bottom:0px;">템플릿 정보&nbsp</h5><img src="/resources/images/salary/document.png"/>
			<span style="float:right" class="spanTag">템플릿 항목 정보를 입력해주세요</span>
			<hr><br><br>
			
	
				<div class="input-container justify-content-center">
			    	<div style="width:80px">이름</div>
			    	<input type="text" class="form-control icon1" id="ptNm" name="ptNm" placeholder="ex) 연차수당 포함 급여" required><br>
			    </div>
			    <div class="input-container justify-content-center">
			    	<div style="width:80px">설명</div>
			        <input type="text" class="form-control icon2" id="ptEpn" name="ptEpn" placeholder="연차수당이 정산되는 달의 급여입니다" required><br>
			    </div>
			    <button type="button" class="btn mt-2 mr-3 btn-outline-dark" style="float:right;" onclick ="autoWrite()">자동채우기</button>
			    <sec:csrfInput/>
	      
	    </div> 
	</div>
</form>

<script>
//자동채우기
function autoWrite(){
	
   let ptNm = "테스트 템플릿";
   let ptEpn = "테스트 템플릿 설명입니다.";
   
   $("#ptNm").val(ptNm);
   $("#ptEpn").val(ptEpn); 
}
</script>
</body>
</html>