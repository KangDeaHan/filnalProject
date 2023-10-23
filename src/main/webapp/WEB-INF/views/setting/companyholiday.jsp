<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 휴일 설정</title>
<style>
/*
html, body {
	min-width: 1000px;
    min-height: 1000px;
}
*/

div {
/*    	border: 1px solid blue;    */
}

#header {
	height: 100px;
}

#example-select {
	display: inline-block;
	width: 150px;
}

#holidayInsert {
	float: right;
	width: 150px;
}

#plus {
	display: inline-block;
}

.hol {
	display: inline-block;
	vertical-align: top;
	margin-top: 3px;
}

.card-body {
	display: flex;
	align-items: center;
	border-bottom: 1px solid rgb(222, 222, 222);
	padding: 12px 30px 0px 30px;
}

.icon {
	display: flex;
	align-items: center;
}

.form-group.mb-3 {
	display: flex;
	align-items: center;
	width: 100vw;
}

.holidayType {
	margin-left: auto;
}

.holiNm {
	margin-left: 20px;
	width: 23vw;
}

.holiCont {
	margin-left: 50px;
	margin-top: 14px;
}

.holidayType {
/* 	margin-left: 50px; */
}

.lzy.lazyload--done {
	width: 50px;
	height: 50px;
}

.lazyload.lazyload--done {
	width: 50px;
	height: 50px;
}

.form-check-label {
	margin-top: 3px;
}


.btn.mb-2.btn-outline-danger.fe.fe-24.fe-trash-2.sm {
	float: right;
	
 	width: 16px; 
 	height: 16px; 
 	padding-top: 0px;
 	padding-left: 1px;
 	padding-bottom: 0px;
/*  	font-size: 1px; */
 	text-align: center;
 	border: none;  
 	margin-bottom:1px;
}

.mb-3 {
	margin-bottom: 0px;
}

