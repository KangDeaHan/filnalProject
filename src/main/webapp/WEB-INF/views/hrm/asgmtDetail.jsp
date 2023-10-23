<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>border를 두고 작업</title>
    <style>

/*  		div{
			border: 1px solid red;
		}  */

        #header1 {
/*             height: 10vh; */
            display: flex;
            align-items: center; /* 수직 정렬 중앙 정렬 */
        }

        #header3 {
            padding: 10px;
        }

        #content {
            display: flex;
        }

        #left-table {
            display: inline-block;
            width: 100%;
            vertical-align: top;
        }

/*         #right-table { */
/*             display: inline-block; */
/*             width: 45%;  */
/*             vertical-align: top; */
/*         } */
        .table-container table {
            width: 100%; /* 테이블 너비 100% 설정 */
        }

        .table-container th,
        .table-container td {
            padding: 10px; /* 셀 안의 여백 설정 */
            text-align: center; /* 가운데 정렬 */
        }
        
       #dataTable_filter {
    	margin-left: auto;
        margin-right: 20px;
  	 	 }

        .table-container tr {
            border-bottom: 1px solid #ddd; /* 테이블 행 사이 경계선 설정 */
        }
        td, th{
        	height: 100px;
        }
		table {
	        border-collapse: collapse;
	        width: 100%;
	    }
	
	    /* 테이블 헤더 스타일 지정 */
	    th {
	        background-color: #f2f2f2;
	        text-align: center;
	        padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
	        border: 1px solid #ddd; /* 테두리 스타일 지정 */
	        height : 30px;
	    }
	
	    /* 테이블 데이터 셀 스타일 지정 */
	    td {
	        text-align: center;
	        padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
	        border: 1px solid #ddd; /* 테두리 스타일 지정 */
	        height: 20px;
	    }
        
        p {
            margin-bottom: 0px;
        }

        .two {
            background: #dcf4ff;
        }

        .one {
            background: #dffbe3;
        }
		.table-hover th {
		    border: 1.5px lightgrey solid;
		}
		
		.table-hover td {
		    border: 1.5px lightgrey solid;
		}
    </style>
</head>
<body>


        <div id="header1">
        <div id="header3">
            <a href="/personnel/Appointments">
                <h1>인사발령</h1>
            </a>
        </div>

    </div>
    
            <ul class="nav nav-tabs mb-3" id="myTab" role="tablist" >
            
            <!-- <div id="dataTable_filter" class="dataTables_filter">
            	<div  style="float: right; width: ">
                <label>Search:<input type="text" id="searchField" class="form-control form-control-sm" placeholder="이름 , 사번 입력하세요" aria-controls="dataTable"></label>
					<label>
					submit / button / reset
						<button type="button" id="searchButton" class="btn btn-primary btn-icon-split btn-sm">
							<span class="icon text-white-50">							                                 
                                 <i class="fas fa-flag"></i>
                               </span><span class="text">검색</span>
                           </button>
					</label>
                </div>
            </div> -->
            
        </ul>
        
    <div style="width: 100%; display: inline-block;">
<%--     <div style="width: 30%; display: inline-block; margin-top: 10px; background: #dcf4ff; border-color: #dcf4ff" class="alert alert-primary" role="alert">발령 사유<br>${asgmtDetailList[0].asgmtRsn }</div> --%>
<%--     <div style="width: 30%; display: inline-block; margin-top: 10px; " class="alert alert-dark" role="alert">발령 메모<br>${asgmtDetailList[0].asgmtMm }</div> --%>
    <span style="float: right; margin-top: 15px;margin-right:15px; "><button type="button" class="btn mb-2 btn-success" style="background: #dcf4ff; border-color:#dcf4ff; width: 25px; height: 25px;border-radius:20px;border:1px solid black;"> </button> 변경후</span>
    <span style="float: right; margin-top: 15px;margin-right:25px;"><button type="button" class="btn mb-2 btn-success" style="background: #dffbe3; border-color:#dffbe3; width: 25px; height: 25px;border-radius:20px;border:1px solid black;"> </button> 변경전</span>
    </div>
    

    
        <input type="hidden" id="fwrDate" value="${asgmtDetailList[0].fwrDate }"> 
