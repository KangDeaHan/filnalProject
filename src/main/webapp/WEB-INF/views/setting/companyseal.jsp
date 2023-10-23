<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 직인 설정</title>
<style>
div {
	/* 	border: 1px solid blue; */
	
}

#header {
	height: 15vh;
}

.custom-select {
	width: 150px;
	text-align: center;
	padding-right: 12px;
}
.dropzone.bg-light.rounded-lg.dz-clickable {
	margin: auto;
	width: 200px;
	height: 200px;
}
.card.shadow.mb-4 {
	width: 40vw;
	margin: 0 auto;
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
	const $myFile = $("input[name='file']"); //파일
	const $preImg = $("#preImg"); //이미지
	const myimg = document.querySelector("#myImg");
	
	fUp = document.querySelector("#sealForm");
	fUp.addEventListener("submit",fUpdate);
	
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
	        	            width: "250px",
	        	            height: "250px"
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
	
		//로고 업데이트
		var formData = new FormData();
		formData.append("file",$myFile[0].files[0])
		$.ajax({
			url:"/setting/sealFile/fileUpdate",
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
				    Swal.fire({
						title: "등록 완료",
				        text: "",
				        icon: "success",
				        confirmButtonText: "확인"
					})
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
<form id="sealForm" action="" method="POST" enctype="multipart/form-data">
	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>회사 직인 설정</h1>
			<hr>
			<br>
		</div>
		<div class="card shadow mb-4">
			<div class="card-header">
				<select class="custom-select" id="custom-select">
					<option selected="1">직접 업로드</option>
					<option value="2">자동 생성</option>
				</select>
			</div>
			<div class="card-body">
				<h6 class="text-muted mt-4" style="width:60px; margin: 0 auto;">회사 직인</h6>
				<div style="width:200px; margin: 0 auto;">
					<img id="myImg" src="${companyInfoVO.fileList[0].svfiName}" style="width: 200px; height: 200px;">
					<div id="preImg"></div>
				</div>
				<br>
				<div style="width:180px; margin: 0 auto;">
					<input type="file" name="file">
				</div>
				<br><br><br><br><br><br>
				<div style="float: right;">
					<button class="saveButton">저장</button>
	                <a href="setmain"><button type="button" class="cancelBtn">취소</button></a>
                </div>
			</div>
			<!-- .card-body -->
		</div>
	</div>
</form>
</body>
</html>