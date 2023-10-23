<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 소식</title>
<style>
a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a {
	text-decoration-line: none;
}
.mainBtn, .noticeSubmit, .noticeUpSubmit {
	background: linear-gradient(to right, #3783C6, #39A4C5);
	border-radius: 10px;
	padding: 10px 20px;
    color: white;
    border: none;
    font-weight: 900;
    margin-bottom: 15px;
}

.fe.fe-send {
    vertical-align: middle;
}

.full {
	width:100%;
	height:809px;
	border-top: 1px solid #EDEDEE;
}
#noticeTitle {
	color: black;
    font-weight: bold;
    margin-top : 30px;
    border : none;
}
#noticeTitle::placeholder {
    color: #CDD1D5;
}

#noticeTextArea::placeholder {
    color: #CDD1D5;
}

#noticeTextArea {
  width: 100%;
  height: 430px;
  font-weight: bold;
  border : none;
}

.fileUp {
	border-radius: 10px;
	background-color:white;
	padding: 10px 20px;
    color: #556372;
    cursor: pointer;
    border: 1px solid #EFEFEF;
    font-weight: 900;
}

.fileUp:hover {
    background-color: #f5f5f5; /* 배경 색상 */
    cursor: pointer;
}
.table-notice {
    font-size: 14px;
    background: white;
    border:none;
    width: 100%;
}
.notice-title {
    font-weight: 700;
    font-size: 16px;
    color: black;
    border:none;
}
.notice-time {
    font-weight: 700;
    font-size: 0.75rem;
    color: gray;
}
.notice-name {
    font-weight: 600;
    font-size: 0.9rem;
    color: gray;
}

table.table-notice tbody:hover {
    background-color: #f5f5f5;
}

.noticeHeader {
    max-height: 95%; /* 최대 높이를 원하는 값으로 설정 */
    overflow: hidden;
}

/* 웹킷 기반 브라우저 (Chrome, Safari) */
.noticeHeader::-webkit-scrollbar {
    width: 10px; /* 스크롤바의 너비 */
}

.noticeHeader::-webkit-scrollbar-thumb {
    background-color: #888; /* 스크롤바의 색상 */
    border-radius: 10px; /* 둥근 경계 적용 */
}

/* 파이어폭스 */
.noticeHeader {
    scrollbar-width: thin; /* 스크롤바의 너비 설정 */
}

.noticeHeader::-webkit-scrollbar-thumb {
    background-color: #888; /* 스크롤바의 색상 */
    border-radius: 10px; /* 둥근 경계 적용 */
}
</style>
</head>
<body>
	<div id="myWrap">
	<div class="d-flex flex-row bd-highlight mb-3">
		<div class="myWork">
			<a href="/common/home">
				<h1 style="color: #CDD1D5;margin-left: 25px;margin-top:5px;">홈 피드</h1>
			</a>
		</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="flex-fill">
			<h1 style="margin-top:5px;">회사 소식</h1>
		</div>
		<div class="d-flex flex-row justify-content-end">
				<c:set var="oneBreak" value="false" />
				<c:forEach items="${authentication.authorities}" var="authority">
					<c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
						<c:if
							test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 21 && oneBreak eq false}">
							<button type="button" class="mainBtn" data-toggle="modal"
								data-target="#verticalModal">
								<span class="fe fe-plus-circle fe-16 mr-2"></span>공지사항 등록하기
							</button>
							<c:set var="oneBreak" value="true" />
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
     	</div>
     </div>
     <div class="d-flex flex-row bd-highlight mb-3">
	     <div class="noticeTab">
	   		<h5 style="border-bottom: 2px solid black;margin-left: 25px;">공지사항 <span id="noticeCount" style="color:#3783C6;font-size:20px;font-weight:bold;"> 0</span></h5>
		 </div>
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   		<div class="todoTap">
<!--    			<h5 style="color: #CDD1D5;margin-top:3px;">할 일</h5> -->
   		</div>
     </div>
     <div class="full">
     	
     </div>
     
     <!-- Modal -->
   <div class="modal fade" id="verticalModal" tabindex="-1" role="dialog" aria-labelledby="verticalModalTitle" aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered" role="document">
           <div class="modal-content" style="border-radius: 1.3rem; border: none;">
               <form id="noticeForm" enctype="multipart/form-data">
                   <div class="modal-header">
                       <br>
                       <input type="hidden" name="postNo" id="postNo">
                       <input class="form-control form-control-lg" id="noticeTitle" name="postTitle" type="text" placeholder="공지사항 제목" style="color: black; font-weight: bold;">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                       </button>
                   </div>
                   <div class="modal-body" style="height: 55vh;">
                       <textarea class="form-control" id="noticeTextArea" name="postCont" rows="4" placeholder="공지사항 내용을 작성해주세요."></textarea>
                       <br>
                       <div class="fileUp" id="fileUpBtn">
                           <span class="fe fe-folder-plus fe-16 mr-2"></span>
                           <span class="fileName"> 첨부파일 </span>
                           <button type="button" class="close delete-schedule"><span>+</span></button>
                           <input type="file" id="fileInput" name="file" style="display: none;">
                           <input type="hidden" name="fileNo" id="fileNo">
                       </div>
                   </div>
                   <div class="modal-footer" style="justify-content: center;">
                       <button type="button" class="noticeSubmit" style="width: 95%;"><span class="fe fe-edit-2 fe-16 mr-2"></span>작성하기</button>
                       <button type="button" class="noticeUpSubmit" style="width: 95%; display: none;"><span class="fe fe-edit-3 fe-16 mr-2"></span>수정하기</button>
                   </div>
               </form>
           </div>
       </div>
   </div>
