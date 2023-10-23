<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
				<font style="vertical-align: inherit;"><a class="gray-link" href="/advct/vacbk">휴가/휴직 현황&nbsp;&nbsp;</a></font>
				<font style="vertical-align: inherit;"><a href="/advct/annualGive">&nbsp;&nbsp;&nbsp;구성원 연차 상세</a></font>
			</h4>
		</div>
		<hr>
		<div class="card-body" style="margin-top:2%;">
				<h4>연차 지급</h4>
					<!-- table -->
					<div id="dataTable-1_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">

						<div class="row">
						    <div class="col-sm-12 col-md-12">
							    <div id="dataTable-1_filter" class="dataTables_filter d-flex justify-content-end align-items-center">
							        <input type="search" id="searchField" class="form-control form-control-sm" placeholder="" aria-controls="dataTable-1">
							        <button type="button" id="searchButton" class="btn btn-primary btn-icon-split btn-sm">
							            <span class="text">검색</span>
							        </button>
							    </div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<table id="allTable" class="table table-borderless table-hover allTable" style="white-space: nowrap;">
									
								</table>
									
							</div>
						</div>
						
						<div class="row">
							<div class="col-sm-12 col-md-4">
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
				        <li class="page-item page-number1 active"><a class="page-link" href="#">1</a></li><li class="page-item page-number1"><a class="page-link" href="#">2</a></li><li class="page-item" id="nextPage1">
				            <a class="page-link" href="#" aria-label="Next">
				                <span aria-hidden="true">&raquo;</span>
				            </a>
				        </li>
				    </ul>
				</nav>
						</div>
					</div>
				</div>
</body>
<script type="text/javascript">
	
	//부여 연차 업데이트
	$(document).on("click","#update",function(){
		
		let giveDays = $(this).closest("tr").find(".giveDaysSelect").val();
		console.log("이거는 giveDays",giveDays);
		
		vacHoldVO ={
				"empNo":empNo,
				"vhGiveDays" : giveDays
		}
		console.log("이건 vacHoldVO",vacHoldVO);
		
		$.ajax({
			type:"put",
			url:"/advct/updateDays",
			contentType: "application/json",
			dataType:"json",
			data: JSON.stringify(vacHoldVO),
			beforeSend:function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	         },
	         success:function(){
	        	 Swal.fire("수정에 성공하였습니다.");
	         }
		})
	})


	const $List=$("#allTable");
	console.log("이건 $List",$List);
	
	$(()=>{
		getList();
	})
	//연차 부여하기
	$(document).on("click", "#save", function() {

		let giveDays = $(this).closest("tr").find(".giveDaysSelect").val();
			console.log("이거는 giveDays",giveDays);
			
		vacHoldVO={
				
				"vhGiveDays" : giveDays
		}
			console.log("이건 vacHoldVO",vacHoldVO);
		$.ajax({
			type:"post",
			url:"/advct/giveDays",
			contentType: "application/json",
			dataType:"json",
			data: JSON.stringify(vacHoldVO),
			beforeSend:function(xhr){
	            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	         },
	         success:function(){
	        	 Swal.fire("추가에 성공하였습니다.");
	         }
		})
// 		getList();
	})
	
	
	
	function getList(){
		
		$.ajax({
			type:"get",
			url:"/advct/empList",
			dataType:"json",
			success:function(rest){
				console.log("체크체크1",rest);
				let tbl =`<thead>`
				tbl +=`<tr role="row" style="text-align:center;">`
				tbl +=`<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="Name: activate to sort column ascending" style="width: 100px;"><strong>사원명</strong></th>`
				tbl +=`<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="#: activate to sort column ascending" style="width: 100px;"><strong>사원 번호</strong></th>`
				tbl +=`<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="#: activate to sort column ascending" style="width: 100px;"><strong>부서</strong></th>`
				tbl +=`<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="#: activate to sort column ascending" style="width: 100px;"><strong>팀</strong></th>`
				tbl +=`	<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="#: activate to sort column ascending" style="width: 100px;"><strong>직위</strong></th>`
				tbl +=`	<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="#: activate to sort column ascending" style="width: 100px;"><strong>직급</strong></th>`
				tbl +=`	<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="Date: activate to sort column ascending" style="width: 100px;"><strong>재직 상태</strong></th>`
				tbl +=`	<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="Date: activate to sort column ascending" style="width: 100px;"><strong>연차 부여 일수</strong></th>`
				tbl +=`	<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="Date: activate to sort column ascending" style="width: 60px;"><strong>비고1</strong></th>`
				tbl +=`	<th class="sorting" tabindex="0" aria-controls="dataTable-1" rowspan="1" colspan="1" aria-label="Date: activate to sort column ascending" style="width: 60px;"><strong>비고2</strong></th>`
				tbl +=`</tr>`
					tbl +=`</thead>`
				 tbl +=`<tbody>`;
				for (let i = 0; i < rest.length; i++) {
				    tbl +=	`<tr role="row" class="odd" style="text-align: center;">`;
				    tbl +=` <td>\${rest[i].empNm}</td>`;
				    tbl +=` <td id="empNo">\${rest[i].empNo}</td>`;
				    tbl +=` <td>\${rest[i].jcode}</td>`;
				    tbl +=` <td>\${rest[i].dtcode}</td>`;
				    tbl +=` <td>\${rest[i].ptnCode}</td>`;
				    tbl +=`	<td>\${rest[i].grdCode}</td>`;
				    tbl +=`	<td>\${rest[i].stClfCd}</td>`;
				    tbl +=`<td>`;
					    tbl +=`<select id="giveDays" class="form-control giveDaysSelect">`;
					    for (var j = 1; j <= 10; j++) {
						    tbl +=	`<option>`+j+`</option>`;
						}
					    tbl +=`</select>`;
				    tbl +=`</td>`;
				    tbl +=`<td><button type="button" id="update" name="upDate" class="btn mb-2 btn-outline-warning">수정하기</button></td>`;
				    tbl +=`<td><button type="button" id="save" name="save" class="btn mb-2 btn-outline-info">부여 하기</button></td>`;
				    tbl +=`</tr>`;
				}
				    tbl +=`</tbody>`;
				    
				    $List.html(tbl);
				    
			
			$(function() {
				    var itemsPerPage1 = 7; // 한 페이지당 표시할 열의 수
				    var currentPage1 = 1; // 현재 페이지
				    var totalRows1 = $("table#allTable tbody tr").length; // 전체 행 수
				    var totalPages1 = Math.ceil(totalRows1 / itemsPerPage1); // 전체 페이지 수

				    console.log("totalRows1",totalRows1);
				    
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
					    // ... (기존 코드)
		
					    // 검색 기능 구현
					    $("#searchButton").on("click", function() {
					        search();
					    });
		
					    // Enter 키 누를 때 검색 함수 호출
					    $("#searchField").on("keyup", function(event) {
					        if (event.keyCode === 13) {
					            search();
					        }
					    });
		
					    function search() {
					        var searchText = $("#searchField").val().toLowerCase();
					        console.log("검색어:", searchText);
		
					        // 모든 행을 숨김
					        $("table#allTable tbody tr").hide();
		
					        // 검색어와 일치하는 행을 표시
					        $("table#allTable tbody tr").each(function() {
					            var employeeName = $(this).find('td:eq(0)').text();
					            if (employeeName.toLowerCase().indexOf(searchText) !== -1) {
					                $(this).show();
					            }
					        });
		
					        // 검색 결과가 변경되었으므로 페이지 번호를 리셋하지 않고 현재 페이지를 업데이트
					        updatePage1();
					    }
					});
			}
		});
	}

</script>
</html>