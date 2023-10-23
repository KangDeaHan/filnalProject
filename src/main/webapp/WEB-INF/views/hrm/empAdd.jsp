<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 추가</title>
<style type="text/css">
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
    #body1 {
    	align-items: center;
    	padding-left : 15%;
    	padding-right : 15%;
    }

    button.btn-primary {
        margin-left: auto;
        margin-right: 20px;
    }
/*     div{ 
    	border: solid 1px; 
    	border: color red; 
    }  */
    
</style>


<script>
//서버에서 발행된 헤더네임과 토큰갑사 저장
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';
$(function() {



	
//     const mU1 = document.querySelector("#emp-num");
//     const mU2 = document.querySelector("#u2");

//     function fCheck(pThis){
//         if(pThis.checked){
//             console.log("check:",mU1,mU2)
//             mU2.value = mU1.value
//         }
//         else {
//             mU2.value = "";
//         }
//     }
	
	
	
});



$(function() {
	  // "입력완료" 버튼 클릭 시 Ajax를 통해 데이터를 서버로 전송
	  $("#inputCompleteButton").on("click", function() {
		  console.log("개똥이");
		  
			let formData = new FormData();
			formData.append("empImg",$("input[name='empImg']").val());
			formData.append("empNo",$("input[name='empNo']").val());
			formData.append("empPass",$("input[name='empPass']").val());
			formData.append("empNm",$("input[name='empNm']").val());
			formData.append("cpNo",$("input[name='cpNo']").val());
			formData.append("empAddr1",$("input[name='empAddr1']").val());
			formData.append("empAddr2",$("input[name='empAddr2']").val());
			formData.append("empAddr3",$("input[name='empAddr3']").val());
			formData.append("regn",$("input[name='regn']").val());
			formData.append("empMail",$("input[name='empMail']").val());
			formData.append("entCaseCode",$("select[name='entCaseCode']").val());
			formData.append("stClfCd",$("select[name='stClfCd']").val());
			formData.append("entDate",$("input[name='entDate']").val());
			formData.append("jcode",$("select[name='jcode']").val());
			formData.append("ptnCode",$("select[name='ptnCode']").val());
			formData.append("grdCode",$("select[name='grdCode']").val());
			formData.append("dcode",$("select[name='dcode']").val());
			formData.append("dtcode",$("select[name='dtcode']").val());
			formData.append("cnthxVOList.blctSdate",$("input[name='blctSdate']").val());
			formData.append("cnthxVOList.blctEdate",$("input[name='blctEdate']").val());
			formData.append("cnthxVOList.ctrtCaseCode",$("select[name='ctrtCaseCode']").val());
			formData.append("cnthxVOList.prSdate",$("input[name='prSdate']").val());
			formData.append("cnthxVOList.prEdate",$("input[name='prEdate']").val());
			formData.append("cnthxVOList.bwctSdate",$("input[name='bwctSdate']").val());
			formData.append("cnthxVOList.bwctEdate",$("input[name='bwctEdate']").val());
			formData.append("cnthxVOList.bcntAmt",$("input[name='bcntAmt']").val());
			formData.append("genCode",$("input[name='genCode']").val());
		  
			
			console.log("하2......." + formData[0])
		//필요한 db 엔터티 : EMP, 
	    // 폼 데이터 직렬화
	    	let data = {
				"empImg":$("input[name='empImg']").val()
				,"empNo":$("input[name='empNo']").val()
				,"empPass":$("input[name='empPass']").val()
				,"empNm":$("input[name='empNm']").val()
				,"cpNo":$("input[name='cpNo']").val()
				,"empAddr1":$("input[name='empAddr1']").val()
				,"empAddr2":$("input[name='empAddr2']").val()
				,"empAddr3":$("input[name='empAddr3']").val()
				,"regn":$("input[name='regn']").val()
				,"empMail":$("input[name='empMail']").val()
				,"entCaseCode":$("select[name='entCaseCode']").val()
				,"stClfCd":$("select[name='stClfCd']").val()
				,"entDate":$("input[name='entDate']").val()
				,"jcode":$("select[name='jcode']").val()
				,"ptnCode":$("select[name='ptnCode']").val()
				,"grdCode":$("select[name='grdCode']").val()
				,"dcode":$("select[name='dcode']").val()
				,"dtcode":$("select[name='dtcode']").val()
				,"blctSdate":$("input[name='blctSdate']").val()
				,"blctEdate":$("input[name='blctEdate']").val()
				,"ctrtCaseCode":$("select[name='ctrtCaseCode']").val()
				,"prSdate":$("input[name='prSdate']").val()
				,"prEdate":$("input[name='prEdate']").val()
				,"bwctSdate":$("input[name='bwctSdate']").val()
				,"bwctEdate":$("input[name='bwctEdate']").val()
				,"bcntAmt":$("input[name='bcntAmt']").val()
				,"genCode":$("input[name='genCode']").val()// 성별 값 가져오기
				
			};
	   
		
// 			console.log("data : " ,JSON.stringify(data));

			const file = $("#file")[0];

		    // Ajax 요청 보내기
			formData.append("file",file.files[0]);
		    $.ajax({
		    	
		      url: "/personnel/empadd", // 서버 컨트롤러의 URL
              processData:false,  
              contentType:false,  
		      data : formData,    
		      type: "post", 
		      dataType:"text",
		      beforeSend:function(xhr){
				xhr.setRequestHeader(header,token);
			  },
		      success: function(response) {
		        console.log("성공했엉!!!", response);
				  Swal.fire({
		              title: "사원추가성공",
		                text: "",
		                icon: "success",
		                confirmButtonText: "확인"
		            }).then(function() {

		            });
		        window.location.href = '/personnel/emp';
		      },
		      error: function() {
		        console.log("실패했엉!!!");
		        // 오류 처리 로직을 여기에 추가하세요.
				  Swal.fire({
		              title: "정보를 정확하게 기입해주세요!",
		                text: "",
		                icon: "error",
		                confirmButtonText: "확인"
		            }).then(function() {

		            });
		      }
		    });
	  });
	});

