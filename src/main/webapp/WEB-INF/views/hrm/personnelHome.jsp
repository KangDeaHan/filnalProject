<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>인사처리 첫화면</title>

<!--  본문스타일 -->
<style>

.gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important; 
}

 #header1 { 
     height: 25vh ;
 } 
#header2 {
    display: flex;
    align-items: center; /* 수직 정렬 중앙 정렬 */
    height: 30%; /* 부모 높이에 맞게 설정 */
}
#header2>div {
    display: flex;
    align-items: center; /* 수직 정렬 중앙 정렬 */
    height: 100%; /* 부모 높이에 맞게 설정 */
}
#header3{
	padding: 10px;
}

body, html {
    min-height: 100%;
}

body {
    overflow-x: auto; /* 가로 스크롤바 추가 */
    overflow-y: auto; /* 세로 스크롤바 추가 */
    white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
}



#cont1 { 
	overflow-y: auto; /* 세로 스크롤바 추가 */
    height: 75hv; 
} 

button.btn-primary {
    margin-left: auto;
    margin-right: 20px;
}
#dataTable_filter {
	margin-left: auto;
}

#pro{
	height: 50px;
	width: 50px;
}


.card-body {
    overflow-x: auto; /* 가로 스크롤바 추가 */
}


/* 추가된 스타일 */
.example1, .example2 {
    table-layout: auto;
    width: 100%;
}


/*  모달스타일	  */
/* Remove default bullets */
ul, #myUL {
  list-style-type: none;
}

/* Remove margins and padding from the parent ul */
#myUL {
  margin: 0;
  padding: 0;
}

/* Style the caret/arrow */
.caret {
  cursor: pointer;
  user-select: none; /* Prevent text selection */
}

/* Create the caret/arrow with a unicode, and style it */
.caret::before {
  content: "\25B6";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

/* Rotate the caret/arrow icon when clicked on (using JavaScript) */
.caret-down::before {
  transform: rotate(90deg);
}

/* Hide the nested list */
.nested {
  display: none;
}

/* Show the nested list when the user clicks on the caret/arrow (with JavaScript) */
.active {
  display: block;
}

/*  계약상태 테이블 숨기기 */
#cont2 {
    display: none; /* 페이지 로드 시 숨김 */
}
/* 간략버튼 */
.hidden {
    display: none;
}
li #dataTable_filter {
	margin-right: 0px;
}
button #toggleButton{
	margin: 0px;
}
#person {
	height: 80px;
	width: 110px;
}

/* 클릭 가능한 행에 대한 호버 스타일 */



</style>
</head>
<body>
    <!-- border를 표시하고 작업해야 나중에 예쁘게 정리할 수 있음 -->
    <div id="myWrap">
