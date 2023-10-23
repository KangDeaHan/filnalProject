<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
div {
/* 	border: 1px solid blue; */
}

#steps {
	display: flex;
	height: 900px;
}

.step {
		display : flex;
		margin-bottom : 15px;
		margin-top : 15px;
	}

#Aside {
	/* 		border : 1px solid red; */
	margin: 0px;
}

#Bside {
	/* 		border : 1px solid red; */
	
}

#scroll {
	height: 800px;
	overflow-y: auto; /* 세로 스크롤 활성화 */
}

.icon {
	background-image: url(/resources/images/search-magnifier.png);
	background-repeat: no-repeat;
	background-position: 10px center;
	padding-left: 40px;
	box-sizing: border-box;
	background-size: 14px 14px; /* 원하는 가로 및 세로 크기로 설정합니다. */
}

/* 테이블 전체 스타일 지정 */
table {
	border-collapse: collapse;
	width: 100%;
}

table tbody {
	height : 70%;
	overflow-y : auto;
}

/* 테이블 헤더 스타일 지정 */
.table thead th { 
 	background-color: #f2f2f2; 
 	text-align: center; 
 	color: #343a40 !important;
 	font-weight : bold !important;
/* 	padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */ 
 	border: 1px solid #ddd; /* 테두리 스타일 지정 */ 
/* 	height: 30px; */
 } 

/* 테이블 데이터 셀 스타일 지정 */
td {
	text-align: center;
	padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
	border: 1px solid #ddd; /* 테두리 스타일 지정 */
}

.nav-link {
	display: block;
	padding: 0.5rem 1rem;
}

.nav-link:hover, .nav-link:focus {
	text-decoration: none;
}

.nav-link.disabled {
	color: #6c757d;
	pointer-events: none;
	cursor: default;
}
</style>
<meta charset="UTF-8">
<title>정산하기 - 지급항목</title>
</head>
<body>