<%--         사유${asgmtDetail.asgmtRsn } --%>
    
    
     <div class="card shadow">
    <div class="card-body">
    <div id="content">
        <div id="left-table">
            <!-- 왼쪽 테이블 내용 -->
            <table class="table table-hover" border="1">
    
                <thead>
			        <tr>
			           <%--  <th>
			            
							<c:choose>
							    <c:when test="${asgmtDetailList[0].asgmtCcst == 'C0101'}"> 
							        <div class="custom-control custom-checkbox">
							            <input type="checkbox" onclick="selectAll(this)" class="custom-control-input" id="all2">
							            <label class="custom-control-label" for="all2"></label>
							        </div>
							    </c:when>
							    <c:when test="${asgmtDetailList[0].asgmtCcst != 'C0101'}"> 
							        <div></div>
							    </c:when>
							</c:choose>
			                
			                
			            </th> --%>
			            <th><strong>프로필</strong></th>
			            <th  style="border-right: 1px #ddd solid;"><strong>이름</strong></th>
			            <th class="one"><strong>본부</strong></th>
			            <th class="one"><strong>부서</strong></th>
			            <th class="one"><strong>팀</strong></th>
			            <th class="one"><strong>조직,직책</strong></th>
			            <th class="one"><strong>직위</strong></th>
			            <th class="one" style="border-right: 1px #ddd solid;"><strong>직급</strong></th>
			            
			            
			            <th class="two"><strong>본부</strong></th>
			            <th class="two"><strong>부서</strong></th>
			            <th class="two"><strong>팀</strong></th>
			            <th class="two"><strong>조직,직책</strong></th>
			            <th class="two"><strong>직위</strong></th>
			            <th class="two"><strong>직급</strong></th>
			           
			           
			        </tr>
			    </thead>
			    <tbody>
			    
			            <c:forEach var="asgvo2" items="${asgmtDetailList}" varStatus="start1">
			            <tr style="height: 50px;" class="original">
							    <%-- <td>
							    <c:choose>
							    <c:when test="${asgmtDetailList[0].asgmtCcst == 'C0101'}"> 
							        <div class="custom-control custom-checkbox">
							            <input type="checkbox" name="checkbox" class="custom-control-input" id="2474+${start1.index}">
							            <label class="custom-control-label" for="2474+${start1.index}"></label>
							        </div>
							          </c:when>
								    <c:when test="${asgmtDetailList[0].asgmtCcst != 'C0101'}"> 
								        <div></div>
								    </c:when>
								</c:choose>
							    </td> --%>
			            	
			                
			                <td>
			                    <div class="avatar avatar-md">
			                        <img src="${asgvo2.empImg }" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" >
			                    </div>
			                </td>
			                <td>
			                    <p class="mb-0 text-muted">
			                        <strong>${asgvo2.empVO.empNm }</strong>
			                    </p>
			                    <small class="mb-0 text-muted">${asgvo2.empVO.empNo }</small>
			                </td>
			                <!-- DCODE -->
			                <td >${asgvo2.empVO.acenter }</td>
			                <td >${asgvo2.empVO.bcenter }</td>
			                <td >${asgvo2.empVO.ccenter }</td>
			                
			                <c:choose>
			                
			                <c:when test="${asgvo2.empVO.jcode !=null}">
			                <!-- 조직, 직책 -->
			                <td >${asgvo2.empVO.jcode },${asgvo2.empVO.dtcode }</td>
			                </c:when>
			                <c:when test="${asgvo2.empVO.jcode ==null}">
			                <td >신입</td>
			                </c:when>
			                
			                </c:choose>
			                <!-- 직위 -->
			                <td >${asgvo2.empVO.ptnCode }</td>
			                <!-- 직급 -->
			                <td >${asgvo2.empVO.grdCode }</td>
			                
			                <td id="aCenter"><strong>${asgvo2.acenter}</strong></td>
			                <td id="bCenter"><strong>${asgvo2.bcenter}</strong></td>
			                <td id="cCenter"><strong>${asgvo2.ccenter}</strong></td>
			                
			                <c:choose>
			                <c:when test="${asgvo2.jcode !=null}">
			                <td id="sum"><strong>${asgvo2.jcode},${asgvo2.dtcode }</strong></td>
			                </c:when>
			                <c:when test="${asgvo2.jcode ==null}">
			                <td id="sum"></td>
			                </c:when>
			                </c:choose>
			                <!-- 직책,조직장 -->
			                <td id="ptnCode"><strong>${asgvo2.ptnCode }</strong></td>
			                <td id="grdCode"><strong>${asgvo2.grdCode }</strong></td>
			        
			            </tr>
			            
	   				 <tr class="fake" style="border: 0px; display: none;">
	                    <td colspan="2"  style="border-right: 1px #ddd solid;"></td>
	                    <td colspan="6"  style="border-right: 1px #ddd solid;">발령 사유 : <strong>${asgvo2.asgmtRsn}</strong></td>
	                    <td colspan="6" >발령 메모 : <strong>${asgvo2.asgmtMm}</strong></td>
	   				 </tr>
			            
			            
			                </c:forEach>
			    </tbody>
            </table>
        </div>
        
 <%--        <div id="right-table">
            <!-- 오른쪽 테이블 내용 -->
            <table class="table table-hover">
                <thead class="thead-dark">
			        <tr>
			            <th>본부</th>
			            <th>부서</th>
			            <th>팀</th>
			            <th>조직,직책</th>
			            <th>직위</th>
			            <th>직급</th>
			           
			        </tr>
			    </thead>
			    <tbody>
			            <c:forEach var="asgvo" items="${asgmtDetailList}" varStatus="start">
			            <tr>
			                <td class="two" id="aCenter">${asgvo.acenter}</td>
			                <td class="two" id="bCenter">${asgvo.bcenter}</td>
			                <td class="two" id="cCenter">${asgvo.ccenter}</td>
			                <td class="two" id="sum">${asgvo.jcode }, ${asgvo.dtcode } </td>
			                <!-- 직책,조직장 -->
			                <td class="two" id="ptnCode">${asgvo.ptnCode }</td>
			                <td class="two" id="grdCode">${asgvo.grdCode }</td>
			        
			            </tr>
			        </c:forEach>
			    </tbody>
            </table>
        </div> --%>
    </div>
    </div>
    </div>
    
    <c:choose>
	    <c:when test="${asgmtDetailList[0].asgmtCcst == 'C0101'}"> 
			 <button style="float: right; margin: 15px;'" type="button" onclick="sUpdate()" class="btn mb-2 btn-primary">인사발령</button> 
	   		 <button style="float: right; margin: 15px;" type="button" data-toggle="modal" data-target="#defaultModal" class="btn mb-2 btn-danger">인사발령 취소</button>						        
		</c:when>
	</c:choose>
   
    


    <div id="footer1">
        
    </div>
    
    <!-- 모달창 -->
     <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="defaultModalLabel">발령취소</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                              </button>
                            </div>
                            
                            <!-- 내용 -->
                            <div class="modal-body">
                            
                             
                               <div class="form-row">
                                  <p>취소 사유</p>
									<textarea class="form-control" id="asgmtRsn" rows="4">?? </textarea>
                               </div><br>
                              <!-- 네번째줄끝 -->
                             
                            
                            </div>
                            
                            <div class="modal-footer">
                              <button class="btn mb-2 btn-danger" onclick="fcancel()">발령취소</button>
                            </div>
                             <sec:csrfInput/>
                          </div>
                        </div>
                      </div>
    <!-- 모달창 -->
    
    
    
    
    
    
    <script type="text/javascript">
    
    document.querySelectorAll('.original').forEach(function(originalRow) {
        originalRow.addEventListener('mouseenter', function() {
            var fakeRow = originalRow.nextElementSibling;
            if (fakeRow && fakeRow.classList.contains('fake')) {
                fakeRow.style.display = 'table-row';
            }
        });
        
        originalRow.addEventListener('mouseleave', function() {
            var fakeRow = originalRow.nextElementSibling;
            if (fakeRow && fakeRow.classList.contains('fake')) {
                fakeRow.style.display = 'none';
            }
        });
    });
    
    ///////////검색 시작 ///////////////
    $(function() {
	console.log("검색!!");
    var itemsPerPage1 = 5; // 한 페이지당 표시할 열의 수
    var currentPage1 = 1; // 현재 페이지
    var totalRows1 = $("table#allTable tbody tr:visible").length; // 전체 행 수
    var totalPages1 = Math.ceil(totalRows1 / itemsPerPage1); // 전체 페이지 수

    // 초기 페이지 업데이트
    updatePage1();

    // 이전 페이지로 이동
    $("#prevPage1").on("click", function() {
        if (currentPage1 > 1) {
            currentPage1--;
            updatePage1();
        }
    });

    // 다음 페이지로 이동
    $("#nextPage1").on("click", function() {
        if (currentPage1 < totalPages1) {
            currentPage1++;
            updatePage1();
        }
    });

    // 페이지 번호들을 동적으로 생성
    function generatePageNumbers1() {
        $("#pagination1 li.page-number1").remove(); // 기존 페이지 번호 제거

        for (var i = 1; i <= totalPages1; i++) {
            var pageLink = $("<li class='page-item page-number1'><a class='page-link' href='#'>" + i + "</a></li>");
            if (i === currentPage1) {
                pageLink.addClass("active");
            }
            pageLink.insertBefore($("#nextPage1"));
        }

        // 페이지 번호 클릭 시 해당 페이지로 이동
        $(".page-number1 a").on("click", function() {
            currentPage1 = parseInt($(this).text());
            updatePage1();
        });
    }

    // 페이지를 업데이트하고 테이블을 다시 그리는 함수
    function updatePage1() {
        var startIndex = (currentPage1 - 1) * itemsPerPage1;
        var endIndex = startIndex + itemsPerPage1;

        // 모든 행을 숨김
        $("table#allTable tbody tr").hide();

        // 현재 페이지의 행만 표시
        $("table#allTable tbody tr").slice(startIndex, endIndex).show();

        // 페이지 번호들을 동적으로 생성
        
        generatePageNumbers1();
         
    }
    
});