<!--     컨트롤러에서 받아온 전체 값 확인하는 태그 -->
        <div id="header1">
           
            <div id="header2">
            	<div id="header2-1">
            		<div id="header3">
		           		<a href="/personnel/emp"> <!-- "사원" 링크에 href 속성 추가 -->
							<h1 style="margin-left: 25px;">사원</h1>
						</a>
					</div> 
					<c:set var="oneBreak" value="false" />
					<c:forEach items="${authentication.authorities}" var="authority">
					    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
					        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 31 && oneBreak eq false }">
					            <div id="header3">
					                <a href="/personnel/Appointments" >
					                    <h1 class="gray-link" >인사발령</h1>
					                </a>
					            </div>
					        <c:set var="oneBreak" value="true" />
					        </c:if>
					    </c:forEach>
					</c:forEach>
				</div>
					<c:set var="oneBreak" value="false" />
					<c:forEach items="${authentication.authorities}" var="authority">
					    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
					        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 32  && oneBreak eq false}">
								<button  type="button" onclick = "location.href ='/personnel/empadd'" class="btn mb-2 btn-primary" >사원 추가하기</button>
					        <c:set var="oneBreak" value="true" />
					        </c:if>
					    </c:forEach>
					</c:forEach>
				
            </div>
            		<c:set var="oneBreak" value="false" />
					<c:forEach items="${authentication.authorities}" var="authority">
					    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
					        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 32 && oneBreak eq false}">
								<div style="display: flex; justify-content: flex-end; align-items: stretch; width: 100%;">	  
								</div>
								<div style="display: flex; justify-content: flex-end; align-items: stretch; width: 100%;border-bottom: 1px #e9ecef solid;">
								    <div class="contents" style="display: flex; flex-direction: column; align-items: center;">
								        <dl class="vm_name" style="display: flex; flex-direction: column; align-items: flex-end;">
								            <dd><input id="excelFile"  type="file" name="excelFile" style="display: none;"/></dd>
								        </dl>  
								    </div>
									    <div class="bottom" >
									        <button type="button" class="btn mb-2 btn-outline-info" id="fileUploadButton"><span>엑셀파일 선택</span></button>
									        <button type="button" id="addExcelImpoartBtn" class="btn mb-2 btn-primary" ><span>사원리스트 추가</span></button> 
									    </div>
									    
								            
								</div>
								<c:set var="oneBreak" value="true" />
					        </c:if>
					    </c:forEach>
					</c:forEach>
					<div>
			            <ul style="display: flex; align-items: center; list-style-type: none; padding: 0; margin: 20px 0px 5px 20px;">
							<li style="margin-right: 20px;"><a id="all" onclick="showContent(1)" data-toggle="tab" role="tab"  href="#" >
							<h3 id="all2">전체</h3></a></li>
							<c:set var="oneBreak" value="false" />
							<c:forEach items="${authentication.authorities}" var="authority">
							    <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
							        <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 33 && oneBreak eq false}">
							             <li >
							                <a id="csdata" onclick="showContent(2)"
							                   data-toggle="tab" href="#" role="tab">
							                    <h3 id="csdata2" style="color: #CDD1D5">계약상태</h3>
							                </a>
							            </li>
							            <c:set var="oneBreak" value="true" />
							        </c:if>
							    </c:forEach>
							</c:forEach>
						</ul>
						<hr>
	            	</div>
<!-- 						<li id="dataTable_filter" class="dataTables_filter"> -->
<!-- 							<button type="button" class="btn mb-2 btn-primary" data-toggle="modal" data-target="#defaultModal" >조직도</button>	 -->
<!-- 							<button class="btn mb-2 btn-primary" id="downloadButton">전체다운로드</button>	 -->
<!-- 							<button type="button" class="btn mb-2 btn-primary" id="toggleButton" onclick="toggleBriefView()">간략보기</button>	 -->
<!-- 						</li> -->
        </div>
      </div> <!-- div myWrap -->
      <div id="body1">
 
          <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
	        <div id="cont1">

              <!-- table -->
              <div class="card shadow">
                <div class="card-body">
                <div id="table-scroll">
                  <table id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
                    <thead>
                      <tr class="">
                        <th class="insa"><strong>기본정보</strong></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
<!--                         <th class="insa"></th> -->
                        <th class="insa"></th>
                        <th class="insa"></th>
                        <th class="insa"><strong>인사정보</strong></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
                        <th class="insa"><strong>개인 정보</strong></th>
                        <th class="insa"></th>
                        <th class="insa"></th>
                      </tr>
                      <tr>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>번호</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>프로필</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>이름</strong></th>
                        
                        <th class="insa" onclick="event.cancelBubble=true"><strong>상태</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>사번</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>입사일</strong></th>
