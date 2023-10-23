<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important;
}
.vacationList{
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

.hr-sect {
   display: flex;
   flex-basis: 100%;
   align-items: center;
   color: rgba(0, 0, 0, 0.35);
   font-size: 12px;
   margin: 8px 0px;
}

.hr-sect::before, .hr-sect::after {
   content: "";
   flex-grow: 1;
   background: rgba(0, 0, 0, 0.35);
   height: 1px;
   font-size: 0px;
   line-height: 0px;
   margin: 0px 16px;
}

.card-body tr {
    text-align: center;
}
/* 휴가신청 */
/* .card-body{ */
/*     height: 1000px; */
/* } */

#contaner{
   width: 90%;
}

#resultFild{
   margin-top: 20px;
}
#wetreeJsContaner{
	overflow:auto;
    display: none; 
    width: 100%; 
    height: 100%; 
    background-color: rgba(240, 240, 240, 0.9); 
     position: fixed;  
    z-index: 7000;  
    padding-left: 350px;   
    padding-top: 140px;
    
}
#wetreeJs{
   margin: 50px auto;
   width: 60%;
   height: 70%;
}
/* 휴가신청 */
</style>
</head>
<body>
	<div style="display: flex;">
		<div>
			<h1 style="margin-left:25px;">
				<font style="vertical-align: inherit;"><a href="/vct/main">내 휴가&nbsp;</a></font>
			</h1>
		</div>
		<div>
		      <c:set var="oneBreak" value="false" />
                 <c:forEach items="${authentication.authorities}" var="authority">
                     <c:forEach var="authMenu" items="${authMenuList}" varStatus="start">
                         <c:if test="${authority.authority == authMenu.authrtId && authMenu.menuReadCd == 'Y' && authMenu.menuNo == 51 && oneBreak eq false}">
							<h1 style="margin-left:25px;">
								<font style="vertical-align: inherit;"><a class="gray-link" href="/advct/vacbk">구성원 휴가&nbsp;&nbsp;&nbsp;&nbsp;</a></font>
							</h1>
                             <c:set var="oneBreak" value="true" />
                         </c:if>
                     </c:forEach>
                 </c:forEach>
		</div>
	</div>
   
   <hr>
	    <h4 style="margin-left:25px;">
		    <font style="vertical-align: inherit;"><a href="/vct/main">휴가&nbsp;&nbsp;</a></font>
		    <font style="vertical-align: inherit;"><a href="/vct/Annual" class="gray-link">&nbsp;&nbsp;&nbsp;연차&nbsp;&nbsp;</a></font>
		    <font style="vertical-align: inherit;"><a href="/vct/bkApply" class="gray-link">&nbsp;&nbsp;&nbsp;휴직/복직</a></font>
		</h4>
   <hr>
   <div class="col-12">
      <div class="row align-items-center my-3">
         <div class="col">
            <h2 class="card-title">
               <font style="vertical-align: inherit;"><font
                  style="vertical-align: inherit;">휴가 종류</font></font>
            </h2>
         </div>
      </div>
      <!-- 바디  시작 -->
         <div class="accordion w-100" id="accordion1">
            <div id="collapse1" class="collapse" aria-labelledby="heading1"
               data-parent="#accordion1">
               <div class="row">
                  <c:forEach var="vac" items="${vaclist}" varStatus="status">
                     <div class="col-md-3">
                        <div class="card shadow mb-4">
                           <div class="card-body text-center">
                              <div class="avatar avatar-lg mt-4">
                                 <button type="button" class="btn btn-primary" 
                                    data-toggle="modal" data-target=".modal-right"
                                    style="background-color: transparent; border: none; box-shadow: none;">
                                    <img
                                    src="${vac.imgRoot}"
                                    alt="휴가" title="휴가" width="64" height="64"/>
                                 </button>
                              </div>
                           <div class="card-text my-2" >
                              <input type="hidden" class="getNo" name="getNo" value="${vac.vacTypeNo}">
                                 <strong class="card-title my-0"><font
                                    style="vertical-align: inherit; "><font
                                       style="vertical-align: inherit;">${vac.vacTypeName}</font></font></strong>
                                     <font style="vertical-align: inherit; display: none;">${vac.vhInfo}</font>
                                 <c:choose>
                                    <c:when test="${vac.vacTypeName !='연차'}">
                                       <p class="small text-muted mb-0">
                                          <font style="vertical-align: inherit;">${vac.vacTypeUseDate}일 사용가능</font>
                                       </p>
                                    </c:when>
                                    <c:when test="${vac.vacTypeName =='연차'}">
                                       <p id="totalDays" class="small text-muted mb-0 totalDays">
                                          <font style="vertical-align: inherit;">13일 사용가능</font>
