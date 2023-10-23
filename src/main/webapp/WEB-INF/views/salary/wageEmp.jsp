<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>    
<style>
	div {
/*   		border : 1px solid blue;   */
	}
	#steps {
 		display : flex; 
 		height : 900px;
	}
	
	.step {
		display : flex;
		margin-bottom : 15px;
		margin-top : 15px;
	}
	
	#Aside {
/* 		border : 1px solid red; */
		margin : 0px;
	}
	#Bside {
/* 		border : 1px solid red; */
	}
	#scroll {
		height : 800px;
		overflow-y: auto; /* 세로 스크롤 활성화 */
	}
	 .icon {
    	background-image : url(/resources/images/salary/search-magnifier.png);
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

    /* 테이블 헤더 스타일 지정 */
    th {
        background-color: #f2f2f2;
        text-align: center;
        padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
        border: 1px solid #ddd; /* 테두리 스타일 지정 */
        height : 30px;
        color : black;
    }

    /* 테이블 데이터 셀 스타일 지정 */
    td {
        text-align: center;
        padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
        border: 1px solid #ddd; /* 테두리 스타일 지정 */
        color : black;
    }
</style>
<meta charset="UTF-8">
<title>정산 대상자 설정</title>
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
						<img class="mt-2" src="/resources/images/salary/team.png">
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
	
	<div id="Bside" style="width:80%;">
	    	<div class="row justify-content-center">
	        	<div class="col-12" style="margin-left:0px;margin-right:0px;margin-bottom: 10px;">
	            	<p class="card-text">${ptNm} / <strong>${SCVO.prStlNm}</strong></p>
	                <h2 class="mb-2 page-title" style="display:inline-block">정산대상자</h2>
	                <button id="payButton" onclick="payItem()"  type="button" class="btn btn-success" style="float:right;color:white;">→ 지급항목</button>
	            </div>  
	
					<div class="row" id="scroll" style="margin-left:3px;">
						<!-- Small table -->
						<div class="col-md-12">
							<div class="card shadow">
								<div class="card-body">
									<form id="empForm">
										<!-- table -->
										<div id="dataTable-1_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
											<div id="haha" class="row">
												<div style="width:30%">
													<div class="dataTables_length" id="dataTable-1_length">
														<label style="margin-left:20px;">
															Size
															<select id="pageSize" name="dataTable-1_length" aria-controls="dataTable-1" class="custom-select custom-select-sm form-control form-control-sm" onChange="fPage()">
																<option value="10">10</option>
																<option value="15">15</option>
																<option value="30">30</option>
																<option value="50">50</option>
																<option value="100">100</option>
															</select>
														</label>
													</div>
												</div>
												<div style="display:flex;justify-content:flex-end;">
													<div style="padding-top:10px;margin-left:900px;">
							                            <select class="form-control" style="height: calc(1.5em + 0.5rem + 2px);width:100px;" name="condition" id="condition">
							                            	<option value="">전체</option> <!-- value="${param.keyword}" -->
							                                <option value="empNo">사번</option>
							                                <option value="empNm">이름</option>
							                                <option value="dnm">부서명</option>
							                                <option value="ptnCodeNm">직위</option>
							                            </select>
													</div>
													<div style="padding-top:10px;margin-left:10px;margin-bottom:10px;">
														<input type="text" class="form-control" style="height: calc(1.5em + 0.5rem + 2px);width:200px;" 
														name="keyword" id="keyword" value="" required />
													</div>
													<div style="margin-left:10px;padding-top:10px;">
														<button type="button" id="searchButton" class="btn btn-primary btn-icon-split btn-sm">
										                	<span class="text">검색</span>
									                    </button>
								                    </div>
								               </div>     
											</div>	
										</div>
										
									</form>
										<div class="row">
											<div class="col-sm-12" id="empList"> <!-- Ajax 리스트 table 삽입될 부분 -->
						                        	
											</div>	
										</div>
					
										<div class="row">
											<div class="col-sm-12 col-md-5">
										    	<div id="showInfo" class="dataTables_info" id="dataTable-1_info" role="status" aria-live="polite">
<!-- 										      		Showing 1 to 16 of 63 entries -->
										    	</div>
											</div>
											<div class="col-sm-12 col-md-7">
												<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
												    <ul class="pagination">
												    	
										        	</ul>
												</div>
											</div>
										</div>
								</div>
							</div>
						</div><!-- .col-md-12 -->
						<!-- simple table -->
					</div> <!-- .row -->
						
			</div><!-- .row -->
				
			
	</div><!-- bside -->
						
</div> <!-- steps -->

<script>

	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	const $page = $(".pagination");
	//페이지 로드되자마자 실행
	function ajaxExec(pCurPage){
		
		let	pageVO  = {
	            total:0,
	            pageSize:$("#pageSize").val(),
	            pageCnt:0,
	            currentPage:pCurPage       
	        }
		
		console.log("pageVO는 나오낭??", pageVO);
		
		$.ajax({
		    type : "post",
	 		url : "/salary/wageEmpListAjax",
		    contentType:"application/json;charset=UTF-8",
		    data: JSON.stringify(pageVO),
		    dataType : "json",
		    beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	    	},
		    success : function (data){
	      		console.log("data : ", data);
	      		
	      		let pageCnt =  Math.ceil(data.total / pageVO.pageSize);
                let pageData = data.pageData;
	
                console.log("pageCnt : ", pageCnt);
                console.log("pageData : ", pageData);
                
			      // 서버에서 받은 데이터를 처리하는 부분
			      // HTML 테이블 생성 및 데이터 추가
				    var table = "";
					
			      	table += `
			      	
			      		<table class="table datatables dataTable no-footer" id="dataTable-1" role="grid" aria-describedby="dataTable-1_info" border="1">
		      				<thead>
                        	<tr role="row">
	                        	<th></th>
		                        <th style="width: 30;color:black;white-space: nowrap;">번호</th>
		                        <th style="width: 142.766px;color:black;white-space: nowrap;">사번</th>
		                        <th style="width: 110.312px;color:black;white-space: nowrap;">이름</th>
		                        <th style="width: 120px;color:black;white-space: nowrap;">입사일</th>
		                        <th style="width: 95.5625px;color:black;white-space: nowrap;">재직여부</th>
		                        <th style="width: 100px;color:black;white-space: nowrap;">생년월일</th>
		                        <th style="width: 136.766px;color:black;white-space: nowrap;">근로유형</th>
		                        <th style="width: 200px;color:black;white-space: nowrap;">부서명</th>
		                        <th style="width: 100px;color:black;white-space: nowrap;">직위</th>
	                    	</tr>
                        </thead>
                        <tbody>
			      	`;
			      
			                      
	//                       $.each(pageData, function(idx, test){
		            			for (var i = 0; i < pageData.length; i++) { 
		            				
		            				let test = pageData[i];
		            				console.log("kgb",test);
		            				let idx = i;
		            				
		            				// Date 객체 생성 (여기서는 test.entDate를 밀리초로 가정합니다)
		            			    var date = new Date(test.entDate);

		            			    // 원하는 형식으로 날짜를 문자열로 변환
		            			    var formattedDate = date.getFullYear() + '-' + 
		            			                        ('0' + (date.getMonth() + 1)).slice(-2) + '-' + 
		            			                        ('0' + date.getDate()).slice(-2);

		            			    // 결과 출력
		            			    console.log("Formatted Date: " + formattedDate);

		            				
		            				// 결과 출력
		            				console.log("Formatted Date: " + formattedDate);
		            				
		            				table += `
						         				<tr role="row">
							                       	<td>
							                          <div class="custom-control custom-checkbox">
							                            <input type="checkbox" class="custom-control-input" name="checkedEmpNo" id="\${idx+1}">
							                            <label class="custom-control-label" for="\${idx+1}"></label>
							                          </div>
							                       	</td>
							                        <td>\${test.rnum}</td>
							                        <td>\${test.empNo}</td>
							                        <td>\${test.empNm}</td>
							                        <td>\${formattedDate}</td>
							                        <td>\${test.stClfCdNm}</td>
							                        <td>\${test.empBrdt}</td>
							                        <td>\${test.ctrtCaseNm}</td>
							                        <td>\${test.deptVOList.dnm}</td>
							                        <td>\${test.ptnCodeNm}</td>
							                   	</tr>`;
	                    		} //for끝
								// });	//jQuery for문 쓸때는 있어야함.		 
			           
					  table += `
						  		</tbody>
                			</table>
					  `;		
					  
			          // 생성한 테이블을 페이지의 특정 div에 추가
			          $('#empList').html(table);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		console.log("data : ", data);
		console.log("startPage : " + data.startPage);
		console.log("endPage : " + data.endPage);
		console.log("total : " + data.total);
						
					 //바닥부분 - 페이지 글갯수 표시
			          var cont = `Showing \${data.startPage} to \${data.endPage} of \${data.total} entries`;
			          
			          $("#showInfo").html(cont);
			          
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			        
			  		let pageHtml = "";
        
        			console.log("startPage : ${startPage}");
        			console.log("endPage : ${endPage}");
			  		

			  		// 페이지 번호 목록 추가
			  		for (let i = 1; i <= pageCnt; i++) {
			  		    if (i == pCurPage) {
			  		        pageHtml += `
			  		            <li class="paginate_button page-item active">
			  		                <a href="#" aria-controls="dataTable-1" data-dt-idx="\${i}" tabindex="0" class="page-link" onclick=fPage(\${i}) > \${i}</a>
			  		            </li>
			  		        `;
			  		    } else {
			  		        pageHtml += `
			  		            <li class="paginate_button page-item">
			  		                <a href="#" aria-controls="dataTable-1" data-dt-idx="\${i}" tabindex="0" class="page-link" onclick=fPage(\${i}) > \${i}</a>
			  		            </li>
			  		        `;
			  		    }
			  		}


			  		// $page에 페이지 번호 목록을 추가
			  		$page.html(pageHtml);
		   		},
			    error:function(xhr, status, error){
			    console.log("code: " + xhr.status)
			    console.log("message: " + xhr.responseText)
			    console.log("error: " + error);
				}
			});
	}//ajax 끝
	
	ajaxExec(1); // 처음 실행할 때는 1페이지
	
	function fPage(pPageNum) {
        event.preventDefault(); //a태그 경로이동 기능 막기
        if(!pPageNum){
            pPageNum = 1;
        }
        ajaxExec(pPageNum);
    }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//부분 검색
	//페이지 로드되자마자 실행
	function ajaxSearchExec(pCurPage,condition,keyword){
		
		let	pageVO  = {
	            "total":0,
	            "pageSize":$("#pageSize").val(),
	            "pageCnt":0,
	            "currentPage":pCurPage,
	            "condition":condition,
	            "keyword":keyword
	        }
		
		console.log("pageVO는 나오낭??", pageVO);
		
		$.ajax({
		    type : "post",
	 		url : "/salary/wageEmpListAjax",
		    contentType:"application/json;charset=UTF-8",
		    data: JSON.stringify(pageVO),
		    dataType : "json",
		    beforeSend: function(xhr) {
	            xhr.setRequestHeader(header, token);
	    	},
		    success : function (data){
	      		console.log("data : ", data);
	      		
	      		let pageCnt =  Math.ceil(data.total / pageVO.pageSize);
                let pageData = data.pageData;
	
                console.log("pageCnt : ", pageCnt);
                console.log("pageData : ", pageData);
                
			      // 서버에서 받은 데이터를 처리하는 부분
			      // HTML 테이블 생성 및 데이터 추가
				    var table = "";
					
			      	table += `
			      	
			      		<table class="table datatables dataTable no-footer" id="dataTable-1" role="grid" aria-describedby="dataTable-1_info" border="1">
		      				<thead>
                        	<tr role="row">
                        	<th></th>
	                        <th style="width: 30;color:black;white-space: nowrap;">번호</th>
	                        <th style="width: 142.766px;color:black;white-space: nowrap;">사번</th>
	                        <th style="width: 110.312px;color:black;white-space: nowrap;">이름</th>
	                        <th style="width: 120px;color:black;white-space: nowrap;">입사일</th>
	                        <th style="width: 95.5625px;color:black;white-space: nowrap;">재직여부</th>
	                        <th style="width: 100px;color:black;white-space: nowrap;">생년월일</th>
	                        <th style="width: 136.766px;color:black;white-space: nowrap;">근로유형</th>
	                        <th style="width: 200px;color:black;white-space: nowrap;">부서명</th>
	                        <th style="width: 100px;color:black;white-space: nowrap;">직위</th>
	                    	</tr>
                        </thead>
                        <tbody>
			      	`;
			      
			                      
	//                       $.each(pageData, function(idx, test){
		            			for (var i = 0; i < pageData.length; i++) { 
		            				
		            				let test = pageData[i];
		            				console.log("kgb",test);
		            				let idx = i;
		            				
		            				// Date 객체 생성 (여기서는 test.entDate를 밀리초로 가정합니다)
		            			    var date = new Date(test.entDate);

		            			    // 원하는 형식으로 날짜를 문자열로 변환
		            			    var formattedDate = date.getFullYear() + '-' + 
		            			                        ('0' + (date.getMonth() + 1)).slice(-2) + '-' + 
		            			                        ('0' + date.getDate()).slice(-2);

		            			    // 결과 출력
		            			    console.log("Formatted Date: " + formattedDate);

		            				
		            				// 결과 출력
		            				console.log("Formatted Date: " + formattedDate);
		            				
		            				table += `
						         				<tr role="row">
							                       	<td>
							                          <div class="custom-control custom-checkbox">
							                            <input type="checkbox" class="custom-control-input" name="checkedEmpNo" id="\${idx+1}">
							                            <label class="custom-control-label" for="\${idx+1}"></label>
							                          </div>
							                       	</td>
							                        <td>\${test.rnum}</td>
							                        <td>\${test.empNo}</td>
							                        <td>\${test.empNm}</td>
							                        <td>\${formattedDate}</td>
							                        <td>\${test.stClfCdNm}</td>
							                        <td>\${test.empBrdt}</td>
							                        <td>\${test.ctrtCaseNm}</td>
							                        <td>\${test.deptVOList.dnm}</td>
							                        <td>\${test.ptnCodeNm}</td>
							                   	</tr>`;
	                    		} //for끝
								// });	//jQuery for문 쓸때는 있어야함.		 
			           
					  table += `
						  		</tbody>
                			</table>
					  `;		
					  
			          // 생성한 테이블을 페이지의 특정 div에 추가
			          $('#empList').html(table);
					
        ////////////////////////////////////////////////////////////////////////////
			        
			  		let pageHtml = "";
        
//         			console.log("startPage :" + ${startPage});
//         			console.log("endPage :" + ${endPage});
			  		

			  		// 페이지 번호 목록 추가
			  		for (let i = 1; i <= pageCnt; i++) {
			  		    if (i == pCurPage) {
			  		        pageHtml += `
			  		            <li class="paginate_button page-item active">
			  		                <a href="#" aria-controls="dataTable-1" data-dt-idx="\${i}" tabindex="0" class="page-link" onclick=fPage(\${i}) > \${i}</a>
			  		            </li>
			  		        `;
			  		    } else {
			  		        pageHtml += `
			  		            <li class="paginate_button page-item">
			  		                <a href="#" aria-controls="dataTable-1" data-dt-idx="\${i}" tabindex="0" class="page-link" onclick=fPage(\${i}) > \${i}</a>
			  		            </li>
			  		        `;
			  		    }
			  		}


			  		// $page에 페이지 번호 목록을 추가
			  		$page.html(pageHtml);
		   		},
			    error:function(xhr, status, error){
			    console.log("code: " + xhr.status)
			    console.log("message: " + xhr.responseText)
			    console.log("error: " + error);
				}
			});
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////
</script>

<script type="text/javascript">
$(function(){
	$("#searchButton").on("click",function(){ //검색 버튼 클릭시 - 부분검색 함수 실행
			
		let condition = $("#condition").val();
		let keyword = $("#keyword").val();
		
		console.log("condition : " + condition + ", keyword : " + keyword);
		
		ajaxSearchExec(1,condition,keyword); //부분검색 함수
	});
	
	
});//$ function끝

// $(document).ready(function() {
// 	$("#keyword").on("keydown", function(event) {
// 	    // 입력 필드에서 엔터 키를 누를 때 검색 함수 실행
// 	    if (event.key === "Enter" || event.keyCode === 13) {
// 	        let condition = $("#condition").val();
// 	        let keyword = $("#keyword").val();
	           
// 	        ajaxSearchExec(1, condition, keyword);
// 	    }
// 	});
// })
///////////////////////////////////////////////////////////////////////////////////////////////////

function payItem(){

	let arrSabun = [];
	 $("[name=checkedEmpNo]:checked").each(function(index, item){
		    //console.log("체킁:",$(item).closest("tr").children().eq(2).html());
			arrSabun.push($(item).closest("tr").children().eq(2).html());
	 });

    console.log("보낼 배열:",arrSabun); //(3) ['201202021', '202101019', '202103311'] //배열 안에 들어있는 값들 string

	$.ajax({
		url:"/salary/checkedEmpList",
		contentType:"application/json;charset=UTF-8",
		data: JSON.stringify(arrSabun), //자바스크립트객체를 자바 스트링으로 보냄 (직렬화)
		dataType:"text",
		type:"post",
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token);
    	},
		success:function(data){
			console.log("data:", data);
			
			if(data == "success"){
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
				      title: '정산대상자 목록이 확정되었습니다.'
				    }).then(function () {
		                // 토스트가 보여진 후 이동할 URL 설정
		                location.href = "/salary/wagePay";
		            });
				
			} else if (data == "fail") {
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
				      icon: 'error',
				      title: '정산대상자 목록 등록 실패'
				    })
				
			}
		},
		error:function(xhr, status, error){
		    console.log("code: " + xhr.status)
		    console.log("message: " + xhr.responseText)
		    console.log("error: " + error);
		}
		
	});

}
</script>
</body>
</html>