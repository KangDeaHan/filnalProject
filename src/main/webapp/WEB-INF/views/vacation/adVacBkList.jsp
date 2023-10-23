<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
thead th {
    font-weight: bold; /* 굵게 설정 */
    color: black;      /* 검은색 텍스트 색상 설정 */
    text-align: center; /* 텍스트 가운데 정렬 */
}

.gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important;
}

.card-body{
  background-color: white; /* 흰색 배경 */
  padding: 20px; /* 카드 안의 내용과의 간격 조절 */
  border-radius: 10px; /* 카드 테두리 둥글게 만듦 */
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}


a:visited {
	color: black;
	text-decoration: none;
}

a {
	text-decoration-line: none;
}
</style>
</head>
<body>
	<div style="display: flex;">
		<div>
			<h1 style="margin-left:25px;">
				<font style="vertical-align: inherit;"><a class="gray-link" href="/vct/main">내 휴가&nbsp;</a></font>
			</h1>
		</div>
		<div>
			<h1 style="margin-left:25px;">
				<font style="vertical-align: inherit;"><a href="/advct/vacbk">구성원 휴가&nbsp;&nbsp;&nbsp;&nbsp;</a></font>
			</h1>
		</div>
	</div>
	<hr>
	<div>
		<h4 style="margin-left:25px;">
			 <font style="vertical-align: inherit;"><a href="/advct/vacbk">휴가/휴직 현황&nbsp;&nbsp;</a></font> 
				<font
				style="vertical-align: inherit;"><a class="gray-link" href="/advct/annualGive">&nbsp;&nbsp;&nbsp;구성원 연차 상세</a></font>
		</h4>
	</div>
	<hr>
				
	<div class="row my-4">
		<!-- Small table -->
		<div class="col-md-12" >
			<div class="card shadow">
				<div class="card-body" >
				<h4>휴가 내역</h4>
					<!-- table -->
					<div id="dataTable-1_wrapper"
						class="dataTables_wrapper dt-bootstrap4 no-footer">

						<div class="row">
							<div class="col-sm-12 col-md-12">
								 <div id="dataTable-1_filter" class="dataTables_filter">
                                    <input type="search" id="searchField" class="form-control form-control-sm" placeholder="" aria-controls="dataTable-1">
                                    <button type="button" id="searchButton" class="btn btn-primary btn-icon-split btn-sm">
                                        <span class="text">검색</span>
                                    </button>
                                </div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
									<table id="allTable" class="table table-borderless table-hover">
									<thead>
										<tr role="row" style="text-align:center;">
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="#: activate to sort column ascending"
												style="width: 200px;"><strong>사원 번호</strong></strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Name: activate to sort column ascending"
												style="width: 200px;"><strong>사원명</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Date: activate to sort column ascending"
												style="width: 200px;"><strong>휴가명</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Department: activate to sort column ascending"
												style="width: 200px;"><strong>휴가 시작일</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Company: activate to sort column ascending"
												style="width: 200px;"><strong>휴가 종료일</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Phone: activate to sort column ascending"
												style="width: 200px;"><strong>휴가신청일자</strong></th>
											<th class="sorting_desc" tabindex="0"
												aria-controls="dataTable-1" rowspan="1" colspan="1"
												aria-label="Address: activate to sort column ascending"
												style="width: 200px;" aria-sort="descending"><strong>휴가 사용일수</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="City: activate to sort column ascending"
												style="width: 200px;"><strong>반차 유형</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Action: activate to sort column ascending"
												style="width: 200px;"><strong>휴가상태코드</strong></th>
