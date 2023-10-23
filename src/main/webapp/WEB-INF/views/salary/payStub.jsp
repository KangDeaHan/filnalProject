<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<head>
<meta charset="UTF-8">
<title>급여명세서</title>
<style>

	 #header1 {
	     height: 14vh;
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

	/* 링크 스타일 */
	.aTag {
		text-decoration: none; /* 밑줄 제거 */
		margin-right: 20px; /* 각 링크 사이의 간격 조절 */
	}
	
	a:visited {
	   color: black;
	   text-decoration: none;
	}
	div {
	/*     	border: 1px solid blue; /* 항상 레이아웃을 눈으로 보면서 */      */
	 }
	span {
	/* 	border: 1px solid red; */
	}
	
	.tool{
	display: inline-block;
	width: 60%; 
	height: 350px;
	margin : 20px;
	padding : 50px;
	vertical-align: top;
	background: white;
	
	}
	#tool{
		overflow: auto;
	}
	
	.modal-content {
	margin: auto;
	width: 500px;
	height: 400px;
	}
	
	.modal-dialog {
		max-width: none;
	}
	
	#cardBody {
	position: fixed;
	top: 0;
	left: 35%;
	width: 222mm;
	height: 247mm;
	overflow: auto;
	}
	
	#newbody {
		width: 100%;
		height: 100% overflow: auto;
	}

	.oneBlock{
		display: inline-block;
		width: 150px;
		font-size: 23px;
	}
	.twoBlock{
		display: inline-block;
		font-size: 23px;
		color: black;
	}
	.down{
		display: inline-block;
		margin : 20px;
		max-height: 350px;
		overflow: auto;
		background: white;
	}
	tr, td{
		border-top : 0px;
		border-bottom: 1px solid #e9ecef;
	}
	.th2{
		color: black;
		font-weight: bold;
	}
</style>
</head>
<body>

<div id="container"> <!--wrapper-->
		<div id="header1">
			<div id="header2">
			
				<div id="header3">
					<h1><a href="/salary/payStub"  style="margin-left: 25px;">급여명세서</a></h1>
				</div>
			</div>
			<hr>
				<div id="header3">
					<h4 style="margin-bottom: 2px;">
						<a href="/salary/payStub" style="margin-left: 25px;">급여명세서 목록</a>&nbsp;&nbsp; 
					</h4>
				</div>
		
		</div>
		<hr>

	<div style="margin-left: 1410px; width:100px;">
	<select class="form-control" id="year">
		<option>None</option>

	</select>
	</div>
	
	<br>



	<div class="tool">
		<div style="float: left; width: 40%" id="mPay" >
			<h4>급여 내역이 없습니다.</h4>
		</div>
		
		<div style="float: right; width: 40%">
			<img style="margin-left: -50px; width: 250px;" alt="" src="/resources/images/pay/pay.png">
		</div>

	
	</div>
	<div class="tool" style="width: 30%;" id="yPay">
		<h4>급여 내역이 없습니다.</h4>
	</div>

	<br><br>
	<h4 style="display: inline-block; margin-left: 25px;">정산 리스트</h4> 


	<div class="tool" style="width: 93%; height: 100%">
	<table class="table table-hover" style="text-align: center;">
						<thead>
                          <tr>
                            <th class="th2"><strong>급여 명세서</strong></th>
                            <th class="th2"><strong>지급 날짜</strong></th>
                            <th class="th2"><strong>지급 금액</strong></th>
                            <th class="th2"><strong>공제 금액</strong></th>
                            <th class="th2"><strong>실 수령액</strong></th>
                            <th class="th2"><strong>다운로드</strong></th>
                          </tr>
                        </thead>
                        <tbody id="tbody">
                          <tr>
							<td colspan="6">급여 내역이 없습니다</td>
							
                          </tr>
                        
                          
                        </tbody>
                      </table>
	</div>	
</div>



	<div class="modal fade bd-example-modal-xl" tabindex="-1" role="dialog"
		aria-labelledby="myExtraLargeModalLabel" style="display: none;"
		aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content" id="cardBody">
				<!-- //////////////// newbody 시작 ///////////////// -->
				<div class="modal-body" id="newbody">

				</div>
				<!-- //////////////// newbody 끝 ///////////////// -->
				<div style="margin: 15px;">
					<button style="float: right;" type="button" class="btn btn-primary"
						id="savePdfButton2" onclick="pdfPrint()">PDF다운로드</button>
				</div>

			</div>
		</div>
	</div>





</body>

