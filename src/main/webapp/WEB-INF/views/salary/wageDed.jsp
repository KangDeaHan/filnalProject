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
	background-image: url(/resources/images/salary/search-magnifier.png);
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
<title>정산하기 - 공제항목</title>
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
						<img class="mt-2" src="/resources/images/salary/check.png">
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
					<h2 class="mb-2 page-title" style="display: inline-block">공제항목</h2>
					<button id="DedButton" onclick="wageDedAjax()" type="button"
						class="btn btn-success"
						style="float: right; color: white; margin-right: 145px;"> → 결과 미리보기 </button>
				</div>
				
				<div class="mb-4" id="scroll" style="margin-right:130px;">
					<div class="card shadow">
						<div class="card-body" style="width: 1300px; height: 750px;"> <!-- height : 750 적당했음. -->
							<ul class="nav nav-pills nav-fill mb-4" id="pills-tab"
								role="tablist" style="width: 30%">
								
								<li class="nav-item itemNames"><a class="nav-link active"
									id="pills-contact-tab" data-toggle="pill" href="#pills-contact"
									role="tab" aria-controls="pills-contact" aria-selected="false">법정공제내역</a>
								</li>
								<li class="nav-item itemNames"><a class="nav-link" id="pills-etc-tab"
									data-toggle="pill" href="#pills-etc" role="tab"
									aria-controls="pills-etc" aria-selected="false">기타공제내역</a></li>
							</ul>

							<div class="tab-content mb-1" id="pills-tabContent">
								<!-- ////////////// 법정공제내역 시작 //////////////////////////// -->
								<div class="tab-pane fade active show" id="pills-contact" role="tabpanel"
									aria-labelledby="pills-contact-tab">
								
									<div class="col-md-12 my-4">
					                  <div class="card shadow">
					                    <div class="card-body">
					                      <h5 class="card-title mb-3">대상자</h5>
					                      <table id="LawDedTable" class="table table-bordered table-hover mb-0">
					                        <thead>
					                          <tr>
					                            <th rowspan="2">사번</th>
					                            <th rowspan="2">이름</th>
					                            <th rowspan="2">과세총액</th>
					                            <th colspan="4">사대보험</th>
					                            <th colspan="2">원천세</th>
					                            <th rowspan="2">법정공제금액 합계</th>
					                          </tr>
					                          
					                          <tr>
					                          	<th>국민연금</th>
					                            <th>건강보험</th>
					                            <th>장기요양보험</th>
					                            <th>고용보험</th>
					                            <th>소득세</th>
					                            <th>지방소득세</th>
					                          </tr>
					                        </thead>
					                        
					                        <tbody>
					                          <c:forEach var="totalEmpDed" items="${totalEmpDedList}" varStatus="stat">	
						                          <tr>
						                            <td>${totalEmpDed[0].empNo}</td>
						                            <td>${totalEmpDed[0].empNm}</td>
						                          	<td><fmt:formatNumber value="${totalEmpDed[0].totalTaxAmt}" pattern="#,###" /></td>
						                            
						                            <!-- 각 사원의 합계를 계산하기 위해 totalLawDedAmt 변수 초기화 -->
      												<c:set var="totalLawDedAmt" value="0" />
						                            
						                            <c:forEach var="totalDedList" items="${totalEmpDed}" varStatus="status">
							                            <td><fmt:formatNumber value="${totalDedList.pdAmt}" pattern="#,###" /></td>
						                            	
						                            	<!-- 각 항목의 합계를 totalLawDedAmt에 누적 -->
						                            	<c:set var="totalLawDedAmt" value="${totalLawDedAmt + totalDedList.pdAmt}" />
						                          	</c:forEach>
						                          		
						                          		<td><strong id="total_${stat.index}"><fmt:formatNumber value="${totalLawDedAmt}" pattern="#,###" /></strong></td>
						                          </tr>
					                        	</c:forEach>
					                        </tbody>
					                        
					                      </table>
					                    </div>
					                  </div>
					                </div>	
								
								</div>
								<!-- ////////////// 법정공제내역 끝 //////////////////////////// -->
								<!-- ////////////// 기타공제내역 시작 //////////////////////////// -->
								<div class="tab-pane fade" id="pills-etc" role="tabpanel"
									aria-labelledby="pills-etc-tab">
								
								<div class="col-md-12 my-4">
					                  <div class="card shadow">
					                    <div class="card-body">
					                      <h5 class="card-title mb-3" style="display:inline-block">대상자</h5>
					                      <table id="OtherDedTable" class="table table-bordered table-hover mb-0">
					                        <thead>
					                          
					                          <tr>
					                            <th>사번</th>
					                            <th>이름</th>
					                          	
					                          <c:forEach var="pdVO" items="${OtherDedList}" varStatus="stat">	
					                          
					                            <th>${pdVO.pdNm}</th>
					                          
					                          </c:forEach>
					                          
