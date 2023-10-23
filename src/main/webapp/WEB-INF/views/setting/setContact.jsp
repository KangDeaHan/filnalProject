<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만든 사람들</title>

<style>
	div {
/*    		border: 1px solid blue;   */
	}
	.divline {
		border: 1px solid rgb(219, 218, 218);
		border-radius: 5px;
		display: inline-block;
		width: 250px;
		height: 150px;
		margin: 3px;
	}
	.divImg {
		width: 84.96px;
		height: 113.4px;
		display: inline-block;
		border: 2px solid black;
		border-radius: 15px;
	}
	.enm {
		display: inline-block;
		margin-left: 40px;
		font-weight: bold;
	}
	#headDiv {
		margin-bottom: 50px;
	}
</style>
</head>

<script>
	
</script>

<body>
	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>만든 사람들</h1>
			<hr>
			<br>
		</div>
		<div class="card shadow mb-4">
			<div class="card-body" id="">
				<div id="headDiv">
					<h5>대덕인재 402호 2023년 3월반</h5>
					<br>
					<h5>2조 인사이트</h5>
				</div>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/임민우.jpg" class="divImg">
					<p class="enm" id="enm1">임민우</p>
				</div>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/곽우재.jpg" class="divImg">
					<p class="enm" id="enm2">곽우재</p>
				</div>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/김수지.jpg" class="divImg">
					<p class="enm" id="enm3">김수지</p>
				</div>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/김승종.jpg" class="divImg">
					<p class="enm" id="enm4">김승종</p>
				</div>
				<br>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/이현학.jpg" class="divImg">
					<p class="enm" id="enm5">이현학</p>
				</div>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/박병철.jpg" class="divImg">
					<p class="enm" id="enm6">박병철</p>
				</div>
				<div class="card-body divline">
					<img src="/resources/images/setting/profile/신진수.jpg" class="divImg">
					<p class="enm" id="enm7">신진수</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>