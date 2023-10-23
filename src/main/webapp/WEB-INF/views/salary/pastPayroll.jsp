<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>  
  
<!DOCTYPE html>
<html>
<head>
<style>
	 #header1 {
	     height: 14vh;
	 }
	 #header2 {
	     display: flex;
	     align-items: center; /* 수직 정렬 중앙 정렬 */
	     height: 60%; /* 부모 높이에 맞게 설정 */
	 }
	 #header2>div {
	     display: flex;
	     align-items: center; /* 수직 정렬 중앙 정렬 */
	     height: 100%; /* 부모 높이에 맞게 설정 */
	 }
	.gray-link {
	    color: #CDD1D5 !important;
	    text-decoration: none !important; 
	}
	/* 링크 스타일 */
	.aTag {
		text-decoration: none; /* 밑줄 제거 */
		margin-right: 20px; /* 각 링크 사이의 간격 조절 */
	}
	
	a:visited {
	   color: black;
	   text-decoration: none;
	}
	
	.table thead th, td {
		text-align: center;
		color : black !important;;
	}
</style>
<meta charset="UTF-8">
<title>지난 정산 내역</title>
</head>
<body>
		<div id="header1">
			<div id="header2">
			
				<div id="header3">
					<h1><a href="/salary/home" class="aTag" style="margin-left: 25px;">급여정산</a>&nbsp;&nbsp; <a href="#" class="gray-link">퇴직소득</a>&nbsp;&nbsp;</h1>
					<h1><a href="/salary/dataManagement" class="aTag gray-link"  >자료관리</a></h1>
				</div>
			</div>
			<hr>
				<div id="header3">
					<h4 style="margin-bottom: 2px;">
							<a href="/salary/home" class="aTag gray-link" style=" margin-left: 25px;">홈</a>&nbsp;&nbsp; 
							<a href="/salary/pastPayroll" class="aTag" >지난 정산 내역</a>&nbsp;&nbsp; 
							<a href="/salary/tmpList" class="aTag gray-link">정산템플릿 목록</a>
					</h4>
				</div>
		
		</div>
		<hr>

	
	<div class="input-container justify-content-center">
		<c:if test="${latestPrYr != 0}">
    		<input style="width:150px;" type="text" class="form-control" value="${latestPrYr}" /><br>
		</c:if>
   	</div>
	
    <c:if test="${latestPrYr != 0}">	
    	<div class="card shadow">
       		<div class="card-body">
          		<h5 class="card-title"><span class="fe fe-24 fe-clipboard"></span>&nbsp;정산 내역 리스트</h5>
   	</c:if>
                      
    <!-- latestPrYr가 null이면 해당 메시지를 출력 -->
    <c:if test="${latestPrYr == 0}">
    	<div class="card shadow" style="width : 900px; margin-top:100px;">
    		<div class="card-body">
    			<p style="font-size:1.1rem;text-align:center;padding-top:10px;"><span class="fe fe-24 fe-alert-circle" style="margin-top:30px;"></span> 해당 귀속연도에 정산내역이 없습니다</p>
    </c:if>
		              
		              
           <!-- pastPayrollList가 비어있지 않으면 테이블을 출력 -->
       		  <c:if test="${not empty pastPayrollList}">
                  <table class="table table-striped table-hover">
                    <thead>
                      <tr>
                        <th>귀속년월</th>
                        <th>급여정산명</th>
                        <th>급여지급일자</th>
                        <th>지급총액</th>
                        <th>공제총액</th>
                        <th>실지급액</th>
                        <th></th>
                      </tr>
                    </thead>
                    
                    <tbody>
					<c:forEach var="pastPayroll" items="${pastPayrollList}" varStatus="stat">	
                      <tr>
                      	<form method="post">
	                        <input type="hidden" value="${pastPayroll.ptNo}" name="ptNo" />
	                        <input type="hidden" value="${pastPayroll.prYr}" name="prYr" />
	                        <input type="hidden" value="${pastPayroll.prMth}" name="prMth" />
	                        <input type="hidden" value="${pastPayroll.prStlNm}" name="prStlNm" />
	                        <input type="hidden" value="${pastPayroll.prPdate}" name="prPdate" />
                         
                       		<sec:csrfInput/>
                       	</form>
                       	
                        <td>${pastPayroll.prYr}-${pastPayroll.prMth}</td>
                        <td>${pastPayroll.prStlNm}</td>
                        <td>${pastPayroll.prPdate}</td>
                        <td><fmt:formatNumber value="${pastPayroll.sumPytlAmt}" pattern="#,###" />원</td>
                        <td><fmt:formatNumber value="${pastPayroll.sumDdtlAmt}" pattern="#,###" />원</td>
                        <td><fmt:formatNumber value="${pastPayroll.sumNetAmt}" pattern="#,###" />원</td>
                        <td>
                          <div class="dropdown">
                            <button class="btn btn-sm dropdown-toggle" type="button" id="dr1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                              <span class="text-muted sr-only">Action</span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dr1">
                              <a class="dropdown-item" href="#" onclick="viewWageRes(this)"><i class="fe fe-24 fe-file-text fe-12 mr-4"></i>정산 결과 보기</a>
                              <a class="dropdown-item" href="#" onclick="excelDown(this)"><i class="fe fe-download fe-12 mr-4"></i>이체리스트 다운로드</a>
                              <a class="dropdown-item" href="#" style="color:red" onclick="deletePayroll(this)"><i class="fe fe-delete fe-12 mr-4"></i>정산 삭제하기</a>
                            </div>
                          </div>
                        </td>
                      </tr>
       				</c:forEach>	

                    </tbody>
                  </table>
               	</c:if>
               </div>
             </div>
                  
