<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근무 설정</title>

<style>
	div {
/*      	border: 1px solid blue;        */
	}
	
	.divline {
		border: 1px solid rgb(219, 218, 218);
		border-radius: 5px;
		display: inline-block;
		width: 250px;
		height: 150px;
		margin: 3px;
	}
	.divline2 {
		border: 1px solid rgb(219, 218, 218);
		border-radius: 5px;
		display: inline-block;
		width: 60vw;
		padding: 10px;
		margin-left: 50px;
	}
	#workInsertBtn, #workApInsertBtn {
		vertical-align: top;
		float: right;
		width: 150px;
	}
	.workInsert {
		display: inline-block;
		vertical-align: top;
		margin-top: 3px;
	}
	#plus, #chevron-right {
		display: inline-block;
	}
	#workTypeHead {
		display: inline-block;
		margin-top: 10px;
	}
	#workApHead {
		display: inline-block;
		margin-top: 10px;
		vertical-align: top;
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
	.fRight {
		float: right;
		margin-right: 33px;
	}
	.mb-3 {
		width: 350px;
	}
	.divWorkImg {
		width: 50px;
		height: 50px;
		display: inline-block;
	}
	.pWorkNm {
		font-weight: bold;
	}
	.dropdown {
		float: right;
	}
	.wkIcon, .wkIcon1, .workIcon, .workIcon1 {
		width: 50px;
		height: 50px;
	}
	/* 라디오 버튼 css */
	.select {
		/* padding: 15px 10px; */
		padding: 0px;
		width: 145.5px;
		margin-top: 20px;
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
	.div1 {
		display: inline-block;
		width: 18vw;
		text-align: center;
	}
	.p1 {
		font-size: small;
		margin-bottom: 0px;
		display: inline-block;
	}
	.p2 {
		margin-bottom: 0px;
		margin-left: 10px;
		font-weight: bold;
		display: inline-block;
	}
	#setTime {
		width: 280px;
	}
	.timeControl {
		width: 147px;
		margin-left: 70px;
	}
	#wetreeJsContaner {
		overflow: auto;
	    display: none; 
	    width: 100%; 
	    height: 100%; 
	    background-color: rgba(240, 240, 240, 0.9); 
	     position: fixed;  
	    z-index: 1050;  
	    padding-left: 350px;	
	    padding-top: 140px;
	}
	#wetreeJs {
	    margin: 50px auto;
	    width: 60%;
	    height: 70%;
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
		$("#workName").val("최종프로젝트");
		$("#wkDescr").val("최종프로젝트 시연을 위한 강압적인 연장근무");
		$("#wkWtime").val("7");
		$("#newStartTime").val("18:00");
		$("#newEndTime").val("22:00");
		$("#night1").prop('checked', true);
		$("#hd1").prop('checked', true);
	}
	
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	
	let workAdd;
	let workUp;
	
	$(function () {
		
		//아이콘 토글 버튼
		document.querySelector("#toggleButton").addEventListener("click", function () {
			var targetDiv = document.querySelector("#targetDiv");
			// 현재 상태를 확인하여 토글
			if (targetDiv.style.display == "none" || targetDiv.style.display == "") {
				targetDiv.style.display = "block";
			}
		});
		
		workUp = document.querySelector("#workUpForm");
		workUp.addEventListener("submit", fWorkUp);
		
		workAdd = document.querySelector("#workAddForm");
		workAdd.addEventListener("submit", fWorkAdd);

	});
	
	$(document).ready(function() {
		// 맞츰 근무 수정 모달이 열릴 때 이벤트 리스너 추가
		$('.modal-right1').on('show.bs.modal', function (event) {
			var modal = $(this);
			
			// 클릭한 근무 종류 목록의 ID를 가져와서 해당 근무 종류 정보를 조회
			var workId = $(event.relatedTarget).closest('.edit-work').data('work-id');
			
			console.log("workId::", workId);
			
			// AJAX 요청을 사용하여 서버에서 근무 종류 정보 가져오기
			$.ajax({
				url: '/setting/getWorkInfo/' + workId,
				method: 'GET',
				success: function(data) {
					console.log("data::", data);
					// 가져온 데이터를 모달 창에 적용
					modal.find("#workName1").val(data.wkNm);
					modal.find("#wkDescr1").val(data.wkDescr);
					modal.find("#wkWtime1").val(data.wkWtime);
					modal.find("#newStartTime1").val(data.wkStime);
					modal.find("#newEndTime1").val(data.wkEtime);
					modal.find("#imgRoot1").val(data.imgRoot);
					modal.find("#wkNo1").val(data.wkNo);
					modal.find("#toggleButtonImage").attr("src", data.imgRoot);
					modal.find('input[name="wkNight1"][value="' + data.wkNight + '"]').prop('checked', true);
					modal.find('input[name="wkHd1"][value="' + data.wkHd + '"]').prop('checked', true);
					
					// 이미지를 클릭할 때 호출되는 함수
					function selectIcon(imgSrc) {
						// imgRoot 입력 필드 찾기
						var imgRootInput = document.querySelector("#imgRoot1");
						
						// imgRoot 입력 필드의 값을 선택한 이미지의 src로 설정
						imgRootInput.value = imgSrc;
						
						// 이미지를 표시
						var toggleButtonImage = document.querySelector("#toggleButtonImage");
						toggleButtonImage.src = imgSrc;
						
						// targetDiv를 숨김
						var targetDiv = document.querySelector("#targetDiv1");
						targetDiv.style.display = "none";
					}
					
					// 이미지를 클릭 할 떄 selectIcon 함수 호출
					var images = document.querySelectorAll(".workIcon1");
					images.forEach(function (image) {
						image.addEventListener("click", function() {
							var imgSrc = image.getAttribute("src");
							selectIcon(imgSrc);
						});
					});
					
					// 토글 버튼을 클릭할 때 targetDiv를 표시
					var toggleButton = document.querySelector("#toggleButton1");
					var targetDiv = document.querySelector("#targetDiv1");
					
					toggleButton.addEventListener("click", function(){
						if(targetDiv.style.display == "none" || targetDiv.style.display == "") {
							targetDiv.style.display = "block";
						}
					});
					
					// 라디오 버튼에 대한 이벤트 리스너 추가
					$('input[name="wkNight1"]').on('change', function() {
						modal.find('input[name="wkNight1"][value="'+ $(this).val() + '"]').prop('checked', true);
					});
					
					$('input[name="wkHd1"]').on('change', function() {
						modal.find('input[name="wkHd1"][value="'+ $(this).val() + '"]').prop('checked', true);
					});
				},
				error: function(xhr, status, error){
		            console.log("code: " + xhr.status)
		            console.log("message: " + xhr.responseText)
		            console.log("error: " + error);
		        }
			});
		});
	});
	
	function fDel(pthis) {
		console.log("wkNo::", pthis.id.substr(5));
		
		const wkNo = parseInt(pthis.id.substr(5));
		if(1<=wkNo && wkNo <=7) {
			Swal.fire({
				title: "기본 근무는 삭제할 수 없습니다.",
		        text: "",
		        icon: "error",
		        confirmButtonText: "확인"
		    }).then(function() {
		    	return false;
		    });
		}else {
			Swal.fire({
			    title: '이 항목을 삭제하시겠습니까?',
			    showCancelButton: true,
			    cancelButtonText: '취소',
			    confirmButtonText: '확인',
			}).then((result) => {
			    if (result.isConfirmed) {
			    	$.ajax({
			    		type: "POST",
			    		url: "/setting/workDel",
			    		data: JSON.stringify(wkNo),
			    		contentType: "application/json; charset=utf-8",
			    		beforeSend:function(xhr){
					       xhr.setRequestHeader(header, token);
					    },
					    success: function(rslt) {
					    	console.log("rslt::", rslt);
					    	Swal.fire({
								title: "삭제 완료",
						        text: "",
						        icon: "success",
						        confirmButtonText: "확인"
						    }).then(function() {
						    	$(pthis).closest('.card-body').remove();
						    });
					    },
					    error: function (xhr, status, error) {
							console.log("code: " + xhr.status);
							console.log("message: " + xhr.responseText);
							console.log("error: " + error);
							Swal.fire({
								title: "삭제 실패",
						        text: "",
						        icon: "error",
						        confirmButtonText: "확인"
							});
						},
			    	});
			    }
			});
		}
	}
	
	function fWorkUp() {
		event.preventDefault();
		
		const wkNo = $("#wkNo1").val();
		const wkNm = $("#workName1").val();
		const wkDescr = $("#wkDescr1").val();
		const wkWtime = $("#wkWtime1").val();
		const imgRoot = $("#imgRoot1").val();
		const wkStime = $("#newStartTime1").val();
		const wkEtime = $("#newEndTime1").val();
		const wkNight = $('input[name="wkNight1"]:checked').val();
		const wkHd = $('input[name="wkHd1"]:checked').val();
		
		let workVO = {
			"wkNo": wkNo,
			"wkNm": wkNm,
			"wkDescr": wkDescr,
			"wkWtime": wkWtime,
			"imgRoot": imgRoot,
			"wkStime": wkStime,
			"wkEtime": wkEtime,
			"wkNight": wkNight,
			"wkHd": wkHd
		}
		
		console.log("workVO::", workVO);
		
		$.ajax({
			type: "POST",
			url: "/setting/workUp",
			data: JSON.stringify(workVO),
			contentType: "application/json;charset=utf-8",
			cache:false,
			dataType:"text",
			beforeSend:function(xhr){
				  xhr.setRequestHeader(header,token);
			},
			success : function(result){
				console.log("업데이트결과:", result);
				
				Swal.fire({
					title: "수정 완료",
			        text: "",
			        icon: "success",
			        confirmButtonText: "확인"
			    }).then(function() {
			    	//모달 닫기
			        $(".modal-right1").modal("hide");
			    	
			        $("#imgNo"+wkNo).attr('src', imgRoot);
			        $("#workNmNo"+wkNo).html(wkNm);
			    });
			},
			error:function(xhr, status, error){
	            console.log("code: " + xhr.status)
	            console.log("message: " + xhr.responseText)
	            console.log("error: " + error);
	        }
		});
		
	}
	
	//버튼 클릭 이벤트 리스너를 추가합니다.
	document.addEventListener("DOMContentLoaded", function () {
		// 모든 이미지 요소에 클릭 이벤트 리스너 추가
		const images = document.querySelectorAll(".workIcon");
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
	
	function fWorkAdd() {
		event.preventDefault();
		
		const wkNm = $("#workName").val();
		const wkDescr = $("#wkDescr").val();
		const wkWtime = $("#wkWtime").val();
		const wkNight = $("input[name=wkNight]:checked").val();
		const wkHd = $("input[name=wkHd]:checked").val();
		const imgRoot = $("#imgRoot").val();
		const wkNo = $("#wkNo").val();
		const wkStime = $("#newStartTime").val();
		const wkEtime = $("#newEndTime").val();
		
		let workVO = {
			"wkNm": wkNm,	
			"wkDescr": wkDescr,	
			"wkWtime": wkWtime,	
			"wkNight": wkNight,	
			"wkHd": wkHd,
			"imgRoot": imgRoot,
			"wkStime": wkStime,
			"wkEtime": wkEtime
		}
		
		console.log("workVO::", workVO);
		
		$.ajax({
			type: "POST",
			url: "/setting/workAdd",
			data: JSON.stringify(workVO),
			contentType: "application/json;charset=utf-8",
			cache: false,        //요건 선택 권장!
			dataType: "text",
			beforeSend: function(xhr){
			    xhr.setRequestHeader(header,token);
			},
			success: function(result){
				console.log("추가 결과::", result);
				
				Swal.fire({
					title: "추가 완료",
			        text: "",
			        icon: "success",
			        confirmButtonText: "확인"
			    }).then(function() {
			        location.reload();
			    });
			},
			error: function(xhr, status, error){
	            console.log("code: " + xhr.status)
	            console.log("message: " + xhr.responseText)
	            console.log("error: " + error);
	        }
		});
	}
	
   //단계별 승인 참조대상 선택시 모달열기
   let mymodal = $("#wetreeJsContaner")
   $(document).on("click",".approvePlusBtn",function(){
       mymodal.css("display", "block");
       getJson(this);
   });
   
   //모달 닫기
   $("#myModalClose").on("click",function(){
      mymodal.css("display","none");
   })
	
	   //jstree결과값 받기
	   function getJson(thisBtn) {
	   $.ajax({
           type:'get',
           url:'/approval/organizationChart',
           dataType:'json',
           success: function(data) {
            console.log("체킁 : ",data);
              let listOne = data.one;
              let listTwo = data.two;
              
               var company = new Array();
               // 데이터 받아옴
               $.each(listOne, function(idx, item){
                  if(item.uprDcode==0){
                     item.uprDcode = "#";
                  }
               company.push({id:item.dcode+"", parent:item.uprDcode+"", text:item.dnm});
               });
               $.each(listTwo, function(idx, item){
                  let temp = item.deptName;
                  if(temp==null){
                     
                  }else{
                  company.push({"id":item.uprDcode+""+idx, "parent":item.dcode+"", "text":item.deptName, "icon":"/resources/images/user2.png", "info":item.uprDcode+"" });
                  }
               });
                 console.log("최종",company);
               // 트리 생성
               $('#sujiTree').jstree({
                   core: {
                      data: company    //데이터 연결
                       },
                       types: {
                              'default': {
                                   'icon': 'jstree-folder'
                               }
                       },
                       plugins: ['wholerow', 'types','search','dnd','contextmenu']
                })
                .bind('loaded.jstree', function(event, data){
                       //트리 로딩 롼료 이벤트
                })
                .bind('select_node.jstree', function(event, data){
                   console.log("선택한노드:", data.node);
                   if(data.node.original.info != null){
	                   $.ajax({
	                      url : "/approval/selectEmp?keyword=" + data.node.original.info,
	                      dataType : "json",
	                      type : "get",
	                      success : function(result){
	                        console.log("result",result);
	                        
	                        Swal.fire({
	            			    title: '결재 승인자를 변경하시겠습니까?',
	            			    showCancelButton: true,
	            			    cancelButtonText: '취소',
	            			    confirmButtonText: '확인'
	            			}).then((rslt) => {
	            			    if (rslt.isConfirmed) {
	            			    	$.ajax({
	            			    		type: "POST",
	            			    		url: "/setting/workApUp",
	            			    		data: result.empNo,
	            			    		contentType: "application/json; charset=utf-8",
	            			    		beforeSend:function(xhr){
	            					       xhr.setRequestHeader(header, token);
	            					    },
	            					    success : function(upResult){
	            							console.log("업데이트결과:", upResult);
	            							
	            							Swal.fire({
	            								title: "저장 완료",
	            						        text: "",
	            						        icon: "success",
	            						        confirmButtonText: "확인"
	            						    }).then(function() {
	            						    	$('#sujiTree').jstree("destroy");//트리 초기화
	            		                        $("#myModalClose").click();//모달 닫기버튼
	            		                        
	            		                        $("#empNo").html(result.empNo);
	            		                        $("#dtCodeNm").html(result.dtCodeNm);
	            		                        $("#empNm").html(result.empNm);
	            						    });
	            						},
	            						error:function(xhr, status, error){
	            				            console.log("code: " + xhr.status)
	            				            console.log("message: " + xhr.responseText)
	            				            console.log("error: " + error);
	            				        }
	            			    	});
	            			    }
	            			});
	                      }
                      });
                   };
                });
           },
           error:function (data) {
               alert("에러");
           }
       });
    }
	
	//jsTree 열고/닫기
	let openTemp = false;
	$("#open").on("click",function(){
	   if(openTemp == false){
	      $("#sujiTree").jstree("open_all");
	   }else{
	      $("#sujiTree").jstree("close_all");	
	   }
	   openTemp = !openTemp;
	});
</script>

<body>
	<!-- 근무 수정 모달창 -->
	<div class="modal fade modal-right1 modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>맞춤 근무 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="workUpForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divSetWork1">
						<h5>기본 설정</h5><br>
						<p class="labelBasic" style="display: inline-block;">아이콘 설정</p>
						<button type="button" id="toggleButton1" class="toggleButton1">
							<img src="/resources/images/setting/workIcon/working-time.png" class="wkIcon1"
								id="toggleButtonImage">
						</button>
						<input type="hidden" name="imgRoot1" id="imgRoot1" value="">
						<input type="hidden" name="wkNo1" id="wkNo1" value="">
						<br>
						<div id="targetDiv1" class="targetDiv1">
							<c:forEach var="fileInfoVO" items="${fileInfoList}">
								<button type="button"><img
										src="/resources/images/setting/workIcon/${fileInfoVO.orfiName}"
										id="file${fileInfoVO.fileSn}" class="workIcon1"></button>
							</c:forEach>
						</div>
						<br>
	                    <div class="input-group mb-3">
	                        <label for="workName1" class="labelBasic">근무명&emsp;</label>
	                        <input type="text" id="workName1" name="workName1" class="form-control basic" required style="width: 150px; margin-left: 65px;">
	                    </div>
						<div class="input-group mb-3">
	                        <label for="wkDescr1" class="labelBasic">근무설명</label>
	                        <textarea class="form-control basic" id="wkDescr1" name="wkDescr1" rows="3" style="width: 150px; margin-left: 65px;"></textarea>
                      	</div>
                      	<br><br>
                      	<h5>상세 설정</h5><br>
                      	<div class="leftDiv">
                      		<label for="workDay1" style="margin-top: 8px;">주 근무시간</label><br>
                      		<label for="workStime1" style="margin-top: 33px;">시작 시간</label><br>
                      		<label for="workEtime1" style="margin-top: 18px;">종료 시간</label><br>
                      		<label for="wkNight1" style="margin-top: 30px;">야간 근무 등록</label><br>
                      		<label for="wkHd1" style="margin-top: 22px;">휴일 근무 등록</label><br>
                      	</div>
	                    
	                    <div class="rightDiv">
	                    	<div class="input-group mb-3 fRight" style="width: 110px;">
		                        <input type="text" class="form-control" id="wkWtime1" name="wkWtime1">
		                        <div class="input-group-append">
		                            <span class="input-group-text">시간</span>
		                        </div>
	                        </div>
							<br>
							<input class="form-control timeControl" id="newStartTime1" type="time" name="time1" placeholder="시작 시간" style="margin-top: 40px;">
                            <input class="form-control timeControl" id="newEndTime1" type="time" name="time1" placeholder="종료 시간" style="margin-top: 10px;">
							<div class="select fRight" style="margin-top: 30px;">
								<input type="radio" id="uNight1" name="wkNight1" value="Y"><label for="uNight1">허용함</label>
								<input type="radio" id="uNight2" name="wkNight1" value="N"><label for="uNight2">허용안함</label>
							</div>
							<div class="select fRight">
								<input type="radio" id="uHd1" name="wkHd1" value="Y"><label for="uHd1">허용함</label>
								<input type="radio" id="uHd2" name="wkHd1" value="N"><label for="uHd2">허용안함</label>
							</div>
	                    </div>
					</div>
					<br>
					<div class="modal-footer">
						<button class="saveButton" id="workUp">수정</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 근무 추가 모달창 -->
	<div class="modal fade modal-right modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>맞춤 근무 추가</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="workAddForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divSetWork">
						<h5>기본 설정</h5><br>
						<p class="labelBasic" style="display: inline-block;">아이콘 설정</p>
						<button type="button" id="toggleButton" class="toggleButton">
							<img src="/resources/images/setting/workIcon/working-time.png" class="wkIcon"
								id="wkIcon">
						</button>
						<input type="hidden" name="imgRoot" id="imgRoot" value="/resources/images/setting/workIcon/working-time.png">
						<br>
						<div id="targetDiv" class="targetDiv">
							<c:forEach var="fileInfoVO" items="${fileInfoList}">
								<button type="button"><img
										src="/resources/images/setting/workIcon/${fileInfoVO.orfiName}"
										id="file${fileInfoVO.fileSn}" class="workIcon"></button>
							</c:forEach>
						</div>
						<br>
	                    <div class="input-group mb-3">
	                        <label for="workName" class="labelBasic">근무명&emsp;</label>
	                        <input type="text" id="workName" name="workName" class="form-control basic" required style="width: 150px; margin-left: 65px;">
	                    </div>
						<div class="input-group mb-3">
	                        <label for="wkDescr" class="labelBasic">근무설명</label>
	                        <textarea class="form-control basic" id="wkDescr" name="wkDescr" rows="3" style="width: 150px; margin-left: 65px;"></textarea>
                      	</div>
                      	<br><br>
                      	<h5>상세 설정</h5><br>
                      	<div class="leftDiv">
                      		<label for="workDay" style="margin-top: 8px;">주 근무시간</label><br>
                      		<label for="workStime" style="margin-top: 33px;">시작 시간</label><br>
                      		<label for="workEtime" style="margin-top: 18px;">종료 시간</label><br>
                      		<label for="wkNight" style="margin-top: 30px;">야간 근무 등록</label><br>
                      		<label for="wkHd" style="margin-top: 22px;">휴일 근무 등록</label><br>
                      	</div>
	                    
	                    <div class="rightDiv">
	                    	<div class="input-group mb-3 fRight" style="width: 110px;">
		                        <input type="text" class="form-control" id="wkWtime" name="wkWtime">
		                        <div class="input-group-append">
		                            <span class="input-group-text">시간</span>
		                        </div>
	                        </div>
							<br>
							<input class="form-control timeControl" id="newStartTime" type="time" name="time" placeholder="시작 시간" style="margin-top: 40px;">
                            <input class="form-control timeControl" id="newEndTime" type="time" name="time" placeholder="종료 시간" style="margin-top: 10px;">
							<div class="select fRight" style="margin-top: 30px;">
								<input type="radio" id="night1" name="wkNight" value="Y"><label for="night1">허용함</label>
								<input type="radio" id="night2" name="wkNight" value="N"><label for="night2">허용안함</label>
							</div>
							<div class="select fRight">
								<input type="radio" id="hd1" name="wkHd" value="Y"><label for="hd1">허용함</label>
								<input type="radio" id="hd2" name="wkHd" value="N"><label for="hd2">허용안함</label>
							</div>
	                    </div>
					</div>
					<br>
					<div class="modal-footer">
						<button type="button" class="cancelBtn" onclick="fAutoFill()">자동채우기</button>
						<button class="saveButton" id="workSave">저장</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>근무 설정</h1>
			<hr>
			<br>
		</div>
		<div class="card shadow mb-4">
			<div class="card-body">
				<h5 id="workApHead">근무 결재 승인자</h5>
				<div class="card-body divline2">
					<div class="div1">
						<p class="p1">사번</p>
						<p class="p2" id="empNo">${empVo.empNo}</p>
					</div>
					<div class="div1">
						<p class="p1">직책</p>
						<p class="p2" id="dtCodeNm">${empVo.dtCodeNm}</p>
					</div>
					<div class="div1">
						<p class="p1">성명</p>
						<p class="p2" id="empNm">${empVo.empNm}</p>
					</div>
				</div>
				<button type="button" class="form-control approvePlusBtn" id="workApInsertBtn" data-toggle="modal"
					data-target="#verticalModal">
					<div class="workInsert">승인자 설정</div>
					<div id="chevron-right">
						<span class="fe fe-24 fe-chevron-right"></span>
					</div>
				</button>
			</div>
		</div>
		
		<div class="card shadow mb-4">
			<div class="card-body" id="work-body">
				<div id="workHeadDiv">
					<h5 id="workTypeHead">근무 종류</h5>
					<button type="button" class="form-control" id="workInsertBtn" data-toggle="modal"
						data-target=".modal-right">
						<div id="plus">
							<span class="fe fe-24 fe-plus"></span>
						</div>
						<div class="workInsert">맞춤 근무 추가</div>
					</button>
				</div>
				<br>
				<!-- this를 쓰거나, divline2.eq(0) 를써서 데이터를 넘긴다 -->
				<c:forEach var="workVO" items="${workList}" varStatus="status">
					<div class="card-body divline edit-work" data-work-id="${workVO.wkNo}" <c:if test="${workVO.wkYn eq 'N'}">style="display: none;"</c:if>>
						<img src="${workVO.imgRoot}" class="divWorkImg" id="imgNo${workVO.wkNo}" >
						<div class="dropdown">
	                        <button class="btn btn-sm dropdown-toggle more-vertical" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                            <span class="text-muted sr-only">Action</span>
	                        </button>
	                        <div class="dropdown-menu dropdown-menu-right" style="">
	                            <div data-toggle="modal" data-target=".modal-right1" class="openModal" id="openModal1"><a class="dropdown-item" href="#">수정하기</a></div>
	                            <a class="dropdown-item" id="delNo${workVO.wkNo}" href="#" onclick="fDel(this)">삭제하기</a>
	                        </div>
	                    </div>
						<br><br><br>
						<p class="pWorkNm" id="workNmNo${workVO.wkNo}">${workVO.wkNm}</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>