<!-- 											<th class="sorting" tabindex="0" aria-controls="dataTable-1" -->
<!-- 												rowspan="1" colspan="1" -->
<!-- 												aria-label="Action: activate to sort column ascending" -->
<!-- 												style="width: 100px;">비고</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="vacApply" items="${vacList}" varStatus="status">
										
										<tr role="row" class="odd"  style="text-align:center;">
											<td >${vacApply.empNo}</td>
											<td>${vacApply.vaapEmp}</td>
											<td>${vacApply.vacTypeName}</td>
											<td>${vacApply.vaapStart}</td>
											<td class="">${vacApply.vaapEnd}</td>
											<td>${vacApply.vaapDate}</td>
											<td class="sorting_1">${vacApply.vaapDays}일</td>
											<td class="">${vacApply.vaapType}</td>
				              				   <c:choose>
											        <c:when test="${vacApply.vaapApstCode eq '결재대기'}">
											        	<td>
											            	<span class="badge badge-pill badge-info" style="color: white;">${vacApply.vaapApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${vacApply.vaapApstCode eq '결재완료'}">
											        	<td>
											           		<span class="badge badge-pill badge-success" style="color: white;">${vacApply.vaapApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${vacApply.vaapApstCode eq '반려'}">
											        	<td>
											            	<span class="badge badge-pill badge-danger" style="color: white;">${vacApply.vaapApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${vacApply.vaapApstCode eq '결재요망'}">
											       		 <td>
											            	<span class="badge badge-pill badge-warning" style="color: white;">${vacApply.vaapApstCode}</span>
											            </td>
											        </c:when>
											    </c:choose>
										</tr>
										<tr role="row" class="even">
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-5">
							</div>
              <nav aria-label="Table Paging" class="my-3">
					<ul class="pagination justify-content-end mb-0" id="pagination1">
					    <!-- "이전" 버튼 -->
					    <li class="page-item" id="prevPage1">
					        <a class="page-link" href="#" aria-label="Previous">
					            <span aria-hidden="true">&laquo;</span>
					        </a>
					    </li>
					    <!-- 페이지 번호들이 여기에 동적으로 추가됩니다. -->
					    <!-- "다음" 버튼 -->
				        <li class="page-item" id="nextPage1">
				            <a class="page-link" href="#" aria-label="Next">
				                <span aria-hidden="true">&raquo;</span>
				            </a>
				        </li>
				    </ul>
				</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- simple table -->
	</div>
	<!-- 휴직 리스트 조회 -->
	<div class="row my-4">
		<!-- Small table -->
		<div class="col-md-6" >
			<div class="card shadow" style="width:100%;">
				<div class="card-body" >
				<h4>휴직 내역</h4>
					<!-- table -->
					<div id="dataTable-1_wrapper"
						class="dataTables_wrapper dt-bootstrap4 no-footer">
						<div class="row">
							<div class="col-sm-12 col-md-12">
								 <div id="dataTable-1_filter" class="dataTables_filter">
                                    <input type="search" id="searchField2" class="form-control form-control-sm" placeholder="" aria-controls="dataTable-1">
                                    <button type="button" id="searchButton2" class="btn btn-primary btn-icon-split btn-sm">
                                        <span class="text">검색</span>
                                    </button>
                                </div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12" style="white-space: nowrap;">
									<table id="allTable2" class="table table-borderless table-hover">
									<thead>
										<tr role="row" style="text-align:center;">
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="#: activate to sort column ascending"
												style="width: 200px;"><strong>사원 번호</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Name: activate to sort column ascending"
												style="width: 200px;"><strong>사원명</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Date: activate to sort column ascending"
												style="width: 200px;"><strong>휴직명</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Department: activate to sort column ascending"
												style="width: 200px;"><strong>휴직 시작일</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Company: activate to sort column ascending"
												style="width: 200px;"><strong>휴직 종료일</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="City: activate to sort column ascending"
												style="width: 200px;"><strong>증명자료 제출여부</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Action: activate to sort column ascending"
												style="width: 200px;"><strong>휴직상태코드</strong></th>
<!-- 											<th class="sorting" tabindex="0" aria-controls="dataTable-1" -->
<!-- 												rowspan="1" colspan="1" -->
<!-- 												aria-label="Action: activate to sort column ascending" -->
<!-- 												style="width: 100px;">비고</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="bkApply" items="${bkList}" varStatus="status">
										
										<tr role="row" class="odd"  style="text-align:center;">
											<td >${bkApply.empNo}</td>
											<td>${bkApply.empNm}</td>
											<td>${bkApply.bkCode}</td>
											<td>${bkApply.bkSdate}</td>
											<td>${bkApply.bkEdate}</td>
											<td><span class="badge badge-pill badge-danger" style="color:white;">
					              				  <font>${bkApply.bkCertYn}</font></span></td>
 											 <c:choose>
											        <c:when test="${bkApply.bkApstCode eq '결재대기'}">
											        	<td>
											            	<span class="badge badge-pill badge-info" style="color: white;">${bkApply.bkApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${bkApply.bkApstCode eq '결재완료'}">
											        	<td>
											           		<span class="badge badge-pill badge-success" style="color: white;">${bkApply.bkApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${bkApply.bkApstCode eq '반려'}">
											        	<td>
											            	<span class="badge badge-pill badge-danger" style="color: white;">${bkApply.bkApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${bkApply.bkApstCode eq '결재요망'}">
											       		 <td>
											            	<span class="badge badge-pill badge-warning" style="color: white;">${bkApply.bkApstCode}</span>
											            </td>
											        </c:when>
											    </c:choose>
										</tr>
										<tr role="row" class="even">
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-5">
							</div>
			 <div class="col-md-6">
              <nav aria-label="Table Paging" class="my-3">
					<ul class="pagination justify-content-start mb-0" id="pagination2">
						<!-- 이전 버튼 -->
					    <li class="page-item" id="prevPage2">
					        <a class="page-link" href="#" aria-label="Previous">
					            <span aria-hidden="true">&laquo;</span>
					        </a>
					    </li>
					    <!-- "다음" 버튼 -->
				        <li class="page-item" id="nextPage2">
				            <a class="page-link" href="#" aria-label="Next">
				                <span aria-hidden="true">&raquo;</span>
				            </a>
				        </li>
				    </ul>
				</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	<!-- 복직 리스트 조회 -->
		<div class="col-md-6" >
			<div class="card shadow" style="width:100%;">
				<div class="card-body" >
					<h4>복직 내역</h4>
					<div id="dataTable-1_wrapper"
						class="dataTables_wrapper dt-bootstrap4 no-footer">
						<div class="row">
							<div class="col-sm-12 col-md-12">
								 <div id="dataTable-1_filter" class="dataTables_filter">
                                    <input type="search" id="searchField3" class="form-control form-control-sm" placeholder="" aria-controls="dataTable-1">
                                    <button type="button" id="searchButton3" class="btn btn-primary btn-icon-split btn-sm">
                                        <span class="text">검색</span>
                                    </button>
                                </div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
									<table id="allTable3" class="table table-borderless table-hover">
									<thead>
										<tr role="row" style="text-align:center;">
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="#: activate to sort column ascending"
												style="width: 200px;"><strong>사원 번호</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Name: activate to sort column ascending"
												style="width: 200px;"><strong>사원명</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Department: activate to sort column ascending"
												style="width: 200px;"><strong>복직 시작일</strong></th>
											<th class="sorting" tabindex="0" aria-controls="dataTable-1"
												rowspan="1" colspan="1"
												aria-label="Action: activate to sort column ascending"
												style="width: 200px;"><strong>복직상태코드</strong></th>
<!-- 											<th class="sorting" tabindex="0" aria-controls="dataTable-1" -->
<!-- 												rowspan="1" colspan="1" -->
<!-- 												aria-label="Action: activate to sort column ascending" -->
<!-- 												style="width: 100px;">비고</th> -->
										</tr>
									</thead>
									<tbody>
										<c:forEach var="rsApply" items="${rsList}" varStatus="status">
										
										<tr role="row" class="odd"  style="text-align:center;">
											<td >${rsApply.empNo}</td>
											<td>${rsApply.empNm}</td>
											<td>${rsApply.rsDate}</td>
											<c:choose>
											        <c:when test="${rsApply.rsApstCode eq '결재대기'}">
											        	<td>
											            	<span class="badge badge-pill badge-info" style="color: white;">${rsApply.rsApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${rsApply.rsApstCode eq '결재완료'}">
											        	<td>
											           		<span class="badge badge-pill badge-success" style="color: white;">${rsApply.rsApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${rsApply.rsApstCode eq '반려'}">
											        	<td>
											            	<span class="badge badge-pill badge-danger" style="color: white;">${rsApply.rsApstCode}</span>
											            </td>
											        </c:when>
											        <c:when test="${rsApply.rsApstCode eq '결재요망'}">
											       		 <td>
											            	<span class="badge badge-pill badge-warning" style="color: white;">${rsApply.rsApstCode}</span>
											            </td>
											        </c:when>
											</c:choose>
										</tr>
										<tr role="row" class="even">
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-5">
							</div>
              <nav aria-label="Table Paging" class="my-3">
					<ul class="pagination justify-content-end mb-0" id="pagination3">
					    <li class="page-item" id="prevPage3">
					        <a class="page-link" href="#" aria-label="Previous">
					            <span aria-hidden="true">&laquo;</span>
					        </a>
					    </li>
				        <li class="page-item" id="nextPage3">
				            <a class="page-link" href="#" aria-label="Next">
				                <span aria-hidden="true">&raquo;</span>
				            </a>
				        </li>
				    </ul>
				</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		<!-- simple table -->
</body>
<script>
$(function() {
	
    var itemsPerPage1 = 10; // 한 페이지당 표시할 열의 수
    var currentPage1 = 1; // 현재 페이지
    var totalRows1 = $("table#allTable tbody tr").length; // 전체 행 수
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
            search();
        }
    });

    function search() {
        var searchText = $("#searchField").val().toLowerCase();

        // 모든 행을 숨김
        $("table#allTable tbody tr").hide();

        // 검색어와 일치하는 행을 표시
        $("table#allTable tbody tr").each(function() {
            var employeeName = $(this).find('td:eq(1)').text(); // 두 번째 열의 사원 이름을 가져옴
            if (employeeName.toLowerCase().indexOf(searchText) !== -1) {
                $(this).show();
            }
        });

        // 검색 결과가 변경되었으므로 페이지도 업데이트
        updatePage1();
    }

});

$(function() {
    var itemsPerPage2 = 10;
    var currentPage2 = 1;
    var totalRows2 = $("table#allTable3 tbody tr").length;
    var totalPages2 = Math.ceil(totalRows2 / itemsPerPage2);

    // 초기 페이지 업데이트
    updatePage2();

    $("#prevPage2").on("click", function() {
        if (currentPage2 > 1) {
            currentPage2--;
            updatePage2();
        }
    });

    $("#nextPage2").on("click", function() {
        if (currentPage2 < totalPages2) {
            currentPage2++;
            updatePage2();
        }
    });

    function generatePageNumbers2() {
        $("#pagination2 li.page-number2").remove();

        for (var i = 1; i <= totalPages2; i++) {
            var pageLink = $("<li class='page-item page-number2'><a class='page-link' href='#'>" + i + "</a></li>");
            if (i === currentPage2) {
                pageLink.addClass("active");
            }
            pageLink.insertBefore($("#nextPage2"));
        }

        $(".page-number2 a").on("click", function() {
            currentPage2 = parseInt($(this).text());
            updatePage2();
        });
    }

    function updatePage2() {
        var startIndex = (currentPage2 - 1) * itemsPerPage2;
        var endIndex = startIndex + itemsPerPage2;

        $("table#allTable2 tbody tr").hide();

        $("table#allTable2 tbody tr").slice(startIndex, endIndex).show();

        generatePageNumbers2();
    }
});

$(document).ready(function() {
    $("#searchButton2").on("click", function() {
        search();
    });

    $("#searchField2").on("keyup", function(event) {
        if (event.keyCode === 13) {
            search();
        }
    });

    function search() {
        var searchText = $("#searchField2").val().toLowerCase();

        $("table#allTable2 tbody tr").hide();

        $("table#allTable2 tbody tr").each(function() {
            var employeeName = $(this).find('td:eq(1)').text().toLowerCase();
            if (employeeName.indexOf(searchText) !== -1 || searchText === "") {
                $(this).show();
            }
        });

        updatePage2();
    }
});
// //복직 처리
$(function() {
    var itemsPerPage3 = 10;
    var currentPage3 = 1;
    var totalRows3 = $("table#allTable3 tbody tr").length;
    var totalPages3 = Math.ceil(totalRows3 / itemsPerPage3);

    // 초기 페이지 업데이트
    updatePage3();

    $("#prevPage3").on("click", function() {
        if (currentPage3 > 1) {
            currentPage3--;
            updatePage3();
        }
    });

    $("#nextPage3").on("click", function() {
        if (currentPage3 < totalPages3) {
            currentPage3++;
            updatePage3();
        }
    });

    function generatePageNumbers3() {
        $("#pagination3 li.page-number3").remove();

        for (var i = 1; i <= totalPages3; i++) {
            var pageLink = $("<li class='page-item page-number3'><a class='page-link' href='#'>" + i + "</a></li>");
            if (i === currentPage3) {
                pageLink.addClass("active");
            }
            pageLink.insertBefore($("#nextPage3"));
        }

        $(".page-number3 a").on("click", function() {
            currentPage3 = parseInt($(this).text());
            updatePage3();
        });
    }

    function updatePage3() {
        var startIndex = (currentPage3 - 1) * itemsPerPage3;
        var endIndex = startIndex + itemsPerPage3;

        $("table#allTable3 tbody tr").hide();

        $("table#allTable3 tbody tr").slice(startIndex, endIndex).show();

        generatePageNumbers3();
    }
});

$(document).ready(function() {
    $("#searchButton3").on("click", function() {
        search();
    });

    $("#searchField3").on("keyup", function(event) {
        if (event.keyCode === 13) {
            search();
        }
    });

    function search() {
        var searchText = $("#searchField3").val().toLowerCase();

        $("table#allTable3 tbody tr").hide();

        $("table#allTable3 tbody tr").each(function() {
            var employeeName = $(this).find('td:eq(1)').text().toLowerCase();
            if (employeeName.indexOf(searchText) !== -1 || searchText === "") {
                $(this).show();
            }
        });

        updatePage3();
    }
});



</script>

</html>