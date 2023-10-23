<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="favicon.ico">
<title>로그인</title>
<!-- Simple bar CSS -->
<link rel="stylesheet" href="/resources/light/css/simplebar.css">
<!-- Fonts CSS -->
<link
	href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">
<!-- Icons CSS -->
<link rel="stylesheet" href="/resources/light/css/feather.css">
<!-- Date Range Picker CSS -->
<link rel="stylesheet" href="/resources/light/css/daterangepicker.css">
<!-- App CSS -->
<link rel="stylesheet" href="/resources/light/css/app-light.css" id="lightTheme">
<link rel="stylesheet" href="/resources/light/css/app-dark.css" id="darkTheme" disabled>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
console.log("여기?")
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

let findPw;

$(function(){
	findPw = document.querySelector("#findPwForm");
	findPw.addEventListener("submit", fPw);
});

function fPw(){
	event.preventDefault();
	
	const userId = $("#userId").val();
	const birthday = $("#birthday").val();
	const myEmail = $("#myEmail").val();
	
	console.log("###" + userId)
	console.log("###" + birthday)
	console.log("###" + myEmail)
	
	$.ajax({
		url : "/common/findPw",
		type : "post",
		data : JSON.stringify({
			"userId" : userId,
			"birthday" : birthday,
			"myEmail" : myEmail
		}),
		contentType: "application/json;charset=utf-8",
        cache:false,        //요건 선택 권장!
		dataType:"text",
        beforeSend:function(xhr){
			  xhr.setRequestHeader(header,token);
		},
	    success: function(result) {
	        if (result == "0") {
	        	alert("임시 비번이 이메일로 발송되었습니다.");
	        	location.href ="/common/login";
	        } else if (result == "-1") {
	        	alert("다시 확인해주세요");
	        } else if (result == "-2") {
	            console.log("오류가 발생했습니다. 다시 시도해주세요.");
	        }
	    },
	    error: function(xhr, textStatus, errorThrown) {
	        // AJAX 요청 오류 처리
	        console.error("AJAX 오류: " + textStatus);
	    }
	})
}

function autoWrite(){
	let id = "202307024";
	let regn = "950724";
	let emMail = "p123abc@naver.com";
	
	$("#userId").val(id);
	$("#birthday").val(regn);
	$("#myEmail").val(emMail);
}

</script>

<style type="text/css">
#text{
	font-size: 15px;
}
</style>

<body class="light ">
	<div class="wrapper vh-100">
		<div class="row align-items-center h-100">
			<form class="col-lg-3 col-md-4 col-10 mx-auto text-center" action="" method="post" id="findPwForm">
				<a class="navbar-brand mx-auto mt-2 flex-fill text-center"	href="/common/login">
					<img src="/resources/images/logo.png" alt="회사로고" style="width:300px;">
				</a>
				<br>
				<div id= "text">사원번호와 생년월일 이메일을 입력해주세요.</div>
				<br>
				<div class="form-group">
					<label for="userId" class="sr-only">사원번호</label>
					<input type="text" name="userId" id="userId" class="form-control form-control-lg"
						   placeholder="ex) 202309001" required autofocus>
				</div>
				<div class="form-group">
					<label for="birthday" class="sr-only">생년월일</label> <input
						type="text" id="birthday" name="birthday"
						class="form-control form-control-lg" placeholder="ex) 951017" required>
				</div>
				
				<div class="form-group">
					<label for="myEmail" class="sr-only">이메일</label> <input
						type="text" id="myEmail" name="myEmail"
						class="form-control form-control-lg" placeholder="ex) abc123@naver.com"	required>
				</div>
				<br>
				<button id="sub" class="btn btn-lg btn-primary btn-block" type="submit">비밀번호 찾기</button><br/>
				<button type="button" class="btn mb-2 btn-outline-dark " onclick ="autoWrite()">이현학 사원 자동채우기</button>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
	<script src="/resources/light/js/jquery.min.js"></script>
	<script src="/resources/light/js/popper.min.js"></script>
	<script src="/resources/light/js/moment.min.js"></script>
	<script src="/resources/light/js/bootstrap.min.js"></script>
	<script src="/resources/light/js/simplebar.min.js"></script>
	<script src='/resources/light/js/daterangepicker.js'></script>
	<script src='/resources/light/js/jquery.stickOnScroll.js'></script>
	<script src="/resources/light/js/tinycolor-min.js"></script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async
		src="https://www.googletagmanager.com/gtag/js?id=UA-56159088-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];

		function gtag() {
			dataLayer.push(arguments);
		}
		gtag('js', new Date());
		gtag('config', 'UA-56159088-1');
		

		

		
	</script>
</body>
</html>
</body>
</html>