</body>
<script>
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

	$(() => {
		notiList();
	})
	
	
	function convertTimeToRelative(timeInMilliseconds) {
    const currentTime = new Date().getTime();
    const timeDifference = currentTime - timeInMilliseconds;

    const seconds = Math.floor(timeDifference / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);

    	if (days > 0) {
	        return days + "일 전";
	    } else if (hours > 0) {
	        return hours + "시간 전";
	    } else if (minutes > 0) {
	        return minutes + "분 전";
	    } else {
	        return "방금 전";
	    }
	}
	
	// 공지사항 리스트 불러오기
	   const notiList = function() {
	       let url = "/common/notiList";
	       $.ajax({
	           url: url,
	           type: "get",
	           beforeSend: function (xhr) {
	               xhr.setRequestHeader(header, token);
	           },
	           success: function (res) {
	               console.log("공지사항 리스트 ", res);
	               const noticeCount = res.length;
	               
	               let str = "<table class='table-notice'>";
	               for (let i = 0; i < res.length; i++) {
	                   const relativeTime = convertTimeToRelative(res[i].wriDate);
	                   
	                   
	                   // 파일 다운로드 링크 생성
	                   const fileDownloadLink = res[i].svfiName; // 첨부 파일의 경로
	                   
	                   str += `<tbody id="noticeTable" style="border-bottom: 1px solid #EDEDEE;">
	                   <tr>
	                       <td style='width:70px; height:70px;'>
	                           <img src="/resources/images/insight-basic50x50.png">
	                       </td>
	                       <td>
	                           <div>
	                               <span class="notice-title">\${res[i].postTitle}</span>&nbsp;&nbsp;
	                               <span class="notice-time">\${relativeTime}</span>&nbsp;&nbsp;
	                               <c:set var="oneBreak" value="false" />
	                                   <c:forEach items="${authentication.authorities}" var="authority">
	                                       <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
	                                           <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 22 && oneBreak eq false}">
	                               <span>
	                                   <button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></button>
	                                   <div class="dropdown-menu dropdown-menu-left">
	                                       <button class="dropdown-item" onclick="noticeSelect(\${res[i].postNo})">수정</button>
	                                       <button class="dropdown-item" onclick="deleteNotice(\${res[i].postNo})" style="color:red;">삭제</button>
	                               
	                                   </div>
	                               </span>
	                               <c:set var="oneBreak" value="true" />
	                                   </c:if>
	                               </c:forEach>
	                           </c:forEach>
	                           </div>
	                           <div>
	                               <span class="notice-name">\${res[i].empNm}님</span><br>
	                               \${res[i].fileNo ? `<span class="fe fe-paperclip fe-16 mr-2" style="font-weight: 700;font-size: 0.85rem;color: black;"><a style="margin-left:-9px;" href="\${fileDownloadLink}" download="\${res[i].orfiName}">
	                         			    <button type="button" style="border:none;background:none;">
	                         		        <span style="font-weight: 700;font-size: 0.75rem;color: gray;">\${res[i].orfiName}</span>
	                         		    </button>
	                         		</a></span>` : ''}
	                           </div>
	                       </td>
	                   </tr>
	                   <tr>
	                       <td style="border:none;"></td>
	                       <td style="border-top:none;">\${res[i].postCont}</td>
	                   </tr>
	                   <td colspan="2" style="padding: 20px 0;border: none;"></td>
	                   </tbody>`;
	               }
	               str += "</table>";
	               $(".full").html(str);
	               $("#noticeCount").text(noticeCount);
	           },
	           error: function (xhr, status, error) {
	               console.error("AJAX 요청 실패: " + error);
	           },
	       });
	   }
	
	// 공지사항 1개 조회
	const noticeSelect = function(postNo){
	    console.log("1개조회버튼 클릭", postNo);
	    $("#verticalModal").modal("show");
	    $(".noticeSubmit").css("display", "none");
	    $(".noticeUpSubmit").css("display", "block");

	    $.ajax({
	        url: "/common/notiSelect/" + postNo,
	        type: "get",
	        dataType: "json",
	        contentType: "application/json;charset=utf-8",
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success: function (result) {
	            console.log("select 체크", result);

	            // 조회된 공지사항 내용에서 <br> 태그를 \n으로 변환
	            let formattedContent = result.postCont.replace(/<br>/g, "\n");

	            // 모달 창 내의 입력 필드에 기존 값 설정
	            $("#noticeTitle").val(result.postTitle);
	            $("#noticeTextArea").val(formattedContent); // .val() 메서드를 사용하여 값을 설정

	            $("#postNo").val(result.postNo);
	        },
	        error: function (xhr, status, error) {
	            console.error("AJAX 요청 실패: " + error);
	        },
	    });
	}

	
	// 공지사항 수정
	$(".noticeUpSubmit").on("click",function(){
		let postNo = $("#postNo").val();
		let title = $("#noticeTitle").val();
		let contentValue = noticeCnt.val();
	    // <textarea> 내의 줄바꿈(\n)을 <br> 태그로 처리
	    let formattedContent = contentValue.replace(/\n/g, "<br>");
	    
		let noticeVal = {
				postTitle : title,
				postCont : formattedContent,
				postNo : postNo
		};
	    $.ajax({
	        url: "/common/notiUpdate",
	        data: JSON.stringify(noticeVal),
	        type: "put",
	        dataType: "json",
	        contentType: "application/json;charset=utf-8",
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success: function (result) {
	            console.log("공지수정 체크", result);
	            console.log("수정데이터 체크", noticeVal);
	            Swal.fire({
	                position: 'top-end',
	                icon: 'success',
	                title: '수정 완료',
	                showConfirmButton: false,
	                timerProgressBar: true,
	                timer: 1500
	            })
	            $("#verticalModal").modal("hide");
	            notiList();
	        },
	        error: function (xhr, status, error) {
	            console.error("AJAX 요청 실패: " + error);
	        },
	    });
	})
	

	// 공지사항 삭제
	const deleteNotice = function(postNo){
	    console.log("삭제버튼");
	    $.ajax({
	        url: "/common/notiDelete/" + postNo,
	        type: "delete",
	        dataType: "json",
	        contentType: "application/json;charset=utf-8",
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success: function (result) {
	            console.log("공지삭제 체크", result);
	            Swal.fire({
	                  position: 'top-end',
	                  icon: 'success',
	                  title: '삭제 완료',
	                  showConfirmButton: false,
	                  timerProgressBar: true,
	                  timer: 1500
	                })
	            notiList();
	        },
	        error: function (xhr, status, error) {
	            console.error("AJAX 요청 실패: " + error);
	        },
	    });
	}
	
	const noticeTitle = $("#noticeTitle");
	const noticeCnt = $("#noticeTextArea");
	
	$(".noticeSubmit").on("click", function () {
	    // <textarea> 내의 값을 가져옴
	    let titleValue = noticeTitle.val();
	    let contentValue = noticeCnt.val();

	    // <textarea> 내의 줄바꿈(\n)을 <br> 태그로 처리
	    let formattedContent = contentValue.replace(/\n/g, "<br>");

	    if (!titleValue || !formattedContent) {
	        alert("제목과 내용을 입력해주세요.");
	        return; // AJAX 요청을 실행하지 않고 함수 종료
	    }

	    let url = "/common/notiInsert";

	    let noticeVal = {
	        wriNo: ${empVO.empNo},
	        postTitle: titleValue,
	        postCont: formattedContent // 줄바꿈 처리된 내용 사용
	    };
	    $.ajax({
	        url: url,
	        data: JSON.stringify(noticeVal),
	        type: "post",
	        dataType: "json",
	        contentType: "application/json;charset=utf-8",
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader(header, token);
	        },
	        success: function (result) {
	            console.log("공지등록 체크", result);
	            Swal.fire({
	                position: 'top-end',
	                icon: 'success',
	                title: '등록 완료',
	                showConfirmButton: false,
	                timerProgressBar: true,
	                timer: 1500
	            })
	            $("#verticalModal").modal("hide");
	            notiList();
	        },
	        error: function (xhr, status, error) {
	            console.error("AJAX 요청 실패: " + error);
	        },
	    });
	});


	// 모달 닫히면 값 초기화	
	$('#verticalModal').on('hidden.bs.modal', function () {
	    $('#noticeTitle').val(''); // 공지사항 제목 초기화
	    $('#noticeTextArea').val(''); // 공지사항 내용 초기화
	    resetFileUpload(); // input file 초기화
	});
	
	//div 요소를 클릭하면 input 태그를 클릭하도록
	const fileUpBtn = document.getElementById("fileUpBtn");
	const fileInput = document.getElementById("fileInput");
	
	fileUpBtn.addEventListener("click", function() {
	    fileInput.click();
	});
	
	// 파일 선택을 완료 이벤트
	fileInput.addEventListener("change", function() {
	    const selectedFiles = fileInput.files;
	    if (selectedFiles.length > 0) {
	        // 첫 번째 파일 이름을 .fileName 요소에 표시
	        const fileNameElement = document.querySelector('.fileName');
	        fileNameElement.textContent = selectedFiles[0].name;

	        // 버튼 요소의 내용을 "×"로 변경
	        const closeButton = document.querySelector('.delete-schedule');
	        closeButton.innerHTML = '<span>×</span>';

	        // 나머지 파일 개수 표시
	        const fileCount = selectedFiles.length - 1; // 첫 번째 파일을 제외
	        if (fileCount > 0) {
	            fileNameElement.textContent += ` 외 \${fileCount}개`;
	        }
	    }
	});

	
	// x 버튼 클릭시 input file 초기화
	const closeButton = document.querySelector('.delete-schedule');
	closeButton.addEventListener('click', function() {
		resetFileUpload();
	});
	
	// 초기화 이벤트
	function resetFileUpload() {
	    // input 태그의 값을 초기화합니다.
	    fileInput.value = '';

	    // 파일 이름 초기화
	    const fileNameElement = document.querySelector('.fileName');
	    fileNameElement.textContent = '첨부파일';

	    // "×" 버튼을 다시 "+"로 변경
	    closeButton.innerHTML = '<span>+</span>';
	}
	
	// "×" 버튼을 클릭할 때 input 태그의 이벤트 핸들러를 제거
	closeButton.addEventListener('click', function(e) {
	    e.stopPropagation();
	});
</script>
</html>