<%-- 					                              <c:forEach var="pdVO" items="${}" varStatus="status"> --%>
<%-- 				                            	<th>${pdVO.pdNm}</th> --%>
<%-- 				                            </c:forEach> --%>
					                          
					                          	<th>기타공제금액 합계</th>
					                          </tr>
					                        </thead>
					                        
					                        <tbody>
					                        	<c:forEach var="odList" items="${totalOtherDedList}" varStatus="stat">
						                          <tr>
						                            <td>${odList[0].empNo}</td>
						                            <td>${odList[0].empNm}</td>
						                            
						                             <c:set var="totalPdAmt" value="0" /> <!-- totalPdAmt 초기화 -->
						                            
						                            <c:forEach var="payDedVO" items="${odList}" varStatus="status">
												     	<c:set var="totalPdAmt" value="${totalPdAmt + payDedVO.pdAmt}" />
												     	
												     	<td><input type="number" id="input_${status.index}" value="${payDedVO.pdAmt}" name="pdAmt" 
												     		onkeyup="updateTotal(this)"/></td>
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
								<!-- ////////////// 기타공제내역 끝 //////////////////////////// -->
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
// 	    const inputValue = parseInt($(pThis).val().replace(/,/g, '')) || 0;
	    
	    // 현재 행(tr)을 찾기
	    const currentRow = $(pThis).closest("tr");

	    // 현재 행에서 모든 input 요소를 찾아서 값을 합산
	    let totalAmount = 0;
	    currentRow.find("input[type='number']").each(function() {
// 	    	totalAmount += parseInt($(this).val().replace(/,/g, '')) || 0;
	        totalAmount += parseInt($(this).val()) || 0;
	    });
	    
		// 합산된 값을 totalAmt 요소에 설정
	    const totalAmtTD = currentRow.find("td:last strong");
// 	    totalAmtTD.html(totalAmount);
// 	    totalAmtTD.html(`<fmt:formatNumber value="${totalAmount}" pattern="#,###" />`);
	    totalAmtTD.text(totalAmount.toLocaleString()); // 숫자를 천단위 구분기호로 형식화하여 설정
// 	    let totalAmt = $(pThis).closest("tr").find("td:last")[0];
	    
// 	    console.log("totalAmount : ", totalAmount);
	    
	} //시간되면 숫자 한개씩 올렸을때 (onchange 함수도 걸어두기!!) (어차피 동시에 일어나는 일이 아님)

///////////////////////////////////////////////////////////////////////////////	
	
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	
	var ptNo = "${SCVO.ptNo}";
	var prYr = "${SCVO.prYr}";
	var prMth = "${SCVO.prMth}";
	
	var LDtrElements = $("#LawDedTable tbody tr");
	var ODtrElements = $("#OtherDedTable tbody tr");
	var LDthElements = $("#LawDedTable thead tr:eq(1)"); // 두 번째 <tr> 요소를 선택.
//	var LDthElements = $("#LawDedTable thead tr:eq(1)")[0]; (인덱스 대괄호에 담아야 jQuery박스 벗기고 내부에 있는 객체들의 값을 확인할 수 있음)
	
	
	var ODthElements = $("#OtherDedTable thead tr>th");
// 	var ODthElements = ODtrElements.find("th");
	
	console.log("ODtrElements : ", ODtrElements);
	console.log("ODthElements : ", ODthElements);
	
	// <th> 요소들을 선택하고 값을 배열에 저장.
	var LDthValues = [];
	LDthElements.find("th").each(function() {
		LDthValues.push($(this).text());
	});
	
	
	var ODthValues = []; //ODthValues
	for (var i = 2; i < ODthElements.length - 1; i++) {
		ODthValues.push(ODthElements.eq(i).text());
	}
	

	// thValues 배열에는 <th> 요소들의 텍스트 값이 담겨 있음.
// 	console.log("thValues : ", thValues);
	
// 	console.log("LDtrElements :", LDtrElements);
// 	console.log("ODtrElements :", ODtrElements);
// 	console.log("LDthElements :", LDthElements);
	console.log("ODthValues : ", ODthValues);
	
