<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.EmpVO" var="empVO" />
   <%-- <div>세션체킁: ${empVO }</div> --%>
</sec:authorize>
<script>
$(function(){
	let number = $(".number");
	let won = $(".won");
	let sum = $(".sum");
	let total = $("#totalSum");
	
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
	
	//비품 추가버튼
	let num = 1;
	$("#plusBtn").on("click",function(){
		let htmlCode = `
			<div class="furCcontaner">
				품명 : <input name="fixName" type="text" required>
				규격 : <input name="fixStandard" type="text" ><br/>
				수량 : <input name="fixNumber" class="number" type="number" required>
				단가 : <input name="fixUnitPrice" class="won" type="number" required>원<br/>
				금액 : <input name="fixPrice" class="sum" type="number">원<br/><br/>
			</div>
		`;
		if(num <3){
			$("#plusFurn").append(htmlCode);
			num += 1;
		}else{
			Swal.fire({
				  icon: 'error',
				  title: '잠깐!',
				  text: '비품 신청은 한번에 3개까지만 가능합니다',
			})
		}
	});
	
	//비품 삭제 버튼
	$(document).on("click","#subtractBtn",function(){
		let mychild = $("#plusFurn").children(".furCcontaner").last();
		if(num > 1){
			mychild.remove();
			num -= 1;
		}
	});
	
	//저장하기
	$(document).on("click","#saveBtn",function(){
		let fildForm = $(".furCcontaner");
		
		let docIndex     = 0;
		let fixName      = ""; //품명
		let fixStandard  = ""; //규격
		let fixNumber    = 0;  //수량
		let fixUnitPrice = 0;  //단가
		let fixPrice     = 0;  //금액
		let fixUsage     = ""; //용도
		let fixTotal     = 0;       //합계
		let subject      = 0;       //제목
		
		let fixData = []; //FixturesList
		for(let i=0; i<fildForm.length; i++){
			
			docIndex     = i+1;
			fixName      = $(fildForm[i]).children("input[name='fixName']")[0].value;
			fixStandard  = $(fildForm[i]).children("input[name='fixStandard']")[0].value;
			fixNumber    = $(fildForm[i]).children("input[name='fixNumber']")[0].value;
			fixUnitPrice = $(fildForm[i]).children("input[name='fixUnitPrice']")[0].value;
			fixPrice     = $(fildForm[i]).children("input[name='fixPrice']")[0].value;
			fixUsage = $("textarea[name='fixUsage']")[0].value; //용도
			fixTotal = $("input[name='fixTotal']")[0].value;       //합계
			subject = $("input[name='subject']")[0].value; //제목
			
			fixturesVO = {
				"docIndex" : docIndex,
				"fixName" : fixName,     
				"fixStandard": fixStandard, 
				"fixNumber": fixNumber,  
				"fixUnitPrice": fixUnitPrice,
				"fixPrice": fixPrice,
				"fixUsage": fixUsage, 
				"fixTotal": fixTotal,  
				"subject": subject 	
			}
			fixData.push(fixturesVO);
		}

		
		let checkEmpNo = $(".checkEmpNo");
		let serialNumber = 0; //결제
		let empNo        ="" ; //사원번호
		
		let apboxData = []; //ApboxList
		for(let i=0; i<checkEmpNo.length; i++){
			serialNumber = i+1;
			empNo = checkEmpNo[i].value;

			apboxVO = {
				"serialNumber":serialNumber,
				"empNo":empNo
			}
			apboxData.push(apboxVO);
		}
		let mainSubject = $("#mainSubject").html();//문서종류
		
		//보낼 데이터
		let Mydata = [
			fixData,
			apboxData,
			mainSubject
		];
		console.log(Mydata);
		
		//문서작성INSERT
		$.ajax({
			url : "/approval/fixApp",
			contentType : "application/json; charset:utf-8",
			data : JSON.stringify(Mydata),
			type : "post",
			dataType : "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				$(".modal fade bd-example-modal-lg2 show").click();
				if(result > 0){
					Swal.fire({
						  position: 'top-end',
						  icon: 'success',
						  title: '저장완료',
						  showConfirmButton: false,
						  timer: 1500
					});
				
					let myName = "${empVO.empNm}";
					let myMassage = "비품 신청";
					let myData = "비품";
					messageVO = {
						setter:myName,
						massage:myMassage,
						data:myData
					};
					
				 	//myDocList();
				 	myFixList();
					webSocket.send(JSON.stringify(messageVO));
				}
			}
		})
	});

	//수량 변경시 금액 구하기
	$(document).on("change",".number",function(){
		let parent = $(this).parent();
		let won = parent.children(".won")[0].value;
		let sum = parent.children(".sum")[0];
		let number = this.value;

		sum.value = won * number;

		//총 합계
		let arr = []; arr = $(".sum");
		let myWon = 0;
		for(let i=0; i<arr.length; i++){
			let mySum = arr[i].value;
			myWon += +mySum;
		}
		total.val(myWon);
	})
	
	//단가 변경시 금액 구하기
	$(document).on("change",".won",function(){
		let parent = $(this).parent();
		let won = parent.children(".number")[0].value;
		let sum = parent.children(".sum")[0];
		let number = this.value;
		
		sum.value = won * number;
		
		//총 합계
		let arr = []; arr = $(".sum");
		let myWon = 0;
		for(let i=0; i<arr.length; i++){
			let mySum = arr[i].value;
			myWon += +mySum;
		}
		total.val(myWon);
	})
	
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
	            	 if(data.node.original.info != null){
						 $.ajax({
							 url : "/approval/selectEmp?keyword=" + data.node.original.info,
							 dataType : "json",
							 type : "get",
							 success : function(result){
								let htmlCode = "";
								
								htmlCode += `<talbe border="1" style="float:right;">
											 <tr>
												<td><input type="hidden"  class = "checkEmpNo" value="\${result.empNo}"></td>
											 	<td><button type="button" class="badge badge-pill badge-info checkEmpNm">\${result.empNm}</button></td>
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
});//function


//자동채우기
function autoWrite(){
	let $subject =      $('input[name = subject]'); //제목
	let $fixName =      $('input[name = fixName]'); //품명
	let $fixStandard =  $('input[name = fixStandard]'); //규격
	let $fixNumber =    $('input[name = fixNumber]'); //수량
	let $fixUnitPrice = $('input[name = fixUnitPrice]'); //단가
	let $fixPrice =     $('input[name = fixPrice]'); //금액
	let $fixUsage =     $('textarea[name = fixUsage]'); //용도 
	let $fixTotal =     $('input[name = fixTotal]'); //합계
	
	$subject.val("명함신청 합니다.");
	$fixName.val("명함");
	$fixStandard.val("90mm * 50mm");
	$fixNumber.val(100);
	$fixUnitPrice.val(200);
	$fixUsage.html("업무 목적으로 사용.");
	$fixPrice.val(20000);
	$fixTotal.val(20000);
	
	
	
}


//찾기!
function fSch() { 
    console.log("찾기")
    $('#sujiTree').jstree(true).search($("#schText").val());
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
<style>
.mainBtn {
   background: linear-gradient(to right, #3783C6, #39A4C5);
   border-radius: 10px;
   padding: 10px 20px;
   color: white;
   cursor: pointer;
   border: none;
   margin : 0 auto;
}

#wetreeJsContaner {
	display: none;
	width: 100%;
	height: 100%;
	background-color: rgba(240, 240, 240, 0.9);
	position: fixed;
 	z-index: 7000;
	padding-left: 350px;
	padding-top: 140px;
}

#wetreeJs {
	margin: 50px auto;
	width: 60%;
	height: 70%;
}
</style>

<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.EmpVO" var="empVO" />
<%--    <div>세션체킁: ${empVO }</div> --%>
</sec:authorize>

    
    
<div tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class="modal-content"
			style="border-right: 1px solid #dfdfdf; height: 800px;">
			<div class="modal-header">
				<span class="badge badge-pill badge-primary">비품 신청란</span>
			</div>

			<div class="modal-body row" style="position: relative;">
				<div class="col-8" style="border-right: 1px solid #dfdfdf;">
					<img src="https://cdn-icons-png.flaticon.com/512/1355/1355764.png" style="width: 40px; position: absolute; top: 5px;">
					<p id="mainSubject" class="h2" style="width: 500px; margin-left: 55px;">비품신청</p>

					제목 : <input name="subject" type="text" placeholder="제목을 입력해주세요.">
					<div id="plusFurn" style="margin-top: 20px;">
						<div class="furCcontaner">
							품명 : <input name="fixName" type="text"  style=""> 
							규격 : <input name="fixStandard" type="text"><br /> 
							수량 : <input	name="fixNumber" class="number" type="number" >
							단가 : <input name="fixUnitPrice" class="won" type="number" >원<br />
						       금액 : <input name="fixPrice" class="sum" 	type="number">원<br/>
							<br />
						</div>
					</div>

					용도 : <br />
					<textarea name="fixUsage" rows="10" cols="55"></textarea>
					<br />
					<div style="float: right; margin-right: 63px">
						합계 : <input name="fixTotal" id="totalSum" type="number">원<br />
					</div>
					<input id="plusBtn" class="btn mainBtn" type="button" value="+"> <input id="subtractBtn" class="btn mainBtn" type="button" value="-"> <br />
					<input class="btn mb-2 btn-outline-dark" style=" margin-top:10px; width:100px;" type="button" value="자동채우기" onclick="autoWrite()"> 
				</div>
				<div class=" col-4">
				<p class="h4">승인참조</p>
				<hr />
				<div id="resultApprovePlus">
					<p class="PlusBtnContaner">
						<label class="h5" for="chamjo">1단계</label> <input type="button"
							class="btn mb-2 btn-outline-dark approvePlusBtn" value="+" style="float: right;">
					</p>
				</div>
				<button id="approveLevelBtn" type="button"	class="btn mb-2 btn-secondary btn-block">+ 단계 추가하기</button>
				</div>
			</div>
			<button id="saveBtn" type="button" class="btn mb-2 mainBtn btn-lg btn-block">저장하기</button>
		</div>
	</div>
</div>



<!-- <div id="wetreeJsContaner" style="overflow: auto"> -->
<!-- 	<div id="wetreeJs"> -->
<!-- 		<button type="button" id="open" class="btn mb-2 btn-outline-link"> -->
<!-- 			<span class="fe fe-24 fe-book-open"></span> -->
<!-- 		</button> -->
<!-- 		<div id="sujiTree"></div> -->
<!-- 		<input type="text" id="schText" value=""> -->
<!-- 		<button class="btn mb-2 btn-secondary" onclick="fSch()">찾아볼까낭</button> -->
<!-- 		<!--검색기능--> -->
<!-- 		<button id="myModalClose" type="button" class="btn mb-2 btn-secondary" -->
<!-- 			data-dismiss="modal">닫기</button> -->
<!-- 		<div class="modal-footer"></div> -->
<!-- 	</div> -->
<!-- </div> -->