<!--                         <th class="insa" onclick="event.cancelBubble=true">퇴직일</th> -->
                        <th class="insa" onclick="event.cancelBubble=true"><strong>근속 기간</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>입사 유형</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>직급</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>직위</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>조직</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>주조직 직책</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>이메일</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>성별</strong></th>
                        <th class="insa" onclick="event.cancelBubble=true"><strong>휴대전화</strong></th>
                      </tr>
                    </thead>
                    <tbody>

                     <c:forEach items="${emplist}" var="empVO" varStatus="loop">                

                      <tr class="clickable-row">
							<td class="insa">${loop.index+1}</td>	
							<td class="insa">
							    <c:choose>
							        <c:when test="${empty empVO.empImg}">
							            <img style="border-radius: 10px;" id="pro" src="/resources/images/insight-basic50x50.png" alt="인사이트">
							        </c:when>
							        <c:otherwise>
							            <img style="border-radius: 10px;" id="pro" src="${empVO.empImg}" alt="인사이트" onerror="this.src='/resources/images/insight-basic50x50.png'">
							        </c:otherwise>
							    </c:choose>
							</td>
							<td class="insa"><a href="/common/myPage?empNo=${empVO.empNo}"></a>${empVO.empNm}</td>	
							<td class="insa">
								<p class="mb-0 text-muted">
									<c:choose>
						              <c:when test="${empVO.stClfCdNm eq '재직중'}">
						                <span class="badge badge-pill badge-primary" style="color: white;">재직중</span>
						              </c:when>
						              <c:when test="${empVO.stClfCdNm eq '휴직중' }">
						                <span class="badge badge-pill badge-warning" style="color: white;">휴직중</span>
						              </c:when>
						            </c:choose>
								</p>
							</td>	
							<td class="insa">${empVO.empNo}</td>	
							<td class="insa"><fmt:formatDate value="${empVO.entDate}" pattern="yyyy-MM-dd" /></td>	
<%-- 							<td class="insa"><fmt:formatDate value="${empVO.outDate}" pattern="yyyy-MM-dd" /></td>	 --%>
							<td class="insa"></td>	
							<td class="insa">${empVO.entCaseNm}</td>	
							<td class="insa">${empVO.grdCodeNm}</td>	
							<td class="insa">${empVO.ptnCodeNm}</td>	
							<td class="insa">${empVO.deptVOList.dnm}</td>	
							<td class="insa">${empVO.dtCodeNm}</td>	
							<td class="insa">${empVO.empMail}</td>	
							<td class="insa">${empVO.genCodeNm}</td>	
							<td class="insa">${empVO.cpNo}</td>
                      </tr>                      
 				     </c:forEach>                                                                                                   
                    </tbody>
                  </table>
                </div>
                </div>
              </div>
          
			  <!-- 페이징처리 태그들 시작-->