<%--                                           <font style="vertical-align: inherit;">${vac.totalDays}일 사용가능</font> --%>
                                       </p>
                                    </c:when>
                                 </c:choose>
                              </div>
                           </div>
                           <div class="card-footer">
                              <div class="row align-items-center justify-content-between">
                                 <div class="col-auto">
                                    <small> <span class="dot dot-lg bg-success mr-1"></span><font
                                       style="vertical-align: inherit;">${vac.vacTypeExp}</font></small>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </c:forEach>
               </div>
            </div>
         </div>
                           <!-- Slide Modal -->
   <div id="modalType" class="modal fade modal-right modal-slide" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="defaultModalLabel">휴가 신청</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body"style="margin-left:2%;">
                    <div style="margin-bottom:-1%">
                        <p class="mb-2">
                            <strong><font style="vertical-align: inherit;">
                                <img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
                                <font style="vertical-align: inherit;">휴가 정보</font>
                            </font></strong>
                        </p>
                        <div class="card" style="margin: 1%; width: 600px; height: 90px; pointer-events: none;">
                            <div class="card-body" style="display: flex; align-items: center;">
                                <h5 id="modalUpdateName" style="display:flex;"></h5>
                                <div id="VacTypeUseDate" class="badge badge-pill badge-success VacTypeUseDate" style="color:white;">
                                    <span class="badge badge-pill badge-success"></span>
                                </div>
                            </div>
                            <div class="card-body" style="margin-top:-4%;">
                                <p id="vacationInfo"></p>
                                <p id="vacTypeNo" style="display:none;"></p>
                            </div>
                        </div>
                        <br>
                    </div>
                    <div>
                        <div class="">
                            <p class="mb-2">
                                <strong><font style="vertical-align: inherit;">
                                    <img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
                                    <font style="vertical-align: inherit;">휴가 일정</font>
                                </font></strong>
                            </p>
                        </div>
                        <form>
                            <sec:csrfInput />
                            <div id="cardBody1"class="card-body" style="margin:-2%;">
                                <input type="hidden" name="dftNo" value="${vac.dftNo}">
                                <div>
                                    <strong>휴가 신청 기간</strong><br>
                                    <input id="vaapDays" name="vaapDays" class="btn mb-2 btn-outline-success vaapDays" role="alert" style="width:600px;" value="사용한 휴가 일수" readonly/>
                                </div>
                                &nbsp;
                                <div style="margin-top:-3%">
                                    <strong>휴가 시작일</strong>
                                    <input class="form-control start-date start-date" id="start-date" type="date" name="sDate1" style="width:600px;"/>
                                </div>
                                &nbsp;
                                <div style="margin-top:-3%">
                                    <strong>휴가 종료일</strong>
                                    <input class="form-control end-date end-date" id="end-date" type="date" name="eDate1" style="width:600px;"/>
                                </div>
                                &nbsp;
                                <div id="halfTime" class="halfTime1" style="margin-top:-1%">
                                    <select class="form-control" id="example-select" name="vacType" style="width:600px; ">
                                        <option disabled selected hidden>당일 휴가의 유형을 선택하세요</option>
                                        <option value="오전 반차(4시간)">오전 반차(4시간)</option>
                                        <option value="오후 반차(4시간)">오후 반차(4시간)</option>
                                        <option value="하루 종일(8시간)">하루 종일(8시간)</option>
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="example-textarea1"><font style="vertical-align: inherit;"></font></label>
                                    <textarea class="form-control rsn" id="example-textarea" rows="10" style="width: 600px; height: 108px;" placeholder="휴가신청 사유 작성" name="rsn"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                
                <div class="row">
                        <!-- 휴가 정보 및 휴가 일정 내용 추가 -->
                    <div class="col-8">
                    </div>
                    <div class="col-4">
                        <div class="float-right" style="margin:10%; margin-top:-3px;width:600px; height:100px;">
                           <p class="mb-2">
                                <strong><font style="vertical-align: inherit;">
                                    <img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
                                    <font style="vertical-align: inherit;">승인 참조</font>
                                </font></strong>
                            </p>
                            <hr />
                            <div id="resultApprovePlus" style="height:30px;">
                                <p class="PlusBtnContaner"><label class="h5" for="chamjo">1단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>
                            </div>
                            <button id="approveLevelBtn" type="button" class="btn mb-2 btn-secondary btn-block">+ 단계 추가하기</button>
                        </div>
                    </div>
                </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="autoButton"class="btn mb-2 btn-outline-success">자동완성</button>
                    <button type="button" class="btn mb-2 btn-outline-dark" data-dismiss="modal">취소</button>
                    <button type="button" id="insert" name="insert" class="btn mb-2 btn-outline-info insert">저장하기</button>
               <button type="button" id="Approval1"name="approval1" class="btn mb-2 btn-outline-primary Approval1">결재요청</button>
                </div>
            </div>
        </div>
    </div>
                     
         <div>
            <div class="hr-sect">
               <div class="btn btn-outline-secondary" id="heading1">
                  <a role="button" href="#collapse1" data-toggle="collapse"
                     data-target="#collapse1" aria-expanded="false"
                     aria-controls="collapse1"> <strong><font
                        style="vertical-align: inherit;"><font
                           style="vertical-align: inherit;">신규 신청</font></font></strong>
                  </a>
               </div>
            </div>
         </div>
      </div>
      
   <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->   
   <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->   
   <!-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
            
         <div class="card-body vacationList">
             <h2 class="card-title">
                 <font style="vertical-align: inherit;"><font style="vertical-align: inherit;">신청 내역</font></font>
             </h2>
             <table class="table table-hover" id="vacationTable">
                 <thead>
                     <tr>
                         <th><strong><font style="vertical-align: inherit; color:black;">휴가명</font></strong></th>
                         <th><strong><font style="vertical-align: inherit; color:black;">날짜</font></strong></th>
                         <th><strong><font style="vertical-align: inherit; color:black;">기간</font></strong></th>
                         <th><strong><font style="vertical-align: inherit; color:black;">상태</font></strong></th>
                     </tr>
                 </thead>
                 <tbody>
            <c:forEach var="VacApplyVO" items="${applyList}" varStatus="status">
                <tr id="selectOne"class="selectOne" data-toggle="modal" data-target="#verticalModal">
                    <input type = hidden name="vaapCode" id="vaapCode" class="vaapCode" value="${VacApplyVO.vaapCode}"/>
                    <input type = hidden id="totaldays2"name="totaldays2" value="${VacApplyVO.totaldays2}"/>
                    <td><font style="vertical-align: inherit;">${VacApplyVO.vacTypeName}</font></td>
                    <td><font style="vertical-align: inherit;">${VacApplyVO.vaapStart}~${VacApplyVO.vaapEnd}</font></td>
                    <td><font style="vertical-align: inherit;">${VacApplyVO.vaapDays}일</font></td>
