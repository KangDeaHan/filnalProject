<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>휴가 설정</title>

<style>
	div {
/* 	   	border: 1px solid blue;    */
	}

	.divline {
		border: 1px solid rgb(219, 218, 218);
		border-radius: 5px;
		display: inline-block;
		width: 80vw;
		padding: 10px;
		
	}

	.divline2 {
		border: 1px solid rgb(219, 218, 218);
		border-radius: 5px;
		display: inline-block;
		width: 250px;
		height: 150px;
		margin: 3px;
	}

	#vacInsertBtn, #yearInsertBtn {
		vertical-align: top;
		float: right;
		width: 150px;
	}

	.vacInsert {
		display: inline-block;
		vertical-align: top;
		margin-top: 3px;
	}

	#plus, #chevron-right {
		display: inline-block;
	}

	#vacTypeHead {
		display: inline-block;
		margin-top: 10px;
	}
	
	#yearHead {
		display: inline-block;
		margin-top: 10px;
	}
	

	.vacIcon, .vacIcon1, .vacationIcon, .vacationIcon1 {
		width: 50px;
		height: 50px;
	}

	/* 라디오 버튼 css */
	.select {
		/* padding: 15px 10px; */
		padding: 0px;
		width: 220px;
		margin-top: 12px;
	}

	.select input[type=radio] {
		display: none;
	}

	.select input[type=radio]+label {
		display: inline-block;
		cursor: pointer;
		height: 24px;
		width: 70px;
		border: 1px solid #333;
		line-height: 24px;
		text-align: center;
		font-weight: bold;
		font-size: 13px;
	}

	.select input[type=radio]+label {
		background-color: #fff;
		color: #333;
	}

	.select input[type=radio]:checked+label {
		background-color: #333;
		color: #fff;
	}

	#targetDiv, #targetDiv1 {
		display: none;
		width: 280px;
		height: 160px;
	}
	
	.modal-content {
	    max-height: 100vh; /* 스크롤 최대 높이 설정 */
	    overflow-y: auto; /* 세로 스크롤 활성화 */
	}
	
	.basic {
		margin-left: 10px;
	}
	
	.labelBasic {
		font-weight: bold;
	}
	
	label {
		font-weight: bold;
	}
	
	#toggleButton, #toggleButton1 {
		margin-left: 131px;
	}
	
	.leftDiv {
		display: inline-block;
	}
	
	.rightDiv {
		float: right;
		width: 250px;
		margin-left: 30px;
	}
	.mb-3 {
		width: 350px;
	}
	.divVacImg {
		width: 50px;
		height: 50px;
		display: inline-block;
	}
	.vacTypeNm {
		font-weight: bold;
	}
	.dropdown {
		float: right;
	}
	.div1 {
		display: inline-block;
		width: 23vw;
	}
	.p1 {
		font-size: small;
		margin-bottom: 0px;
	}
	.p2 {
		margin-bottom: 0px;
		font-weight: bold;
	}
	.saveButton {
	background: #3783C6;
	border-radius: 10px;
	padding: 10px 20px;
	color: white;
	border: none;
	font-weight: 900;
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

	function fAutoFill() {
		$("#vacTypeName").val("테스트휴가");
		$("#vhInfo").val("테스트휴가 입니다");
		$("#vacTypeExp").val("V0202");
		$("#vacTypeDay").val("2");
		$("#time2").prop('checked', true);
		$("#holi2").prop('checked', true);
		$("#sal2").prop('checked', true);
		$("#gender1").prop('checked', true);
		$("#vacTypeFile1").prop('checked', true);
	}
	
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	
	
	$(document).ready(function() {
	    // 맞춤 휴가 수정 모달이 열릴 때 이벤트 리스너 추가
	    $('.modal-right1').on('show.bs.modal', function (event) {
	        var modal = $(this);
	        
	        // 클릭한 휴가 종류 목록의 ID를 가져와서 해당 휴가 종류 정보를 조회
	        var vacationId = $(event.relatedTarget).closest('.edit-vacation').data('vacation-id');
	        
	        console.log("vacationId:::", vacationId);
	        // AJAX 요청을 사용하여 서버에서 휴가 종류 정보 가져오기
	        $.ajax({
	            url: '/setting/getVacationInfo/' + vacationId,
	            method: 'GET',
	            success: function(data) {
	            	console.log("data:::", data);
	                // 가져온 데이터를 모달 창에 적용
	                modal.find('#vacTypeName1').val(data.vacTypeName);
	                modal.find('#vhInfo1').val(data.vhInfo);
	                modal.find('#vacTypeDay1').val(data.vacTypeUseDate);
	                modal.find('#toggleButtonImage').attr('src', data.imgRoot);
	                modal.find('#vacTypeNo1').val(data.vacTypeNo);
	                modal.find('#imgRoot1').val(data.imgRoot);
	                
	                modal.find('input[name="vacTypeTime1"][value="' + data.vacTypeTime + '"]').prop('checked', true);
	                modal.find('input[name="vacTypeHoli1"][value="' + data.vacTypeHoli + '"]').prop('checked', true);
	                modal.find('input[name="vacTypeSal1"][value="' + data.vacTypeSal + '"]').prop('checked', true);
	                modal.find('input[name="vacTypeGender1"][value="' + data.vacTypeGender + '"]').prop('checked', true);
	                modal.find('input[name="vacTypeFile1"][value="' + data.vacTypeFile + '"]').prop('checked', true);
	                
	             	// 라디오 버튼에 대한 이벤트 리스너 추가
	                $('input[name="vacTypeTime1"]').on('change', function() {
	                    var selectedValue = $(this).val();
	                    data.vacTypeTime = selectedValue;
	                    modal.find('input[name="vacTypeTime1"][value="' + data.vacTypeTime + '"]').prop('checked', true);
	                });

	                $('input[name="vacTypeHoli1"]').on('change', function() {
	                    var selectedValue = $(this).val();
	                    data.vacTypeHoli = selectedValue;
	                    modal.find('input[name="vacTypeHoli1"][value="' + data.vacTypeHoli + '"]').prop('checked', true);
	                });

	                $('input[name="vacTypeSal1"]').on('change', function() {
	                    var selectedValue = $(this).val();
	                    data.vacTypeSal = selectedValue;
	                    modal.find('input[name="vacTypeSal1"][value="' + data.vacTypeSal + '"]').prop('checked', true);
	                });

	                $('input[name="vacTypeGender1"]').on('change', function() {
	                    var selectedValue = $(this).val();
	                    data.vacTypeGender = selectedValue;
	                    modal.find('input[name="vacTypeGender1"][value="' + data.vacTypeGender + '"]').prop('checked', true);
	                });

	                $('input[name="vacTypeFile1"]').on('change', function() {
	                    var selectedValue = $(this).val();
	                    data.vacTypeFile = selectedValue;
	                    modal.find('input[name="vacTypeFile1"][value="' + data.vacTypeFile + '"]').prop('checked', true);
	                });
	                
	                
	             	// 이미지를 클릭할 때 호출되는 함수
	                function selectIcon(imgSrc) {
	                    // imgRoot 입력 필드를 찾습니다.
	                    var imgRootInput = document.getElementById("imgRoot1");

	                    // imgRoot 입력 필드의 값을 선택한 이미지의 src로 설정합니다.
	                    imgRootInput.value = imgSrc;

	                    // 이미지를 표시합니다.
	                    var toggleButtonImage = document.getElementById("toggleButtonImage");
	                    toggleButtonImage.src = imgSrc;
	                    

	                    // targetDiv를 숨깁니다.
	                    var targetDiv = document.getElementById("targetDiv1");
	                    targetDiv.style.display = "none";
	                }

	                // 이미지를 클릭할 때 selectIcon 함수 호출
	                var images = document.querySelectorAll(".vacationIcon1");
	                images.forEach(function (image) {
	                    image.addEventListener("click", function () {
	                        var imgSrc = image.getAttribute("src");
	                        selectIcon(imgSrc);
	                    });
	                });

	                // 토글 버튼을 클릭할 때 targetDiv를 표시
	                var toggleButton = document.getElementById("toggleButton1");
	                var targetDiv = document.getElementById("targetDiv1");
	                console.log("toggleButton::", toggleButton);
	                toggleButton.addEventListener("click", function () {
	                    
	                    if (targetDiv.style.display == "none" || targetDiv.style.display == "") {
	                        targetDiv.style.display = "block";
	                    } 
	                    console.log("targetDiv::", targetDiv);
	                });
	                
	                
	             	// #vacTypeExp select 요소의 옵션들을 추가하기 전에 기존 옵션들을 모두 제거
	                modal.find('#vacTypeExp1').empty();

	                // 새로운 옵션들을 추가
	                var options = [
	                    { value: 'V0201', text: '신청시 지급' },
	                    { value: 'V0202', text: '매월 지급' },
	                    { value: 'V0203', text: '매년 지급' },
	                    { value: 'V0204', text: '근속시 지급' },
	                    { value: 'V0205', text: '연차 소진시 지급' },
	                    { value: 'V0206', text: '담당자가 직접 지급' }
	                    // 필요한 만큼 옵션을 추가
	                ];

	                options.forEach(function(option) {
	                    var $option = $('<option>', {
	                        value: option.value,
	                        text: option.text
	                    });

	                    if (data.vacTypeExp == option.value) {
	                        $option.prop('selected', true);
	                    }

	                    modal.find('#vacTypeExp1').append($option);
	                });
	                
	            },
	            error: function() {
	            	Swal.fire({
						title: "휴가 정보를 불러오는데 실패했습니다.",
				        text: "",
				        icon: "error",
				        confirmButtonText: "확인"
				    });
	            }
	        });
	        
	    });
	    
	}); // $(document).ready(function() 끝

	//버튼 클릭 이벤트 리스너를 추가합니다.
	document.addEventListener("DOMContentLoaded", function () {
		// 모든 이미지 요소에 클릭 이벤트 리스너 추가
		const images = document.querySelectorAll(".vacationIcon");
		const toggleButtonImage = document.querySelector("#toggleButton img");
		const targetDiv = document.querySelector("#targetDiv");
		
		images.forEach(function (image) {
			image.addEventListener("click", function () {
				// 이미지를 클릭한 이미지로 변경
				const src = image.getAttribute("src");
				toggleButtonImage.setAttribute("src", src);
				
				// imgRoot 값을 변경
                const imgRootInput = document.querySelector("#imgRoot");
                imgRootInput.value = src;
                
				targetDiv.style.display = "none"
			});
		});
	});

	let vacTypeUp;
	
	$(function () {
		
		//아이콘 토글 버튼
		document.querySelector("#toggleButton").addEventListener("click", function () {
			var targetDiv = document.querySelector("#targetDiv");
			// 현재 상태를 확인하여 토글
			if (targetDiv.style.display == "none" || targetDiv.style.display == "") {
				targetDiv.style.display = "block";
			}
		});
		
		vacTypeUp = document.querySelector("#setVacTypeForm1");
		vacTypeUp.addEventListener("submit", fVacTypeUp);
		
		document.getElementById("setVacTypeForm").addEventListener("submit", function (event) {
            event.preventDefault(); // 폼 제출 기본 동작을 막습니다.
			
            Swal.fire({
				  title: "저장 완료",
		          text: "",
		          icon: "success",
		          confirmButtonText: "확인"
		     }).then(function() {
		    	 document.getElementById("setVacTypeForm").submit();
		     });
        });
	});
	
	
	function fVacTypeUp() {
		event.preventDefault();
		
		const vacTypeNo = document.querySelector("#vacTypeNo1").value;
		const vacTypeName = document.querySelector("#vacTypeName1").value;
		const vacTypeExp = document.querySelector("#vacTypeExp1").value;
		const vacTypeUseDate = document.querySelector("#vacTypeDay1").value;
		const vhInfo = document.querySelector("#vhInfo1").value;
		const imgRoot = document.querySelector("#imgRoot1").value;
		const vacTypeTime = document.querySelector('input[name="vacTypeTime1"]:checked').value;
	    const vacTypeHoli = document.querySelector('input[name="vacTypeHoli1"]:checked').value;
	    const vacTypeSal = document.querySelector('input[name="vacTypeSal1"]:checked').value;
	    const vacTypeGender = document.querySelector('input[name="vacTypeGender1"]:checked').value;
	    const vacTypeFile = document.querySelector('input[name="vacTypeFile1"]:checked').value;
		
		let vacTypeVO = {
			"vacTypeNo":vacTypeNo,
			"vacTypeName":vacTypeName,
			"vacTypeExp":vacTypeExp,
			"vacTypeUseDate":vacTypeUseDate,
			"vhInfo":vhInfo,
			"imgRoot":imgRoot,
			"vacTypeTime":vacTypeTime,
			"vacTypeHoli":vacTypeHoli,
			"vacTypeSal":vacTypeSal,
			"vacTypeGender":vacTypeGender,
			"vacTypeFile":vacTypeFile
		}
		
		console.log("vacTypeVO:::", vacTypeVO);
		
		$.ajax({
			type: "POST",
			url: "/setting/vacTypeUp",
			data: JSON.stringify(vacTypeVO),
			contentType: "application/json;charset=utf-8",
			cache:false,        //요건 선택 권장!
			dataType:"text",
			beforeSend:function(xhr){
				  xhr.setRequestHeader(header,token);
			},
			success : function(result){
				console.log("업데이트결과:", result);
				
				if(result==1){
					Swal.fire({
						title: "수정 완료",
				        text: "",
				        icon: "success",
				        confirmButtonText: "확인"
				    }).then(function() {
				    	console.log("확인확인:::", vacTypeNo);
						$(".modal-right1").modal("hide");
				        // 이미지 엘리먼트의 src 속성 업데이트
						$('#imgNo'+vacTypeNo).attr('src', imgRoot);
						$('#vacNmNo'+vacTypeNo).html(vacTypeName);
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
	
	function fDel(pthis) {
		
		console.log("pthis::", pthis);
		console.log("vacTypeNo::", pthis.id.substr(5));
		
		const vacTypeNo = parseInt(pthis.id.substr(5));
		if(1<=vacTypeNo && vacTypeNo<=7) {
			Swal.fire({
				title: "기본 휴가는 삭제할 수 없습니다.",
		        text: "",
		        icon: "error",
		        confirmButtonText: "확인"
		    });
			return false;
		}
		Swal.fire({
		    title: '이 항목을 삭제하시겠습니까?',
		    showCancelButton: true,
		    cancelButtonText: '취소',
		    confirmButtonText: '확인'
		}).then((rslt) => {
			if (rslt.isConfirmed) {
				$.ajax({
					type: "POST",
					url: "/setting/vacTypeDel",
					data: JSON.stringify(vacTypeNo),
					contentType: "application/json; charset=utf-8",
					beforeSend:function(xhr){
				       xhr.setRequestHeader(header, token);
				    },
					success: function (rslt) {
						console.log("rslt::", rslt);
						if(rslt == 1) {
							Swal.fire({
								title: "삭제 완료",
						        text: "",
						        icon: "success",
						        confirmButtonText: "확인"
						    }).then(function() {
						    	$(pthis).closest('.card-body').remove();
						    });
						} else {
							Swal.fire({
								title: "삭제 실패",
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
		});
	}
	
</script>

<body>

	<!-- 맞춤 휴가 추가 모달창 -->
	<div class="modal fade modal-right modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>맞춤 휴가 추가</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="/setting/vacTypeAdd" id="setVacTypeForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divSetVacType">
						<h5>기본 설정</h5><br>
						<p class="labelBasic" style="display: inline-block;">아이콘 설정</p>
						<button type="button" id="toggleButton" class="toggleButton">
							<img src="/resources/images/setting/vacationIcon/calendar.png" class="vacIcon"
								id="vacIcon">
						</button>
						<input type="hidden" name="imgRoot" id="imgRoot" value="/resources/images/setting/vacationIcon/calendar.png">
						<br>
						<div id="targetDiv" class="targetDiv">
							<c:forEach var="fileInfoVO" items="${fileInfoList}">
								<button type="button"><img
										src="/resources/images/setting/vacationIcon/${fileInfoVO.orfiName}"
										id="file${fileInfoVO.fileSn}" class="vacationIcon"></button>
							</c:forEach>
						</div>
						<br>
	                    <div class="input-group mb-3">
	                        <label for="vacTypeName" class="labelBasic">휴가명&emsp;</label>
	                        <input type="text" id="vacTypeName" name="vacTypeName" class="form-control basic" required style="width: 150px; margin-left: 65px;">
	                    </div>
						<div class="input-group mb-3">
	                        <label for="vhInfo" class="labelBasic">휴가설명</label>
	                        <textarea class="form-control basic" id="vhInfo" name="vhInfo" rows="3" style="width: 150px; margin-left: 65px;"></textarea>
                      	</div>
                      	<br>
                      	<h5>상세 설정</h5><br>
                      	<div class="leftDiv">
                      		<label for="vacTypeExp">휴가 부여 방법</label><br>
                      		<label for="vacTypeDay" style="margin-top: 28px;">부여 일수</label><br>
                      		<label for="vacTypeTime" style="margin-top: 20px;">사용 단위</label><br>
                      		<label for="vacTypeHoli" style="margin-top: 17px;">휴일 포함</label><br>
                      		<label for="vacTypeSal" style="margin-top: 16px;">급여 지급</label><br>
                      		<label for="vacTypeGender" style="margin-top: 15px;">적용 성별</label><br>
                      		<label for="vacTypeFile" style="margin-top: 14px;">증명자료 제출</label>
                      	</div>
	                    
	                    <div class="rightDiv">
	                        <select class="form-control" id="vacTypeExp" name="vacTypeExp" style="width: 230px;">
	                            <option selected value="V0201">신청시 지급</option>
	                            <option value="V0202">매월 지급</option>
	                            <option value="V0203">매년 지급</option>
	                            <option value="V0204">근속시 지급</option>
	                            <option value="V0205">연차 소진시 지급</option>
	                            <option value="V0206">담당자가 직접 지급</option>
	                        </select>
	                        <br>
	                    	<div class="input-group mb-3" style="width: 120px;">
		                        <input type="text" class="form-control" id="vacTypeDay" name="vacTypeUseDate">
		                        <div class="input-group-append">
		                            <span class="input-group-text">일</span>
		                        </div>
	                        </div>
							
							<div class="select">
								<input type="radio" id="time1" name="vacTypeTime" value="V0301"><label for="time1">일</label>
								<input type="radio" id="time2" name="vacTypeTime" value="V0302"><label for="time2">반차</label>
								<input type="radio" id="time3" name="vacTypeTime" value="V0303"><label for="time3">시간</label>
							</div>
							
							<div class="select">
								<input type="radio" id="holi1" name="vacTypeHoli" value="Y"><label for="holi1">포함</label>
								<input type="radio" id="holi2" name="vacTypeHoli" value="N"><label for="holi2">미포함</label>
							</div>
							
							<div class="select">
								<input type="radio" id="sal1" name="vacTypeSal" value="Y"><label for="sal1">유급</label>
								<input type="radio" id="sal2" name="vacTypeSal" value="N"><label for="sal2">무급</label>
							</div>
							
							<div class="select">
								<input type="radio" id="gender1" name="vacTypeGender" value="A"><label for="gender1">모두</label>
								<input type="radio" id="gender2" name="vacTypeGender" value="M"><label for="gender2">남자만</label>
								<input type="radio" id="gender3" name="vacTypeGender" value="F"><label for="gender3">여자만</label>
							</div>
							
							<div class="select">
								<input type="radio" id="vacTypeFile1" name="vacTypeFile" value="N"><label for="vacTypeFile1">없음</label>
								<input type="radio" id="vacTypeFile2" name="vacTypeFile" value="Y"><label for="vacTypeFile2">제출</label>
							</div>
	                    </div>
					</div>
					<br>
					<div class="modal-footer">
						<button type="button" class="cancelBtn" onclick="fAutoFill()">자동채우기</button>
						<button class="saveButton" id="vacTypeSave">저장</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 맞춤 휴가 수정 모달창 -->
	<div class="modal fade modal-right1 modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>맞춤 휴가 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="setVacTypeForm1" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divSetVacType1">
						<h5>기본 설정</h5><br>
						<p class="labelBasic" style="display: inline-block;">아이콘 설정</p>
						<button type="button" id="toggleButton1" class="toggleButton1">
							<img src="/resources/images/setting/vacationIcon/calendar.png" class="vacIcon1"
								id="toggleButtonImage">
						</button>
						<input type="hidden" name="imgRoot1" id="imgRoot1" value="" >
						<input type="hidden" name="vacTypeNo1" id="vacTypeNo1" value="">
						<br>
						<div id="targetDiv1" class="targetDiv1">
							<c:forEach var="fileInfoVO" items="${fileInfoList}">
								<button type="button"><img
										src="/resources/images/setting/vacationIcon/${fileInfoVO.orfiName}"
										id="file${fileInfoVO.fileSn}" class="vacationIcon1"></button>
							</c:forEach>
						</div>
						<br>
	                    <div class="input-group mb-3">
	                        <label for="vacTypeName1" class="labelBasic">휴가명&emsp;</label>
	                        <input type="text" id="vacTypeName1" name="vacTypeName1" class="form-control basic" required style="width: 150px; margin-left: 65px;">
	                    </div>
						<div class="input-group mb-3">
	                        <label for="vhInfo1" class="labelBasic">휴가설명</label>
	                        <textarea class="form-control basic" id="vhInfo1" name="vhInfo1" rows="3" style="width: 150px; margin-left: 65px;"></textarea>
                      	</div>
                      	<br>
                      	<h5>상세 설정</h5><br>
                      	<div class="leftDiv">
                      		<label for="vacTypeExp1">휴가 부여 방법</label><br>
                      		<label for="vacTypeDay1" style="margin-top: 28px;">부여 일수</label><br>
                      		<label for="vacTypeTime" style="margin-top: 20px;">사용 단위</label><br>
                      		<label for="vacTypeHoli" style="margin-top: 17px;">휴일 포함</label><br>
                      		<label for="vacTypeSal" style="margin-top: 16px;">급여 지급</label><br>
                      		<label for="vacTypeGender" style="margin-top: 15px;">적용 성별</label><br>
                      		<label for="vacTypeFile" style="margin-top: 14px;">증명자료 제출</label>
                      	</div>
	                    
	                    <div class="rightDiv">
	                        <select class="form-control" id="vacTypeExp1" name="vacTypeExp1" style="width: 230px;">
	                            <option selected value="V0201">신청시 지급</option>
	                            <option value="V0202">매월 지급</option>
	                            <option value="V0203">매년 지급</option>
	                            <option value="V0204">근속시 지급</option>
	                            <option value="V0205">연차 소진시 지급</option>
	                            <option value="V0206">담당자가 직접 지급</option>
	                        </select>
	                        <br>
	                    	<div class="input-group mb-3" style="width: 120px;">
		                        <input type="text" class="form-control" id="vacTypeDay1" name="vacTypeUseDate1">
		                        <div class="input-group-append">
		                            <span class="input-group-text">일</span>
		                        </div>
	                        </div>
							
							<div class="select">
								<input type="radio" id="uTime1" name="vacTypeTime1" value="V0301"><label for="uTime1">일</label>
								<input type="radio" id="uTime2" name="vacTypeTime1" value="V0302"><label for="uTime2">반차</label>
								<input type="radio" id="uTime3" name="vacTypeTime1" value="V0303"><label for="uTime3">시간</label>
							</div>
							
							<div class="select">
								<input type="radio" id="uHoli1" name="vacTypeHoli1" value="Y"><label for="uHoli1">포함</label>
								<input type="radio" id="uHoli2" name="vacTypeHoli1" value="N"><label for="uHoli2">미포함</label>
							</div>
							
							<div class="select">
								<input type="radio" id="uSal1" name="vacTypeSal1" value="Y"><label for="uSal1">유급</label>
								<input type="radio" id="uSal2" name="vacTypeSal1" value="N"><label for="uSal2">무급</label>
							</div>
							
							<div class="select">
								<input type="radio" id="uGender1" name="vacTypeGender1" value="A"><label for="uGender1">모두</label>
								<input type="radio" id="uGender2" name="vacTypeGender1" value="M"><label for="uGender2">남자만</label>
								<input type="radio" id="uGender3" name="vacTypeGender1" value="F"><label for="uGender3">여자만</label>
							</div>
							
							<div class="select">
								<input type="radio" id="uVacTypeFile1" name="vacTypeFile1" value="N"><label for="uVacTypeFile1">없음</label>
								<input type="radio" id="uVacTypeFile2" name="vacTypeFile1" value="Y"><label for="uVacTypeFile2">제출</label>
							</div>
	                    </div>
					</div>
					<br>
					<div class="modal-footer">
						<button class="saveButton" id="vacTypeUp">수정</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>휴가 설정</h1>
			<hr>
			<br>
		</div>
		<div class="card shadow mb-4">
			<div class="card-body">
				<div id="vacTypeHeadDiv">
					<h5 id="vacTypeHead">휴가 종류</h5>
					<button type="button" class="form-control" id="vacInsertBtn" data-toggle="modal"
						data-target=".modal-right">
						<div id="plus">
							<span class="fe fe-24 fe-plus"></span>
						</div>
						<div class="vacInsert">맞춤 휴가 추가</div>
					</button>
				</div>
				<br>
				<!-- this를 쓰거나, divline2.eq(0) 를써서 데이터를 넘긴다 -->
				<c:forEach var="vacTypeVO" items="${vacTypeList}" varStatus="status">
					<div class="card-body divline2 edit-vacation" data-vacation-id="${vacTypeVO.vacTypeNo}" <c:if test="${vacTypeVO.vacTypeName eq '반차'}">style="display: none;"</c:if> <c:if test="${vacTypeVO.vacTypeYn eq 'N'}">style="display: none;"</c:if>>
						<img src="${vacTypeVO.imgRoot}" class="divVacImg" id="imgNo${vacTypeVO.vacTypeNo}" >
						<div class="dropdown">
	                        <button class="btn btn-sm dropdown-toggle more-vertical" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                            <span class="text-muted sr-only">Action</span>
	                        </button>
	                        <div class="dropdown-menu dropdown-menu-right" style="">
	                            <div data-toggle="modal" data-target=".modal-right1" class="openModal" id="openModal1"><a class="dropdown-item" href="#">수정하기</a></div>
	                            <a class="dropdown-item" id="delNo${vacTypeVO.vacTypeNo}" href="#" onclick="fDel(this)">삭제하기</a>
	                        </div>
	                    </div>
						<br><br><br>
						<p class="vacTypeNm" id="vacNmNo${vacTypeVO.vacTypeNo}">${vacTypeVO.vacTypeName}</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

</body>

</html>