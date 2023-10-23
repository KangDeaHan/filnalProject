<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>


function checkPro(apbProList){
	   let count = 0;
	   
	   if(apbProList){
		   for (var i = 0; i < apbProList.length; i++) {
		      if(apbProList[i].apbPro == "반려"){
		         count = +41;
		      }
		      
		      if(apbProList[i].apbPro == "진행중"){
		         count = +2;
		      }
		      
		      if(apbProList[i].apbPro == "승인"){
		         count = -1;
		      }
		   }
	   }else{
		   count = 999;
	   }
	   
	   return count;
	};


$(function(){
	
	//나의 휴가 리스트
	function myVacationList(){
		console.log("신진수")
		$.ajax({
			url : "/vct/myVacationList",
			dataType : "json",
			type : "get",
			success : function(result){
				console.log("나의 휴가 리스트",result);
				let htmlCole = `
                        <table class="table table-hover" id="vacationTable">
                        <thead>
                            <tr>
                                <th><font style="vertical-align: inherit;">휴 직 명</font></th>
                                <th><font style="vertical-align: inherit;">휴 직 시 작 일</font></th>
                                <th><font style="vertical-align: inherit;">휴 직 종 료 일</font></th>
                                <th><font style="vertical-align: inherit;">증 명 자 료 여 부</font></th>
                                <th><font style="vertical-align: inherit;">승 인 상 태</font></th>
                            </tr>
                            
                        </thead>
                        <tbody>`;

                  		$.each(result, function (index, BkApplyVO) {
               			let checkMyFixPro = checkPro(BkApplyVO.apBoxList);
               			console.log("결재 상태 확인  : " , checkMyFixPro)
               			console.log("결재 상태 fileSetting : ",BkApplyVO.fileSetting)
               			
               			 htmlCole +=`<tr class="selectOne" data-toggle="modal" data-target="#verticalModal">
                                <input type="hidden" name="bkNo" value="\${BkApplyVO.bkNo}" id="jinsu" class="lastbkNo"/>
                                <td><font style="vertical-align: inherit;">
                                       <input type="hidden" class="bkNameSelect" name="bkNameSelect" />\${BkApplyVO.bkName}</font></td>
                                <td><font style="vertical-align: inherit;">\${BkApplyVO.bkSdate}</font></td>
                                <td><font style="vertical-align: inherit;">\${BkApplyVO.bkEdate}</font></td>
                                <td><span class="badge badge-pill badge-danger"><font style="vertical-align: inherit;">\${BkApplyVO.bkCertYn}</font></span></td>`;
	                               
		               			console.log("BkApplyVO2  : " , BkApplyVO)
	               	          if(checkMyFixPro > 20 && checkMyFixPro < 130){
	               	        	  console.log("테스트1");
	               	        	htmlCole +=`<td>
				                             <span class="badge badge-pill badge-danger" style="color: white;">반려</span>
			               	        	  <td>`;
	                          }else if(checkMyFixPro < 0){
	               	        	  console.log("테스트2");
                        	  	htmlCole +=`<td>
				                             <span class="badge badge-pill badge-success" style="color: white;">결재완료</span>
			               	        	  <td>`;
	                          }else if(checkMyFixPro > 130 ){
	               	        	  console.log("테스트3");
                        	    htmlCole +=`<td>
			               	        		 <span class="badge badge-pill badge-warning" style="color: white;">결재요망</span>
			               	        	  <td>`;
	                          }else{
	               	        	  console.log("테스트4");
                        	    htmlCole +=`<td>
				                             <span class="badge badge-pill badge-info" style="color: white;">결재대기</span>
			               	        	  <td>`;
	                          }
                              htmlCole += `</tr>`;
                              if(BkApplyVO.fileSetting != null){
                                  htmlCole += `<input type="hidden" id="fileSetting" name="fileSetting" />\${BkApplyVO.fileSetting}`;
                              }
//                               htmlCole += `
//                                           <input type="hidden" class="bkDftNo" name="bkDftNo" value="\${BkApplyVO.dftNo}" />
//                                           </tbody>
//                                       </table>
//                                   `; 
                            })
                            
                          $("#bkApplyResult").html(htmlCole);
							
			}
		})
	}
	
// 	empList();
	myVacationList();
})

</script>

<style>

th font {
    font-weight: bold; /* 굵게 설정 */
    color: black;      /* 검은색 텍스트 색상 설정 */
    text-align: center; /* 텍스트 가운데 정렬 */
}
.card-body{
  background-color: white; /* 흰색 배경 */
  padding: 20px; /* 카드 안의 내용과의 간격 조절 */
  border-radius: 10px; /* 카드 테두리 둥글게 만듦 */
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}
.gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important;
}

a:visited {
   color: black;
   text-decoration: none;
}

a {
   text-decoration-line: none;
}
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
</style>
</head>
<body>
   <div>
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
          <font style="vertical-align: inherit;"><a href="/vct/main"class="gray-link">휴가&nbsp;&nbsp;</a></font>
          <font style="vertical-align: inherit;"><a href="/vct/Annual"class="gray-link">&nbsp;&nbsp;&nbsp;연차&nbsp;&nbsp;</a></font>
          <font style="vertical-align: inherit;"><a href="/vct/bkApply">&nbsp;&nbsp;&nbsp;휴직/복직</a></font>
      </h4>
      <hr>
   </div>
   <div class="card-body1 row" id="row1" style="margin-bottom:1%;">
    <div class="col-md-6">
        <div class="card-body">
            <!-- Button trigger modal -->
            <h2 class="card-title">
                <font style="vertical-align: inherit;">휴직 신청내역</font>
            </h2>
            <div id="tableContainer" style="display: flex;">
                <div style="flex: 1;" id="bkApplyResult">
		            <!-- ///////////////////////////////////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ////////        결과           ///////// -->
		            <!-- ///////////////////////////////////// -->
		            
                </div>
            </div>
       </div>
    </div>
    <div class="col-md-6">
        <div class="card-body">
            <!-- Button trigger modal -->
            
            <font style="font-size:20px;">