<!--               <nav aria-label="Table Paging" class="my-3"> -->
<!-- 					<ul class="pagination justify-content-end mb-0" id="pagination1"> -->
<!-- 					    "이전" 버튼 -->
<!-- 					    <li class="page-item" id="prevPage1"> -->
<!-- 					        <a class="page-link" href="#" aria-label="Previous"> -->
<!-- 					            <span aria-hidden="true">&laquo;</span> -->
<!-- 					        </a> -->
<!-- 					    </li> -->
<!-- 					    페이지 번호들이 여기에 동적으로 추가됩니다. -->
<!-- 					    "다음" 버튼 -->
<!-- 				        <li class="page-item" id="nextPage1"> -->
<!-- 				            <a class="page-link" href="#" aria-label="Next"> -->
<!-- 				                <span aria-hidden="true">&raquo;</span> -->
<!-- 				            </a> -->
<!-- 				        </li> -->
<!-- 				    </ul> -->
<!-- 				</nav> -->
			  <!-- 페이징처리 태그들 끝-->
             </div>
           <!-- 첫 번째 컨텐츠 끝 -->
				
				
        </div> <!-- .col-12 -->
       </div> <!-- .row -->
       </div>
          
        
		<!-- 두 번째 컨텐츠 시작 -->
		<div id="cont2">
		  <div class="container-fluid">
		    <div class="row justify-content-center">
		      <div class="col-12">
		
		        <!-- 계약현황 -->
		        <div class="row justify-content-between"> <!-- justify-content-between 클래스 추가 -->
		          <div class="col-md mb-4"> <!-- mb-4 클래스를 추가하여 아래 여백 추가 -->
		            <div class="card shadow">
		              <div class="card-body text-center">
		                <div class="row justify-content-center">
		                  <div>
		                    <span><p>근로계약 만료예정자</p></span>
		                    <div class="row justify-content-center"><h4 id="ednum1"></h4><h4>명</h4></div>
		                  </div>
		                  <div>
		                    <img id="person" alt="프로필" src="/resources/images/사람.jpg"> <!-- id를 클래스로 변경 -->
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <div class="col-md mb-4">
		            <div class="card shadow">
		              <div class="card-body text-center">
		                <div class="row justify-content-center">
		                  <div>
		                    <span><p>임금계약 만료예정자</p></span>
		                    <div class="row justify-content-center"><h4 id="ednum2"></h4><h4>명</h4></div>
		                  </div>
		                  <div>
		                    <img id="person" alt="프로필" src="/resources/images/사람.jpg">
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		          <div class="col-md mb-4">
		            <div class="card shadow">
		              <div class="card-body text-center">
		                <div class="row justify-content-center">
		                  <div>
		                    <span><p>수습중</p></span>
		                    <div class="row justify-content-center"><h4 id="ednum3"></h4><h4>명</h4></div>
		                  </div>
		                  <div>
		                    <img id="person" alt="프로필" src="/resources/images/사람.jpg">
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </div>
		
		
	
             <!-- table2 -->
             <div class="card shadow">
                <div class="card-body">
                <div id="table-scroll">
                  <table id="example2" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example2_info">
                    <thead>
                
                      <tr>
				        <th class="insa" ><strong>번호</strong></th>
				        <th class="insa" ><strong>프로필</strong></th>
				        <th class="insa" ><strong>이름</strong></th>
				        <th class="insa" ><strong>사번</strong></th>
				        <th class="insa" ><strong>근로계약 시작일</strong></th>
				        <th class="insa" ><strong>근로계약 만료일</strong></th>
				        <th class="insa" ><strong>임금계약 시작일</strong></th>
				        <th class="insa" ><strong>임금계약 만료일</strong></th>
				        <th class="insa" ><strong>수습기간 시작일</strong></th>
				        <th class="insa" ><strong>수습기간 시작일</strong></th>
				        <th class="insa" ><strong>주조직 직책</strong></th>
				        <th class="insa" ><strong>직위</strong></th>
				        <th class="insa" ><strong>상태</strong></th>
				      </tr>
                    </thead>
                    <tbody>

                     <c:forEach items="${emplist2}" var="empVO" varStatus="loop">                
                     
                      <tr class="clickable-row">
			              <td class="insa">${loop.index+1}</td>	
			              <td class="insa">
			              	<c:choose>
						        <c:when test="${empty empVO.empImg}">
						            <img id="pro" style="border-radius: 10px;" src="/resources/images/insight-basic50x50.png" alt="인사이트">
						        </c:when>
						        <c:otherwise>
						            <img id="pro" style="border-radius: 10px;" src="${empVO.empImg}" alt="인사이트" onerror="this.src='/resources/images/insight-basic50x50.png'">
						        </c:otherwise>
						    </c:choose>
			              </td>
			              <td class="insa"><a href="/common/myPage?empNo=${empVO.empNo}"></a>${empVO.empNm}</td>
			              <td class="insa">${empVO.empNo}</td>	
			              <td class="insa"><fmt:formatDate value="${empVO.cnthxVOList.blctSdate}" pattern="yyyy-MM-dd" /></td>	
			              <td class="insa"><fmt:formatDate value="${empVO.cnthxVOList.blctEdate}" pattern="yyyy-MM-dd" /></td>	
			              <td class="insa"><fmt:formatDate value="${empVO.cnthxVOList.bwctSdate}" pattern="yyyy-MM-dd" /></td>	
			              <td class="insa"><fmt:formatDate value="${empVO.cnthxVOList.bwctEdate}" pattern="yyyy-MM-dd" /></td>	
			              <td class="insa"><fmt:formatDate value="${empVO.cnthxVOList.prSdate}" pattern="yyyy-MM-dd" /></td>	
			              <td class="insa"><fmt:formatDate value="${empVO.cnthxVOList.prEdate}" pattern="yyyy-MM-dd" /></td>	
			              <td class="insa">${empVO.dtCodeNm}</td>	
			              <td class="insa">${empVO.ptnCodeNm}</td>	
			              <td class="insa">
			              	<p class="mb-0 text-muted">
								<c:choose>
					              <c:when test="${empVO.stClfCdNm eq '재직중'}">
					                <span class="badge badge-pill badge-primary" style="color: white;">재직중</span>
					              </c:when>
					              <c:when test="${empVO.stClfCdNm eq '휴직중' }">
					                <span class="badge badge-pill badge-warning" style="color: white;">휴직중</span>
					              </c:when>
					            </c:choose>
							</p>
			              </td>	
					  </tr>

 				     </c:forEach>                  
                    </tbody>
                  </table>
                </div>
                </div>
              </div>
              
			  <!-- 페이징처리 태그들 시작-->