//검색 기능 구현	
$(document).ready(function() {
    $("#searchButton").on("click", function() {
        search();
    });

    // Enter 키 누를 때 검색 함수 호출
    $("#searchField").on("keyup", function(event) {
        if (event.keyCode === 13) { // Enter 키의 keyCode는 13입니다.
        	console.log("검검")
            search();
        }
    });
    
    var searchText = ""; // 검색어를 저장할 변수 추가


    function search() {
        var searchText = $("#searchField").val().toLowerCase();

        // 모든 행을 숨김
        $("table tbody tr").hide();

        // 검색어와 일치하는 행을 표시
        $("table tbody tr").each(function() {
            var employeeName = $(this).closest("tr").find('td:eq(2)').text(); // 세 번째 열의 사원 이름을 가져옴
            if (employeeName.indexOf(searchText) !== -1) {
                $(this).show();
            }
        });



    }
    
});
    ///////////검색 끝 ///////////////
    
    
    
	//체크박스 전부선택
	function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('checkbox');
	  
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  });
	}
	
	function fcancel(){
		console.log("로그쳌");
		
		var empNoList = [];
		
		var checkboxes = $("input[name=checkbox]:checked");
		
		checkboxes.each(function () {
			var tr = $(this).closest("tr");
			
			var empNo = tr.find("td:eq(2) small").text();
			var asgmtRsn = $("#asgmtRsn").val();
			var fwrDate = $("#fwrDate").val();
			
			console.log("@@@" + asgmtRsn);
			console.log("fwrDate@@!" + fwrDate);
			
			
			empNo = {
					"empNo" : empNo,
					"asgmtRsn" : asgmtRsn,
					"fwrDate" : fwrDate
					}
			
			empNoList.push(empNo);
		})
		
			console.log("리스트 " , empNoList);

			$.ajax({
				type : "post",
				url : "/personnel/cancel",
				data: JSON.stringify(empNoList),
				contentType: 'application/json; charset=utf-8',
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success : function(suc){
					console.log("성공 히히");
					
					location.href="/personnel/Appointments";
					
				},
				error: function(xhr, status, error) {
	                console.error("AJAX 오류:", error);             
	            }
			})
	}
	
	

	function sUpdate(){
		var empNoList = [];
		
		var checkboxes = $("input[name=checkbox]:checked");
		
		checkboxes.each(function () {
			var tr = $(this).closest("tr");

			var empNo = tr.find("td:eq(2) small").text();
			var fwrDate = $("#fwrDate").val();
			var aCenter =tr.find("#aCenter").text();
			var bCenter =tr.find("#bCenter").text();
			var cCenter =tr.find("#cCenter").text();
			var sum     =tr.find("#sum").text();
			var ptnCode =tr.find("#ptnCode").text();
			var grdCode =tr.find("#grdCode").text();
			var jCode;       //직무 sum 1
			var dtCode;      // 팀장 파트장 sum 2
// 			var head;         //조직장 sum 3
			
			var Scut = sum.split(",");

			 console.log("sum2" + sum);
			
			
			jCode = Scut[0];
			dtCode = Scut[1];
// 			head = Scut[2];
			
			console.log("jcode" + jCode)
			console.log("dtCode" + dtCode)
// 			console.log("head" + head)
			
			empNo = {
					"empNo" : empNo,
					"fwrDate" : fwrDate,
				    "aCenter" : aCenter,	
				    "bCenter" : bCenter,	
				    "cCenter" : cCenter,	
				    "ptnCode" : ptnCode,	
				    "grdCode" : grdCode,	
				    "jCode" : jCode,	
				    "dtCode" : dtCode	
// 				    "head" : head,	
					}
			
			
			empNoList.push(empNo);
		})
			console.log("리스트22 " , empNoList);
		
		
		$.ajax({
			type : "post",
			url : "/personnel/sUpdate",
			data: JSON.stringify(empNoList),
			contentType: 'application/json; charset=utf-8',
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(suc){
				console.log("성공 히히");
				
// 				location.href="/personnel/Appointments";
				
			},
			error: function(xhr, status, error) {
                console.error("AJAX 오류:", error);             
            }
		})
		
	}
    
	
    </script>
</body>
</html>