<div id="steps">

	<div id="Aside" class="mr-3" style="width:10%;">
		<div style="margin-bottom:10px;">
			${SCVO.prStlNm}<br>
			지급일 ${SCVO.prPdate}
		</div>
		<div>
			<span class="badge badge-pill badge-success">근로소득</span> 
		</div>
		<div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/check.png">
					</div>
					<div>
						<strong>Step1<br> 정산대상자</strong>
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/pay.png">
					</div>
					<div>
						Step2<br> 지급 항목
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/deduction.png">
					</div>
					<div>
						Step3<br> 공제 항목
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/result.png">
					</div>
					<div>
						Step4<br> 결과 미리보기
					</div>
				</div>
				<div class="updown">&nbsp;&nbsp;&nbsp;|</div>
				<div class="step">
					<div class="mr-3">
						<img class="mt-2" src="/resources/images/salary/red-flag.png">
					</div>
					<div>
						Step5<br> 정산 완료
					</div>
				</div>
			</div>
	</div>
		<!-- ------------------------------------------------------------------------------------------------------------------------------------------>

		<div id="Bside" style="width: 90%;">

			<div class="row justify-content-center">
				<div class="col-12"
					style="margin-left: 0px; margin-right: 0px; margin-bottom: 10px;">
					<p class="card-text">${ptNm}
						/ <strong>${SCVO.prStlNm}</strong>
					</p>
					<h2 class="mb-2 page-title" style="display: inline-block">지급항목</h2>
					<button id="payButton" onclick="wagePayAjax()" type="button"
						class="btn btn-success"
						style="float: right; color: white;margin-right:145px;"> → 공제항목 </button>
				</div>
				<div class="mb-4" id="scroll" style="margin-right:130px;">
					<div class="card shadow">
						<div class="card-body" style="width: 1300px; height: 750px;"> <!-- height : 750 적당했음. -->
							<ul class="nav nav-pills nav-fill mb-4" id="pills-tab"
								role="tablist" style="width: 30%">
								<li class="nav-item itemNames"><a class="nav-link active" 
									id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
									role="tab" aria-controls="pills-profile" aria-selected="false">기본급</a>
								</li>
								<li class="nav-item itemNames"><a class="nav-link"
									id="pills-contact-tab" data-toggle="pill" href="#pills-contact"
									role="tab" aria-controls="pills-contact" aria-selected="false">초과근무수당</a>
								</li>
								<li class="nav-item itemNames"><a class="nav-link" id="pills-etc-tab"
									data-toggle="pill" href="#pills-etc" role="tab"
									aria-controls="pills-etc" aria-selected="false">기타수당</a></li>
							</ul>

							<div class="tab-content mb-1" id="pills-tabContent">
								<!-- ////////////// 기본급 시작 //////////////////////////// -->
								<div class="tab-pane fade active show" id="pills-profile" role="tabpanel"
									aria-labelledby="pills-profile-tab">
								
									<div class="col-md-12 my-4">
					                  <div class="card shadow">
					                    <div class="card-body">
					                      <h5 class="card-title mb-3">대상자</h5>
					                      <table id="basePayTable" class="table table-bordered table-hover mb-0">
					                        <thead>
					                          <tr>
					                            <th>사번</th>
					                            <th>이름</th>
					                            <th>기본급</th>
					                            <th>기본시급</th>
					                            <th>소정근무시간</th>
					                          </tr>
					                        </thead>
					                        
					                        <tbody>
					                          <c:forEach var="basePay" items="${basePayList}" varStatus="stat">	
						                          <tr>
						                            <td>${basePay.empNo}</td>
						                            <td>${basePay.empNm}</td>
						                          	<td><fmt:formatNumber value="${basePay.basePay}" pattern="#,###" /></td>
						                          	<td><fmt:formatNumber value="${basePay.basicHourWage}" pattern="#,###" /></td>
						                            <td>209</td>
						                          </tr>
					                        	</c:forEach>
					                        </tbody>
					                        
					                      </table>
					                    </div>
					                  </div>
					                </div>	
									
								</div>
								<!-- ////////////// 기본급 끝 //////////////////////////// -->
								<!-- ////////////// 초과근무수당 시작 //////////////////////////// -->
								<div class="tab-pane fade" id="pills-contact" role="tabpanel"
									aria-labelledby="pills-contact-tab">
								
									<div class="col-md-12 my-4">
					                  <div class="card shadow">
					                    <div class="card-body">
					                      <h5 class="card-title mb-3">대상자</h5>
					                      <table id="overtimePayTable" class="table table-bordered table-hover mb-0">
					                        <thead>
					                          <tr>
					                            <th rowspan="2">사번</th>
					                            <th rowspan="2">이름</th>
					                            <th rowspan="2">기본시급</th>
					                            <th rowspan="2">인정시간</th>
					                            <th colspan="2">연장 &nbsp;&nbsp;<span class="badge badge-pill badge-primary">+50% 가산</span></th>
					                            <th colspan="2">야간  &nbsp;&nbsp;<span class="badge badge-pill badge-primary">+50% 가산</span></th>
					                            <th colspan="2">휴일  &nbsp;&nbsp;<span class="badge badge-pill badge-primary">+50% 가산</span></th>
					                            <th rowspan="2">초과근무수당</th>
					                          </tr>
					                          
					                          <tr>
					                            <th>근무시간</th>
					                            <th>금액</th>
					                            <th>근무시간</th>
					                            <th>금액</th>
					                            <th>근무시간</th>
					                            <th>금액</th>
					                          </tr>
					                        </thead>
					                        
					                        <tbody>
					                          <c:forEach var="exPay" items="${exPayList}" varStatus="stat">	
						                          <tr>
						                            <td>${exPay.empNo}</td>
						                            <td>${exPay.empNm}</td>
						                          	<td><fmt:formatNumber value="${exPay.basicHourWage}" pattern="#,###" /></td>
						                            <td>${exPay.totalAdmitTime}</td>
						                            <td>${exPay.totalExtime}</td>
						                          	<td><fmt:formatNumber value="${exPay.overtimePay}" pattern="#,###" /></td>
						                            <td>${exPay.totalNightime}</td>
						                          	<td><fmt:formatNumber value="${exPay.nightimePay}" pattern="#,###" /></td>
						                            <td>${exPay.totalHdtime}</td>
						                          	<td><fmt:formatNumber value="${exPay.hdtimePay}" pattern="#,###" /></td>
						                          	<td><strong><fmt:formatNumber value="${exPay.totalExPay}" pattern="#,###" /></strong></td>
						                          </tr>
					                        	</c:forEach>
					                        </tbody>
					                        
					                      </table>
					                    </div>
					                  </div>
					                </div>	
								
								
								</div>
								<!-- ////////////// 초과근무수당 끝 //////////////////////////// -->
								<!-- ////////////// 기타수당 시작 //////////////////////////// -->
								<div class="tab-pane fade" id="pills-etc" role="tabpanel"
									aria-labelledby="pills-etc-tab">
								
								<div class="col-md-12 my-4">
					                  <div class="card shadow">
					                    <div class="card-body">
					                      <h5 class="card-title mb-3" style="display:inline-block">대상자</h5>
					                      <table id="otherPayTable" class="table table-bordered table-hover mb-0">
					                        <thead>
					                          
					                          <tr>
					                            <th>사번</th>
					                            <th>이름</th>
					                          