<!--               <nav aria-label="Table Paging" class="my-3"> -->
<!-- 					<ul class="pagination justify-content-end mb-0" id="pagination2"> -->
<!-- 					    "이전" 버튼 -->
<!-- 					    <li class="page-item" id="prevPage2"> -->
<!-- 					        <a class="page-link" href="#" aria-label="Previous"> -->
<!-- 					            <span aria-hidden="true">&laquo;</span> -->
<!-- 					        </a> -->
<!-- 					    </li> -->
<!-- 					    페이지 번호들이 여기에 동적으로 추가됩니다. -->
<!-- 					    "다음" 버튼 -->
<!-- 				        <li class="page-item" id="nextPage2"> -->
<!-- 				            <a class="page-link" href="#" aria-label="Next"> -->
<!-- 				                <span aria-hidden="true">&raquo;</span> -->
<!-- 				            </a> -->
<!-- 				        </li> -->
<!-- 				    </ul> -->
<!-- 				</nav> -->
			  <!-- 페이징처리 태그들 끝-->
				
				
            </div> <!-- .col-12 -->
          </div> <!-- .row -->
        </div>
    	</div> <!-- 두 번째 컨텐츠 끝  -->
	</div>
<!-- 	body1끝 -->
    <!-- 조직도 모달 시작-->
<div class="modal fade" id="defaultModal" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" style="display: none;" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="defaultModalLabel">조직도</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
      
      <!-- 내용 -->
		<ul id="myUL">
		  <li data-id="company"><span class="caret">회사</span>
		    <ul class="nested">
			  <li data-id="1"><span class="caret">개발본부</span>
			    <ul class="nested">
		          <li data-id="11"><span class="caret">웹개발</span>
		            <ul class="nested">
		              <li data-id="111"><span class="caret">웹개발1팀</span></li>
		              <li data-id="112"><span class="caret">웹개발2팀</span></li>
		            </ul>
		          </li>
		          <li data-id="12"><span class="caret">SW개발</span>
		            <ul class="nested">
		              <li data-id="121"><span class="caret">SW개발1팀</span></li>
		              <li data-id="122"><span class="caret">SW개발2팀</span></li>
		            </ul>
		          </li>
		      </ul>
		     </li>
		     <li data-id="2"><span class="caret">승종본부</span>
		       <ul class="nested">
		         <li data-id="21"><span class="caret">승종본부1</span>
		           <ul class="nested">
		             <li data-id="211"><span class="caret">SW개발1팀</span></li>                
		             <li data-id="212"><span class="caret">SW개발2팀</span></li>               
		           </ul>
		         </li>
			      <li data-id="22"><span class="caret">승종본부2</span>
			        <ul class="nested">
			          <li>Black Tea</li>
			          <li>White Tea</li>
			        </ul>
			      </li>
		      </ul>
		    </li>
		  </ul>
		</li>
	  </ul>
      <!-- 내용  끝-->
      
      <!-- 모달 footer 시작-->
      <div class="modal-footer">
        <button type="button" class="btn mb-2 btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn mb-2 btn-primary">Save changes</button>
      </div>
      <!-- 모달 footer 끝 -->
    </div>
  </div>