</script> 


</head>
<body>

	<form id="empForm" method="POST" action="/personnel/empadd">
		<div id="header1">
		
			<div id="header2">
				<button type="button" onclick="location.href = '/personnel/emp'" class="btn mb-2 btn-outline-secondary">나가기<span class="fe fe-24 fe-arrow-left"></span></button>
				<div style="margin-left: 1000px;">
				<button type="button" onclick="autoSelect()" class="btn mb-2 btn-primary"><span class="fe fe-24 fe-send"></span>자동채우기</button>
				<button type="button" id="inputCompleteButton" class="btn mb-2 btn-primary"><span class="fe fe-24 fe-send"></span>입력완료</button>
				</div>
			</div>
			
			
		</div>
		<div id="body">
		   <div id="body1">
		   
		   
			<div class="accordion w-100" id="accordion1">
		      <div class="card shadow">
		      
				
		        <div class="card-header" id="heading1">
		          <a role="button" href="#collapse1" data-toggle="collapse" data-target="#collapse1" aria-expanded="true" aria-controls="collapse1" class="">
		            <strong>기본정보입력</strong>
		          </a>
		        </div>
		        <div id="collapse1" class="collapse show" aria-labelledby="heading1" data-parent="#accordion1" style="" >
		          <div class="card-body">
		            
		           
		           <div class="" style="position: relative; display: flex; align-items: stretch; width: 100%;">
					    <div class="">
					        <div class="form-group mb-3" style="margin-right: 20px;">
					            <label for="simpleinput">프로필 사진</label>
										<div id="preImg">
										</div>
										<input type="file" id="file" name="file"> 
										<input type="hidden" id="filePath" name="empImg" value="">
					        </div>
					        
					        <div class="" style="position: relative; display: flex; align-items: stretch; width: 100%;">
						        <div class="form-group mb-3" style="margin-right: 20px;"> <!-- Add margin-right here -->
						            <label for="simpleinput">이름</label>
						            <input type="text" id="name" class="form-control" name="empNm" value="" placeholder="이름" required onblur="CheckNM()">
						        </div>
						        
						        <div class="form-group mb-3" style="margin-right: 20px;"> <!-- Add margin-right here -->
						            <label for="simpleinput">사번</label>
						            <input type="text" id="emp-num" class="form-control" name="empNo" value="" placeholder="사번입력 ex)202309061" onblur="validateEmpNo()" required>
						        </div>
					        </div>
					        
					        <div class="" style="position: relative; display: flex; align-items: stretch; width: 100%;">
						        <div class="form-group mb-3" style="margin-right: 20px;"> <!-- Add margin-right here -->
						            <label for="example-password">비밀번호</label>
						            <input type="password" id="example-password" class="form-control" placeholder="비밀번호를 입력하세요" value="" name="empPass" required>
						        </div>
						        
						        <div class="form-group mb-3" style="margin-right: 20px;"> <!-- Add margin-right here -->
						           <label for="simpleinput">휴대폰 번호</label>
								   <input type="tel" class="form-control" id="phone" name="cpNo" placeholder="휴대폰 번호를 입력하세요" value="" onblur="validatePhoneNumber()">
								   <span id="phone-error" style="color: red;"></span>
						        </div>
					        </div>
					        
					    </div>
					
					    <div class="" style="position: relative; display: flex; flex-wrap: wrap; align-items: stretch; width: 100%;">
					        
					        <div class="" style="position: relative; display: flex; align-items: stretch; width: 100%;">
						        <div class="form-group mb-3" style="margin-right: 20px;"> <!-- Add margin-right here -->
						          <input type="text" name="empAddr1" class="form-control" id="sample6_postcode" placeholder="우편번호" value="">
									<input type="button"  onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
									<input type="text" name="empAddr2" class="form-control" id="sample6_address" placeholder="주소" value="">
									<input type="text" name="empAddr3" class="form-control" id="sample6_detailAddress" placeholder="상세주소" value="">
									<input type="text" class="form-control"  id="sample6_extraAddress" placeholder="참고항목">
								</div>
						        
								<div class="form-group mb-3" style="margin-right: 20px;">
								    <label for="u_ssn">주민등록번호:</label>
								    <input type="text" id="u_ssn" name="regn" class="form-control" placeholder="주민등록번호 입력" onblur="CheckSSN()" value="">
								    
								    <label for="u_sex">성별:</label>
								    <input type="text" id="u_sex" name="u_sex" class="form-control" disabled>
								    <input type="text" id="u_sex_name" name="genCode" value="" style="display: none;">
								    <br>
								    <input type="button" value="주민등록번호 검사" onclick="CheckSSN()" style="display: none;">
								</div>
						  	</div>
					        <div class="form-group mb-3" style="margin-right: 20px;">
					            <label for="example-email">Email</label>
					            <input type="email" id="example-email" name="empMail" onblur="validateEmail(this)" class="form-control" placeholder="Email" value="">
					            <span id="email-error" style="color: red;"></span>
					        </div>
							
					        <div class="form-group mb-3">
					            <label for="example-select">입사유형</label>
					            <select class="form-control" id="example-select1" name="entCaseCode">
					                <c:forEach items="${cmCodelist}" var="code">
						               <c:if test="${code.cmGroup eq 'join'}">
						               	 <c:if test="${code.cmNm != '입사유형코드'}">
						               	 	<option value="${code.cmCode}">${code.cmNm}</option>
						               	 </c:if>
						               </c:if>
									</c:forEach>    
					            </select>
					        </div>
					    
					        <div class="form-group mb-3" style="display:none; margin-right: 20px;" >
					            <label for="example-select">재직상태</label>
					            <select class="form-control" id="example-select1-2" name="stClfCd">
									<c:forEach items="${cmCodelist}" var="code">
						              <c:if test="${code.cmGroup eq 'tenure'}">
									  	<c:if test="${code.cmNm != '재직상태코드'}">
						               	 <option value="${code.cmCode}">${code.cmNm}</option>
						                </c:if>
						              </c:if>
									</c:forEach>        
					            </select>
					        </div>
					
					        <div class="form-group mb-3" style="margin-right: 20px;">
					            <label for="example-date">입사일</label>
					            <input class="form-control" id="example-date1" type="date" name="entDate">
					        </div>
					    </div>
					</div>
		
		             
		         
		             
		          
		          </div>
		        </div>
		        
		      </div>
		        
		       
		        
		      <div class="card shadow">
		        <div class="card-header" id="heading1">
		          <a role="button" href="#collapse2" data-toggle="collapse" data-target="#collapse2" aria-expanded="false" aria-controls="collapse2" class="collapsed">
		            <strong>인사정보입력</strong>
		          </a>
		        </div>
		        <div id="collapse2" class="collapse" aria-labelledby="heading2" data-parent="#accordion1" style="">
		          <div class="card-body">
		          
		          	<div class="" style="position: relative; display: flex; flex-wrap: wrap; align-items: stretch; width: 100%;">
		          	
			     		<div class="form-group mb-3" style="margin-right: 40px;">
			                <label for="example-select">직무</label>
			                <select class="form-control" id="example-select2" name="jcode">
			                	<c:forEach items="${cmCodelist}" var="code">
			                		<c:if test="${code.cmGroup eq 'job'}">
			                		  <c:if test="${code.cmNm != '직무코드'}">
			                			<option value="${code.cmCode}">${code.cmNm}</option>
			                		  </c:if>
			                		</c:if>
			                	</c:forEach>			
			                </select>
			             </div>			
					       
			             <div class="form-group mb-3" style="margin-right: 40px;">
			                <label for="example-select">직위</label>
			                <select class="form-control" id="example-select3" name="ptnCode">
			                	<c:forEach items="${cmCodelist}" var="code">
			                		<c:if test="${code.cmGroup eq 'spot'}">
			                		  <c:if test="${code.cmNm != '직위코드'}">
			                			<option value="${code.cmCode}">${code.cmNm}</option>
			                		  </c:if>
			                		</c:if>
			                	</c:forEach>			
			                </select>
			             </div>   
			                       
			             <div class="form-group mb-3" style="margin-right: 40px;">
			                <label for="example-select">직급</label>
			                <select class="form-control" id="example-select4" name="grdCode">
			                	<c:forEach items="${cmCodelist}" var="code">
			                		<c:if test="${code.cmGroup eq 'hobong'}">
			                		  <c:if test="${code.cmNm != '직급코드(호봉)'}">
			                			<option value="${code.cmCode}">${code.cmNm}</option>
			                		  </c:if>
			                		</c:if>
			                	</c:forEach>			
			                </select>
			             </div>
			             
				     	<div class="form-group mb-3" style="margin-right: 40px;">
			 	        <label for="example-select">부서/직책</label>	            
				             <div class="input-group mb-3">
				               	                
			                 <select class="form-control" id="example-select5" name="dcode"> 
			                	<c:forEach items="${deptlist}" var="list">
			                			<option value="${list.dcode}">${list.dnm}</option>
			                	</c:forEach>			
			                 </select>
				                	               	              
			                <select class="form-control" id="example-select6" name="dtcode" >                 
		                	  <c:forEach items="${cmCodelist}" var="code">
		                		<c:if test="${code.cmGroup eq 'position'}">
		                		  <c:if test="${code.cmNm != '직책코드'}">
		                			<option value="${code.cmCode}">${code.cmNm}</option>
		                		  </c:if>
		                		</c:if>
		                	  </c:forEach>			
			                </select>
			             
		<!-- 	               <div class="input-group-append">	                -->
		<!-- 					<div class="form-control"> -->
		<!--                       <div class="form-check"> -->
		<!--                         <input class="form-check-input" type="checkbox" value="" id="invalidCheck"  onchange="fCheck(this)" required="" > -->
		<!--                         <label class="form-check-label" for="invalidCheck"> 부서장 </label> -->
		<!--                         <input type="text" id="u2" value="" name="empNo2" hidden><br>  -->
		<!--                       </div> -->
		<!--                     </div>	               -->
		<!-- 	               </div> -->
			               
			             	</div>
		          	 	</div>
		              </div> 
		          </div>
		        </div>
		      </div>
		      <div class="card shadow">
		        <div class="card-header" id="heading1">
		          <a role="button" href="#collapse3" data-toggle="collapse" data-target="#collapse3" aria-expanded="false" aria-controls="collapse3" class="collapsed">
		            <strong>근로계약 정보입력</strong>
		          </a>
		        </div>
		        <div id="collapse3" class="collapse" aria-labelledby="heading3" data-parent="#accordion1" style="">
		          <div class="card-body">
		           <div class="" style="position: relative; display: flex; flex-wrap: wrap; align-items: stretch; width: 100%;">
		            
		         	 <div class="form-group mb-3" style="margin-right: 50px;">
		               <label for="example-date">근로 계약 시작일(적용일)</label>
		               <input class="form-control" id="example-date2" type="date" name="blctSdate">
		             </div>   
		                         
		         	 <div class="form-group mb-3" style="margin-right: 50px;">
		               <label for="example-date">근로 계약 종료일</label>
		               <input class="form-control" id="example-date3" type="date" name="blctEdate">
		             </div>               
		         	 
					 <div class="form-group mb-3" style="margin-right: 50px;">
		               <label for="example-select">계약유형</label>
		               <select class="form-control" id="example-select7" name="ctrtCaseCode">			
					      <option value="A0601">정규직</option>
					      <option value="A0602">계약직</option>
		               </select>
		             </div>	  
		                    	 
		         	 <div class="form-group mb-3">
		               <label for="example-date">수습 시작일</label>
		               <input class="form-control" id="example-date4" type="date" name="prSdate">              
		             </div>               
		         	 <div class="form-group mb-3" style="margin-right: 50px;">
		               <label for="example-date">수습 종료일</label>
		               <input class="form-control" id="example-date5" type="date" name="prEdate">
		             </div>               
		         	 
		           </div>     
		          </div>
		        </div>
		      </div>
		      <div class="card shadow">
		        <div class="card-header" id="heading1">
		          <a role="button" href="#collapse4" data-toggle="collapse" data-target="#collapse4" aria-expanded="false" aria-controls="collapse4" class="collapsed">
		            <strong>임금계약 정보입력</strong>
		          </a>
		        </div>
		        <div id="collapse4" class="collapse" aria-labelledby="heading4" data-parent="#accordion1" style="">
		          <div class="card-body">
		           <div class="" style="position: relative; display: flex; flex-wrap: wrap; align-items: stretch; width: 100%;">
		        	<div class="form-group mb-3" style="margin-right: 50px;">
		              <label for="example-date">임금 계약 시작일(적용일)</label>
		              <input class="form-control" id="example-date6" type="date" name="bwctSdate">              
		            </div>               
		
		        	 <div class="form-group mb-3" style="margin-right: 50px;">
		              <label for="example-date">임금 계약 종료일</label>
		              <input class="form-control" id="example-date7" type="date" name="bwctEdate">              
		             </div>    
		                
		             <div class="form-group mb-3" style="margin-right: 50px;">        
			            <div class="input-group mb-3" style="padding: 4%;">
			              <label for="example-date" style="padding-right: 10%;">계약금액</label>
			              <input type="text" class="form-control" aria-label="Amount (to the nearest dollar)" name="bcntAmt" value="50000">
			              <div class="input-group-append">
			                <span class="input-group-text">원</span>
			              </div>
			            </div>
			         </div>
			         
		           </div>
		<!-- 			 <div class="form-group mb-3"> -->
		<!--                <label for="example-select">소득구분</label> -->
		<!--                <select class="form-control" id="example-select8" name="bincClf">			 -->
		<!-- 			      <option>근로소득</option> -->
		<!-- 			      <option>사업소득</option> -->
		<!-- 			      <option>기타소득</option> -->
		<!--                </select> -->
		<!--              </div> -->
		             	  
		          </div>
		        </div>
		      </div>
		    </div>
			
			
		   </div>
		</div>
	</form>