<%-- 					                          <c:set var="pdNmList" value="${[]}" /> --%>
					                          	
					                          <c:forEach var="pdVO" items="${pdVOList}" varStatus="stat">	
					                          
					                            <th>${pdVO.pdNm}</th>
<%-- 					                          	<c:set var="pdNmList" value="${pdNmList + [pdVO.pdNm]}"/> --%>
					                          </c:forEach>
					                          
					                          	<th>기타수당 합계</th>
					                          </tr>
					                        </thead>
					                        
					                        <tbody>
					                        
					                        	<c:forEach var="payList" items="${pdTotalList}" varStatus="stat">
						                          <tr>
						                          	
						                            <td>${payList[0].empNo}</td>
						                            <td>${payList[0].empNm}</td>
						                            
					                        	    <c:set var="totalPdAmt" value="0" /> <%-- 각 사람의 합계를 0으로 초기화 --%>
						                            
						                            <c:forEach var="payDedVO" items="${payList}" varStatus="status">
												     	<td>
												     		<input type="number" id="input_${status.index}" value="${payDedVO.pdAmt}" name="pdAmt" 
												     			   onkeyup="updateTotal(this)"/>
												     	</td>
												     	<c:set var="totalPdAmt" value="${totalPdAmt + payDedVO.pdAmt}" />
												    </c:forEach>
						                     			
						                     			<td><strong id="total_${stat.index}"><fmt:formatNumber value="${totalPdAmt}" pattern="#,###" /></strong></td>
						                          </tr>
					                        	</c:forEach>
					                     
					                          
					                        </tbody>
					                        
					                      </table>
					                    </div>
					                  </div>
					                </div>	
					                
								</div>
								<!-- ////////////// 기타수당 끝 //////////////////////////// -->
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<!-- bside -->

	</div>
	<!-- steps -->

<script>
	
	//input 값이 변경될 때 호출되는 함수
	function updateTotal(pThis) {
		console.log("pThis : ", pThis);
	    console.log("pThis2 : ", $(pThis));
		
	    // 입력된 숫자 가져오기
	    const inputValue = parseInt(pThis.value) || 0;
	    
	    // 현재 행(tr)을 찾기
	    const currentRow = $(pThis).closest("tr");

	    // 현재 행에서 모든 input 요소를 찾아서 값을 합산
	    let totalAmount = 0;
	    currentRow.find("input[type='number']").each(function() {
	        totalAmount += parseInt($(this).val()) || 0;
	    });
	    
		// 합산된 값을 totalAmt 요소에 설정
	    const totalAmtTD = currentRow.find("td:last strong");
	    totalAmtTD.text(totalAmount.toLocaleString()); // 숫자를 천단위 구분기호로 형식화하여 설정
	    
	    console.log("totalAmount : ", totalAmount);
	    
	} //시간되면 숫자 한개씩 올렸을때 (onchange 함수도 걸어두기!!) (어차피 동시에 일어나는 일이 아님)
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////

	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	
	var liElements = $(".itemNames"); // 클래스가 "nav-item"인 모든 <li> 요소를 선택.
	
	// 각 <li> 요소에서 텍스트를 추출하여 변수에 저장.
	var firstLiText = liElements.eq(0).find("a").text(); // 첫 번째 <li>
	var secondLiText = liElements.eq(1).find("a").text(); // 두 번째 <li>
	var thirdLiText = liElements.eq(2).find("a").text(); // 세 번째 <li>

	// 각 변수에는 각각의 <li>의 텍스트가 저장됩니다.
	console.log("firstLiText: ", firstLiText);
	console.log("secondLiText: ", secondLiText);
	console.log("thirdLiText: ", thirdLiText);
	
