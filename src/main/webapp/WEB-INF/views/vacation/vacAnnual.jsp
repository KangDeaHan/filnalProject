<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">


.text-center {
    text-align: center; /* 텍스트 가운데 정렬 */
}

.gray-link {
    color: #CDD1D5 !important;
    text-decoration: none !important;
}

.rounded{
  background-color: white; /* 흰색 배경 */
  padding: 20px; /* 카드 안의 내용과의 간격 조절 */
  border-radius: 10px; /* 카드 테두리 둥글게 만듦 */
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}

.card-body{
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

.table th, .table td {
	padding: 10px; /* 셀 내 여백을 조절합니다. 원하는 크기로 조정할 수 있습니다. */
	text-align: left; /* 셀 내 텍스트 정렬을 조절합니다. 필요에 따라 변경할 수 있습니다. */
	border: 1px solid #ddd; /* 셀 경계선 스타일을 지정합니다. */
	color: black;
}

.table {
	table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정합니다. */
	width: 100%; /* 테이블 전체 너비를 100%로 설정합니다. */
	border-collapse: collapse; /* 테이블 셀 간의 경계를 합칩니다. */
	text-align: left;
}

.table td {
	text-align: right;
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
			<font style="vertical-align: inherit;"><a href="/vct/Annual">&nbsp;&nbsp;&nbsp;연차&nbsp;&nbsp;</a></font>
			<font style="vertical-align: inherit;"><a href="/vct/bkApply"class="gray-link">&nbsp;&nbsp;&nbsp;휴직/복직</a></font>
		</h4>
		<hr>
	</div>

	<div style="vertical-align: inherit; margin-left: 1%">
		<h2 class="card-title">
			<font style="vertical-align: inherit;">연차 현황 </font>
		</h2>
	</div>
	<div class="col-md-6">
	    <nav aria-label="Table Paging" class="my-3">
	    <div id="page">
	        <ul class="pagination justify-content-start mb-0" id="pagination2">
	            <li class="page-item" id="prevPage">
	                <a class="page-link" href="#" aria-label="Previous">
	                    <span aria-hidden="true">&laquo;</span>
	                </a>
	            </li>
	            <input type="serach" id="yearInput" class="form-control date" style="width:100px;" aria-controls="dataTable-1" />
	            <li class="page-item" id="nextPage">
	                <a class="page-link" href="#" aria-label="Next">
	                    <span aria-hidden="true">&raquo;</span>
	                </a>
	            </li>
	        </ul>
	    </div>
	    </nav>
	</div>

	<div id="totalSum" style="margin-top:-60px;"></div>
	<div class="d-flex" style="margin-top:-15px;">
	
		<div class="card-body" style="width: 50%; flex: 1;">
			<div id="list1" style="text-align:center;">
			</div>
		</div>
		
		<div class="card-body" style="width: 50%; flex: 1;">
			<div id="list2" style="text-align:center;"></div>
		</div>
	
	</div>
</body>
<script>
		//Enter 키를 눌렀을 때 실행할 동작
		$("#yearInput").on("keyup", function(event) {
		    if (event.key === "Enter") {
		        getList();
		    }
		});
		
		function getCurrentYear() {
		    const currentDate = new Date();
		    return currentDate.getFullYear();
		}
		
		let currentYear = getCurrentYear(); 
		$("#yearInput").val(currentYear); 
		
		$("#prevPage").click(function() {
		    currentYear--; 
		    $("#yearInput").val(currentYear);
		    getList();
		});
		
		$("#nextPage").click(function() {
		    if (currentYear < getCurrentYear()) {
		        currentYear++;
		        $("#yearInput").val(currentYear); 
		        getList();
		    }
		});


	const $total = $("#totalSum");
	const $list1 = $("#list1");
	const $list2 = $("#list2");
	
	$(()=>{
		getList();
	})

	function getList(){
	const vhGiveDate = $("#yearInput").val();
	const vaapDate =$(".date").val();
	
	console.log("vhGiveDate::" , vhGiveDate);
	console.log("vaapDate::" , vaapDate);
		
		$.ajax({
			type:"get",
			url:"/vct/AnList",
			data : {
				"vhGiveDate" : vhGiveDate,
				"vaapDate" : vaapDate
			},
			dataType:"json",
			success:function(rslt){
				console.log("체크:22",rslt);
					
			let tbl=`<div class="col" style="margin-left: 22%; margin-top: 2%;">`;
				tbl+=`<div class="d-flex">`
				tbl+=	`<div class="shadow p-3 mb-5 bg-body-tertiary rounded"`;
				tbl+=	`style="width: 300px; height: 150px;">`
				tbl+=		`<strong style="display: block; font-size: 16px; color: black">부여`
				tbl+=			` 연차</strong> <strong`
				tbl+=			` style="display: block; text-align: center; font-size: 50px; color: blue;">+\${rslt.plusList}</strong>`
				tbl+=	`</div>`
				tbl+=	`<div class="shadow p-3 mb-5 bg-body-tertiary rounded"`
				tbl+=		`style="width: 300px; height: 150px;">`
				tbl+=		`<strong style="display: block; font-size: 16px;">사용한 연차</strong> <strong`
				tbl+=		` style="display: block; text-align: center; font-size: 50px; color: red;">-\${rslt.minusList}</strong>`
				tbl+=	`</div>`
				tbl+=	`<div class="shadow p-3 mb-5 bg-body-tertiary rounded"`
				tbl+=		` style="width: 300px; height: 150px;">`
				tbl+=		`<strong style="display: block; font-size: 16px;">사용가능한 연차</strong> <strong`
				tbl+=		` style="display: block; text-align: center; font-size: 50px; color: green;">\${rslt.total}</strong>`
				tbl+=`</div>`
				tbl+=`</div>`
				tbl+=`</div>`
					
					$total.html(tbl);
	
		let tbl1 = `<table class="table table-bordered table-hover mb-0 text-center">`;
		    tbl1 +=	`<thead>`;
			tbl1 +=	`<tr>`;
			tbl1 +=	`<th style="text-align:center;"><strong>부여 날짜</strong></th>`;
			tbl1 += `<th style="text-align:center;"><strong>부여 연차</strong></th>`;
			tbl1 += `</tr>`;
			tbl1 += `</thead>`;
			tbl1 += `<tbody>`;
			for (let i = 0; i < rslt.list1.length; i++) {
				tbl1 +=`<tr>`;
				tbl1 +=`<td style="text-align:center;">\${rslt.list1[i].vhGiveDate}</td>`;
				tbl1 +=`<td style="text-align:center;">\${rslt.list1[i].vhGiveDays}</td>`;
				tbl1 +=`</tr>`;
			}
			tbl1 +=`</tbody>`;
			tbl1 +=`</table>`;
			
				$list1.html(tbl1);
		
		let tbl2 = `<table class="table table-bordered table-hover mb-0 text-center">`;
		    tbl2 +=	`<thead>`;
			tbl2 +=`<tr>`;
			tbl2 +=	`<th style="text-align:center;"><strong>사용 날짜</strong></th>`;
			tbl2 +=`<th style="text-align:center;"><strong>사용일 수</strong> </th>`;
			tbl2 +=`</tr>`;
			tbl2 +=`</thead>`;
			tbl2 +=`<tbody>`;
			for (let i = 0; i < rslt.list2.length; i++) {
				tbl2 +=`<tr style="text-align:center;">`;
				tbl2 +=`<td style="text-align:center;">\${rslt.list2[i].vaapDate}</td>`;
				tbl2 +=`<td style="text-align:center;">\${rslt.list2[i].vaapDays}</td>`;
				tbl2 +=`</tr>`;
			}
			tbl2 +=`</tbody>`;
			tbl2 +=`</table>`;
				
			$list2.html(tbl2);

			},
			error: function (xhr, status, error) {
            console.log("code: " + xhr.status)
            console.log("message: " + xhr.responseText)
            console.log("error: " + error);
            }
		});
	}
</script>
</html>