<script>
//지난정산내역 완료 페이지로 보낼 데이터 form 전송
function viewWageRes(pThis) {
	event.preventDefault(); // a tag 이동 막기
	
// 	console.log("pThis : ", pThis);
	var form = $(pThis).closest("tr").find("form");
// 	console.log("form : ", form);
	
	// 폼의 액션을 설정
    form.attr("action", "/salary/viewWageRes");
	
    // form 전송
    form.submit();
	
}

const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';



//급여대장 삭제하기 위한 데이터 ajax 전송
function deletePayroll(pThis) {
	event.preventDefault(); // a tag 이동 막기
	
	var tr = $(pThis).closest("tr");
	console.log("tr " , tr);

	var ptNo = tr.find("[name=ptNo]").val();
	var prYr = tr.find("[name=prYr]").val();
	var prMth = tr.find("[name=prMth]").val();
	
	let data = {"ptNo" : ptNo,
				"prYr" : prYr,
				"prMth" : prMth
				};
	
	$.ajax({
		url: "/salary/deletePayroll", 
		type: "delete", 
		data: JSON.stringify(data), // 업데이트할 북마크 상태 데이터
		contentType:"application/json;charset=utf-8",
		dataType: "text",
		beforeSend:function(xhr){
			  xhr.setRequestHeader(header, token);
			  },
		success: function (result) {
			console.log("result : ", result);
// 			if(result=="success"){
// 				rowList.removeChild(colmd3Div);
// 			}
			location.href ="/salary/pastPayroll";
		},
		error:function(xhr, status, error){
			console.log("code: " + xhr.status)
			console.log("message: " + xhr.responseText)
			console.log("error: " + error);
		}
	});//ajax끝
}//deletePayroll 끝



//이체리스트 엑셀 다운로드
function excelDown(pThis){
	
	event.preventDefault(); // a tag 이동 막기
	
	var tr = $(pThis).closest("tr");
	console.log("tr " , tr);

	var ptNo = tr.find("[name=ptNo]").val();
	var prYr = tr.find("[name=prYr]").val();
	var prMth = tr.find("[name=prMth]").val();
	
	let data = {
				"ptNo" : ptNo,
				"prYr" : prYr,
				"prMth" : prMth
				}
	
	$.ajax({
			url : "/salary/excelDownPayroll",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify(data),
		    xhrFields: {
		        responseType: "blob",
		    },
			type : "post",
		//	dataType : "text",
			beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	    	},
			success : function(result){
				console.log("ppp",result);
				
				//var blob = new Blob([result], { type: "application/octetstream" });
			    var downloadUrl = URL.createObjectURL(result);
		        var a = document.createElement("a");
		            a.href = downloadUrl;
		            a.download = "salaryCert.xlsx";
		            document.body.appendChild(a);
		            a.click();
				//console.log("result : ", blob);
				
			},
			error:function(xhr, status, error){
			    console.log("code: " + xhr.status)
			    console.log("message: " + xhr.responseText)
			    console.log("error: " + error);
			}
		
	})//ajax
}//excelDown 끝
</script>	
             
</body>
</html>