<script type="text/javascript">
var header = '${_csrf.headerName}';
var token =  '${_csrf.token}';

let mPay;
let yPay;
let tBody;
let year;

function reset(){
	$(this).find('form')[0].reset();
	$(".dropdown-content").css("display", "none");
}

$('#cardBody').on('hidden.bs.modal', reset);



function addCommasToNumber(number) {
	// 숫자를 문자열로 변환
    let numberString = number ? number.toString() : '0'; // number가 null인 경우 0으로 대체
    
    // 천단위 구분 기호(쉼표) 추가
    numberString = numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    
    return numberString;
}

function changeBirthFormat(empBrdt) {
    if (empBrdt === null) {
        return '1990.01.01';
    }
    
    // 원하는 포맷으로 변경
    let formattedEmpBrdt = empBrdt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');

    return formattedEmpBrdt;
}



$(document).ready(function () {
	

    $("#savePdfButton2").click(function() {
        pdfPrint();
    });
	
	today = new Date();
	year = today.getFullYear();
    console.log("날짜"  + year);
	
    $.ajax({
        type: "get",
        url: "/salary/loadYear",
        dataType : "json" ,
        success: function (result) {
        	console.log("뭐자??" + result)
        	console.log("이거얌 " + result[0].prYr);
        	console.log("이거얌 " + result.length);
        	
        	str = "";
        	
        	for(let i=0; i<result.length; i++){
        		str += `
    	    		<option>\${result[i].prYr}</option>
            	`;
        	}
        	console.log("ㅇㅇㅇ? "+str);
        	
        	$("#year").html(str);
        },
        error: function (error) {
            alert("Error!");
        },
    });
	
    $.ajax({
        type: "get",
        url: "/salary/payStubAjax/"+year,
        dataType : "json" ,
        success: function (result) {
            console.log("헤헷2442 " + result[0].scNo);
            console.log("헤헷2442 " + result.length);
            mPay ="";
            mPay += `
				<h4>\${addCommasToNumber(result[0].prMth)}월 급여</h4>
				<h1>\${addCommasToNumber(result[0].netAmt)} 원</h1>
				<br><br><br><br>
				
				<div class="oneBlock" >지급</div><div class="twoBlock">\${addCommasToNumber(result[0].pytlAmt)}</div><br>
				<div class="oneBlock" >공제</div><div class="twoBlock">\${addCommasToNumber(result[0].ddtlAmt)}</div><br>
				<div class="oneBlock" >지급 기간</div><div class="twoBlock">\${addCommasToNumber(result[0].prMth)}월</div><br>
			`;
			yPay ="";
			yPay += `
				<h4>\${result[0].prYr}년 누적 수령액</h4>
				<h1 style="text-align: right;">\${addCommasToNumber(result[0].sumNetAmt)} 원</h1>
				<hr>
				<div>
				급여명세서 발급<br>
				갑종근로소득에 대한 소득세 원청징수확인서 발급
				</div>
			`;
			
     
			tBody="";
            for (let i = 0; i < result.length; i++) {
                tBody += `
                    <tr>
                		<input type='hidden' id="scNo" value='\${result[i].scNo}'>
                        <td>\${addCommasToNumber(result[i].prMth)}월 급여 명세서</td>
                        <td>\${result[i].prPdate}</td>
                        <td>\${addCommasToNumber(result[i].pytlAmt)}원</td>
                        <td>\${addCommasToNumber(result[i].ddtlAmt)}원</td>
                        <td>\${addCommasToNumber(result[i].netAmt)}원</td>
                        <td><button onclick="downPdf(this)" id="savePdfButton2" type="button" data-toggle="modal" data-target=".bd-example-modal-xl" style="border:none;background:none;">
                        <span class="fe fe-paperclip fe-16 mr-2" style="font-weight: 700;font-size: 0.85rem;color: black;"></span>
						</button></td>
                    </tr>
                `;
            }

            $("#mPay").html(mPay);
            $("#yPay").html(yPay);
            $("#tbody").html(tBody);
			
            
        },
        error: function (request, status, error) {
            console.log("code: " + request.status)
            console.log("message: " + request.responseText)
            console.log("error: " + error);
        }
    });
    
    
    let jsPDF = jspdf.jsPDF;
    function pdfPrint(){
     	console.log("함수 실행")
         html2canvas($('#newbody').get(0), {
    	    scale: 2 // 캔버스 해상도를 2배로 설정합니다.
    	  }).then(function (canvas) {
           // 캔버스를 이미지로 변환
           console.log("변환 전")
           const imgData = canvas.toDataURL("image/png");
    		console.log("변환 후")
           const imgWidth = 210; // 가로(mm) (A4)
           const pageHeight = imgWidth * 1.414; // 세로 길이 (A4)
           const imgHeight = (canvas.height * imgWidth) / canvas.width;

           const doc = new jsPDF({
              orientation: "p",
              unit: "mm",
              format: "a4",
           });

           let heightLeft = imgHeight;
           let position = 0;

           // 첫 페이지 출력
           doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
           heightLeft -= pageHeight;

           // 한 페이지 이상일 경우 루프 돌면서 출력
           while (heightLeft >= 20) {
              position = heightLeft - imgHeight;
              doc.addPage();
              doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
              heightLeft -= pageHeight;
           }

           // 파일 저장
           doc.save('급여명세서.pdf');
           
           location.href="/salary/payStub";
     });
    }
    

    
});

	$(document).on("change", "#year", function(){
   		let year;
   		year = $("#year").val();
   		
   	    $.ajax({
   	        type: "get",
   	        url: "/salary/payStubAjax/"+ year,
   	        dataType : "json" ,
   	        success: function (result) {
   	            console.log("헤헷2442 " + result[0].scNo);
   	            console.log("헤헷2442 " + result.length);
   	            console.log("year : " + year)
   	            
   	            mPay ="";
   	            mPay += `
   					<h4>\${result[0].prMth}월 급여</h4>
   					<h1>\${addCommasToNumber(result[0].netAmt)} 원</h1>
   					<br><br><br><br>
   					
   					<div class="oneBlock" >지급</div><div class="twoBlock">\${addCommasToNumber(result[0].pytlAmt)}</div><br>
   					<div class="oneBlock" >공제</div><div class="twoBlock">\${addCommasToNumber(result[0].ddtlAmt)}</div><br>
   					<div class="oneBlock" >지급 기간</div><div class="twoBlock">\${result[0].prMth}월</div><br>
   				`;
   				
   				yPay ="";
   				yPay += `
   					<h4>\${result[0].prYr}년 누적 수령액</h4>
   					<h1 style="text-align: right;">\${addCommasToNumber(result[0].sumNetAmt)} 원</h1>
   					<hr>
   					<div>
   					급여명세서 발급<br>
   					갑종근로소득에 대한 소득세 원청징수확인서 발급
   					</div>
   				`;
   				
   	     
				tBody="";
   	            for (let i = 0; i < result.length; i++) {
   	                tBody += `
   	                    <tr>
	                		<input type='hidden' id="scNo" value='\${result[i].scNo}'>
	                        <td>\${addCommasToNumber(result[i].prMth)}월 급여 명세서</td>
	                        <td>\${result[i].prPdate}</td>
	                        <td>\${addCommasToNumber(result[i].pytlAmt)}원</td>
	                        <td>\${addCommasToNumber(result[i].ddtlAmt)}원</td>
	                        <td>\${addCommasToNumber(result[i].netAmt)}원</td>
	                        <td><button onclick="downPdf(this)" id="savePdfButton2" type="button" data-toggle="modal" data-target=".bd-example-modal-xl" style="border:none;background:none;">
	                        <span class="fe fe-paperclip fe-16 mr-2" style="font-weight: 700;font-size: 0.85rem;color: black;"></span>
							</button></td>
   	                    </tr>
   	                `;
   	            }

   	            $("#mPay").html(mPay);
   	            $("#yPay").html(yPay);
   	            $("#tbody").html(tBody);
   				
   	            
   	        },
   	        error: function (error) {
   	            alert("Error!");
   	        },
   	    });
   	    
   	})