</div> <!-- 모달 끝--> 
</body>

<!-- 검색기능 구현 함수 -->

<script>
// $(document).ready(function() {
//     $("#searchButton").on("click", function() {
//         search();
//     });

//     // Enter 키 누를 때 검색 함수 호출
//     $("#searchField").on("keyup", function(event) {
//         if (event.keyCode === 13) { // Enter 키의 keyCode는 13입니다.
//             search();
//         }
//     });
    
//     var searchText = ""; // 검색어를 저장할 변수 추가

//     function search() {
//         var searchText = $("#searchField").val().toLowerCase();

//         // 모든 행을 숨김
//         $("table tbody tr").hide();

//         // 검색어와 일치하는 행을 표시
//         $("table tbody tr").each(function() {
//             var employeeName = $(this).find("td:nth-child(3)").text().toLowerCase(); // 세 번째 열의 사원 이름을 가져옴
//             if (employeeName.indexOf(searchText) !== -1) {
//                 $(this).show();
//             }
//         });

//         // 검색 결과가 없는 경우 메시지를 표시하거나 다른 조치를 취할 수 있습니다.
//         if ($("table tbody tr:visible").length === 0) {
//             // 검색 결과가 없는 경우 처리할 내용을 여기에 추가
//         }
//         // 페이징 함수 호출
//         updatePage1();
//     }
    
// });
</script>

<!-- 사원전체 페이징처리 함수 -->
<script>