<!--                 <button type="button" id="rsRequest" class="btn mb-2 btn-outline-success float-right" -->
<!--                     data-toggle="modal" data-target="#verticalModal3" -->
<!--                     style="float:right; width:150px; height:50px;">복직 신청하기</button> -->
            </font>
            <h2 class="card-title">
                <font style="vertical-align: inherit;">복직 신청내역</font>
            </h2>
            <div id="tableContainer" style="display: flex;">
                <div style="flex: 1;">
                    <table class="table table-hover" id="vacationTable">
                        <thead>
                            <tr>
                                <th><font style="vertical-align: inherit;">소 속 명</font></th>
                                <th><font style="vertical-align: inherit;">성 명</font></th>
                                <th><font style="vertical-align: inherit;">직 위</font></th>
                                <th><font style="vertical-align: inherit;">복 직 희 망 일</font></th>
                                <th><font style="vertical-align: inherit;">승 인 상 태</font></th>
                            </tr>
                        </thead>
                        <tbody>
                           <c:forEach var="rsReqst" items="${empList}" varStatus="status">
                   <tr class="selectOne2" data-toggle="modal" data-target="#verticalModal3">
                      <input type="hidden" id="rsNo" name="rsNo" value="${rsReqst.rsNo }"/>
                       <td><font style="vertical-align: inherit;">${rsReqst.dnm}</font></td>
                       <td><font style="vertical-align: inherit;">${rsReqst.empNm}</font></td>
                       <td><font style="vertical-align: inherit;">${rsReqst.ptnCode}</font></td>
                       <td><font style="vertical-align: inherit;">${rsReqst.rsDate}</font></td>
<!--                        <td id="" class="rsApstCode"><span class="badge badge-pill badge-warning"> -->
<%--                            <font style="vertical-align: inherit;">${rsReqst.rsApstCode}</font></span></td> --%>
                             <c:choose>
                                <c:when test="${rsReqst.rsApstCode eq '결재대기'}">
                                   <td>
                                       <span class="badge badge-pill badge-info" style="color: white;">${rsReqst.rsApstCode}</span>
                                    </td>
                                </c:when>
                                <c:when test="${rsReqst.rsApstCode eq '결재완료'}">
                                   <td>
                                         <span class="badge badge-pill badge-success" style="color: white;">${rsReqst.rsApstCode}</span>
                                    </td>
                                </c:when>
                                <c:when test="${rsReqst.rsApstCode eq '반려'}">
                                   <td>
                                       <span class="badge badge-pill badge-danger" style="color: white;">${rsReqst.rsApstCode}</span>
                                    </td>
                                </c:when>
                                <c:when test="${rsReqst.rsApstCode eq '결재요망'}">
                                      <td>
                                       <span class="badge badge-pill badge-warning" style="color: white;">${rsReqst.rsApstCode}</span>
                                    </td>
                                </c:when>
                            </c:choose>
                   </tr>
                   <input type="hidden" id="dftNo" class= "rsdftNo"name="rsdftNo" />
               </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
       </div>
    </div> 
</div>
   <div class="card-body1 row" id="row1">
       <div style="display: flex; justify-content: space-between;">
           <div class="col-md-6">
               <div class="card-body" style="height:714px;">
                   <div style="vertical-align: inherit; ">
                       <h2 class="card-title">휴직 신청</h2>
                       <div style="margin-left:63%;">
                           <button type="button" id="autoButton" class="btn mb-2 btn-outline-success">자동 완성</button>
                           <button type="button" id="insertSave" class="btn mb-2 btn-outline-info">저장 하기</button>
                           <button type="button" id="bkApproval" name="insert" class="btn mb-2 btn-outline-primary">결재요청</button>
                       </div>
                 </div>
      <div class="table" style="white-space: nowrap;">
         <table class="table table-bordered">
            <tr>
               <td style="width: 100px;">휴 직 명</td>
               <td style="width: 900px;">
                   <div id="bkNameType"class="form-group col-md-4" style="margin-top:20px;">
                       <select id="inputState5" class="form-control inputState5" style="width:500px;">
                            <option disabled selected hidden>휴직 종류를 선택해주세요</option>
                            <option>육아 휴직</option>
                            <option>질병 휴직</option>
                            <option>병역 휴직</option>
                            <option>가족 돌봄 휴직</option>
                          </select>
                   </div>
               </td>
            </tr>   
	            <tr>
	               <td>성    명</td>
	               <td><input type="text" id="name" name="name" class="form-control" readonly></td>
	            </tr>
	            <tr>
	               <td>직    위</td>
	               <td><input type="text" id="code" class="form-control" name="code" readonly></td>
	            </tr>
	            <tr>
                  <td>휴 직 시 작 일</td>
                  <td><input class="form-control startDate" id="startDate" type="date" name="sDate"></td>
              </tr>
              <tr>
                  <td>휴 직 종 료 일</td>
                  <td><input class="form-control endDate" id="endDate" type="date" name="eDate"></td>
              </tr>
         </table>
         </div>
         
       <div class="row">
    <div class="col-md-6">
        <div class="form-group mb-3">
            <div class="">
                <textarea class="form-control bkRsn" id="example-textarea" rows="9" placeholder="휴직 사유를 입력해주세요"></textarea>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card" style="margin-bottom:30px; height: 200px;">
            <div class="float-right">
                <p class="h5">4. 승인참조</p>
                <hr>
                <div id="resultApprovePlus1">
                    <p class="PlusBtnContaner"><label class="h5" for="chamjo">1단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>
                </div>
                <button id="approveLevelBtn1" type="button" class="btn mb-2 btn-secondary btn-block">+ 단계 추가하기</button>
            </div>
        </div>
    </div>
        <div style="margin-top:-2%; margin-left:2%;">
            <input type="file" name="file" class="myFileupload file" multiple />
        </div>
       
        </div>
   </div>