<%--                    <td><span class="badge badge-pill badge-info" style="color: white;">${VacApplyVO.vaapApstCode}</span></td> --%>
					    <c:choose>
					        <c:when test="${VacApplyVO.vaapApstCode eq '결재대기'}">
					        	<td>
					            	<span class="badge badge-pill badge-info" style="color: white;">${VacApplyVO.vaapApstCode}</span>
					            </td>
					        </c:when>
					        <c:when test="${VacApplyVO.vaapApstCode eq '결재완료'}">
					        	<td>
					           		<span class="badge badge-pill badge-success" style="color: white;">${VacApplyVO.vaapApstCode}</span>
					            </td>
					        </c:when>
					        <c:when test="${VacApplyVO.vaapApstCode eq '반려'}">
					        	<td>
					            	<span class="badge badge-pill badge-danger" style="color: white;">${VacApplyVO.vaapApstCode}</span>
					            </td>
					        </c:when>
					        <c:when test="${VacApplyVO.vaapApstCode eq '결재요망'}">
					       		 <td>
					            	<span class="badge badge-pill badge-info" style="color: white;">${VacApplyVO.vaapApstCode}</span>
					            </td>
					        </c:when>
					    </c:choose>
                </tr>
            </c:forEach>
                 </tbody>
             </table>
         </div>
      
      <div class="card-body">
         <!-- Modal -->
                         <div class="modal fade" id="verticalModal" tabindex="-1" role="dialog" aria-labelledby="verticalModalTitle" aria-hidden="true" style="display: none;">
                           <div class="modal-dialog modal-dialog-centered" role="document">
                           <div class="modal-dialog modal-lg" role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="defaultModalLabel">휴가 신청</h5>
                                 <button type="button" class="close" data-dismiss="modal"
                                    aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                 </button>
                              </div>
                              <div class="modal-body">
                               <div class="row">
                                  <div class="col-8">
                                 <p class="mb-2">
                                    <strong><font style="vertical-align: inherit;">
                                          <img
                                          src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
                                          data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
                                          alt="느낌표 " title="느낌표 " width="20" height="20"
                                          class="lzy lazyload--done"
                                          srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
                                          <font style="vertical-align: inherit;">휴가 정보</font>
                                    </font></strong>
                                 </p>
                                 
                                 <div class="card"
                                    style="margin: 3%; width: 92%; height: 80px; pointer-events: none;">
                                    <div class="card-body" style="display: flex; align-items: center;">
                                        <h5 class="vacTypeName" style= "display:flex;"></h5>&nbsp;
                                        <div id="VacTypeUseDate2" class="VacTypeUseDate2" style="color:white;">
                                           <span class="badge badge-pill badge-success"></span>
                                       </div>
	                                        <div id="updateVaapApstCode" class="badge badge-pill badge-dark updateVaapApstCode" style="color:white; margin-top:-3%;">
	                                       </div>
                                    </div>
   
                                    <div class="card-body">
                                         <p class="vacationInfo"></p>
                                    </div>
                                 </div>
                              <div>
                              <div class="">
                                 <p class="mb-2">
                                    <strong><font style="vertical-align: inherit;">
                                          <img
                                          src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
                                          data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
                                          alt="느낌표 " title="느낌표 " width="20" height="20"
                                          class="lzy lazyload--done"
                                          srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
                                          <font style="vertical-align: inherit;">휴가 일정</font>
                                    </font></strong>
                                 </p>
                              </div>
                                    <div id="cardBody1"class="card-body">
                                    <div>
                                       <strong>휴가 신청 기간</strong>
                                       <input id= "vaapDays2" name="vacUseDate" class="btn mb-2 btn-outline-success vaapDays2" role="alert" style="width:100%; " readonly/>
                                    </div>
                                    <div>
                                       <strong>휴가 시작일</strong>
                                       <input class="form-control sDate" id="sDate" type="date" name="startDate" readonly/>
                                    </div>
                                    <div>
                                       <strong>휴가 종료일</strong>
                                       <input class="form-control eDate" id="eDate" type="date" name="endDate" readonly/>
                                    </div>
                                    &nbsp;
                                    
                                    <div id="halfTime2">
                                     <strong>당일 휴가의 유형을 선택해주세요:</strong>
                                       <select class="form-control vacHalfType" id="vacHalfType" name="vacType" readonly >
                                          <option disabled selected hidden>당일 휴가의 유형을 선택하세요</option>
                                           <option value="오전 반차(4시간)">오전 반차(4시간)</option>
                                           <option value="오후 반차(4시간)">오후 반차(4시간)</option>
                                           <option value="하루 종일(8시간)">하루 종일(8시간)</option>
                                       </select>
                                    </div>
                                    
                                    <div class="form-group mb-3">
                                    <strong>사유</strong>
                                       <textarea class="form-control1 rsn2" id="example-textarea"
                                       rows="10" style="width: 100%; height: 80px;"
                                       placeholder="휴가신청 사유 작성" name="rsn" readonly></textarea>
                                    </div>
                                    <div id= "returnRsn"class="form-group mb-3" readonly>