$(function() {
	$(document).on("click","#all" ,function(){
		$("#all2").css("color" ,"black");
		$("#csdata2").css("color", "#CDD1D5");
	})
	
	$(document).on("click","#csdata" ,function(){
		$("#all2").css("color" ,"#CDD1D5");
		$("#csdata2").css("color", "black");
	})

	
	
    var itemsPerPage1 = 5; // 한 페이지당 표시할 열의 수
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
</script>

<!-- 모달 조직도 스크립트 -->
<script>
var toggler = document.getElementsByClassName("caret");
var i;

for (i = 0; i < toggler.length; i++) {
  toggler[i].addEventListener("click", function() {
    this.parentElement.querySelector(".nested").classList.toggle("active");
    this.classList.toggle("caret-down");
  });
}
</script>


<!-- 콘텐츠 바꾸기 함수 -->
<script>
function showContent(contentNumber) {
    event.preventDefault(); // 
    var button = document.getElementById("toggleButton");
    if (contentNumber === 1) {
        document.getElementById('cont1').style.display = 'block';
        document.getElementById('cont2').style.display = 'none';
        
        
 /*        if(button.textContent=== "상세보기"){        	
        toggleBriefView();
        	
       	} */
    } else if (contentNumber === 2) {
        document.getElementById('cont1').style.display = 'none';
        document.getElementById('cont2').style.display = 'block';
        
        
/*         if(button.textContent=== "상세보기"){        	
        toggleBriefView();
        	
       	} */
    }
}
    
</script>

<!-- 계약 상태 클릭시 데이터 받기 -->
<!-- ajax 데이터 불러오기 -->
<script>


$('#csdata').on('click', function() {
	/* $("#all").css("color", "#CDD1D5"); // #hearder3의 글자 색상을 회색으로 변경
	$("#csdata").css("color", "black"); // #csdata의 글자 색상을 검은색으로 변경  */
    // AJAX 요청을 보냅니다.
    
//     $.ajax({
//         url: '/personnel/empA',
//         type: 'GET',
//         dataType: 'json',
//         success: function(emplist2) {
//             // 서버에서 받은 데이터를 화면에 표시합니다.
//             console.log("데이터 들어왔다.",emplist2)
//             renderContractStatusTable(emplist2);
//         },
//         error: function (xhr, status, error) {
//         console.log("code: " + xhr.status)
//         console.log("message: " + xhr.responseText)
//         console.log("error: " + error);
//     }
//     });
    
    $.ajax({
        url: '/personnel/edate',
        type: 'GET',
        dataType: 'json',
        success: function(edateMb) {
            // 서버에서 받은 데이터를 화면에 표시합니다.
            console.log("데이터 들어왔니~",edateMb)
            edateMemNum(edateMb);
        },
        error: function (xhr, status, error) {
        console.log("code: " + xhr.status)
        console.log("message: " + xhr.responseText)
        console.log("error: " + error);
    }
    });
	// 근로계약만료임박 인원요청
	function edateMemNum(edateMb) {
	    var edNum1 = $('#ednum1');
	    edNum1.empty(); // 기존 데이터를 지웁니다.
	    
	    var num1 = edateMb.length; // 근로계약만료임박 인원 수
	    
	    // num1 값을 <h4> 태그 내에 넣어줍니다.
	    edNum1.text(num1);
	}
    
    $.ajax({
        url: '/personnel/edate1',
        type: 'GET',
        dataType: 'json',
        success: function(edateMb1) {
            // 서버에서 받은 데이터를 화면에 표시합니다.
            console.log("데이터 들어왔su~",edateMb1)
            edateMemNum1(edateMb1);
        },
        error: function (xhr, status, error) {
        console.log("code: " + xhr.status)
        console.log("message: " + xhr.responseText)
        console.log("error: " + error);
    }
    });
	// 임금계약만료임박 인원요청
	function edateMemNum1(edateMb1) {
	    var edNum2 = $('#ednum2');
	    edNum2.empty(); // 기존 데이터를 지웁니다.
	    
	    var num2 = edateMb1.length; // 근로계약만료임박 인원 수
	    
	    // num1 값을 <h4> 태그 내에 넣어줍니다.
	    edNum2.text(num2);
	}
    $.ajax({
        url: '/personnel/edate2',
        type: 'GET',
        dataType: 'json',
        success: function(edateMb2) {
            // 서버에서 받은 데이터를 화면에 표시합니다.
            console.log("데이터 들어왔느냐~??",edateMb2)
            edateMemNum2(edateMb2);
        },
        error: function (xhr, status, error) {
        console.log("code: " + xhr.status)
        console.log("message: " + xhr.responseText)
        console.log("error: " + error);
    }
    });
	// 수습중인 인원요청
	function edateMemNum2(edateMb2) {
	    var edNum3 = $('#ednum3');
	    edNum3.empty(); // 기존 데이터를 지웁니다.
	    
	    var num3 = edateMb2.length; // 근로계약만료임박 인원 수
	    
	    // num1 값을 <h4> 태그 내에 넣어줍니다.
	    edNum3.text(num3);
	}
	$('.clickable-row').on('click', function () {
        // 클릭한 a 태그의 href 속성 값으로 이동
        window.location.href = $(this).find('a').attr('href');
    });
	
	
   
    
});

</script>
<script>
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';
	document.getElementById("downloadButton").addEventListener("click", function() {
	    // 사용자에게 다운로드를 시작할 것인지 묻는 메시지 표시
	    if (confirm("전체 데이터를 다운로드하시겠습니까?")) {
	        // 사용자가 동의한 경우 서버로 요청을 보내 파일 다운로드 시작
	        var xhr = new XMLHttpRequest();
	        xhr.open("POST", "/personnel/downloadExcel", true);
			xhr.setRequestHeader(header,token);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	            	console.log(xhr.responseText);
	                //요청이 완료되면 다운로드 링크를 생성하고 클릭
	                var downloadLink = document.createElement("a");
//	                downloadLink.href = "data:application/octet-stream;base64," + xhr.responseText;
	                downloadLink.href = xhr.responseText;
	                downloadLink.download = "전체사원.xlsx";
	                //downloadLink.style.display = "none";
	                //document.body.appendChild(downloadLink);
	                downloadLink.click();
	                //document.body.removeChild(downloadLink);
	                
	            }
	        };
	        xhr.send();
	    }
	});
