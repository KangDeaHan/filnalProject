<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    #header1 {
        height: 10vh;
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
/*     #header3{
    	padding: 10px;
    } */
    
    #cont1 {
/*         height: 70vh; */
    }
    #footer1 {
        height: 0px;
    }
  
    button.btn-primary {
        margin-left: auto;
        margin-right: 20px;
    }
    #dataTable_filter {
    	margin-left: auto;
        margin-right: 20px;
    }
    p{
    	margin-bottom: 0px;
    }

	.mainBtn {
	background: linear-gradient(to right, #3783C6, #39A4C5);
	border-radius: 10px;
	padding: 10px 20px;
	color: white;
	border: none;
	font-weight: 900;
	margin-bottom: 15px;
	width: 150px;
	}
	
	.auto {
	background: white;
	border-radius: 10px;
	padding: 10px 20px;
	color: #556372;
	cursor: pointer;
	border: 1px solid #E9EAEA;
	font-weight: 900;
	}
	
	.modal-footer > * {
	margin: 0px !important;
	}
</style>
</head>
<body>
    <!-- border를 표시하고 작업해야 나중에 예쁘게 정리할 수 있음 -->
    <div id="myWrap">
        <div id="header1">
           
            <div id="header2">
            	<div style="margin-left:25px;">
            		<div id="header3">
		           		<a href="/personnel/emp"> <!-- "사원" 링크에 href 속성 추가 -->
							<h1 style="color: #CDD1D5; width: 80px;">사원</h1>
						</a>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<div id="header3">
						<a href="/personnel/Appointments"> <!-- "인사발령" 링크에 href 속성 추가 -->
							<h1 style="width: 150px;">인사발령</h1>
						</a>
					</div>
				</div>
				
				
				<!-- 모달 중앙 -->
				<div id="insaBtn" style="margin-left:32cm;margin-top:10px;">
					<button style="margin-left: -100px;" type="button" class="mainBtn" data-toggle="modal" data-target="#defaultModal"><span class="fe fe-refresh-ccw fe-16 mr-2" st></span>인사발령 </button>
				</div>
                   <!-- 모달 중앙 끝 -->
            </div>
	            <div>
		            <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">


						<!-- <div id="dataTable_filter" class="dataTables_filter">
							<label>Search:<input type="text" id="searchField" class="form-control form-control-sm" placeholder="상태를 입력하세요" aria-controls="dataTable"></label>
							<label>
							submit / button / reset
								<button type="button" id="searchButton" class="btn btn-primary btn-icon-split btn-sm">
									<span class="icon text-white-50">							                                 
		                                 <i class="fas fa-flag"></i>
		                               </span><span class="text">검색</span>
	                            </button>
							</label>

						</div> -->
					</ul>
	            </div>
        </div>
        <div id="cont1">
          <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">

              <!-- table -->
              <div class="card shadow">
                <div class="card-body">
                <h3>변경내역</h3>
                    <hr>                                                                              
                  <table id="allTable" class="table table-borderless table-hover">
                  
                  <!-- 포이치 추가 시작-->
                  <!-- 진행중인 리스트 -->
                  <c:forEach var="asgmtVO" items="${asgmtVOlist}" varStatus="start">
			  		 <tr style="border-bottom: 2px solid gray;"  onclick="fView(this)">
						    <td>
						        <p class="mb-0 text-muted"><strong><span  style="display: inline-block; width: 100px;">${asgmtVO.asgmtClf}</span>
						               
						            <c:choose>
						            	<c:when test="${asgmtVO.asgmtCcst == null || asgmtVO.asgmtCcst == 'C0101'}">
						                <span class="badge badge-pill badge-warning" style="color: white;">진행중</span>
						            	 </c:when>
						            	<c:when test="${asgmtVO.asgmtCcst eq 'C0102' }">
						                <span class="badge badge-pill badge-success" style="color: white;">완료</span>
						            	 </c:when>
						            	<c:when test="${asgmtVO.asgmtCcst eq 'C0103' }">
						                <span class="badge badge-pill badge-secondary" style="color: white;">취소</span>
						            	 </c:when>
						            </c:choose>
						                
						         </strong></p>
						        <small class="mb-0 text-muted">작성자 : ${asgmtVO.writer} / ${asgmtVO.fwrDate }</small>
						    </td>
						    <td style="width: 200px; float: right; margin-top: 10px;">
						        <c:choose>
						            <c:when test="${asgmtVO.asgmtCcst == null || asgmtVO.asgmtCcst == 'C0101'}">
						                <span class="fe fe-24 fe-calendar" id="lweDate" style="font-size: 15px; text-align: left;">미승인</span>
						            </c:when>
						            <c:when test="${asgmtVO.asgmtCcst eq 'C0102' }">
						                <span class="fe fe-24 fe-calendar" id="lweDate" style="font-size: 15px;">${asgmtVO.lwrDate }</span>
						            </c:when>
						            <c:when test="${asgmtVO.asgmtCcst eq 'C0103' }">
						                <span class="fe fe-24 fe-calendar" id="lweDate" style="font-size: 15px;">${asgmtVO.lwrDate }</span>
						            </c:when>
						        </c:choose>
						    </td>
						    <td style="font-size: 15px; width: 80px;">${asgmtVO.personCount }명</td>
						</tr>
                  </c:forEach>
                  
                  
                  <!-- 포이치 추가 끝-->
                  </table>
                </div>
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
            </div> <!-- .col-12 -->
          </div> <!-- .row -->
        </div>
        
        
        
        <div class="modal fade" id="defaultModal" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="defaultModalLabel">인사발령</h5>
                              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                              </button>
                            </div>
                            
                            <!-- 내용 -->
                             <form action="/personnel/Appointmentset" method="post"> <!-- 폼 시작 -->
                            <div class="modal-body">
                            
                             <!-- 한줄 -->
                               <div class="form-row">
                                  <p>발령 대상 부서</p>
                           		<select class="form-control" name="team" id="example-select">
                                   <option value="0">전체구성원</option>
                                   <c:forEach var="dept" items="${deptList }" varStatus="start">
                                   <option value="${dept.dcode }">${dept.dnm }</option>     
                                   </c:forEach>
                                   
                                   
                                 </select>
                               </div>
                              <!-- 한줄끝 -->
                              <br>
                             <!-- 두줄 -->
                               <div class="form-row">
                                  <p>발령라벨</p>
                           		<select class="form-control" name="promotion" id="example-select">
                                   <option value="직챙승진">직책승진</option>
                                   <option value="전환배치">전환배치</option>
                                   <option value="전직">전직</option>
                                   <option value="전출">전출</option>
                                   <option value="전적">전적</option>
                                   <option value="파견">파견</option>
                                 </select>
                               </div>
                              <!-- 두줄끝 -->
                              <br>
                             <!-- 셋째줄 -->
                               <div class="form-row">
								  <div class="form-group col-md-6">
		                            <label for="date-input1">발령일</label>
		                            <div class="input-group">
		                              <div class="input-group-prepend">
		                              </div>
										<input type="date" name="date" > 
		                            </div>
		                          </div>
                               </div>
                              <!-- 셋째줄끝 -->
                              <!-- 네번쨰줄 -->
                               <div class="form-row">
                                  <p>발령사유</p>
									<textarea class="form-control" name="rsn" id="example-textarea" rows="4" placeholder="작성하기"></textarea>
                               </div><br>
                              <!-- 네번째줄끝 -->
                              <!-- 다섯번쨰줄 -->
                               <div class="form-row">
                                  <p>메모</p>
									<textarea class="form-control" name="note" id="example-textarea" rows="4" placeholder="작성하기"></textarea>
                               </div><br>
                              <!-- 다섯번째줄끝 -->
                            
                            </div>
                            
                            <div class="modal-footer">
                              <button style="display: inline-block; margin-top: 0px;" class="auto" onclick="fill()">자동완성</button>
                              <button style="display: inline-block; margin: 0px;" type="submit" class="mainBtn">작성하기</button>
                            </div>
                             <sec:csrfInput/>
                             </form> <!-- 폼 끝 -->
                          </div>
                        </div>
                      </div>
        
          
        </div>
        <div id="footer1">
        </div>

    </div>
    
<script type="text/javascript">
	function fill(){
		event.preventDefault();
		console.log("채우기!@")
		
		$("select[name=team]").val("12");
		$("select[name=promotion]").val("전환배치");
		$("input[name=date]").val("2023-10-17");
		$("textarea[name=rsn]").val("부서 재배치");
 		$("textarea[name=note]").val("부서 재배치");
	}


	$(document).on("click",("#fill"), function(){
		console.log("채우기")
	})

	$('#defaultModal').on('hidden.bs.modal', function () {
    // 폼 필드 초기화
   	 $(this).find('form')[0].reset();
	});

		

$(function() {
	
    var itemsPerPage1 = 9; // 한 페이지당 표시할 열의 수
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
            var employeeName = $(this).find('span:eq(1)').text(); // 세 번째 열의 사원 이름을 가져옴
            if (employeeName.indexOf(searchText) !== -1) {
                $(this).show();
            }
            console.log("출력", $(this).is(":visible")); 
        });


        updatePage1();

    }
    
});



  function fView(Pthis) {
	    console.log(Pthis);
	    var clf = $(Pthis).find('span:eq(0)').text();
	    var ccst = $(Pthis).find('span:eq(1)').text();
	    var small2 = $(Pthis).find('small').text();
	    var LWR_DATE = $(Pthis).find('span:eq(2)').text();
	    
	    
	    var str = small2;
	    var array = str.split(" ");
	    
	    console.log("뭐냐냐" , clf)
	    
	    var WRITER = array[2];
	    var FWR_DATE = array[4] + " " +array[5];
	    
	    if(LWR_DATE=="미승인"){
	    	LWR_DATE = null;
	    }
	    console.log("Lss" + LWR_DATE)
	    
	    if(ccst == "진행중"){
	    	ccst = "C0101";
	    	url = "asgmtDetailIng";
	    } else if(ccst =="완료") {
	    	ccst = "C0102";
	    	url = "asgmtDetail";
		} else {
			ccst = "C0103";
			url = "asgmtDetailCancel";
		}
	    
	    
		location.href="/personnel/"+url+"?writer=" + WRITER+"&fwrDate="+FWR_DATE+"&ccst="+ccst+"&lwrDate="+LWR_DATE+"&asgmtclf="+clf;
	    



	    
	    
	}
  
</script>
</body>
</html>