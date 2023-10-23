<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
    #header3{
    	padding: 10px;
    }
    
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
    	 .th {
	        background-color: #f2f2f2;
	        text-align: center;
	        padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
	        border: 1px solid #ddd; /* 테두리 스타일 지정 */
	        height : 30px;
	    }
	
	    /* 테이블 데이터 셀 스타일 지정 */
	    .td {
	        text-align: center;
	        padding: 10px; /* 셀 안의 내용과 셀 경계 사이의 간격 */
	        border: 1px solid #ddd; /* 테두리 스타일 지정 */
	        height: 20px;
	    }

	.mainBtn {
	background: linear-gradient(to right, #3783C6, #39A4C5);
	border-radius: 10px;
	padding: 10px 20px;
	color: white;
	border: none;
	font-weight: 900;
	margin-bottom: 15px;
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
	
</style>

</head>
<body>
        <div id="header1">
           
            <div id="header2">
            	<div style="margin-left:25px;">
            		<div id="header3">
		           		<a href="/personnel/emp"> <!-- "사원" 링크에 href 속성 추가 -->
							<h1 style="color: #CDD1D5;">사원</h1>
						</a>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<div id="header3">
						<a href="/personnel/Appointments"> <!-- "인사발령" 링크에 href 속성 추가 -->
							<h1>인사발령</h1>
						</a>
					</div>
				</div>
				
				
				<!-- 모달 중앙 -->

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
<div class="card shadow">
	<div class="card-body">

		<div>
			<input type="hidden" name="Apromotion" value="${promotion }">
			<!-- 발령라벨 -->
			<input type="hidden" name="Adate" value="${date}">
			<!-- 발령일 -->
			<input type="hidden" name="note" value="${note}">
			<!-- 메모 -->
			<input type="hidden" name="rsn" value="${rsn}">
			<!-- 메모 -->
			<input type="hidden" name="WempNo" value="${empNo}">
			<!-- 작성자 사원번호 -->
		</div>
		
		<h3>발령 대상 선택</h3>
		
		<!-- table -->
		<table id="allTable" class="table table-borderless table-hover">
			<thead>
				<tr>
					<th class="th">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" onclick="selectAll(this)"
								class="custom-control-input" id="all2"> <label
								class="custom-control-label" for="all2"></label>
						</div>
					</th>
					<th class="th"><strong>프로필</strong></th>
					<th class="th"><strong>이름</strong></th>
					<th class="th"><strong>본부</strong></th>
					<th class="th"><strong>부서</strong></th>
					<th class="th"><strong>팀</strong></th>
					<th class="th"><strong>조직</strong></th>
					<th class="th"><strong>직책</strong></th>
					<th class="th"><strong>직위</strong></th>
					<th class="th"><strong>직급</strong></th>
				</tr>
			</thead>

			<c:forEach var="memberList" items="${memberList }" varStatus="start">

				<tbody>
					<tr >
						<td class="td">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" name="checkbox"
									class="custom-control-input" id="box${start.index }">
								<label class="custom-control-label" for="box${start.index }"></label>
							</div>
						</td>
						<td class="td">
							<div class="avatar avatar-md">
								<img src="${memberList.empImg }" alt="..." onerror="this.src='/resources/images/insight-basic50x50.png'"
									>
							</div>
						</td>
						<td class="td">
							<p class="mb-0 text-muted">
								<strong>${memberList.empNm }</strong>
							</p> <small class="mb-0 text-muted">${memberList.empNo }</small>
						</td>



						<td class="td">
							<!-- 본부 -->
							
							<div class="form-group mb-3">
								<select class="form-control" id="selectAcenter${start.index }" onchange="fCenter(this)">
									<option value="0">선택안함</option>
									<c:forEach var="Acenterlist" items="${Acenterlist}"
										varStatus="start2">
										<option value="${Acenterlist.dcode }">${Acenterlist.dnm }</option>
									</c:forEach>
								</select>
							</div>
						</td>

						<td class="td">
							<!-- 부서 -->
							<div class="form-group mb-3">
								<select class="form-control" id="selectBcenter${start.index }" onchange="fdept(this)">
									<option value="0">선택안함</option>									

								</select>
							</div>
						</td>

						<td class="td">
							<!-- 팀 -->
							<div class="form-group mb-3">
								<select class="form-control" id="selectCcenter${start.index }" onchange="fteam(this)">
									<option value="0">선택안함</option>

								</select>
							</div>
						</td>
						<td class="td">
							<!-- 조직--> <!-- 모달 중앙 -->
							<div class="form-group mb-3">
							<select class="form-control" id="job${start.index }">
								<c:forEach var="job" items="${jobList }">
									<option >${job.cmNm }</option>
								</c:forEach>
							</select>
							</div>

						</td>
						<td class="td">
							<!-- 직책 --> <!-- 모달 중앙 -->
							<div class="form-group mb-3">
							<select class="form-control" id="position${start.index }">
								<c:forEach var="positionList" items="${positionList }">
									<option >${positionList.cmNm }</option>
								</c:forEach>
							</select>
							</div>
						</td>
						<!-- 직책,조직장 -->
						<td class="td">
							<!-- 직위 -->
							<div class="form-group mb-3">
								<select class="form-control" id="spot${start.index }">
								<c:forEach var="spot" items="${spotList}">
									<option value="${spot.cmCode}">${spot.cmNm }</option>
								</c:forEach>
									

								</select>
							</div>
						</td>
						<td class="td">
							<!-- 직급 -->
							<div class="form-group mb-3">
								<select class="form-control" id="hobong${start.index }">
									<c:forEach var="hobong" items="${hobongList}">
										<option value="${hobong.cmCode}">${hobong.cmNm }</option>
									</c:forEach>
									
								</select>
							</div>
						</td>
					</tr>

				</tbody>

			</c:forEach>

		</table>
<!-- 		<nav aria-label="Table Paging" class="mb-0 text-muted">
			<ul class="pagination justify-content-center mb-0">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item active"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</ul>
		</nav> -->
		<button type="button"  id="idSend" class="mainBtn" style="float: right;">발령하기</button>
		<input type="button" class="auto" onclick="fill()" value="자동채우기" style="float: right; margin-right: 5px;">
		
		        <nav aria-label="Table Paging" class="my-3" ">
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


	<script type="text/javascript">
	function fill(){
		console.log("채우기@$$")
		$("#box0").attr('checked', true);
		$("#box1").attr('checked', true);
		$("#box2").attr('checked', true);
		
		$("#selectAcenter0").val("1").trigger('change');
		$("#selectAcenter1").val("1").trigger('change');
		$("#selectAcenter2").val("2").trigger('change');
		
		
		
		fill2();

		}
	function fill2(){
		$("#selectBcenter0").val("11").trigger('change');
		$("#selectBcenter1").val("11").trigger('change');
		$("#selectBcenter2").val("22").trigger('change');
		fill3();
	}
	
	function fill3(){
		$("#selectCcenter0").val("111").trigger('change');
		$("#selectCcenter1").val("111").trigger('change');
		$("#selectCcenter2").val("221").trigger('change');
		
		fill4();
	}
	
	function fill4(){
		$("#job0").val("개발")
		$("#job1").val("개발")
		$("#job2").val("영업")
		
		$("#position0").val("팀원")
		$("#position1").val("팀원")
		$("#position2").val("팀원")
		
		$("#spot0").val("A0101")
		$("#spot1").val("A0101")
		$("#spot2").val("A0101")
		
		$("#hobong0").val("A0501")
		$("#hobong1").val("A0501")
		$("#hobong2").val("A0501")
		
		
		
	}

	//본부 선택시 변경
	function fCenter(pThis){
		
		var tr = $(pThis).closest("tr");
		var Anum = tr.find("td:eq(3) select");
		var Anum2 = tr.find("td:eq(4) select");
		var Anum3 = tr.find("td:eq(5) select");
	
		var url = "/personnel/pDpm/"+Anum.val();
			 $.ajax({
					type: "get",
					url: url,
					dataType:"json",
					async : false,
					success: function (suc){
						
		 				console.log("성공" + JSON.stringify(suc));
		 				Anum2.empty();
		 				Anum3.empty();
		 				
	 	 				    Anum2.append(`<option value="0" >선택안함</option>`);
	 	 				    Anum3.append(`<option value="0" >선택안함</option>`);
		 				for (i = 0; i < suc.length; i++) {
		 				    var dcode = suc[i].dcode; 
		 				    var dnm = suc[i].dnm;     

	 	 				    Anum2.append(`<option value="\${dcode}">\${dnm}</option>`);
		 				}
		 				
		 				
		 				
					},
					error:function(request,status,error){
					  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				})
		
	}
	//
	//
	//
	//부서 선택시 변경
	function fdept(pThis){
		var tr = $(pThis).closest("tr");
		var Anum2 = tr.find("td:eq(4) select");
		var Anum3 = tr.find("td:eq(5) select");
		
		
	
		var url = "/personnel/pDpm2/"+Anum2.val();
		
		 $.ajax({
				type: "get",
				url: url,
				dataType:"json",
				async : false,
				success: function (suc){
					console.log("성공" + JSON.stringify(suc));
					Anum3.empty();	
					Anum3.append(`<option value="0">선택안함</option>`);
	 				for (i = 0; i < suc.length; i++) {
	 				    var dcode = suc[i].dcode; 
	 				    var dnm = suc[i].dnm;     
	 				    
	 				    console.log("ff " + dcode )
	 				    console.log("ff " + dnm )

 	 				    Anum3.append(`<option value="\${dcode}">\${dnm}</option>`);
	 				}
					
					
				},
				error:function(request,status,error){
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
	}
	//
	//
	//
	//팀 선택시 변경
	function fteam(pThis){
		var tr = $(pThis).closest("tr");
		var Anum3 = tr.find("td:eq(5) select").val();
		
		console.log("dd" + Anum3);
	
		var url = "/personnel/pDpm2/"+Anum3;
		
		 $.ajax({
				type: "get",
				url: url,
				async : false,
				success: function (suc){
	 				console.log("성공" + suc);
					
				},
				error:function(request,status,error){
				  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			})
	}
	
	



	//모달
	let pNum = null;
	
	function fModal(pThis){
		pNum = pThis;
	}
	
	function closeModal() {
	    $('#defaultModal').modal('hide'); // 모달 닫기
	}
	
	//조직장 설정
// 	$(function(){
// 		$("#depthead").change(function(){
// 			if($("#depthead").is(":checked")){
				
// 				$("#depthead").val("조직장");
				
// 			}else{
// 				$("#depthead").val("");
// 			}
// 		})
// 	})
	
	// 모달창 설정 누르면
	function fSet(){
		console.log("ㅇㅇ?")
		
	    const first = document.querySelector("#selectOne");
	    const second = document.querySelector("#selectTwo");
// 	    const depthead = document.querySelector("#depthead");
	      
	    
	        groupValue = first.value+","+second.value;
// 	    if (depthead === null || depthead.value === "") {
// 	        groupValue = first.value+","+second.value;
	        
// 	    } else {
// 	        groupValue =first.value+"," + second.value + "," + depthead.value;
// 	    }
	    
	    pNum.parentElement.children[0].innerHTML = groupValue;
	    
	    closeModal();
		
	}
	
	
	
	//체크박스 전부선택
	function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('checkbox');
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  });
	}
	
	////////////////////////////// 체크박스 처리 시작 //////////////////////////////////////
	$("#idSend").on("click", function () {
		
		
	  var rowData = [];
	
	  var checkboxes = $("input[name=checkbox]:checked");
	  
	  console.log("체크박스 쳌" , checkboxes)
	  if(checkboxes.length==0){
		  Swal.fire({
              title: "인원을 선택하세요",
                text: "",
                icon: "error",
                confirmButtonText: "확인"
            }).then(function() {

            });
		  
	  }
	  
// 	  if(checkboxes.length === $("input[name=checkbox]").length){
// 		 alert("하하");
// 	 	 var filteredCheckboxes = checkboxes.not(':eq(0)');
// 	  }
	  
	
	  checkboxes.each(function () {
		//작성자 정보

           
//         var WempNn = $('input[name=WempNm]').val();
        var WempNo = $('input[name=WempNo]').val();
        var Apromotion = $('input[name=Apromotion]').val();
        var Adate = $('input[name=Adate]').val();
        var note = $('input[name=note]').val();
        var rsn = $('input[name=rsn]').val();
          
		//발령자 정보들  
	    var tr = $(this).closest("tr");
	
	    var EMP_IMG = tr.find("td:eq(1) img").attr("src");
	    var EMP_NM = tr.find("td:eq(2) strong").text();
	    var EMP_NO = tr.find("td:eq(2) small").text();
	    var acenter = tr.find("td:eq(3) select").val();
	    var DDCODE = tr.find("td:eq(4) select").val();//부서코드
	    var TEAM = tr.find("td:eq(5) select").val();
	    var PTN_CODE = tr.find("td:eq(8) select").val();
	    var GRD_CODE = tr.find("td:eq(9) select").val();
	    var sum;
	    var JCODE = tr.find("td:eq(6) select").val();//직무  //sum 에서 가져오기
	    var DTCODE = tr.find("td:eq(7) select").val();;
// 	    var head;
	    var DCODE;
	    



	    
	    if(DDCODE =="0"){
	    	DCODE = acenter;
	    } else if(TEAM =="0"){
	    	DCODE = DDCODE;
	    }else{
	    	DCODE = TEAM;
	    }
	    
	    
	    console.log("DD "+ JCODE);
	    console.log("FF "+DTCODE);
	    
// 	    if (sum.includes(",조직장")) {
// 	    	head = "Y";
// 	    	} else {
// 	    		head = "N";
// 	    	}
	    
	    var rowDataItem = {
	      EMP_IMG: EMP_IMG, //발령 프로필
	      EMP_NM: EMP_NM, //발령자 이름
	      EMP_NO: EMP_NO, //발령자 사원번호
	      DCODE: DCODE, //부서코드
	      JCODE: JCODE, //직무코드
	      PTN_CODE: PTN_CODE, //직채
	      DTCODE: DTCODE,  //직책코드
	      GRD_CODE: GRD_CODE, //직급코드
// 	      head : head, //조직장 여부
	      WempNo : WempNo,  //작성자 사원번호
	      Apromotion : Apromotion, // 발령라벨
	      Adate : Adate, //발령일
	      note :note,  //발령메모
	      rsn :rsn  //발령사유
	      
	    };	

	    rowData.push(rowDataItem);
	  });
	  

	  $.ajax({
			type : "post",
			url : "/personnel/Appointment",
			data : JSON.stringify(rowData),
			contentType: 'application/json; charset=utf-8',		
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function (suc){
				console.log("성공" + JSON.stringify(suc));
				  Swal.fire({
		              title: "신청 완료!",
		                text: "",
		                icon: "success",
		                confirmButtonText: "확인"
		            }).then(function() {
		               //모달 닫기
						window.location.href = "/personnel/Appointments";
		            });
				
			},
			error : function(e){
				console.log("에러",e);
			}
		})
	
	  console.log("쳌쳌",rowData);
	});
		
	//////////////////////////////체크박스 처리 끝 //////////////////////////////////////
	////////////////검색 시작/////////////////
$(function() {
	
    var itemsPerPage1 = 8; // 한 페이지당 표시할 열의 수
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
	var itemsPerPage1 = 8; // 한 페이지당 표시할 열의 수
    var currentPage1 = 1; // 현재 페이지
    var totalRows1 = $("table#allTable tbody tr").length; // 전체 행 수
    var totalPages1 = Math.ceil(totalRows1 / itemsPerPage1); // 전체 페이지 수
    
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
            var employeeName = $(this).find("td:eq(2)").text();
            if (employeeName.indexOf(searchText) !== -1) {
                $(this).show();
            }
        });

        updatePage1();
    }
    
    // 페이지 번호들을 동적으로 생성
    function generatePageNumbers1() {
    	alert('왔다');
    	
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
	////////////////검색 끝/////////////////

</script>
</body>
</html>