function downPdf(pThis) {
    let scNo = $(pThis).closest('tr').find("input#scNo").val();
    console.log("번호" + scNo);
    
    
	$.ajax({
		url : "/salary/issueSC2/"+scNo,
		type : "get",
		contentType: "application/json;charset=utf-8",
		dataType:"json",
		success : function(data){
			console.log("성공::" , data)
			console.log("첫줄나오닝?" , data[0])
			
			str = ""
			str +=`
				<button class="btn mb-2 btn-secondary">귀속월</button>
				&nbsp;&nbsp;<span>\${data[0].prYr}. \${data[0].prMth}</span><br> <br>
				<h2 style="display: inline;">급여명세서</h2>
				<span style="float: right; font-size: 20px;color:black;">\${data[0].empNm} | \${changeBirthFormat(data[0].empBrdt)} | \${data[0].empNo}
					| \${data[0].dnm} </span> <br> <br> <br>

				<div
					style="border-top: 1px solid black; padding: 5px; padding-bottom: 70px;">
					<h3 style="display: inline-block; margin-top: 50px;">
						<strong>실수령액</strong> &nbsp;&nbsp; <span style="font-size:18px;font-weight:normal">\${data[0].prPdate}&nbsp;지급</span> 
						&nbsp;---------------------------------- &nbsp;&nbsp;\${addCommasToNumber(data[0].netAmt)}원
					</h3>
				</div>
			
				<div>
					<div
						style="float: left; width: 44.5%; border-bottom: 3px black solid; margin: 5px 20px 5px;">
						<div class="historyLeft" style="float: left;">
							<h3 class="title">지급내역</h3>
						</div>
						<div class="historyRight" style="float: right;">
							<h3 class="title">\${addCommasToNumber(data[0].pytlAmt)}원</h3>
						</div>
	
					</div>

					<div
						style="float: right; width: 44.5%; border-bottom: 3px black solid; margin: 5px 20px 5px;">
						<div class="historyLeft" style="float: left;">
							<h3 class="title">공제내역</h3>
						</div>
						<div class="historyRight" style="float: right;">
							<h3 class="title">\${addCommasToNumber(data[0].ddtlAmt)}원</h3>
						</div>
					</div>
				</div>
				
				<div>
					<div style="float: left;width: 44.5%; margin: 5px 20px 5px;"">
						<table style="width:100%;">
							<tbody id="payItem">
							</tbody>
						</table>
					</div>
					
					<div style="float: right;width: 44.5%; margin: 5px 20px 5px;"">
						<table style="width:100%;">
							<tbody id="dedItem">
							</tbody>	
						</table>
					</div>
				</div>
				
				<div style="margin-top: 500px;">
					<div>
						● 기본시급 = 연봉 포함 통상임금 ÷ 월소정근무시간, 기본급과 미달 근무 차감금에 활용합니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;기본시급은 소수점 첫째 자리에서 올림표기합니다
					</div>
					<div>● 기본 근무 산정기간(\${data[0].prYr}년 \${data[0].prMth}월)의 기본 시급은
						\${addCommasToNumber(data[0].basicHourWage)}원입니다.</div>
					<div>
						● 초과근무 산정기간(\${data[0].prYr}년 \${data[0].prMth}월)의 기본 시급은 \${addCommasToNumber(data[0].basicHourWage)}원입니다.<br>
						&nbsp;&nbsp;&nbsp;&nbsp; 초과근무수당은 기본시급에 초과한 가산율(%)을 곱한 금액으로 계산되어
						지급됩니다.
					</div>

				</div>
				<div style="margin-top: 120px;">
					<table style="display: inline-block;">
						<tr>
							<td style="padding-right: 70px;color:black;">발급일</td>
							<td style="padding-right: 40px;color:black;">회사명</td>
							<td style="padding-right: 40px;color:black;">대표이사</td>
						</tr>
						<tr>
							<td style="padding-right: 70px;color:black;">\${data[0].scIsDate}</td>
							<td style="padding-right: 40px;color:black;">인사이트</td>
							<td style="padding-right: 40px;color:black;">임민우</td>
						</tr>
					</table>
					<div
						style="display: inline-block; float: right; margin-right: 70px">
						<span style="position: relative; z-index: 2">(서명 인)</span> 
							<img src="\${data[0].svfiName}"
							style="width: 60px; height: 60px; position: absolute; left: 179mm; bottom: 10mm; z-index: 2">
					</div>



				</div>
			`;
		$("#newbody").html(str);
		
		str = "";
		
			for(let i=0; i<data.length; i++){
				if(data[i].pdType == 'B0401'){
					str += `
							<tr>
								<td style="font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${data[i].pdNm}</td>
								<td style="text-align: right; font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${addCommasToNumber(data[i].pdAmt)}</td>
							</tr>
							`;
				}
			}
			$("#payItem").html(str);
			
		str = "";
			for(let i=0; i<data.length; i++){
				if(data[i].pdType == 'B0402'){
					str += `
							<tr>
								<td style="font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${data[i].pdNm}</td>
								<td style="text-align: right; font-size: 16px;padding-top:10px;padding-bottom:10px;border-bottom: 1px solid black;color:black;">\${addCommasToNumber(data[i].pdAmt)}</td>
							</tr>
							`;
				}
			}
			$("#dedItem").html(str);
		},
		error:function(request,status,error){
			  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	

    
}

</script>

</html>