/*	var textArray = []; // 각 <li> 요소에서 텍스트를 추출하여 저장할 빈 배열을 만듦.

	// 각 <li> 요소에 대해 반복 처리.
	liElements.each(function() {
	    // 현재 요소에서 <a> 요소를 찾고 해당 <a> 요소의 텍스트를 가져와 배열에 추가.
	    var textContent = $(this).find("a").text();
	    textArray.push(textContent);
	});

	// 결과 배열에 각 <li>의 텍스트가 저장됨.
	console.log("textArray : ", textArray); 
*/	
	var ptNo = "${SCVO.ptNo}";
	var prYr = "${SCVO.prYr}";
	var prMth = "${SCVO.prMth}";
	
	console.log("ptNo : ", ptNo);
	console.log("prYr : ", prYr);
	console.log("prMth : ", prMth);
	
	var BPtrElements = $("#basePayTable tbody tr"); // 모든 <tr> 요소를 선택.
	var OTPtrElements = $("#overtimePayTable tbody tr"); // 모든 <tr> 요소를 선택.
	var OPtable = $("#otherPayTable");
	var OPtrElements = $("#otherPayTable tbody tr"); // 모든 <tr> 요소를 선택.
	var OPtrInputs = $("#otherPayTable tbody tr input");
	console.log("OPtrElements : ", OPtrElements);
	
	var pdNmArray = []; // 결과를 저장할 배열
	
 	var pdVOList = ${pdVOListJson}; //이미 json문자열로 넘어왔기 때문에 "" 안써도 됨. Java 모델에서 가져온 데이터를 JavaScript 변수에 할당  //""안에 가두면 문자열로 바뀜. //JSP에서 전달된 JSON 형식의 문자열
	console.log("pdVOListJson : ", pdVOList);
 	
 	$.each(pdVOList, function(idx,item){
 		console.log(idx,item.pdNm);
 		pdNmArray.push(item.pdNm);
 	})
 		console.log("pdNmArray : ", pdNmArray);
 	

	///////////////////////////////////////////////////////////////////
 		
	//JSON 문자열을 JavaScript 객체로 파싱  
	// 	var pdVOList = JSON.parse(pdVOListString);  //json문자열이 아니라서 파싱 못함.
	// 	console.log("pdVOList : ", pdVOList); 
	// 	var pdNmArray = []; //자바에서 넘어온 pdNm을 반복문 돌려서 한개씩 뽑아서 데이터를 보내고 싶음. ajax로 데이터를 보내려면 스크립트 배열에 담아서, 뭔가 반복문돌려서 배열에서 1개씩 꺼내서 보내줘야 할 것 같아서 지금 그렇게 하는데 잘 안됨.   
		
	//     for (var i = 0; i < pdVOList.length; i++) { // pdVOList의 각 항목에서 pdNm을 추출하여 배열에 추가
	//         pdNmArray.push(pdVOList[i].pdNm);
	//     }
	//     console.log("pdNmArray : ", pdNmArray);
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	function wagePayAjax(){ //버튼 클릭시 ajax로 데이터 보내기 (insert 수행)
		
		
		//기본급
		BPtrElements.each(function(index) {
	    	var empNo = $(this).find("td:eq(0)").text(); // 각 <tr>에서 첫 번째 <td>의 텍스트를 가져옴.
			
	    	console.log("empNo1 나와라 : ", empNo);
	    	
			var data = {
						"pdNm" : firstLiText,
						"empNo" : empNo, // 각 <tr>에서 추출한 empNo 값을 사용.
						"ptNo" : ptNo,
						"prYr" : prYr,
						"prMth" : prMth 
						};
	    	
			//기본급 insert
			$.ajax({
				url:"/salary/insertBasePay",
				contentType:"application/json;charset=UTF-8",
				async : false,
				data:JSON.stringify(data),
				type:"post",
				dataType:"text",
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token);
		    	},
// 				success:function(result){
// 					console.log("result : ", result);
// 				},
				error:function(xhr, status, error){
				    console.log("code: " + xhr.status)
				    console.log("message: " + xhr.responseText)
				    console.log("error: " + error);
				}
			});//ajax
			
		});//BPtrElementes 반복 끝 (empNo마다 반복 insert 끝)
		//////////////////////////////////////////////////////////////////////////////////
		
		//초과근무수당
		OTPtrElements.each(function(index) {
	    	var empNo = $(this).find("td:eq(0)").text(); // 각 <tr>에서 첫 번째 <td>의 텍스트를 가져옴.
	    	console.log("empNo2 나와라 : ", empNo);
	    	
			var data = {
						"pdNm" : secondLiText,
						"empNo" : empNo, // 각 <tr>에서 추출한 empNo 값을 사용.
						"ptNo" : ptNo,
						"prYr" : prYr,
						"prMth" : prMth 
						};
			
			//초과근무수당 insert
			$.ajax({
				url:"/salary/insertOvertimePay",
				contentType:"application/json;charset=UTF-8",
				async : false,
				data:JSON.stringify(data),
				type:"post",
				dataType:"text",
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token);
		    	},
// 				success:function(result){
// 					console.log("result : ", result);
// 				},
				error:function(xhr, status, error){
				    console.log("code: " + xhr.status)
				    console.log("message: " + xhr.responseText)
				    console.log("error: " + error);
				}
			});//ajax
			
		});//OTPtrElements 반복 끝
		////////////////////////////////////////////////////////////////////////////////////
		
		// $.each(컬렉션배열,콜백);
    	// jQuery객체.each();
    	let trArrays = [];
    	OPtrElements.each(function(index,oneTr){
    		console.log("tr",oneTr);
    		let rowData = [];
    		for(let i=2; i<(oneTr.children.length -1); i++){
    			console.log("체킁:",oneTr.children[i].children[0]);
    			rowData.push(oneTr.children[i].children[0].value); 
    		}

    		//console.log("rowData",rowData);
    		trArrays.push(rowData);
    	});

    	console.log("토탈배열:",trArrays);
		
		//기타수당  (사람별로 insert, pdNm 동적으로 반복해서 값 뽑아와야 함. th pdNm의 같은번째 td에 input 값 뽑아서 변수에 담아 data 보내기(ajax))
		OPtrElements.each(function(index) {
	    	var empNo = $(this).find("td:eq(0)").text(); // 각 <tr>에서 첫 번째 <td>의 텍스트를 가져옴.
	    	console.log("empNo3 나와라 : ", empNo);
	    	
	    	var pdAmtArray = trArrays[index];
			console.log("pdAmtArray : ", pdAmtArray);
			
	    	//pdNm, pdAmt 추출
			for(let i=0; i<pdAmtArray.length; i++){
				var pdAmt = pdAmtArray[i];
				var pdNm = pdNmArray[i];
				console.log("pdNm :", pdNm);
				console.log("pdAmt :", pdAmt);

				var data = {
	 						"pdNm" : pdNm,
							"empNo" : empNo, // 각 <tr>에서 추출한 empNo 값을 사용.
							"ptNo" : ptNo,
							"prYr" : prYr,
							"prMth" : prMth,
							"pdAmt" : pdAmt
							};
				console.log("data : ", data);
				
 				//기타수당 insert
				$.ajax({
					url:"/salary/insertOtherPay",
					contentType:"application/json;charset=UTF-8",
					async : false,
					data:JSON.stringify(data),
					type:"post",
					dataType:"text",
					beforeSend: function(xhr) {
			            xhr.setRequestHeader(header, token);
			    	},
// 					success:function(result){
// 						console.log("result : ", result);
// 					},
					error:function(xhr, status, error){
					    console.log("code: " + xhr.status)
					    console.log("message: " + xhr.responseText)
					    console.log("error: " + error);
					}
				});//ajax
				
				
			};//for 끝		

		}); //OPtrElements 반복 끝
		
		 // 모든 AJAX 요청이 성공한 경우에만 페이지 이동
	    	const Toast = Swal.mixin({
			      toast: true,
			      position: 'center-center',
			      showConfirmButton: false,
			      timer: 1000,
			      timerProgressBar: true,
			      didOpen: (toast) => {
			        toast.addEventListener('mouseenter', Swal.stopTimer)
			        toast.addEventListener('mouseleave', Swal.resumeTimer)
			      } 
			    })

			    Toast.fire({
			      icon: 'success',
			      title: '지급항목이 확정되었습니다.'
			    }).then(function () {
	                // 토스트가 보여진 후 이동할 URL 설정
			        location.href = "/salary/wageDed";
	            });
		
	}//function 끝
	
</script>

</body>
</html>