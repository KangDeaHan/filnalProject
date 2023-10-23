<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설정</title>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
div {
/*     border: 1px solid blue;       */
}

.dropzone.bg-light.rounded-lg.dz-clickable {
	width: 150px;
	height: 10px;
	margin: 0 auto;
}

.card-deck{
	width: 40vw;
	margin: 0 auto;
}
#buttonDiv{
	float: right;
}
.saveButton {
	background: #3783C6;
	border-radius: 10px;
	padding: 10px 20px;
	color: white;
	border: none;
	font-weight: 900;
	margin-bottom: 15px;
} 

.cancelBtn {
	background: white;
	border-radius: 10px;
	padding: 10px 20px;
	color: #556372;
	cursor: pointer;
	border: 1px solid #E9EAEA;
	font-weight: 900;
}

</style>
</head>
<script>
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

let fUp;
$(function(){
	document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
		//카카오 지도 발생
		new daum.Postcode({
			oncomplete: function(data) { //선택시 입력값 세팅
				document.getElementById("address_kakao").value = data.address; // 주소 넣기
				document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
			}
		}).open();
	});

	fUp = document.querySelector("#companyForm");
	fUp.addEventListener("submit",fUpdate);
	
	const $myFile = $("input[name='file']"); //파일
	const $preImg = $("#preImg"); //이미지
	const myimg = document.querySelector("#myImg");
	

	//파일미리보기
	$myFile.on("change",()=>{
		var formData = new FormData();
		formData.append("file",$myFile[0].files[0]);
	
		$.ajax({
	          type : "post",
	          url : "/setting/file/preview",
	          data : formData,    //JSON.stringify 하지 않음에 주의!
	          contentType:false,  //defult값이 application/x-www-form-urlencoded
	          processData:false,  //defult값이 application/x-www-form-urlencoded
	          cache:false,        //요건 선택 권장!
	          dataType : "text",
	          beforeSend:function(xhr){
			  xhr.setRequestHeader(header,token);
			  },
	          success : function(rslt){
	        	    var newImg = $("<img>")
	        	        .attr("src", rslt)
	        	        .css({
	        	            width: "200px",
	        	            height: "100px"
	        	        });
	
	        	    $preImg.empty().append(newImg);
	          },
	          error:function(xhr, status, error){
	              console.log("code: " + xhr.status)
	              console.log("message: " + xhr.responseText)
	              console.log("error: " + error);
	          }
	     });
	});
	
	
	
	function fUpdate() {
		event.preventDefault();
		console.log("췌궥")
	
		const coNm = document.querySelector("#coName").value;
		const coRep = document.querySelector("#CEO").value;
		const coTel = document.querySelector("#coTel").value;
		const coEstdDate = document.querySelector("#coDate").value;
		const coAddr = document.querySelector("#address_kakao").value;
		const coAddr2 = document.querySelector("#address_detail").value;
		const coRegno = document.querySelector("#coRegno").value;
		const corRegno = document.querySelector("#corRegno").value;
		
		let companyInfoVO = {
			"coNm":coNm,
			"coRep":coRep,
			"coTelno":coTel,
			"coEstdDate":coEstdDate,
			"coAddr":coAddr,
			"coAddr2":coAddr2,
			"coRegno":coRegno,
			"corRegno":corRegno,
		}
		
		console.log("kgb", companyInfoVO);
		
		//로고 업데이트
		var formData = new FormData();
		formData.append("file",$myFile[0].files[0])
		$.ajax({
			url:"/setting/logoFile/fileUpdate",
			type:"post",
			data:formData,
	        contentType:false,  //defult값이 application/x-www-form-urlencoded
	        processData:false,  //defult값이 application/x-www-form-urlencoded
	        cache:false,        //요건 선택 권장!
			dataType:"text",
	        beforeSend:function(xhr){
				  xhr.setRequestHeader(header,token);
			},
			success : function(result){
				if(result!=null || result !=""){
					console.log(result)
					myimg.src = result;
				    $preImg.empty()
				    
				    $.ajax({
						type: "POST",
						url: "/setting/companyinfo/update",
						data: JSON.stringify(companyInfoVO),
						contentType: "application/json;charset=utf-8",
						//processData: false,
						beforeSend:function(xhr){
							xhr.setRequestHeader(header,token);
						},
						success: function (rslt) {
							console.log(rslt);
							if(rslt) {
								Swal.fire({
									title: "등록 완료",
							        text: "",
							        icon: "success",
							        confirmButtonText: "확인"
								}).then(function() {
									$.ajax({
										 type: "POST",
										 url: "/setting/getLogo",
										 beforeSend:function(xhr){
											 xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
										 },
									   	 success:function(result){
									   		 console.log(result);
									   		 
									   		 $("#logoImg").attr("src", result);
									   	 },
									   	 error: function (xhr, status, error) {
											 console.log("code: " + xhr.status);
											 console.log("message: " + xhr.responseText);
											 console.log("error: " + error);
										 },
									});
							    });
							} else {
								Swal.fire({
									title: "등록 실패",
							        text: "",
							        icon: "error",
							        confirmButtonText: "확인"
								});
							}
						},
						error: function (xhr, status, error) {
							console.log("code: " + xhr.status);
							console.log("message: " + xhr.responseText);
							console.log("error: " + error);
						},
					});
				}
			},
	        error:function(xhr, status, error){
	            console.log("code: " + xhr.status)
	            console.log("message: " + xhr.responseText)
	            console.log("error: " + error);
	        }
			
		});
	}
	
}); //function
</script>
<body>
<form id="companyForm" action="/companyinfo/update" method="POST" enctype="multipart/form-data">
<sec:csrfInput />
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-12">
				<h1 class="page-title" style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>회사 정보 설정</h1>
				<hr>
				<br>
				<div class="card-deck">
					<div class="card shadow mb-4">
						<div class="card-header">
							<div id="logoDiv1" style="width:60px; margin: 0 auto;">
								<h6 class="text-muted mt-4">회사 로고</h6>
							</div>
							<div id="logoDiv2" style="width:150px; margin: 0 auto;">
								<div><img id="myImg" src="${companyInfoVO.fileList[0].svfiName }" style="width: 150px; height: 75px;"></div>
								<div id="preImg"></div>
							</div>
							<br>
							<div id="logoDiv3" style="width:180px; margin: 0 auto;">
								<input type="file" name="file">
							</div>
						</div>
						<div class="card-body">
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="coName">회사명</label> <input type="text"
											class="form-control" id="coName" name="coNm" value="${companyInfoVO.coNm}"
											placeholder="회사명" required>
									</div>
									<div class="form-group col-md-6">
										<label for="CEO">대표자</label> <input type="text"
											class="form-control" id="CEO" name="coRep" value="${companyInfoVO.coRep}" 
											placeholder="대표자명">
									</div>
								</div>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="coTel">회사 전화번호</label> <input type="text"
											class="form-control" id="coTel" name="coTel" value="${companyInfoVO.coTelno}"
											placeholder="회사 전화번호">
									</div>
									<div class="form-group col-md-6">
										<label for="coDate">설립일</label> <input class="form-control"
											id="coDate" type="date" name="coEstdDate" value="${companyInfoVO.coEstdDate}">
									</div>
								</div>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="inputAddress">회사 주소</label> 
										<input type="text" class="form-control" id="address_kakao" name="address" value="${companyInfoVO.coAddr}"
											placeholder="주소 검색" /> 
									</div>
									<div class="form-group col-md-6">
										<label for="inputAddressDetail">상세주소</label> 
										<input type="text" class="form-control" id="address_detail" name="address_detail" value="${companyInfoVO.coAddr2}"
											placeholder="상세 주소" />
									</div>
								</div>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="coRegno">사업자등록번호</label> <input type="text"
											class="form-control" id="coRegno" name="coRegno" value="${companyInfoVO.coRegno}"
											placeholder="사업자등록번호">
									</div>
									<div class="form-group col-md-6">
										<label for="corRegno">법인등록번호</label> <input type="text"
											class="form-control" id="corRegno" name="corRegno" value="${companyInfoVO.corRegno}"
											placeholder="법인등록번호">
									</div>
								</div>
								<div id="buttonDiv">
									<button id="saveButton" class="saveButton">저장</button>
									<a href="setmain"><button type="button" class="cancelBtn">취소</button></a>
								</div>
						</div>
					</div>
				</div>
				<!-- / .card-desk-->
			</div>
			<!-- .col-12 -->
		</div>
		<!-- .row -->
	</div>
</form>
</body>
<script>

</script>
</html>