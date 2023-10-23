<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

	<h5 style="margin-left:25px;">
		<a href="/salary/tmpList" class="aTag"><span class="fe fe-24 fe-chevron-left spanTag"></span></a>&nbsp
		<a href="/salary/tmpList" class="aTag">정산템플릿 설정</a>
	</h5>
	<hr>
	<h5 style="margin-left:25px;">
		<a href="/salary/tmpUpdate?ptNo=${param.ptNo}" class="aTag" >기본 설정</a>&nbsp;&nbsp; 
		<a href="/salary/payList?ptNo=${param.ptNo}" class="aTag gray-link">지급 항목</a>&nbsp;&nbsp; 
		<a href="/salary/dedList?ptNo=${param.ptNo}" class="aTag gray-link">공제 항목</a>
	</h5>
	<hr>


<form id="tmpUpForm" action="/salary/tmpUpdate">

	<div class="row justify-content-end" style="margin-top:70px;margin-bottom:30px;">
		<button type="reset" class="btn mb-2 btn-outline-secondary">취소</button>&nbsp&nbsp&nbsp
		<button class="btn mb-2 btn-success"
				style="color: white;margin-right:30px;">✓ 수정하기</button>
	</div>
	
	                                                      <!--  ajax로 쓰기 input의 value를 data로 ajax로 보내기. (json 형식으로 보내기)  -->
	<div class="card shadow mb-4">
		<div class="card-body">
	    	<h5 style="display:inline-block;margin-bottom:0px;">템플릿 정보&nbsp</h5><img src="/resources/images/salary/document.png"/>
			<span style="float:right" class="spanTag">템플릿 항목 정보를 입력해주세요</span>
			<hr><br><br>
		
				<input type="hidden" name="ptNo" value="${data.ptNo}" /> <!-- 나중에 hidden으로 고치기  -->
				<div class="input-container justify-content-center">
			    	<div style="width:80px">이름</div>
			    	<input type="text" class="form-control icon1" placeholder="ex) 연차수당 포함 급여" 
			    	name="ptNm" value="${data.ptNm}" required/><br />
			    </div>
			    <div class="input-container justify-content-center">
			    	<div style="width:80px">설명</div>
			        <input type="text" class="form-control icon2" 
			        placeholder="연차수당이 정산되는 달의 급여입니다"
			        name="ptEpn" value="${data.ptEpn}" required/><br />
			    </div>
			  
	    </div> 
	</div>
	
</form>  

<script>

const tmpUpForm = document.querySelector("#tmpUpForm"); //form태그

tmpUpForm.addEventListener("submit", updateAjax); //form 전송 직전에 발생하는 이벤트

function updateAjax() {
	
	event.preventDefault();//폼 전송 막기 (built-in 기능 막기)
	
	console.log("넘어왔닝???");
	
	let data = {
			 "ptNo":$("input[name='ptNo']").val()
			,"ptNm":$("input[name='ptNm']").val()
			,"ptEpn":$("input[name='ptEpn']").val()
	};

	$.ajax({
		url: "/salary/tmpUpdate",
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type : "put",
		dataType : "text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success : function(result){
			console.log("업데이트 성공?:", result);
			if(result=="success"){
				Swal.fire({
					title:'수정 완료!', // Alert 제목
					icon:'success'  // Alert 타입
				});
			}else {
				Swal.fire({
					title:'수정 실패!', 
					icon:'error'              
				});
			}
		},
		error:function(xhr, status, error){
			console.log("code: " + xhr.status)
			console.log("message: " + xhr.responseText)
			console.log("error: " + error);
		}
	})//ajax끝

}//updateAjax()끝

//////////////////////////////////////////////////////////
//페이지 로드 되자마자 실행

	///salary/tmpUpdate?ptNo=8
	let insertRes = "${insertRes}";	//EL변수 -> J/S변수 받으려면 이렇게 해야함
	console.log("insertRes : " + insertRes);

	if(insertRes==1){
		Swal.fire({
			title:'등록 완료!', // Alert 제목
	  		icon:'success'   // Alert 타입
		});
	}




</script>
</body>
</html>