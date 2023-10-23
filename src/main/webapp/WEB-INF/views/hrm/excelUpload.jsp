<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form enctype="multipart/form-data">
    <div class="contents">
        <div>첨부파일은 한개만 등록 가능합니다.</div>
 
        <dl class="vm_name">
                <dt class="down w90">첨부 파일</dt>
                <dd><input id="excelFile" type="file" name="excelFile"/></dd>
        </dl>        
    </div>
            
    <div class="bottom">
        <button type="button" id="addExcelImpoartBtn" class="btn"><span>추가</span></button> 
    </div>
</form> 

</body>

<script>
// function checkFileType(filePath) {
//     var fileFormat = filePath.split(".");
//     if (fileFormat.indexOf("xlsx") > -1) {
//         return true;
//     } else {
//         return false;
//     }

// }

// function check() {
//     var file = $("#excelFile").val();
//     if (file == "" || file == null) {
//         alert("파일을 선택해주세요.");
//         return false;
//     } else if (!checkFileType(file)) {
//         alert("엑셀 파일만 업로드 가능합니다.");
//         return false;
//     }

//     if (confirm("업로드 하시겠습니까?")) {
//         var options = {
//             success : function(data) {
//                 alert("모든 데이터가 업로드 되었습니다.");

//             },
//             type : "POST"
//         };
//         $("#excelUploadForm").ajaxSubmit(options);

//     }
// }

const $addExcelImpoartBtn = $("#addExcelImpoartBtn")// 추가 버튼
$addExcelImpoartBtn.on("click", () => {
    var formData = new FormData();
    var fileInput = $("#excelFile")[0]; // 파일 업로드 필드
    if (fileInput.files.length > 0) {
        formData.append("excelFile", fileInput.files[0]);
        $.ajax({
            type: "post",
            url: "/ex/excelUploadAjax",
            data: formData,
            contentType: false, // 기본값이 application/x-www-form-urlencoded
            processData: false, // 기본값이 true, 데이터 처리 비활성화
            cache: false, // 캐시 사용하지 않음
            dataType: "text",
            beforeSend: function (xhr) {
                // CSRF 토큰 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (rslt) {
                console.log("엑셀파일 결과: " + rslt);
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status);
                console.log("message: " + xhr.responseText);
                console.log("error: " + error);
            }
        });
    } else {
        console.log("파일을 선택해주세요.");
    }
});

</script>
</html>