</div>
      <div class="col-md-6">
      <div class="card-body">
          <div style="vertical-align: inherit;">
              <h2 class="card-title">복직 신청</h2>
              <div style="margin-left: 52%;">
              	   <button type="button" id="autoButton2" class="btn mb-2 btn-outline-success">자동 완성</button>
                   <button type="button" id="modalUpdate" name="upDate" class="btn mb-2 btn-outline-warning">수정하기</button>
                   <button type="button" id="RsSave" name="save" class="btn mb-2 btn-outline-info">저장하기</button>
                   <button type="button" id="Approval2" name="insert" class="btn mb-2 btn-outline-primary">결재요청</button>
              </div>
          </div>
    <div class="row">
        <!-- 좌측 내용 -->
        <div class="col-md-6">
            <div class="card" style="margin-bottom: 20px; height: 250px; white-space: nowrap;">
                <div class="card-body" style="text-align:center;">
                    <h5 class="card-title"style="margin-right:70%;">1. 인적 사항</h5>
                    <table class="table table-bordered table-hover mb-0">
                        <thead>
                            <tr>
                                <th style="width: 25%;">소속</th>
                                <th style="width: 25%;">사번</th>
                                <th style="width: 25%;">성명</th>
                                <th style="width: 25%;">직위</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                              <td id= "dnm" class="dnm"></td>
                              <td id= "empNo1" class="empNo1"></td>
                              <td id= "empNm1" class="empNm1"></td>
                              <td id= "ptnCode" class="ptnCode"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card" style="margin-top:34px; height: 300px;">
                <div class="card-body">
                    <h5 class="card-title">2. 복직 사유</h5>
                    <textarea class="form-control rsResn" id="rsRsn" rows="10" placeholder="복직 사유를 입력해주세요"></textarea>
                </div>
            </div>
        </div>

        <!-- 우측 내용 -->
        <div class="col-md-6">
            <div class="card" style="margin-bottom: 20px; height: 250px;">
                <div class="card-body">
                    <h5 class="card-title">3. 복직 희망 날짜</h5>
                    <div style="display: flex;">
                        <div style="width: 50%;">
                            <input class="form-control rsDateInput" id="rsDateInput" type="date" name="rsDate" value="date">
                        </div>
                    </div>
                </div>
            </div>

            <div class="card" style="margin-top:34px; height: 300px;">
                <div class="float-right">
                    <p class="h5">4. 승인참조</p>
                    <hr>
                    <div id="resultApprovePlus2">
                        <p class="PlusBtnContaner"><label class="h5" for="chamjo">1단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>
                    </div>
                    <button id="approveLevelBtn2" type="button" class="btn mb-2 btn-secondary btn-block">+ 단계 추가하기</button>
                </div>
            </div>
        </div>
    </div>
                </div>
             </div>
             </div>
             </div>
      <!-- 모달모달모달모달모달모달모달모달모달모달모달모달모달모달모달 -->
                      <!-- Modal -->
   <div class="modal fade" id="verticalModal" tabindex="-1" role="dialog" aria-labelledby="verticalModalTitle" style="display: none;" aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered" role="document">
       <div class="modal-content" style="width:120%;  white-space: nowrap;">
         <div class="modal-header">
           <div class="table">
         <table class="table table-bordered">
            <tr>
               <td>휴 직 명</td>
               <td>
                  <div class="form-group col-md-4" style="margin-top:20px;">
                         <select id="inputState2" class="form-control inputState2" style="width: 180px;"disabled>
                          <option selected hidden>휴직 종류 선택</option>
                          <option value="육아 휴직">육아 휴직</option>
                          <option value="질병 휴직">질병 휴직</option>
                          <option value="병역 휴직">병역 휴직</option>
                          <option value="가족 돌봄 휴직">가족 돌봄 휴직</option>
                      </select>
                          </div>
               </td>
            </tr>   
            <tr>
                  <td>휴 직 시 작 일</td>
                  <td><input class="form-control" id="startDate1" type="date" name="sDate1"></td>
              </tr>
              <tr>
                  <td>휴 직 종 료 일</td>
                  <td><input class="form-control" id="endDate1" type="date" name="eDate1"></td>
              </tr>
         </table>
            <div class="form-group mb-3" >
               <div style="width:380px;">
                   <textarea class="form-control bkRsn1" id="rsResn2" rows="8" placeholder="휴직 사유를 입력해주세요"></textarea>
                      <div class="row">
                       <input type="file" id="file" name="file1" class="myFileupload modalFile" style="width: 19%; margin-left:4%;float: left;" />
                       <div id="orfiName" class="orfiName" style="width: 50%; float: left;"></div>
                  </div>
                        
                      <div class="d-none" id="uploadPreviewTemplate">
                        <div class="card mt-1 mb-0 shadow-none border">
                          <div class="p-2">
                            <div class="row align-items-center">
                              <div class="col-auto">
                                <img data-dz-thumbnail="" src="#" class="avatar-sm rounded bg-light" alt="">
                              </div>
                              <div class="col pl-0">
                                <a href="javascript:void(0);" class="text-muted font-weight-bold" data-dz-name=""></a>
                                <p class="mb-0" data-dz-size=""></p>
                              </div>
                              <div class="col-auto">
                                Button
                                <a href="" class="btn btn-link btn-lg text-muted" data-dz-remove="">
                                  <i class="dripicons-cross"></i>
                                </a>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
            </div>
	            	<div id= "returnRsn"class="form-group mb-3" readonly>
			        </div>
             </div>  
               <div class="col-4 float-right" style="width:400px;">
                   <div id="bkapList">
                       </div>
                           <div id=approval>
                                  <p class="h4">승인참조</p>
                                  <hr/>
                                <div id="resultApprovePlus">
                                   <p class="PlusBtnContaner"><label class="h5" for="chamjo">1단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>
                                </div>
                                    <button id="approveLevelBtn" type="button" class="btn mb-2 btn-secondary btn-block">+ 단계 추가하기</button>
                           </div>
                  </div>
                          </div>
                          <div class="modal-footer">
                     <button type="button" id="delete" class="btn mb-2 btn-outline-danger" data-dismiss="modal" >닫기</button>
                     <button type="button" id="update" name="upDate" class="btn mb-2 btn-outline-warning">수정하기</button>
                     <button type="button" id="bkApproval2" name="insert" class="btn mb-2 btn-outline-primary">결재요청</button>
                  </div>
                  </div>
              </div>
           </div>          
                    
   <!-- script 시작 script 시작 script 시작 script 시작 script 시작 script 시작 script 시작-->
   <script>
   
   $('#autoButton').on("click", function () {
	    $(".inputState5").val("육아 휴직");
	    $(".startDate").val("2023-10-23");
	    $(".endDate").val("2024-10-23");
	    $(".bkRsn ").val("육아로 인한 휴직하겠습니다.");
	});
   $('#autoButton2').on("click", function () {
	    $(".rsDateInput").val("2024-10-24");
	    $(".rsResn ").val("휴직기간이 끝나 복직하고 싶습니다.");
	});
   

   let bkNo2;  // 공유하기 위한 전역변수
   //휴직 결재선1
   $("#bkApproval").on("click",function(){
      
      let bkNo = $(this).find("input[name=bkNo]").val();
      console.log("@@@@@@@@@@@bkNo:",bkNo);
      bkNo2 = bkNo;
      
      
         var today = new Date();
         var year = today.getFullYear();
         var month = ('0' + (today.getMonth() + 1)).slice(-2);
         var day = ('0' + today.getDate()).slice(-2);
         var dateString = year + '-' + month + '-' + day;
         console.log(dateString);

        const bkName = $("#inputState5 option:selected").text();
       const bkSdate = $(".startDate").val();
       const bkEdate = $(".endDate").val();
       const bkRsn = $(".bkRsn").val();
       const bkApstCode = 'C0104';
       const bkCertYn = $("input[name=file]").val() != "" ? "B0103" : "B0104";

        console.log("bkNo입니다.:", bkNo2);

      let empNo = $(".empNo1").text();
      let dftNo = $(".bkDftNo").val();
        
         bkApplyVO = {
             "bkName": bkName,
             "bkSdate": bkSdate,
             "bkEdate": bkEdate,
             "bkRsn": bkRsn,
             "empNo": empNo,
             "bkCertYn":bkCertYn,
             "dftNo":dftNo,
             "bkNo":bkNo2
         };
         console.log("#######bkApplyVO#######", bkApplyVO);

         let checkEmpNo = $(".checkEmpNo");
         let apboxData = []; // ApboxList
         for (let i = 0; i < checkEmpNo.length; i++) {
             let serialNumber = i + 1;
             let empNo = checkEmpNo[i].value;

             let apboxVO = {
                 "serialNumber": serialNumber,
                 "empNo": empNo
             };
             apboxData.push(apboxVO);
         console.log("@@@여기는 apboxVO@@@", apboxVO);
         }

         let totalData = [
            bkApplyVO,
             apboxData
         ];
         console.log("###여기는 totalData###", totalData);

         $.ajax({
             type: "post",
             url: "/vct/bkMultiInsert",
             contentType: "application/json; charset:utf-8",
             data: JSON.stringify(totalData),
             dataType: "json",
             beforeSend: function (xhr) {
                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
             },
             success: function () {
                  const $myFile = $("input[name=file]");
                  
                  var formData = new FormData();
                  var check = formData.append("file", $myFile[0].files[0]);
                     console.log("formData", formData);
             
                  var check = $(".myFileupload").val();
                  
                     console.log("check::", check);

                  //휴직 결재선 올림과 동시에 파일 같이 업로드 
               $.ajax({
                  url: "/vct/fileInsert",
                  type: "post",
                  data: formData,
                  contentType: false,
                  processData: false,
                  cache: false,
                  dataType: "text",
                  beforeSend: function(xhr) {
                      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                  },
                  success: function(result) {
                      console.log("Insert된 파일 번호:",result);
                      let bkCertYn = $("input[name=file]").val() != "" ? "B0103" : "B0104"; 

                      let data = {
                          bkName: $(".inputState5").val(),
                          bkSdate: $("#startDate").val(),
                          bkEdate: $("#endDate").val(),
                          bkRsn: $("#example-textarea").val(),
                          bkApstCode: 'C0101',
                          fileSetting: bkCertYn == "B0103" ? "vacation" : null, 
                          bkCertYn: bkCertYn,
                          fileSn: result,
                          "bkNo" : bkNo
                      };
                 
                      console.log("data-->", data);
                     
                      $.ajax({
                          type: "post",
                          url: "/vct/bkApply1",
                          contentType: "application/json;charset=UTF-8",
                          data: JSON.stringify(data),
                          beforeSend: function(xhr) {
                              xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                          },
                          success: function(response) {
                              console.log(response);
                              
                              let myName = "${empVO.empNm}";
                              let myMassage = "휴직 신청";
                              let myData = "휴직";
                              
                              messageVO = {
                                 setter:myName,
                                 massage:myMassage,
                                 data:myData
                              };
                             Swal.fire("결제가 완료되었습니다.","","success").then(function() {
                                location.reload();
                            });
                          },
                          error: function(xhr, status, error) {
                              console.error("AJAX 오류:", error);
                              // TODO: AJAX 요청 실패 시 실행할 코드 작성
                              alert("AJAX 요청에 실패했습니다.");
                          }
                      });
                      
                  },
                  error: function(xhr, status, error) {
                      Swal.fire("파일 미제출된 상태로 저장되었습니다.","","error").then(function() {
                         location.reload();
                     });
                  }
              });
             },
             error: function (xhr, status, error) {
                 console.error("AJAX 오류:", error);
             }
         });
     })
     
     const rsDate = $("input[name=rsDate]");
    const rsResn = $(".rsResn");
    const rsApstCode = $(".rsApstCode");
    const dftNo = $("input[name=rsdftNo]");
    const fileSetting = $("input[name=rsfileSetting]");
    const empNo = $(".empNo1");
    const empNm = $(".empNm1");
    const ptnCode = $(".ptnCode");
    const dnm = $(".dnm");
    const rsNo = $('input[name=rsNo]');
   
       
   //모달속 내역별 조회
   
   $(".selectOne2").on("click", function () {
       console.log("이건 this", this);
       let rsNo = $(this).find('input[name=rsNo]').val();
       
       $.ajax({
           type: "get",
           url: "/vct/rsModal/"+rsNo,
           success: function (result) {
               console.log("이건 복직 result값", result);

               rsDate.val(result.rsDate);
               rsResn.val(result.rsResn);
               rsApstCode.val(result.rsApstCode);
               dftNo.val(result.dftNo);
               fileSetting.val(result.fileSetting);
               empNo.text(result.empNo);
               empNm.text(result.empNm);
               ptnCode.text(result.ptnCode);
               dnm.text(result.dnm);
               
               console.log("rsDate.val(result.rsDate)",rsDate.val(result.rsDate));
               
               //내역별 update
              $("#modalUpdate").on("click",function(){
                     console.log("이거는 rsNo인데::::",rsNo);
                    console.log("이건 thisthis",this);
                 let data={
                       "rsDate" : rsDate.val()   ,
                       "rsResn" : rsResn.val(),
                       "rsNo" : rsNo
                 }
                 console.log("이건 update data:",data);
                 $.ajax({
                    type:"put",
                    url:"/vct/rsModal",
                    data: JSON.stringify(data),
                    contentType:"application/json;charset=utf-8",
                    dataType : "text",
                    beforeSend:function(xhr){
                       xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
                    },
                    success: function (result) {
                        Swal.fire("수정이 완료되었습니다.","","success").then(function() {
                                location.reload();
                            });
                         
                      },
                      error: function(xhr, status, error) {
                           console.error("AJAX 오류:", error);             
                       }
                 })
                 
              });
               
              //복직 결재선 올리기
                 $("#Approval2").on("click", function () {
                  console.log("rsNo입니다.:", rsNo);
                  var today = new Date();
                  var year = today.getFullYear();
                  var month = ('0' + (today.getMonth() + 1)).slice(-2);
                  var day = ('0' + today.getDate()).slice(-2);
                  var dateString = year + '-' + month + '-' + day;
                  console.log(dateString);

                  let empNo = $(".empNo1");
                  let dftNo = $(".rsdftNo");
                 
                  console.log("dftNo왜 안나와?",dftNo);
                  
                  RsReqstVO = {
                      "rsDate": rsDate.val(),
                      "rsResn": rsResn.val(),
                      "rsApstCode": rsApstCode.val(),
                      "dftNo": dftNo.val(),
                      "fileSetting": fileSetting.val(),
                      "empNo": empNo.text(),
                      "empNm": empNm.text(),
                      "ptnCode": ptnCode.text(),
                      "dnm": dnm.text(),
                      "rsNo": rsNo
                      
                  };
                  const dftNoValue = dftNo.val();
                  console.log("dftNo:제발", dftNoValue);   
                  console.log("#######RsReqstVO#######", RsReqstVO);

                  let checkEmpNo = $(".checkEmpNo");
                  let apboxData = []; // ApboxList
                  for (let i = 0; i < checkEmpNo.length; i++) {
                      let serialNumber = i + 1;
                      let empNo = checkEmpNo[i].value;

                      let apboxVO = {
                          "serialNumber": serialNumber,
                          "empNo": empNo
                      };
                      apboxData.push(apboxVO);
                  console.log("@@@여기는 apboxVO@@@", apboxVO);
                  }

                  let totalData = [
                      RsReqstVO,
                      apboxData
                  ];
                  console.log("###여기는 totalData###", totalData);

                  $.ajax({
                      type: "post",
                      url: "/vct/RsmultiInsert",
                      contentType: "application/json; charset:utf-8",
                      data: JSON.stringify(totalData),
                      dataType: "json",
                      beforeSend: function (xhr) {
                          xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                      },
                      success: function () {
                          Swal.fire("결재가 완료되었습니다.","","success").then(function() {
                                location.reload();
                            });
                      },
                      error: function (xhr, status, error) {
                          console.error("AJAX 오류:", error);
                      }
                  });
              })
               
               
           },
           error: function (xhr, status, error) {
               console.error("AJAX 오류:", error);
           }
       });
   });
   
   //복직 신청하기
   $("#RsSave").on("click",function(){
      //RS_APST_CODE, DFT_NO
      const rsDate = $("input[name=rsDate]").val();
      const rsResn = $("#rsRsn").val();
      const rsApstCode = "C0104";
      const dftNo = $("#rsdftNo").val();
      const fileSetting = $("input[name=rsfileSetting]").val();
      let data={
            "rsDate": rsDate,
            "rsResn": rsResn,
            "rsApstCode": rsApstCode,
            "dftNo": dftNo,
            "fileSetting": fileSetting
      }
      
      console.log("이것은 복직신청 Data",data);
      $.ajax({
         type:"post",
         url:"/vct/insertReqst",
         contentType:"application/json;charset=utf-8",
         data: JSON.stringify(data),
         dataType:"json",
         beforeSend: function (xhr) {
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
           },
           success: function (result) {
              Swal.fire("저장이 완료되었습니다.","","success").then(function() {
                    location.reload();
                });
              
           },
           error: function (xhr, status, error) {
               console.error("AJAX 오류:", error);
           }   
           
      })
   });
   
   
   //복직신청 내역 조회
    $(".rsRequest").on("click",function(){
       
   var empNo = sessionStorage.getItem("empNo");
      console.log("empNo입니다.이건 ",empNo);
    $.ajax({
           type: "get",
           url: "/vct/selectEmpInfo/" + empNo,
           contentType: "application/json;charset=utf-8",
           dataType: "json", 
           success: function (result) {
               console.log("성공헀냐?:", result);
                  
          // 데이터를 화면에 출력
               $("#empNo1").text(result.empNo);
               $("#empNm1").text(result.empNm);
               $("#ptnCode").text(result.ptnCode);
               $("#dnm").text(result.dnm);
                  console.log("이건dnm",dnm);
                  
           },
           error: function (xhr, status, error) {
               console.error("AJAX 오류:", error);
           }
       });
      });
   
   
   //휴직 신청 내역별 조회
   $(document).on("click",".selectOne", function () {
	   
	   //내역별 조회시 상태에따라 모달 다르게 뜸
	   let approvalStatus = $(this).find(".badge-success").text();
	   let approvalStatus1 = $(this).find(".badge-info").text();
       console.log("approvalStatus:",approvalStatus);
       if (approvalStatus == '결재완료'|| approvalStatus1 == '결재대기') {
    	   $("#update").hide();
    	   $("#bkApproval2").hide();
    	   $("#approval").hide();
       }
	   
        let bkCertYn = $("input[name=file]").val() != "" ? "B0103" : "B0104"; 
      let bkNo = $(this).find("input[name=bkNo]").val();
      bkNo2 = bkNo;
       let $this = $(this);
       console.log("this", this);
       console.log("이건bkNo", bkNo);
      
      const $myFile = $("input[name=file]");
        
        var formData = new FormData();
        var check = formData.append("file", $myFile[0].files[0]);
        console.log("formData", formData);
        console.log("check", check);
       
        //상태별 조회
         const $bkapList = $("#bkapList");
         const $returnRsn = $("#returnRsn");
        $.ajax({
           type:"get",
           url:"/vct/apboxSelect",
           contentType: "application/json; charset:utf-8",
           data:{
              "bkNo":bkNo2
           },
           dataType:"json",
           beforeSend:function(xhr){
                 xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
              },
              success: function(result) {
                   console.log("result입니다", result);
                 
                 let tbl = `<div class="table-container" style="display: flex; margin-bottom:100%; margin-right:10%;">`;
                 for (var i = 0; i < result.length; i++) {
                     tbl += `<table border="1" style="width: 45%;">`; // 테이블 간 간격을 주려면 margin 스타일을 추가합니다.
                     tbl += `<tbody>`;
                     tbl += `<tr style="background-color: #c0c1c2; text-align: center">`;
                     tbl += `<th>\${result[i].ptnCode}</th>`;
                     tbl += `</tr>`;
                     tbl += `<tr style="height: 50px; text-align: center">`;
                     
                     if (result[i].apbPro == '진행중') {
                         tbl += `<td style="width: 100px;"></td>`;
                     } else if (result[i].apbPro == '승인') {
                         tbl += `<td style="width: 100px;"><img src="${result[i].signImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" style="width: 40px; height: 40px;"></td>`;
                     } else {
                         tbl += `<td style="width: 100px;"><span class="btn btn-outline-danger">\${result[i].apbPro}</span></td>`;
                     }
                     
                       
                     tbl += `</tr>`;
                     tbl += `</tbody>`;
                     tbl += `</table>`;
                 }
                 tbl += `</div>`;

                 $bkapList.html(tbl);
                 
                 let tbl1 = ''; // 변수를 초기화

           	  for (var i = 0; i < result.length; i++) {
           	      if (result[i].apbPro == '반려') {
           	          tbl1 += ` <div>
		      		         		<strong style="color:red;">반려 사유</strong> 
		          	            </div>`;
           	          tbl1 += `<textarea class="form-control1 rsn3" id="example-textarea"rows="10" style="width: 100%; height: 40px;"name="rsn" readonly>\${result[i].rejRsn}</textarea>`;
           	      }
           	  }
           	  $returnRsn.html(tbl1);
			        
                 },
           error: function(xhr, status, error) {
                 console.error("AJAX 오류:", error);             
             }
        });
        
       $.ajax({
           type: "get",
           url: "/vct/bkSelectOne/" + bkNo,
           success: function (rslt) {
               console.log("이건 result인데", rslt);
               const result1 = rslt.result1;//파일 정보값 다나옴
               const fileSn = result1.fileSn;
               const orfiName = result1.orfiName;
               const svfiName = result1.svfiName;
               const fileSize = result1.fileSize;
               const svDate = result1.svDate;
               const fileUdter = result1.fileUdter;
               const fileRoot = result1.fileRoot;
               const fileSetting = result1.fileSetting;
               
               console.log("이거 result1의 값이야",result1);
               
               $(".inputState2").val(rslt.result.bkName);
//                $(".inputState5").val(rslt.result.bkName);
               $("input[name=sDate1]").val(rslt.result.bkSdate);
               $("input[name=eDate1").val(rslt.result.bkEdate);
               $(".bkRsn1").val(rslt.result.bkRsn);
               $("#orfiName").text(rslt.result1.orfiName);
               $("input[name=FileSetting]").val(bkCertYn);
               console.log("Setting fileSetting value:", rslt.result1.fileSetting);
            
           
   //휴직 모달속 결재선2
   $("#bkApproval2").on("click",function(){
         var today = new Date();
         var year = today.getFullYear();
         var month = ('0' + (today.getMonth() + 1)).slice(-2);
         var day = ('0' + today.getDate()).slice(-2);
         var dateString = year + '-' + month + '-' + day;
         console.log(dateString);

        const bkName = $("#inputState5 option:selected").text();
       const bkSdate = $(".startDate").val();
       const bkEdate = $(".endDate").val();
       const bkRsn = $(".bkRsn").val();
       const bkApstCode = 'C0101';
       const bkCertYn = $("input[name=file1]").val() != "" ? "B0103" : "B0104";
       const bkNo = bkNo2;
     

        console.log("bkNo입니다.:", bkNo);

      let empNo = $(".empNo1").text();
         let dftNo = $("input[name=bkDftNo]").val();
        
         console.log("dftNo왜 안나와?:",dftNo);
         
         bkApplyVO = {
             "bkName": bkName,
             "bkSdate": bkSdate,
             "bkEdate": bkEdate,
             "bkRsn": bkRsn,
             "empNo": empNo,
             "bkCertYn":bkCertYn,
             "dftNo":dftNo,
             "bkNo":bkNo
         };
         console.log("#######bkApplyVO#######", bkApplyVO);

         let checkEmpNo = $(".checkEmpNo");
         let apboxData = []; // ApboxList
         for (let i = 0; i < checkEmpNo.length; i++) {
             let serialNumber = i + 1;
             let empNo = checkEmpNo[i].value;

             let apboxVO = {
                 "serialNumber": serialNumber,
                 "empNo": empNo
             };
             apboxData.push(apboxVO);
         console.log("@@@여기는 apboxVO@@@", apboxVO);
         }
      
         let totalData = [
            bkApplyVO,
             apboxData
         ];
         console.log("###여기는 totalData###", totalData);

         $.ajax({
             type: "post",
             url: "/vct/bkMultiInsert",
             contentType: "application/json; charset:utf-8",
             data: JSON.stringify(totalData),
             dataType: "json",
             beforeSend: function (xhr) {
                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
             },
             success: function () {
            	 let myName = "${empVO.empNm}";
                 let myMassage = "휴직 신청";
                 let myData = "휴직";
                 
                 messageVO = {
                    setter:myName,
                    massage:myMassage,
                    data:myData
                 };
            	 
                 Swal.fire("결재가 완료되었습니다.","","success").then(function() {
                         location.reload();
                     });
             },
             error: function (xhr, status, error) {
                 console.error("AJAX 오류:", error);
             }
      });
     })
  },
           error: function (xhr, status, error) {
               console.error("AJAX 오류:", error);
           }
         });
});
   //여기가 휴직신청내역 모달 업데이트 하기직전 코드 다시 해야됨 보류