.mainBtn {
    background: linear-gradient(to right, #05CA1B, #11C2C0);
	border-radius: 10px;
	color: white;
	border: none;
	font-weight: 900;
	margin-bottom: 15px;
	cursor: auto;
} 

.returnYear {
	background: white;
	border-radius: 10px;
	color: #556372;
	border: 1px solid #E9EAEA;
	font-weight: 900;
	cursor: auto;
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
<script>
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

const data = new Array();

function fAutoFill() {
	$("#holName").val("회사 창립 기념일");
	$("#holCont").val("10월23일");
	$("#holSdate").val("2023-10-23");
	$("#holEdate").val("2023-10-23");
	$("#holRepeat").prop('checked', true);
}

let HoliUp;
window.onload = function() {

	HoliUp = document.querySelector("#companyHoliForm");
	HoliUp.addEventListener("submit",fUpdate);
	
	HoliAdd = document.querySelector("#compAddHoliForm");
	HoliAdd.addEventListener("submit",fHoliAdd);
	
	function toggleCheckboxes(checked) {
	    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
	    checkboxes.forEach(function(checkbox) {
	        checkbox.checked = checked;
	    });
	}

	// "전체 선택" 체크박스 요소를 가져와 클릭 이벤트 핸들러 추가
	var selectAllCheckbox = document.getElementById('selectAllCheckbox');
	selectAllCheckbox.addEventListener('change', function() {
	    toggleCheckboxes(this.checked);
	});
	
}

function fHoliAdd() {
	event.preventDefault();
	console.log("fHoliAdd() 체크");
	
	const cohNm = document.querySelector("#holName").value;
	const cohCont = document.querySelector("#holCont").value;
	const cohSdate = document.querySelector("#holSdate").value;
	const cohEdate = document.querySelector("#holEdate").value;
	const cohEsntlYn = document.querySelector("#holEsntl").checked;
	const cohRepeatYn = document.querySelector("#holRepeat").checked;
	
	let companyHoliVO = {
		"cohNm":cohNm,
		"cohCont":cohCont,
		"cohSdate":cohSdate,
		"cohEdate":cohEdate,
		"cohEsntlYn":cohEsntlYn,
		"cohRepeatYn":cohRepeatYn
	}
	
	console.log("ADD VO 확인", companyHoliVO);
	
	$.ajax({
		url:"/setting/companyHoliday/holiAdd",
		type:"post",
		data: JSON.stringify(companyHoliVO),
		contentType: "application/json;charset=utf-8",
        cache:false,        
		dataType:"text",
        beforeSend:function(xhr){
			  xhr.setRequestHeader(header,token);
		},
		success : function(result){
			if(result){
				console.log("아작스성공결과:",result);
				Swal.fire({
					title: "등록 성공",
			        text: "",
			        icon: "success",
			        confirmButtonText: "확인"
				}).then(function() {
					let cohNo = result;
					
					let html = "";
					html += "<div class='form-check'>";
					html += "<input class='form-check-input sm' type='checkbox' name='cohNo' id='"+cohNo+"'><label class='form-check-label' for='"+cohNo+"'>";
					html += $("#holName").val();
					html += "</label>";
					html += "<button class='btn mb-2 btn-outline-danger fe fe-24 fe-trash-2 sm' value='"+cohNo+"' type='button' onclick='fRemove(this)'></button>";
					html += "</div>";
					
					$("#divHoli").append(html);
					
					let mymodal = $("#verticalModal");
					mymodal.modal("hide");
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

function fUpdate() {
	event.preventDefault();
	console.log("fUpdate() 체크")
	
	var companyHoliVO  = `${companyHoliVO}`;
 	console.log("companyHoliVO!!!" + companyHoliVO);
	
	let formData = new FormData();
	
	for(let i=0; i<companyHoliVO.length; i++) {
		const cohNo = $("input[name=cohNo]").eq(i).attr("id"); // id 얻기
	    const cohYn = $("input[name=cohNo]").eq(i).prop("checked"); // 체크 여부 확인
	    
		if(cohNo==null){
			break;
		}
	    
		formData.append("companyHoliVOList["+i+"].cohNo",cohNo);
		formData.append("companyHoliVOList["+i+"].cohYn",cohYn);
	    
		console.log("넘버: " + cohNo);
		console.log("체크: " + cohYn);
	}
	
	$.ajax({
		type: "POST",
		url: "/setting/companyHoliday/update",
		data: formData,
		contentType:false,
		processData:false,
		dataType:"text",
		beforeSend:function(xhr){
	       xhr.setRequestHeader(header, token);
	    },
		success: function (rslt) {
			console.log("rslt : " + rslt);
			if(rslt != null) {
				Swal.fire({
					title: "등록 완료",
			        text: "",
			        icon: "success",
			        confirmButtonText: "확인"
			    }).then(function() {
			    	location.reload();
			    });
			} else {
				Swal.fire({
					title: "등록 실패",
			        text: "",
			        icon: "error",
			        confirmButtonText: "확인"
			    })
			}

		},
		error: function (xhr, status, error) {
			console.log("code: " + xhr.status);
			console.log("message: " + xhr.responseText);
			console.log("error: " + error);
		},
	});
}

function fRemove(pthis) {
	console.log("추가휴일 remove 체크:",pthis);
	console.log("추가휴일 remove 값 체크:",pthis.value);
	console.log("ID:",pthis.parentElement.children[0].id);
	
	const PcohNo = pthis.parentElement.children[0].id;
	
	console.log("ID:",PcohNo);
	
	const cohNo = pthis.value;
	console.log("cohNo 번호::" + cohNo);
	
	
	Swal.fire({
	    title: '이 항목을 삭제하시겠습니까?',
	    showCancelButton: true,
	    cancelButtonText: '취소',
	    confirmButtonText: '확인'
	}).then((rslt) => {
	    if (rslt.isConfirmed) {
	    	$.ajax({
	    		type: "POST",
	    		url: "/setting/searchCompHoli",
	    		data: cohNo,
	    		contentType: "application/json; charset=utf-8",
	      		dataType: "text",
	    		beforeSend:function(xhr){
	    	       xhr.setRequestHeader(header, token);
	    	    },
	    	    success: function (result) {
	    	    	if(result == 1) {
	    	    		Swal.fire({
	    					title: "삭제 불가",
	    			        text: "현재 설정되어있는 휴일은 삭제할 수 없습니다.",
	    			        icon: "error",
	    			        confirmButtonText: "확인"
	    	    		});
	    	    	} else {
	    	    		$.ajax({
    			    		type: "POST",
    			    		url: "/setting/companyHoliday/remove",
    			    		data: cohNo,
    			    		contentType: "application/json; charset=utf-8",
    			      		dataType: "text",
    			    		beforeSend:function(xhr){
    			    	       xhr.setRequestHeader(header, token);
    			    	    },
    			    		success: function (rslt) {
    			    			console.log("rslt : " + rslt);
    			    			if(rslt == 1) {
    			    				Swal.fire({
    									title: "삭제 완료",
    							        text: "",
    							        icon: "success",
    							        confirmButtonText: "확인"
    							    }).then(function() {
    							    	$(pthis).closest('.form-check').remove();
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

function fDelete(pthis) {
	console.log(pthis);
	console.log(pthis.value);
	
	const cohNo = pthis.value;
	console.log("cohNo 번호::" + cohNo);
	
	Swal.fire({
	    title: '이 항목을 삭제하시겠습니까?',
	    showCancelButton: true,
	    cancelButtonText: '취소',
	    confirmButtonText: '확인'
	}).then((rslt) => {
	    if (rslt.isConfirmed) {
			$.ajax({
				type: "POST",
				url: "/setting/companyHoliday/delete",
				data: cohNo,
				contentType: "application/json; charset=utf-8",
		  		dataType: "text",
				beforeSend:function(xhr){
			       xhr.setRequestHeader(header, token);
			    },
				success: function (rslt) {
					console.log("rslt : " + rslt);
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
					    })
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
</head>
<body>
	<!-- <h1>${companyHoliVO}</h1>  -->
	<!-- 오른쪽 모달창 -->
	<div class="modal fade modal-right modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="form-control" id="holidayAdd"
						data-toggle="modal" data-target="#verticalModal">
						<div id="plus">
							<span class="fe fe-24 fe-plus"></span>
						</div>
						<div class="hol">추가하기</div>
					</button>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="companyHoliForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divHoli">
						<div>법정 공휴일은 아래 목록에서 추가하세요.</div>
						<div class="form-check">
							<input class="form-check-input sm" type="checkbox" name="checkbox" id="selectAllCheckbox">
							<label class="form-check-label" for="selectAllCheckbox">전체 선택</label>
						</div>
						<c:forEach var="companyHoliVO" items="${companyHoliVO}">
							<div class="form-check">
								<input class="form-check-input sm" type="checkbox" name="cohNo" id="${companyHoliVO.cohNo}">
								<label class="form-check-label" for="${companyHoliVO.cohNo}">
									${companyHoliVO.cohNm} 
								</label>
							<c:if test="${companyHoliVO.cohNo > 11}">
								<button class="btn mb-2 btn-outline-danger fe fe-24 fe-trash-2 sm" 
									value="${companyHoliVO.cohNo}" type="button" onclick="fRemove(this)"></button>
							</c:if> 				
							</div>
						</c:forEach>
					</div>
					<div class="modal-footer">
						<button class="saveButton">저장</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 가운데 모달창 -->
	<div class="modal fade" id="verticalModal" tabindex="-1" role="dialog"
		aria-labelledby="verticalModalTitle" style="display: none;"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="verticalModalTitle">쉬는 날 추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="compAddHoliForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body">
						<label for="holName">이름</label>
						<input type="text" class="form-control" id="holName" placeholder="휴가명을 적어주세요">
						<label for="holCont">설명</label>
						<input type="text" class="form-control" id="holCont" placeholder="휴가 설명을 적어주세요">
						<label for="holSdate">시작일</label>
						<input type="date" class="form-control" id="holSdate">
						<label for="holEdate">종료일</label>
						<input type="date" class="form-control" id="holEdate">
						<br>
						<label for="holEsntl">필수 여부</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" class="form-check-input" id="holEsntl">
						<br>
						<label for="holRepeat">매년 반복</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" class="form-check-input" id="holRepeat">
					</div>
					<div class="modal-footer">
						<button type="button" class="cancelBtn" onclick="fAutoFill()">자동채우기</button>
						<button class="saveButton">
							저장</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>회사 휴일 설정</h1>
			<hr>
		</div>
		<div class="card shadow mb-4">
			<div class="card-header">
				<select class="form-control" id="example-select">
					<option>2024년</option>
					<option selected="2023">2023년</option>
					<option>2022년</option>
				</select>
				<button type="button" class="form-control" id="holidayInsert"
					data-toggle="modal" data-target=".modal-right">
					<div id="plus">
						<span class="fe fe-24 fe-plus"></span>
					</div>
					<div class="hol">쉬는 날 추가</div>
				</button>
			</div>
			<c:forEach var="companyHoliVO" items="${companyHoliVO}">
				<c:if test="${companyHoliVO.cohYn == 'Y'}">
					<div class="card-body">
						<div class="form-group mb-3">
							<div class="icon">
								<img src="/resources/images/setting/${companyHoliVO.img}"
									class="lzy lazyload--done">
							</div>
							<div class="holiNm">
								<b>${companyHoliVO.cohNm}</b>
							</div>
							<div class="holiCont">
								<p>${companyHoliVO.cohCont}</p>
							</div>
							<div class="holidayType">
								<c:if test="${companyHoliVO.cohEsntlYn == 'Y'}">
									<button type="button" class="mainBtn"> <span class="fe fe-check fe-16 mr-2"></span>필수</button>
								</c:if>
								<c:if test="${companyHoliVO.cohRepeatYn == 'Y'}">
									<button type="button" class="returnYear">매년</button>
<!-- 									 <span class="fe fe-rotate-cw fe-16 mr-2"></span> -->
								</c:if>
								<button class="btn mb-2 btn-outline-danger fe fe-24 fe-trash-2" style="border:none;margin-top:1px;" value="${companyHoliVO.cohNo}" onclick="fDelete(this)"></button>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
</body>
</html>