</body>
<!-- 이미지 파일 미리보기 -->

<script type="text/javascript">

const resultHt = $("#result"); //결과창
const $myFile = $("input[name='file']"); //파일
const $preImg = $("#preImg")//이미지
$myFile.on("change",()=>{
	var formData = new FormData();
	formData.append("file",$myFile[0].files[0]);

	$.ajax({
          type : "post",
          url : "/personnel/preview",
          data : formData,    //JSON.stringify 하지 않음에 주의!
          contentType:false,  //defult값이 application/x-www-form-urlencoded
          processData:false,  //defult값이 application/x-www-form-urlencoded
          cache:false,        //요건 선택 권장!
          dataType : "text",
          beforeSend:function(xhr){
		  	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		  },
          success : function(rslt){
        	    console.log("rslt: " + rslt)
	       	    var newImg = $("<img>")
	       	        .attr("src", rslt)
	       	        .css({
	       	            width: "200px",
	       	            height: "200px"
	       	        });
	       	 	// 파일 경로를 input 태그에 설정
	               $("#filePath").val(rslt);
	
	       	    $preImg.empty().append(newImg);
          },
          error:function(xhr, status, error){
              console.log("code: " + xhr.status)
              console.log("message: " + xhr.responseText)
              console.log("error: " + error);
          }
     });
});
	