//////////////////////////////////////////////////////////////////////////////////	
	function wageDedAjax(){ //버튼 클릭시 ajax로 데이터 보내기 (insert 수행)
		
		// 결과를 저장할 배열 초기화
		var LDdataArrays = [];
		var ODdataArrays = [];
		
		///////////////////////////////////////////////
        
		// 각 <tr> 요소에 대한 루프
		LDtrElements.each(function(idx, item){ 

			// 현재 <tr> 요소 내의 <td> 요소들을 선택.
		    var tdElements = $(item).find("td");
// 			console.log("tdElements : ", tdElements);
		    
		    // 각 <td> 요소의 텍스트 값을 추출하여 저장할 배열 초기화
		    var rowData = [];

		    // <td> 요소들의 텍스트 값을 배열에 담습니다.
		    for(let i=3; i<tdElements.length-1; i++){
// 		    	console.log("tdElements[i] : ", $(tdElements[i]).text().replace(/,/g, ''));
		    	rowData.push(parseInt($(tdElements[i]).text().replace(/,/g, ''))); // rowData 배열의 각 요소에서 쉼표를 제거하고 숫자로 변환하여 새로운 배열에 담습니다.
		    }//for끝
		    
// 		    console.log("rowData : ", rowData);
		  	
		    // 결과 배열에 현재 행의 데이터 배열을 추가합니다.
		    LDdataArrays.push(rowData);

			// 결과 데이터 배열을 확인합니다.
// 			console.log(LDdataArrays);
			
		});	
		
		//법정공제항목  
		LDtrElements.each(function(idx){
			
			var empNo = $(this).find("td:eq(0)").text(); // 각 <tr>에서 첫 번째 <td>의 텍스트를 가져옴.
// 			console.log("empNo : ", empNo);
			
			var LdAmtArray = LDdataArrays[idx];
// 			console.log("LdAmtArray : ", LdAmtArray);
			
			//pdNm, pdAmt 추출
			for(let i=0; i<LdAmtArray.length; i++){
				var pdNm = LDthValues[i];
				var pdAmt = LdAmtArray[i];
				
// 				console.log("pdNm : ", pdNm);
// 				console.log("pdAmt : ", pdAmt);
			
				var data = {
							"pdNm" : pdNm,
							"empNo" : empNo,
							"ptNo" : ptNo,
							"prYr" : prYr,
							"prMth" : prMth,
							"pdAmt" : pdAmt
							};
				console.log("data : ", data);
			
				//법정공제항목 insert
				$.ajax({
					url:"/salary/insertWageDed",
					async : false, //비동기 해제 (동기로 바꿈)
					contentType:"application/json;charset=UTF-8",
					data:JSON.stringify(data),
					type:"post",
					dataType:"text",
					beforeSend: function(xhr) {
			            xhr.setRequestHeader(header, token);
			    	},
					success:function(result){
						console.log("result : ", result);
						
					},
					error:function(xhr, status, error){
					    console.log("code: " + xhr.status)
					    console.log("message: " + xhr.responseText)
					    console.log("error: " + error);
					}
				});//ajax끝
				
				
			};//for 끝
			
		});//법정공제항목 끝
		
		/////////////////////////////////////////////////////
		
		// 기타공제항목 각 <tr> 요소에 대한 루프
		ODtrElements.each(function(idx, item){ 
			
			console.log("item : ", item);
		    // 현재 <tr> 요소 내의 <td> 요소들을 선택.
		    var ODtdElements = $(item).find("td");
			console.log("ODtdElements : ", ODtdElements);
		    
		    // 각 <td> 요소의 텍스트 값을 추출하여 저장할 배열 초기화
		    var rowData = [];

		    // <td> 요소들의 텍스트 값을 배열에 담습니다.
		    for(let i=2; i<ODtdElements.length-1; i++){
		    	console.log("pppp",$(ODtdElements[i]).children().eq(0).val());
		    	console.log("ODtdElements[i] : ",ODtdElements[i].children[0].value); //.value = 문자열
		    	rowData.push( parseInt(ODtdElements[i].children[0].value) ); // rowData 배열의 각 요소에서 쉼표를 제거하고 숫자로 변환하여 새로운 배열에 담음.
		    }//for끝
		    
		    console.log("rowData2 : ", rowData);
		  	
		    // 결과 배열에 현재 행의 데이터 배열을 추가합니다.
		    ODdataArrays.push(rowData);

			// 결과 데이터 배열을 확인합니다.
			console.log("ODdataArrays : ", ODdataArrays);
			
		});	
		
			//기타공제항목  
			ODtrElements.each(function(idx){
				
				var empNo = $(this).find("td:eq(0)").text(); // 각 <tr>에서 첫 번째 <td>의 텍스트를 가져옴.
				console.log("empNo : ", empNo);
				
				var OdAmtArray = ODdataArrays[idx];
				console.log("OdAmtArray : ", OdAmtArray);
				
				//pdNm, pdAmt 추출
				for(let i=0; i<OdAmtArray.length; i++){
					var pdNm = ODthValues[i];
					var pdAmt = OdAmtArray[i];
					
					console.log("pdNm : ", pdNm);
					console.log("pdAmt : ", pdAmt);
				
					var data = {
								"pdNm" : pdNm,
								"empNo" : empNo,
								"ptNo" : ptNo,
								"prYr" : prYr,
								"prMth" : prMth,
								"pdAmt" : pdAmt
								};
					console.log("data : ", data);
				
					//기타공제항목 insert
					$.ajax({
						url:"/salary/insertWageDed",
						contentType:"application/json;charset=UTF-8",
						async : false,
						data:JSON.stringify(data),
						type:"post",
						dataType:"text",
						beforeSend: function(xhr) {
				            xhr.setRequestHeader(header, token);
				    	},
						success:function(result){
							console.log("result : ", result);
							
						},
						error:function(xhr, status, error){
						    console.log("code: " + xhr.status)
						    console.log("message: " + xhr.responseText)
						    console.log("error: " + error);
						}
					});//ajax끝
					
				};//for 끝
				
			});//기타공제항목 끝
			
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
			        location.href = "/salary/wagePrev";
	            });
	    	
		
	}//전체 function 끝
</script>


</body>
</html>