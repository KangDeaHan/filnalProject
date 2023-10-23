<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
/*  	div {  */
/* 		border : 1px solid blue;  */
/*  	}  */
	/* 링크 스타일 */
	a {
		text-decoration: none; /* 밑줄 제거 */
		color: #333; /* 일반 텍스트 색상 */
		margin-right: 20px; /* 각 링크 사이의 간격 조절 */
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
		height : 350px;
		margin: 0 auto; 
    }
    input {
    	width : 500px;
    	margin : 10px;
    	height : 40px;
    }   
    span {
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
    	background-image : url(/resources/images/salary/north-korea-won.png);
    	background-repeat: no-repeat;
    	background-position: 10px center;
    	padding-left: 40px;
    	box-sizing: border-box;
    	background-size: 14px 14px; /* 원하는 가로 및 세로 크기로 설정합니다. */
    }
    .icon3 {
    	background-image : url(/resources/images/salary/speech-bubble.png);
    	background-repeat: no-repeat;
    	background-position: 10px center;
    	padding-left: 40px;
    	box-sizing: border-box;
    	background-size: 14px 14px; /* 원하는 가로 및 세로 크기로 설정합니다. */
    }
    .icon4 {
    	background-image : url(/resources/images/salary/percent.png);
    	background-repeat: no-repeat;
    	background-position: 10px center;
    	padding-left: 40px;
    	box-sizing: border-box;
    	background-size: 14px 14px; /* 원하는 가로 및 세로 크기로 설정합니다. */
    }
    .garo {
    	width:80px;
    }
</style>
<meta charset="UTF-8">
<title>공제 항목 수정</title>
</head>
<body>

	<h5>
		<a href="/salary/tmpList"><span class="fe fe-24 fe-chevron-left"></span></a>&nbsp
		<a href="/salary/tmpList">정산템플릿 설정</a>
	</h5>
	<hr>
	<h5>
		<a href="/salary/tmpUpdate?ptNo=${param.ptNo}">기본 설정</a>&nbsp;&nbsp; 
		<a href="/salary/payList?ptNo=${param.ptNo}">지급 항목</a>&nbsp;&nbsp; 
		<a href="/salary/dedList?ptNo=${param.ptNo}">공제 항목</a>
	</h5>
	<hr>
	
	<h2 style="margin-top:30px;">공제 항목 설정</h2>

<form id="dedUpForm" action="/salary/dedUpdate" method="post">
	<div class="row justify-content-end" style="margin-top:30px;margin-bottom:30px;">
		<button type="reset" class="btn mb-2 btn-outline-secondary">취소</button>&nbsp&nbsp&nbsp
		<button type="submit" class="btn mb-2 btn-success"
										style="color: white;margin-right:30px;">✓ 수정하기</button>
	</div>
	
	<div class="card shadow mb-4">
		<div class="card-body">
	    	<h5 style="display:inline-block;margin-bottom:0px;">항목 정보&nbsp</h5><img src="/resources/images/salary/document.png"/>
			<span style="float:right">공제 항목 정보를 입력해주세요</span>
			<hr><br><br>
			
			<input type="hidden" name="ptNo" value="${param.ptNo}" />
			<input type="hidden" name="pdType" value="B0402" /> <!-- 공제항목 : B0402 -->
			<input type="hidden" name="pdNo" value="${data.pdNo}" />
			
			<div class="input-container justify-content-center">
		    	<div class="garo">이름 *</div>
		    	<input type="text" class="form-control icon1" name="pdNm" value="${data.pdNm}" placeholder="ex) 사내동호회비" required /><br/>
		    </div>
		    <div class="input-container justify-content-center">
		    	<div class="garo">공제 금액</div>
		        <input type="number" class="form-control icon2" name="pdAmt" value="${data.pdAmt}" pattern="[0-9]*" placeholder="ex) 10,000 (해당시 숫자만 입력)" /><br/> <!-- 숫자만 입력할 수 있도록 고정! 정규식?? -->
		    </div>
		    <div class="input-container justify-content-center">
		    	<div class="garo">설명 *</div>
		        <input type="text" class="form-control icon3" name="pdEpn" value="${data.pdEpn}" placeholder="ex) 사내 동호회비 공제"  required /><br/>
		    </div>
    		
            <sec:csrfInput/>
          
	    </div> 
	</div>
</form>  

</body>
</html>