<!-- 	                                   <strong style="color:red;">반려 사유</strong> -->
<!-- 	                                       <textarea class="form-control1 rsn3" id="example-textarea" -->
<!-- 	                                       rows="10" style="width: 100%; height: 40px;" -->
<!-- 	                                        name="rsn" readonly></textarea> -->
                                    </div>
                                 </div>
                              </div>
                              <div class="modal-footer">
<!--                                  <button type="button" id="delete" class="btn mb-2 btn-outline-danger" data-dismiss="modal" >취소하기</button> -->
<!--                                  <button type="button" id="update" name="upDate" class="btn mb-2 btn-outline-warning">수정하기</button> -->
<!--                                  <button type="button" id="save" name="save" class="btn mb-2 btn-outline-info insert">저장하기</button> -->
<!--                                 	  <button type="button" id="Approval2" name="approval" class="btn mb-2 btn-outline-primary Approval2">결재요청</button> -->
									  <button type="button" class="btn mb-2 btn-outline-info insert"  data-dismiss="modal">확인</button>
                                </div>
                             </div>
                            <div class="col-4 float-right"  style="width:2000px;">
                            	<div id="apList" style="display: flex; justify-content: space-between; margin-bottom: 80%;"></div>
<!--                                    <p class="h4">승인참조</p> -->
<!--                                    <hr/> -->
<!--                                  <div id="resultApprovePlus1"> -->
<!--                                     <p class="PlusBtnContaner1"><label class="h5" for="chamjo">1단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p> -->
<!--                                  </div> -->
<!--                                  <button id="approveLevelBtn1" type="button" class="btn mb-2 btn-secondary btn-block">+ 단계 추가하기</button> -->
                           				
<!--                                 </div> -->
                             </div>
                           </div>
                        </div>
                           </div>
                         </div>
                       </div>
                       </div>
   <!-- modal modal modal modal modal===================================================== -->

   <script type="text/javascript">
	//휴가 자동완성기능
   $('#autoButton').on("click", function () {
	    $(".start-date").val("2023-10-20");
	    $(".end-date").val("2023-10-20");
	    $(".halfTime1").find("option:contains('하루 종일(8시간)')").prop("selected", true);
	    $(".vaapDays").val(1);
	    $(".rsn").val("과도한 업무로 인한 휴식");
	});
   
   $('#heading1').click(function() {
       $('#collapse1').collapse('toggle');
   });
   
   $(document).ready(function () {
       // update 버튼 클릭 시 처리
       $("#update").on("click", function () {
           // readonly 속성 해제
           $('#verticalModal textarea[name=rsn]').prop('readonly', false);
           $('#sDate').prop('readonly', false);
           $('#eDate').prop('readonly', false);
           $('#vacHalfType').prop('disabled', false);

           // 모달에서 휴가 날짜에 따른 vactype show hide
           $("#sDate, #eDate").on("change", function () {
               checkStartDateEndDate();
           });

           function checkStartDateEndDate() {
               let startDate = $("#sDate").val();
               let endDate = $("#eDate").val();
               let halfTime = $("#halfTime2");
               let vaapDaysElement = document.getElementById("vaapDays2");

               if (startDate && endDate) {
                   let sDate = new Date(startDate);
                   let eDate = new Date(endDate);
                   let timediff = Math.abs(eDate - sDate);
                   let vaapDays = Math.ceil(timediff / (1000 * 3600 * 24)) + 1;

                   vaapDaysElement.value = vaapDays; 
                   console.log("내가 찾고 싶은 vaapDays", vaapDays);
               } else {
                   vaapDaysElement.val(""); 
               }

               // 반차 card 숨기기 보이기
               if (startDate === endDate) {
                   halfTime.show();
               } else {
                   halfTime.hide();   
               }

               // 달력 이벤트 주기
               if (new Date(startDate) > new Date(endDate)) {
                   Swal.fire("휴가 날짜를 다시 입력하세요.");
                   $("#eDate").val("");
                   vaapDaysElement.value = "";
               } else {
                   $("#eDate").prop("disabled", false);
               }
           }
       });
      $(".vacHalfType").on("change", function(){
          let selectOption = $(this).val();
          let selectOption2 = $(this).val();
          let vaapDaysElement = $(".vaapDays2");

          if(selectOption == "오전 반차(4시간)"){
             vaapDaysElement.val("오전 반차(4시간)(0.5)"); 
          }else if(selectOption2 == "오후 반차(4시간)"){
              vaapDaysElement.val("오후 반차(4시간)(0.5)"); 
          } else if(selectOption == "하루 종일(8시간)"){
              vaapDaysElement.val("하루 종일(8시간)(1)"); 
          } else {
              vaapDaysElement.val(""); 
          }
      });
   });
          
    const typeName = $(".vacTypeName"); 
    const vacationInfo = $(".vacationInfo");
    const vacStart = $(".sDate"); 
    const vacEnd = $(".eDate"); 
    const vaapDay = $("input[name=vacUseDate]");
    const vaapApstCode = $("#updateVaapApstCode");
    const vaapRsn = $(".rsn2"); 
    const vaapType = $(".vacHalfType");
    const vacTypeUseDate2 = $("#VacTypeUseDate2"); 
    console.log("vacTypeUseDate2이다",vacTypeUseDate2);
    
    
    
