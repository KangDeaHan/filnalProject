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

<body class="light ">
	<div class="wrapper vh-100">
		<div class="row align-items-center h-100">
			<form class="col-lg-3 col-md-4 col-10 mx-auto text-center" action="/login" method="post">
				<a class="navbar-brand mx-auto mt-2 flex-fill text-center"	href="/common/login">
					<img src="/resources/images/logo.png" alt="회사로고" style="width:300px;">
				</a>
				<div class="form-group">
					<label for="inputEmail" class="sr-only">Email address</label>
					<input type="text" name="username" id="inputEmail" class="form-control form-control-lg"  placeholder="ID" required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <input
						type="password" id="inputPassword" name="password"
						class="form-control form-control-lg" placeholder="Password"	required>
				</div>
				<div class="checkbox mb-3">
					<label> <input type="checkbox" value="remember-me">
						ID 기억하기
					</label>
				</div>
				<button id="sub" class="btn btn-lg btn-primary btn-block" type="submit">Login</button><br/>
				<a href="/common/findPw"><p>비밀번호를 잊으셨나요?</p></a>
				<input  type="button" class="btn mb-2 btn-outline-dark" onclick="fAutoId(this)" value="최고관리자">
				<input type="button" class="btn mb-2 btn-outline-dark" onclick="fAutoId(this)" value="인사담당자">
				<input type="button" class="btn mb-2 btn-outline-dark" onclick="fAutoId(this)" value="근무담당자">
				<input type="button" class="btn mb-2 btn-outline-dark" onclick="fAutoId(this)" value="급여정산자">
				<input type="button" class="btn mb-2 btn-outline-dark" onclick="fAutoId(this)" value="일반사원">
				<input type="button" class="btn mb-2 btn-outline-dark" onclick="fAutoId(this)" value="중간관리자">
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
		
		
	    function fAutoId(result){
	    	let auth = result.value;
	    	console.log(auth)
	    	let $id = $("#inputEmail")
	    	let $pass = $("#inputPassword")
	    	
	    	console.log($id,$pass)
	    	
	    	if(auth == "최고관리자"){
	    		$id.val("202310002")
	    		$pass.val("java")
	    	}else if(auth == "인사담당자"){
	    		$id.val("202310003")
	    		$pass.val("1234")
	    	}else if(auth == "근무담당자"){
	    		$id.val("202310005")
	    		$pass.val("1234")
	    	}else if(auth == "급여정산자"){
	    		$id.val("202310004")
	    		$pass.val("1234")
	    	}else if(auth == "일반사원"){
	    		$id.val("202310007")
	    		$pass.val("1234")
	    	}else if(auth == "중간관리자"){
	    		$id.val("202309001")
	    		$pass.val("java")
	    	}
	    }
	    
	</script>
	
</body>
</html>
</body>
</html>