</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function autoSelect(){
		console.log("지금은 새벽 한시 반!")
		$("#name").val("임석일");
		$("#emp-num").val("202310161");
		$("#phone").val("010-5571-8953");
		$("#sample6_postcode").val("34908");
		$("#sample6_address").val("대전 중구 계룡로 846");
		$("#sample6_detailAddress").val("대덕인재 개발원");
		$("#sample6_extraAddress").val("4층 402호");
		$("#example-email").val("jmj1273@naver.com");
		$("#u_ssn").val("9806151231234");
		$("#u_sex").val("남자");
		$("#u_sex_name").val("B0201");
		$("#example-date1").val("2023-10-17");
// 		$("#filePath").val("/insightFile/myimg/nca자격증.JPG");
// 		$("#preImg").html('<img src="/insightFile/myimg/nca자격증.JPG" style="width: 200px; height: 200px;">');
		$("#example-select2").val("A0304");
		$("#example-select4").val("A0502");
		$("#example-select5").val("112");
		$("#example-date2").val("2023-10-18");
		$("#example-date3").val("2024-01-17");
		$("#example-select7").val("A0602");
		$("#example-date6").val("2023-10-18");
		$("#example-date7").val("2024-01-17");
		$("input[name='bcntAmt']").val("2500000");
		
	}

	// 주소 검색 함수
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    //이름 유효성 검사
    function CheckNM() {
    	for (var i=0; i<$("#name").val().length; i++)  { 

    	    var chk = $("#name").val().substring(i,i+1); 

    	    if(chk.match(/[0-9]|[a-z]|[A-Z]/)) { 

//     	    	alert("이름을 정확히 입력해주세요");
		  Swal.fire({
              title: "이름을 정확히 입력해주세요",
                text: "",
                icon: "error",
                confirmButtonText: "확인"
            }).then(function() {

            });

    	        return;

    	    }

    	    if(chk.match(/([^가-힣\x20])/i)){

//     	    	alert("이름을 정확히 입력해주세요");
    			  Swal.fire({
    	              title: "이름을 정확히 입력해주세요",
    	                text: "",
    	                icon: "error",
    	                confirmButtonText: "확인"
    	            }).then(function() {

    	            });

    	        return;

    	    }

    	    if($("#name").val() == " "){

//     	    	alert("이름을 정확히 입력해주세요");
		  Swal.fire({
              title: "이름을 정확히 입력해주세요",
                text: "",
                icon: "error",
                confirmButtonText: "확인"
            }).then(function() {

            });

    	        return;

    	    }
    	    
    	    if ($("#name").val().length <= 1) {

//     	    	alert("이름을 정확히 입력해주세요");
		  Swal.fire({
              title: "이름을 정확히 입력해주세요",
                text: "",
                icon: "error",
                confirmButtonText: "확인"
            }).then(function() {

            });

    	    	return;

    	    }

    	} 
    }
    
    // 사번유효성검사
	var hasShownWarning = false; // 경고가 이미 표시되었는지 여부를 나타내는 변수
	
	function validateEmpNo() {
	    var empNoInput = document.getElementById("emp-num");
	    var empNo = empNoInput.value;
	
	    // 숫자로만 이루어져 있는지 체크
	    var numericRegex = /^[0-9]+$/;
	    if (!numericRegex.test(empNo)) {
	        if (!hasShownWarning) {
// 	            alert("사번은 숫자로만 입력해야 합니다.");
	  		  Swal.fire({
	              title: "사번은 숫자로만 입력해야 합니다.",
	                text: "",
	                icon: "error",
	                confirmButtonText: "확인"
	            }).then(function() {

	            });
	            hasShownWarning = true; // 경고를 표시한 후에 상태를 변경
	        }
	        empNoInput.value = "";
	        empNoInput.focus();
	        return false;
	    }
	
	    // 9자리인지 체크
	    if (empNo.length !== 9) {
	        if (!hasShownWarning) {
// 	            alert("사번은 9자리여야 합니다.");
	  		  Swal.fire({
	              title: "사번은 9자리여야 합니다.",
	                text: "",
	                icon: "error",
	                confirmButtonText: "확인"
	            }).then(function() {

	            });
	            hasShownWarning = true; // 경고를 표시한 후에 상태를 변경
	        }
	        empNoInput.value = "";
	        empNoInput.focus();
	        return false;
	    }
	
	    // 유효성 검사 통과
	    return true;
	}
    
    
    //핸드폰 유효성 검사
	function validatePhoneNumber() {
	    var phoneInput = document.getElementById("phone");
	    var phoneValue = phoneInput.value;
	
	    // 핸드폰 번호 체크 정규식
	    var regExp = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
	
	    if (!regExp.test(phoneValue)) {
	        // 유효하지 않은 핸드폰 번호일 경우 에러 메시지 표시
	        document.getElementById("phone-error").textContent = "유효하지 않은 핸드폰 번호입니다.";
	    } else {
	        // 유효한 핸드폰 번호일 경우 에러 메시지 삭제
	        document.getElementById("phone-error").textContent = "";
	    }
	}
	$(document).on("keyup", "#phone", function() { 

	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 

	});
    
    // 이메일 유효성 검사
    function validateEmail(input) {
        var emailValue = input.value;
        var emailError = document.getElementById("email-error");

        var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

        if (!regExp.test(emailValue)) {
            emailError.innerHTML = "올바른 이메일 주소 형식이 아닙니다.";
        } else {
            emailError.innerHTML = "";
        }
    }
	
    //주민번호 유효성 검사
    function CheckSSN() {
        var f = document.getElementById("u_ssn"); // 주민번호 입력란
        var u_sex = document.getElementById("u_sex"); // 성별 입력란
        var u_sex_name = document.getElementById("u_sex_name"); // 성별 코드 입력란
        var ssn = f.value;
        var key = "234567892345";
        var sum = 0;
        var yy = ssn.substring(0, 2);
        var mm = ssn.substring(2, 4);
        var dd = ssn.substring(4, 6);
        var sex = ssn.charAt(6);
        var pre_yy = (sex == "1" || sex == "2") ? "19" : "20";
        var totalyy = pre_yy + yy;

        if (!ssn) return;

        if (isNaN(ssn)) {
//             alert("주민등록번호는 숫자만 입력 가능합니다.");
  		  Swal.fire({
              title: "주민등록번호는 숫자만 입력 가능합니다.",
                text: "",
                icon: "error",
                confirmButtonText: "확인"
            }).then(function() {

            });
            f.value = "";
            f.focus();
            return;
        }

        if (ssn.length != 13) {
//             alert("주민등록번호 13자리이어야 합니다.");
  		  Swal.fire({
              title: "주민등록번호 13자",
                text: "",
                icon: "error",
                confirmButtonText: "확인"
            }).then(function() {

            });
            return;
        }

        if ((mm < 01 || mm > 12 || sex > 4)) {
            alert("월에 해당하는 두 자리가 잘못 입력되었습니다.");
            f.value = "";
            f.focus();
            return;
        }

        var test_dd;

        if (mm == 01 || mm == 03 || mm == 05 || mm == 07 || mm == 08 || mm == 10 || mm == 12) {
            test_dd = 31;
        } else if (mm == 04 || mm == 06 || mm == 09 || mm == 11) {
            test_dd = 30;
        } else if (mm == 02) {
            if (((totalyy % 4) == 0) && ((totalyy % 100) != 0) || ((totalyy % 400) == 0)) {
                test_dd = 29;
            } else {
                test_dd = 28;
            }
        }

        if (dd > test_dd) {
            alert("일자가 틀립니다.");
            return;
        }

        if (sex == "1" || sex == "3") {
            u_sex.value = "남자";
            u_sex_name.value = "B0201";
        } else {
            u_sex.value = "여자";
            u_sex_name.value = "B0202";
        }

//         var endNo = 0;
//         for (var i = 0; i < 12; i++) {
//             sum += ssn.charAt(i) * key.charAt(i);
//         }
//         sum = 11 - (sum % 11);
//         endNo = sum % 10;

//         if (ssn.charAt(12) != endNo) {
//             alert("유효하지 않는 주민번호입니다.\n\n다시 확인하시고 입력해 주세요");
//             f.value = "";
//             f.focus();
//         }
    }
</script>


</html>