</script>
<!-- 간략버튼 클릭시 함수 -->
<script>

/* function toggleBriefView() {
    var elementsToHide = document.querySelectorAll("."); // 숨길 열에 해당하는 클래스를 선택
    var button = document.getElementById("toggleButton"); // 버튼 엘리먼트 가져오기
    for (var i = 0; i < elementsToHide.length; i++) {
        elementsToHide[i].classList.toggle("hidden"); // 열을 숨김 또는 표시하는 클래스를 토글
    }

    if (button.textContent === "간략보기") {
        // 현재 텍스트가 "간략보기"일 때
        button.textContent = "상세보기"; // 텍스트를 "상세보기"로 변경
        // 추가로 여기에서 상세 내용을 표시하거나 다른 작업을 수행할 수 있습니다.
    } else {
        // 현재 텍스트가 "상세보기"일 때
        button.textContent = "간략보기"; // 텍스트를 "간략보기"로 변경
        // 추가로 여기에서 간략 내용을 숨기거나 다른 작업을 수행할 수 있습니다.
    }
    
    
} */
</script>

 
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 모든 clickable-row 클래스를 가진 행 요소를 찾아서 이벤트를 연결합니다.
    const rows = document.querySelectorAll(".clickable-row");

    rows.forEach((row) => {
        row.addEventListener("click", function () {
            // 클릭 시 실행할 작업을 추가하세요.
            // 예를 들어, 클릭 시 해당 행의 상세 정보를 표시하거나 페이지로 이동하는 등의 작업이 가능합니다.
        });

        // 호버 이벤트를 처리하여 클릭 아이콘을 보이게 합니다.
        row.addEventListener("mouseover", function () {
            row.classList.add("hovered"); // 호버 스타일 클래스 추가
        });

        row.addEventListener("mouseout", function () {
            row.classList.remove("hovered"); // 호버 스타일 클래스 제거
        });
    });
});

$(function () {
    // 클릭 가능한 row에 대한 이벤트 핸들러 추가
    $('.clickable-row').on('click', function () {
        // 클릭한 a 태그의 href 속성 값으로 이동
        window.location.href = $(this).find('a').attr('href');
    });
});



</script>
<script>

$(function () {
	$("#example1").DataTable({
	"responsive": true, "lengthChange": false, "autoWidth": false,
	"buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
	}).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
	
	$("#example2").DataTable({
	"responsive": true, "lengthChange": false, "autoWidth": false,
	"buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
	}).buttons().container().appendTo('#example2_wrapper .col-md-6:eq(0)');
});
</script>

<!-- 엑셀 사원리스트 추가하기 함수 -->
<script>
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
// 				alert("사원리스트가 추가되었습니다!");
				  Swal.fire({
		              title: "사원리스트가 추가되었습니다!",
		                text: "",
		                icon: "success",
		                confirmButtonText: "확인"
		            }).then(function() {

		            });
			    // 페이지 새로고침
				window.location.href = '/personnel/emp';
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status);
                console.log("message: " + xhr.responseText);
                console.log("error: " + error);
//                 alert("오류! 정보형식을 맞춰주세요!");
				  Swal.fire({
		              title: "사원리스트 정보형식을 맞춰주세요!",
		                text: "",
		                icon: "error",
		                confirmButtonText: "확인"
		            }).then(function() {

		            });
            }
        });
    } else {
        console.log("파일을 선택해주세요.");
    }
});
</script>

<script>
    // 버튼 클릭 시 파일 입력 필드 클릭 이벤트 핸들러 추가
    $("#fileUploadButton").on("click", function() {
        $("#excelFile").click();
    });
</script>


</html>