//내역별 조회
$(".selectOne").on("click", function () {
      let vaapCode = $(this).find('input[name=vaapCode]').val();
      
      console.log("확인 : " + vaapCode);
		
      //상태별 조회
  	  const $apList = $("#apList");
      const $returnRsn = $("#returnRsn");
      
      $.ajax({
		   type:"get",
		   url:"/vct/selectApbox",
		   contentType: "application/json; charset:utf-8",
		   data:{
			   "vaapCode":vaapCode
		   },
		   dataType:"json",
		   beforeSend:function(xhr){
               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
            },
            success: function(result) {
            	  console.log("result입니다", result);
            	  
            	  
            	  let tbl = `<div class="table-container"><table border="1"><tbody><tr style="background-color: #c0c1c2; padding: 10px; text-align: center">`;

            	  for (var i = 0; i < result.apVO.length; i++) {
            	    tbl += `<th>\${result.apVO[i].ptnCode}</th>`;
            	  }

            	  tbl += `</tr><tr style="height: 50px; text-align: center">`;
					
            	  for (var i = 0; i < result.apVO.length; i++) {
	            	 
	                 if(result.apVO[i].apbPro == '진행중'){
	                     tbl += `<td style="width : 100px;"></td>
	                     `;
	                  }else if(result.apVO[i].apbPro == '승인'){
	                     tbl += `<td style="width : 100px;"><img src="\${result.apVO[i].signImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" style="width:40px; height:40px;"></td>
	                     `;
	                  }else{
	                     tbl += `<td style="width : 100px;"><span class="btn btn-outline-danger" >\${result.apVO[i].apbPro}</span></td>
	                     `;
	                  }
            		  
            	  }
				
            	  tbl += `</tr></tbody></table></div>`;

            	  $apList.html(tbl);
            	  
            	  let tbl1 = ''; // 변수를 초기화

            	  for (var i = 0; i < result.apVO.length; i++) {
            	      if (result.apVO[i].apbPro == '반려') {
            	          tbl1 += `<strong style="color:red;">반려 사유</strong>`;
            	          tbl1 += `<textarea class="form-control1 rsn3" id="example-textarea" rows="10" style="width: 100%; height: 40px;" name="rsn" readonly>\${result.apVO[i].rejRsn}</textarea>`;
            	      }
            	  }
            	  $returnRsn.html(tbl1);
            	  

				
					
            	},
            	
		   error: function(xhr, status, error) {
               console.error("AJAX 오류:", error);             
           }
            	
	   });
      $.ajax({
         type:"get",
         url:"/vct/main/"+vaapCode,
         success:function(rslt){
            console.log("이건 rsltz",rslt);
            
            typeName.text(rslt.vacTypeName);
            vacationInfo.text(rslt.vhInfo);
            vacStart.val(rslt.vaapStart);
            vacEnd.val(rslt.vaapEnd);
            vaapDay.val(rslt.vaapDays);
            vaapApstCode.html(rslt.vaapApstCode);
            vaapRsn.val(rslt.vaapRsn);
            vaapType.val(rslt.vaapType);
//             vacTypeUseDate2.text(rslt.totaldays2+"일 사용가능");
            
            if(rslt.vaapApstCode== 'C0104'){
               vaapApstCode.text("결재 요망");
            }
            if(rslt.vaapApstCode== 'C0101'){
               vaapApstCode.text("결재 대기");
            }
            if(rslt.vaapApstCode== 'C0102'){
               vaapApstCode.text("결재 완료");
            }
            if(rslt.vaapApstCode== 'C0103'){
               vaapApstCode.text("반려");
            }
            

            
            //내역별 수정
            $("#save").on("click",function(){
               
               
               //종료일 - 시작일 = 휴가 신청 일수 
                const vacTypeUseDate2 = parseFloat($("#totalDays").text()); 
               const vaapDays = $('input[name=vacUseDate]').val();
               const vaapRsn =  $('#verticalModal textarea[name=rsn]').val();
               const vaapApstCode = 'C0104';
               const vaapStart = $('#sDate').val();
               const vaapEnd = $('#eDate').val();
               const vaapType = $('.vacHalfType').val();
               
               
               let Data={
                  "vaapCode" : vaapCode,
                  "vaapDays" : vaapDays,
                  "vaapRsn" : vaapRsn,
                  "vaapApstCode" : vaapApstCode,
                  "vaapStart" : vaapStart,
                  "vaapEnd" : vaapEnd,
                  "vaapType" : vaapType
               }
               
                  console.log("이데이터는 update할 Data",Data);
                  console.log("이데이터는vaapApstCode",vaapApstCode);
               
                   if (!vaapStart || !vaapEnd || !vaapRsn) {
                       Swal.fire("빈 칸 없이 모두 작성하세요.");
                   } else if (vaapStart === vaapEnd && !vaapType && !vaapRsn) {
                       Swal.fire("시작일과 종료일이 같은 경우 휴가 유형도 선택해야 합니다.");
                   } else if (!vaapRsn && vaapStart === vaapEnd && vaapType) {
                       Swal.fire("휴가 사유를 작성하세요.");
                   } else if (vacTypeUseDate2 < vaapDays) {
                       Swal.fire("보유하고 있는 휴가가 부족합니다. 날짜를 다시 선택해 주세요.");
                   } else {
               
                  $.ajax({
                     type: "put",
                     url : "/vct/mainUpdate",
                     data: JSON.stringify(Data),
                     contentType:"application/json;charset=utf-8",
                     dataType : "text",
                     beforeSend:function(xhr){
                        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                     },
                     success: function (rslt) {
                    	 Swal.fire("수정이 완료되었습니다.","","success").then(function() {
                             location.reload();
                         });
                          
                          
                       },
                       error: function(xhr, status, error) {
                            console.error("AJAX 오류:", error);             
                        }
                  });
                }
            })
            
            //결재선 올리기2
            $(".Approval2").on("click",function(){
               
               var today = new Date();

               var year = today.getFullYear();
               var month = ('0' + (today.getMonth() + 1)).slice(-2);
               var day = ('0' + today.getDate()).slice(-2);

               var dateString = year + '-' + month  + '-' + day;

               console.log(dateString);
               
               let vaapDays = $('.vaapDays2').val(); //휴가 신청일수
               let vaapRsn =  $('#example-textarea').val(); //휴가 신청사유
               let vaapApstCode = 'C0101' //휴가 신청결재상태코드 (결재대기중)
               let vaapStart = $('.sDate').val();//휴가 시작일
               let vaapEnd = $('.eDate').val(); //휴가 종료일
               let vaapType = $('.vacHalfType').val(); //당일 휴가 유형 (반차)
               let vacTypeNo = rslt.vacTypeNo; // 휴가 종류 번호
               let vaapDate = dateString;
               
               console.log("이거만찍히면됨:::",vacTypeNo);
                 
               vacationFormVO = {
                     "vaapDays": vaapDays, 
                     "vaapRsn": vaapRsn,
                     "vaapApstCode": vaapApstCode,
                     "vaapStart": vaapStart,
                     "vaapEnd": vaapEnd,
                     "vaapType": vaapType, 
                     "vacTypeNo": vacTypeNo,
                     "vaapDate": vaapDate,
                     "vaapCode": vaapCode
                  }
               console.log("@@@@@@vacationFormVO@@@@",vacationFormVO);
               
               
                let checkEmpNo = $(".checkEmpNo");
                  let serialNumber = 0; 
                  let empNo        ="" ; 
                  
                  let apboxData = []; //ApboxList
                  for(let i=0; i<checkEmpNo.length; i++){
                     serialNumber = i+1;
                     empNo = checkEmpNo[i].value;

                     apboxVO = {
                        "serialNumber":serialNumber,
                        "empNo":empNo
                     }
                     apboxData.push(apboxVO);
                     console.log("@@@여기는 apboxVO@@@",apboxVO);
                  }
                  
                  let totalData=[
                        vacationFormVO,
                        apboxData
                  ];
                  console.log("@@@여기는 apboxData@@@",apboxData);
                  console.log("@@@여기는 totalData@@@",totalData);
                  
               $.ajax({
                  type: "post",
                  url:"/vct/multiInsert",
                  contentType:"application/json; charset:utf-8",
                  data : JSON.stringify(totalData),
                  dataType:"json",
                  beforeSend:function(xhr){
                        xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                     },
                  success: function(){
                     
                      let myName = "${empVO.empNm}";
                              let myMassage = "휴가 신청";
                              let myData = "휴가";
                              
                              messageVO = {
                                 setter:myName,
                                 massage:myMassage,
                                 data:myData
                              };
                     
                              Swal.fire("등록되었습니다.","","success").then(function() {
                                  location.reload();
                              });
                     
                  },
                  error: function(xhr, status, error) {
                         console.error("AJAX 오류:", error);             
                     }
               })
               
            })
            
            
         },
         error: function(xhr, status, error) {
                console.error("AJAX 오류:", error);             
            }
      })
   });
   
   
   //반차 값 지정하기
   $("#example-select").on("change", function(){
    let selectOption = $(this).val();
    console.log("이거는 this", this);
    let vaapDaysElement = $("#vaapDays");

    if (selectOption == "오전 반차(4시간)") {
        vaapDaysElement.val("0.5"); 
    } else if (selectOption == "오후 반차(4시간)") {
        vaapDaysElement.val("0.5"); 
    } else if (selectOption == "하루 종일(8시간)") {
        vaapDaysElement.val("1"); 
    } 
});
   
   

   //모달에서 휴가 날짜에 따른 vactype show hide
   $(document).ready(function() {
          
       $("#start-date, #end-date").on("change", function() {
           checkStartDateEndDate();
       });

       function checkStartDateEndDate() {
           let startDate = $("#start-date").val();
           let endDate = $("#end-date").val();
           let halfTime = $("#halfTime");
           let vaapDaysElement = document.getElementById("vaapDays");
           
           if(startDate&&endDate){
            let sDate = new Date(startDate);
             let eDate = new Date(endDate);
             let timediff = Math.abs(eDate-sDate);
             let vaapDays = Math.ceil(timediff/(1000*3600*24))+1;
             
             vaapDaysElement.value = vaapDays;
             console.log("내가 찾고 싶은 vaapDays",vaapDays);
         }else{
            vaapDaysElement.value
         }
           
           //반차 card 숨기기 보이기
           if (startDate === endDate) {
               halfTime.show();
           } else {
               halfTime.hide();
           }
           //달력 이벤트 주기
           if (new Date(startDate) > new Date(endDate)) {
               Swal.fire("휴가 날짜를 다시 입력하세요.");
                $("#end-date").val("");
                vaapDaysElement.value = "";
            } else {
                $("#end-date").prop("disabled", false);
            }
           
       }
   });   
   
   //VAAP_DAYS 휴가 신청 일수
   //휴가신청(insert)하기 버튼 클릭시
     $("#insert").on("click", function(){
           
      let startDate = $("input[name=sDate1]").val();
      let endDate = $("input[name=eDate1]").val();
      let vacType = $("#example-select").val();
      let rsn = $("#example-textarea").val();
      let vacTypeUseDate = parseFloat($("#VacTypeUseDate").text()); 
      let vaapDays = parseFloat($("#vaapDays").val());
      let vaapApstCode = $("#vaapApstCode").val();
      let dftNo = $("input[name=dftNo]").val();
             
             console.log("vaapApstCode값 확인하기용:"+eDate);
             
      //종료일 - 시작일 = 휴가 신청 일수 
                if (!startDate || !endDate || !rsn) {
                    Swal.fire("빈 칸 없이 모두 작성하세요.");
                } else if (startDate === endDate && !vacType && !rsn) {
                    Swal.fire("시작일과 종료일이 같은 경우 휴가 유형도 선택해야 합니다.");
                } else if (!rsn && startDate === endDate && vacType) {
                    Swal.fire("휴가 사유를 작성하세요.");
                } else if (vacTypeUseDate < vaapDays) {
                    Swal.fire("보유하고 있는 휴가가 부족합니다. 날짜를 다시 선택해 주세요.");
                } else {
   
              //ajax로 값 넘기기
                 let formData = new FormData(document.forms[0]);
                    console.log("체크:", formData);
                 
               
                    formData.set("vaapDays",vaapDays);
                    
                     console.log("vaapDays체크:",vaapDays)
              
                  let data = {
                     "vaapStart": startDate,
                     "vaapEnd": endDate,
                     "vaapType": vacType,
                     "vaapRsn": rsn,
                     "vaapDays":vaapDays,
                     "vacTypeNo":$("#vacTypeNo").text(),
                     "vacTypeUseDate" : vacTypeUseDate+"일 사용가능",
                     "vaapApstCode":vaapApstCode,
                     "dftNo" : dftNo
                 };
                 console.log("나와라",JSON.stringify(data));
                 //contentType : 보내는타입(c->s)
                 //dataType : 응답타입(s->c)
                 $.ajax({
                     type: "POST",
                     url: "/vct/mainInsert",
                  contentType: "application/json;charset=UTF-8",
                     data: JSON.stringify(data),   
                  dataType:"text",
                     beforeSend:function(xhr){
                     xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                  },
                     success: function(response) {
                    	 Swal.fire("등록되었습니다.","","success").then(function() {
                             location.reload();
                         });
                     },
                     error: function(xhr, status, error) {
                         console.error("AJAX 오류:", error); 
                     }
                 });
                 
                 
             }
      
       });
      
   //모달 눌렀을때 해당 휴가 종류가 모달 휴가 정보에 뜸
   $(document).on("click", ".card", function() {
      
       let vaapCode = $(this).find('input[name=vaapCode]').val();
         console.log("this : " + this);
         console.log("확인 : " + vaapCode);

         var today = new Date();

         var year = today.getFullYear();
         var month = ('0' + (today.getMonth() + 1)).slice(-2);
         var day = ('0' + today.getDate()).slice(-2);

         var dateString = year + '-' + month + '-' + day;

         console.log(dateString);
      
       let typeName = $(this).find(".card-title").text();
       let typeInfo = $(this).find(".card-title").next().text();
       let getNo = $(this).find('input[name=getNo]').val();
       let VacTypeUseDate = $(this).find(".card-text").find("p").text();
   
       console.log("휴가 종류: " + typeName);
       console.log("휴가 정보: " + typeInfo);
       console.log("해당 번호: " + getNo);
       console.log("사용 가능 일수: " + VacTypeUseDate);
   
       $("#modalUpdateName").text(typeName);
       $("#vacationInfo").text(typeInfo);
       $("#vacTypeNo").text(getNo);
       $("#VacTypeUseDate").text(VacTypeUseDate);

    // 결재선 올리기1
    $("#Approval1").on("click", function() {
       event.preventDefault();
       
        let vaapDays = $('.vaapDays').val(); //휴가 신청일수
        let vaapRsn = $('.rsn').val(); //휴가 신청사유
        let vaapApstCode = 'C0101' //휴가 신청결재상태코드 (결재대기중)
        let vaapStart = $('.start-date').val(); //휴가 시작일
        let vaapEnd = $('.end-date').val(); //휴가 종료일
        let vaapType = $('#example-select').val(); //당일 휴가 유형 (반차)
        let vacTypeNo = getNo; // 휴가 종류 번호
        let vaapDate = dateString;
        let vaapCode =$('.vaapCode').val();

        console.log("vacType이야:", vaapType);
       
        vacationFormVO = {
                "vaapDays": vaapDays,
                "vaapRsn": vaapRsn,
                "vaapApstCode": vaapApstCode,
                "vaapStart": vaapStart,
                "vaapEnd": vaapEnd,
                "vaapType": vaapType,
                "vacTypeNo": vacTypeNo,
                "vaapDate": vaapDate,
                "vaapCode": vaapCode
            }
            console.log("@@@@@@vacationFormVO@@@@", vacationFormVO);


            let checkEmpNo = $(".checkEmpNo");
            let serialNumber = 0;
            let empNo = "";
            let apboxData = []; //ApboxList
            for (let i = 0; i < checkEmpNo.length; i++) {
                serialNumber = i + 1;
                empNo = checkEmpNo[i].value;

                apboxVO = {
                    "serialNumber": serialNumber,
                    "empNo": empNo
                }
                apboxData.push(apboxVO);
                console.log("@@@여기는 apboxVO@@@", apboxVO);
            }

            let totalData = [
                vacationFormVO,
                apboxData
            ];
            console.log("@@@여기는 apboxData@@@", apboxData);
            console.log("@@@여기는 totalData@@@", totalData);

            $.ajax({
                type: "post",
                url: "/vct/multiInsert",
                contentType: "application/json; charset:utf-8",
                data: JSON.stringify(totalData),
                dataType: "json",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(rslt) {
                    console.log("결재선1의 rslt", rslt);
                    
                    let myName = "${empVO.empNm}";
                    let myMassage = "휴가 신청";
                    let myData = "휴가";
                    
                    messageVO = {
                       setter:myName,
                       massage:myMassage,
                       data:myData
                    };
                    webSocket.send(JSON.stringify(messageVO));
                    
                    Swal.fire("등록되었습니다.","","success").then(function() {
                        location.reload();
                    });
                   
                }
            });
       
       
    });

});
      
      
   //휴가창
   //승인참조 사람(단계 추가하기) 추가
   $("#approveLevelBtn").on("click",function(){
      var resultApprovePlus = document.getElementById('resultApprovePlus');
      var lastChild = resultApprovePlus.lastElementChild;
      var labelText = lastChild.querySelector('label').textContent;

      let result = "";
      switch(labelText){
         case "1단계" : 
            result = `<p class="PlusBtnContaner"><label class="h5" for="chamjo">2단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>`;
            break;
         case "2단계" : 
            result = `<p class="PlusBtnContaner"><label class="h5" for="chamjo">3단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>`
            break;
         case "3단계" :
            Swal.fire({
            icon: 'error',
            title: '잠깐!!',
            text: '참조대상은 3단계까지만 추가 가능해요!',
            })
            return; 
      }
      $("#resultApprovePlus").append(result);
   });
   $("#approveLevelBtn1").on("click",function(){
      var resultApprovePlus1 = document.getElementById('resultApprovePlus1');
      var lastChild = resultApprovePlus1.lastElementChild;
      var labelText = lastChild.querySelector('label').textContent;

      let result = "";
      switch(labelText){
         case "1단계" : 
            result = `<p class="PlusBtnContaner1"><label class="h5" for="chamjo">2단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>`;
            break;
         case "2단계" : 
            result = `<p class="PlusBtnContaner1"><label class="h5" for="chamjo">3단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>`
            break;
         case "3단계" :
            Swal.fire({
            icon: 'error',
            title: '잠깐!!',
            text: '참조대상은 3단계까지만 추가 가능해요!',
            })
            return; 
      }
      $("#resultApprovePlus1").append(result);
   });
   
   
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
                         let htmlCode = "";
                         console.log("result",result);
                        
                        htmlCode += `<talbe border="1" style="float:right;">
                                  <tr>
                                     <td><input type="hidden"  class = "checkEmpNo" value="\${result.empNo}"></td>
                                     <td><button type="button" class="badge badge-pill badge-info">\${result.empNm}</button></td>
                                     <td><span class="badge badge-pill badge-success"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">\${result.dtCodeNm}</font></font></span></td>
                                  </tr>            
                        `;

                        let myparent = $(thisBtn).parent(); //내가 선택한 버튼의 부모요소 가져오기
                        let mychildrun = myparent.children(".approvePlusBtn")[0]; //자식요소중 삭제할 버튼 찾기
                        
                        myparent.remove(mychildrun); //삭제
                        mychildrun.style.display = "none";//버튼 없애기
                        
                        myparent.append(htmlCode);//추가


                        $('#sujiTree').jstree("destroy");//트리 초기화
                        $("#myModalClose").click();//모달 닫기버튼

                      }
                      })
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
})
   </script>
</body>
</html>