$("#update").on("click", function () {
    const bkName = $("#inputState2").val();
    const bkSdate = $("#startDate1").val();
    const bkEdate = $("#endDate1").val();
    const bkRsn = $("#rsResn2").val();
    const bkApstCode = 'C0104';
    const $myFile = $("#file");
    const bkNo = bkNo2;
    console.log("this",this);
    console.log("bkNo",bkNo);
    var formData = new FormData();
    
    let files = $myFile[0].files;
    
    for(let i=0;i<files.length;i++){
       formData.append("file", files[i]);
    }
    
    const hasFile = $myFile[0].files.length > 0;
    const bkCertYn = hasFile ? "B0103" : "B0104";
    console.log("bkCertYn", bkCertYn);

    const bkApplyVO = {
        "bkName": bkName,
        "bkSdate": bkSdate,
        "bkEdate": bkEdate,
        "bkRsn": bkRsn,
        "bkApstCode": bkApstCode,
        "bkCertYn": bkCertYn,
        "bkNo":bkNo
    };
    
    formData.append("bkName", bkName);
    formData.append("bkSdate", bkSdate);
    formData.append("bkEdate", bkEdate);
    formData.append("bkRsn", bkRsn);
    formData.append("bkApstCode", bkApstCode);
    formData.append("bkCertYn", bkCertYn);
    formData.append("bkNo", bkNo);

    console.log("bkApplyVO:", bkApplyVO);
    console.log("formData:", formData);

    // Ajax 호출 시작
    $.ajax({
        url: "/vct/bkUpdate",
        processData: false,
        contentType: false,
        data: formData,
        type: "put",
        dataType: "text",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function (rslt) {
           console.log("rslt : " + rslt);
         Swal.fire("수정이 완료되었습니다.","","success").then(function() {
                location.reload();
            });
        },
        error: function (xhr, status, error) {
            console.error("AJAX 오류:", error);
        }
    });
});
   
   
   //로그인한 회원의 휴직 정보 조회
   window.onload = function() {
    empList();
	};
   function empList() {
    
   var empNo = sessionStorage.getItem("empNo");
    $.ajax({
           type: "get",
           url: "/vct/bkApply/" + empNo,
           dataType: "json", 
           success: function (result) {
               console.log("이거왜안나오냐?:", result);
                  
               // 데이터를 화면에 출력
               $("#name").val(result.empNm);
               $("#code").val(result.ptnCode);
           },
           error: function (xhr, status, error) {
               console.error("AJAX 오류:", error);
           }
       });
    
    $.ajax({
           type: "get",
           url: "/vct/selectEmpInfo/"+empNo,
           dataType: "json", 
           success: function (result) {
               console.log("복직 회원 리스트:", result);
                  
               // 데이터를 화면에 출력
               $(".empNo1").text(result.empNo);
               $(".empNm1").text(result.empNm);
               $(".ptnCode").text(result.ptnCode);
               $(".dnm").text(result.dnm);
               
           },
           error: function (xhr, status, error) {
               console.error("AJAX 오류:", error);
           }
       });
   }
   
   //저장하기
   $("#insertSave").on("click", function() {
      const $myFile = $("input[name=file]");
        
        var formData = new FormData();
        var check = formData.append("file", $myFile[0].files[0]);
        console.log("formData", formData);
        
        var check = $(".myFileupload").val();
        
        console.log("check::", check);
        //파일이 있을때 
        if(check != null && check != "") {
           // 파일 업로드
            $.ajax({
                url: "/vct/fileInsert",
                type: "post",
                data: formData,
                contentType: false,
                processData: false,
                cache: false,
                dataType: "text",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    console.log("Insert된 파일 번호:",result);
                    let bkCertYn = $("input[name=file]").val() != "" ? "B0103" : "B0104"; 

                    let data = {
                        bkName: $(".inputState5").val(),
                        bkSdate: $("#startDate").val(),
                        bkEdate: $("#endDate").val(),
                        bkRsn: $("#example-textarea").val(),
                        bkApstCode: 'C0104',
                        fileSetting: bkCertYn == "B0103" ? "vacation" : null, 
                        bkCertYn: bkCertYn,
                        fileSn: result
                       
                    };
               
                    console.log("data-->", data);

                    $.ajax({
                        type: "post",
                        url: "/vct/bkApply",
                        contentType: "application/json;charset=UTF-8",
                        data: JSON.stringify(data),
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function(response) {
                            console.log(response);
                            Swal.fire("저장이 완료되었습니다.","","success").then(function() {
                                location.reload();
                            });
                        },
                        error: function(xhr, status, error) {
                            console.error("AJAX 오류:", error);
                            // TODO: AJAX 요청 실패 시 실행할 코드 작성
                            alert("AJAX 요청에 실패했습니다.");
                        }
                    });
                    
                },
                error: function(xhr, status, error) {
                    Swal.fire("AJAX 오류:", error);
                }
            });
      }
        
        if(check == null || check == "") {
             
             let bkCertYn = $("input[name=file]").val() != "" ? "B0103" : "B0104"; 

              let data = {
                  bkName: $(".inputState5").val(),
                  bkSdate: $("#startDate").val(),
                  bkEdate: $("#endDate").val(),
                  bkRsn: $("#example-textarea").val(),
                  bkApstCode: 'C0104',
                  fileSetting: bkCertYn == "B0103" ? "vacation" : null, 
                  bkCertYn: bkCertYn,
                  dftNo: $("input[name=dftNo]").val(),
              };

              console.log("data-->", data);

              $.ajax({
                  type: "post",
                  url: "/vct/bkApply",
                  contentType: "application/json;charset=UTF-8",
                  data: JSON.stringify(data),
                  beforeSend: function(xhr) {
                      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                  },
                  success: function(response) {
                      console.log(response);
                      Swal.fire("저장이 완료되었습니다.","","success").then(function() {
                        location.reload();
                    });
                      
                  },
                  error: function(xhr, status, error) {
                      console.error("AJAX 오류:", error);
                      // TODO: AJAX 요청 실패 시 실행할 코드 작성
                      alert("AJAX 요청에 실패했습니다.");
                  }
              });
             
          }
    });
     //처음 저장할땐 insert, 다시 저장할땐 update
   
   
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
      var resultApprovePlus = document.getElementById('resultApprovePlus1');
      var lastChild = resultApprovePlus.lastElementChild;
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
   $("#approveLevelBtn2").on("click",function(){
      var resultApprovePlus = document.getElementById('resultApprovePlus2');
      var lastChild = resultApprovePlus.lastElementChild;
      var labelText = lastChild.querySelector('label').textContent;

      let result = "";
      switch(labelText){
         case "1단계" : 
            result = `<p class="PlusBtnContaner2"><label class="h5" for="chamjo">2단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>`;
            break;
         case "2단계" : 
            result = `<p class="PlusBtnContaner2"><label class="h5" for="chamjo">3단계</label> <input type="button" class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;"></p>`
            break;
         case "3단계" :
            Swal.fire({
            icon: 'error',
            title: '잠깐!!',
            text: '참조대상은 3단계까지만 추가 가능해요!',
            })
            return; 
      }
      $("#resultApprovePlus2").append(result);
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


