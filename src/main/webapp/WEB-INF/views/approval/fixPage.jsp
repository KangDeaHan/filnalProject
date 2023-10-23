<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
$(function(){
	
   function fMessage() {
	      let data = event.data;
	      console.log("웹소켓받은메시지",JSON.parse(data));
	      myFixList();
	   }

	//나의문서 상세정보
	$(document).on("click",".myDetailInfo",function(){
		let dftNo = $(this).children(".children").val();
		console.log("체킁2 : ",dftNo)
		$.ajax({
			url : "/approval/selectDetailInfo/"+dftNo+"/"+"나의비품",
			dataType : "json",
			type:"get",
			success : function(result){
				console.log("통신결과",result);
				let apbPro = checkPro(result.apboxEmpList);
				console.log("apbPro : ",apbPro);
				
				
				let htmlCode = "";
				if(apbPro > 20){
					htmlCode += `<p style="margin-left:5px;" class="btn btn-danger morInfo rounded-pill text-dark">반려</p>`;
				}else if(apbPro < 0){
					htmlCode += `<p style="margin-left:5px;" class="btn btn-success primary rounded-pill text-dark">승인</p>`;
				}else{
					htmlCode += `<p style="margin-left:5px;" class="btn btn-warning morInfo rounded-pill text-dark">진행중</p>`;
				}
				htmlCode += `
								<div class="modal-header">
									<h1 class="modal-title" id="defaultModalLabel">비품 신청</h1>`
							htmlCode += `<div class="row">`;
							$.each(result.apboxEmpList, function(idx, test){
								htmlCode += `
												<table border="1" >
												<tr style ="background-color : #c0c1c2; padding:10px; text-align:center" >
													<th>\${test.dtcodenm}</th>
												</tr>
												<tr style="height : 50px; text-align:center">`
								if(test.apbPro == '진행중'){
									htmlCode += `<td style="width : 100px;"></td>
									</tr>
									</table>
									`;
								}else if(test.apbPro == '승인'){
									htmlCode += `<td style="width : 100px;"><img src="\${test.signImg}" style="width:40px; height:40px;"></td>
									</tr>
									</table>
									`;
								}else{
									htmlCode += `<td style="width : 100px;"><span class="btn btn-outline-danger" >\${test.apbPro}</span></td>
									</tr>
									</table>
									`;
								}
							});	 
							htmlCode += `</div>`
				htmlCode +=`
								</div>
								<div class="modal-body">
								<div>
								<div id="VacTypeUseDate" class="badge badge-pill badge-success" style="color:white;">
									<span class="badge badge-pill badge-success">\${result.dockind}</span>
								</div>
									<br/>
									<hr/>
								</div>
								<div>
								<div class="">
									<p class="mb-2">
									<strong><font style="vertical-align: inherit;">
											<img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"  data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
											<font style="vertical-align: inherit;">비품 신청 내용</font>
									</font></strong>
									</p>
								</div>
									<input type="hidden" name="dftNo" value="\${result.dftNo}">
									<div>
										<strong>글제목</strong><br>
										<input class="form-control" id="start-date" type="text" name="startDate" value="\${result.subject}" disabled/>
									</div>
									&nbsp;
									<div class="row">
										<div class="col-6">
											<strong>품명</strong>
											<input class="form-control" id="start-date" type="text" name="startDate" value="\${result.fixName}" disabled/>
										</div>
										
										<div class="col-6">
											<strong>규격</strong>
											<input class="form-control" id="start-date" type="text" name="startDate" value="\${result.fixStandard}" disabled/>
										</div>
									</div>
									&nbsp;

									<div class="row">
										<div class="col-6">
											<strong>수량</strong>
											<input class="form-control" id="start-date" type="text" name="startDate" value="\${result.fixNumber}개" disabled/>
										</div>
										<div class="col-6">
											<strong>단가</strong>
											<input class="form-control" id="start-date" type="text" name="startDate" value="\${result.fixUnitPrice}원" disabled/>
										</div>
										</div>
										&nbsp;

										<div>
											<strong>금액</strong>
											<input class="form-control" id="start-date" type="text" name="startDate" value="\${result.fixTotal}원" disabled/>
										</div>
										&nbsp;
										
										<div class="form-group mb-3">
											<label for="example-textarea">
													<strong>용도</strong>
													<font style="vertical-align: inherit;"></font>
											</label>
											<textarea class="form-control" id="example-textarea" rows="10" style="width: 600px; height: 108px;" name="rsn" readonly>\${result.fixUsage} </textarea>
										</div>
									</div>
									</div>
				`;
				$("#myInfoResult").html(htmlCode);
				if(result.apbPro == "진행중"){
					let htmlCodeFooter = `<input type="button" class="mainBtn myAopImgs" data-dismiss="modal" style="width:49%"  value="승인"/>
										<input type="button" class="mainBtn2 myAopImgs" data-dismiss="modal" style="width:49%" value="반려"/>
										<input type="hidden" class="mydftNo" value="\${result.dftNo}">`
					$("#myInfoResultFooter").html(htmlCodeFooter);
				}else{
					let htmlCodeFooter = `<input type="button" class="mainBtn2 " data-dismiss="modal" style="width:100%" value="닫기"/>`
					$("#myInfoResultFooter").html(htmlCodeFooter);
				}
			}
		});
	});
	
	myFixList()
})//function

//결재진행상태 체크
function checkPro(apbProList){
	let count = 0;
	
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
	
	return count;
};

//시간나타내기
function convertTimeToRelative(timeInMilliseconds) {
    const currentTime = new Date().getTime();
    const timeDifference = currentTime - timeInMilliseconds;

    const seconds = Math.floor(timeDifference / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);
    const days = Math.floor(hours / 24);

       if (days > 0) {
           return days + "일 전";
       } else if (hours > 0) {
           return hours + "시간 전";
       } else if (minutes > 0) {
           return minutes + "분 전";
       } else {
           return "방금 전";
       }
 };

//나의 비품신청 리스트
function myFixList(){
	$.ajax({
		url : "/approval/myFixList",
		dataType : "json",
		success : function(result){
			let DateSort = result.sort(function(a,b){
				return b.applicationDate - a.applicationDate;
			});
			console.log("ArraySort된 result값들",result)
			let htmlCode = "<table class='table table-hover'>";
				for(let i=0; i<result.length; i++){
					const timeResult = convertTimeToRelative(result[i].applicationDate)
					
					let checkMyFixPro = checkPro(result[i].apboxList)
					let fixPro = "";
					if(checkMyFixPro > 20){
						fixPro = '<span class="badge rounded-pill bg-danger text-white" style="padding: 5px;">반려</span>';
					}else if(checkMyFixPro < 0){
						fixPro = '<span class="badge rounded-pill bg-info text-white" style="padding: 5px;">승인</span>';
					}else{
						fixPro = '<span class="badge rounded-pill bg-warning text-white" style="padding: 5px;">진행중</span>' ;
					}
					htmlCode +=`<tr class="myAop" >
								<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
								<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
									<span class="h5 mb-3">\${result[i].subject}</span> 
									<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span> <span class="text-muted">\${timeResult}</span> <br/>
									<span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage} 　<strong>결재상태 : </strong> \${fixPro}</span>  
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
					$.each(result[i].apboxList, function(idx, apbox){
						if(apbox.myImg == null || !apbox.myImg){
							htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
						}else{
							htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
						}
					});
				}
				
				$("#myDocResult").html(htmlCode);
		}
	})	
};
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
.mainBtn2 {
   background: #6c757d;
   border-radius: 10px;
   padding: 10px 20px;
   color: white;
   cursor: pointer;
   border: none;
   margin : 0 auto;
}
#contaner {
	width: 90%;
}
#wetreeJsContaner{
	overflow:auto;
}
</style>


 <!-- Slide Modal -->
 <div class="modal fade modal-right modal-slide" tabindex="-1" role="dialog" aria-labelledby="defaultModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-sm" role="document" style="min-width:35%">
     <div class="modal-content">
<!--        <div class="modal-header"> -->
<!--          <button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!--            <span aria-hidden="true">&times;</span> -->
<!--          </button> -->
<!--        </div> -->

       <div class="modal-body" >
       	 <div id ="myInfoResult">
       	 </div>
        </div>
       <div class="modal-footer">
       	 <div id ="myInfoResultFooter" style="width:100%; margin:0 auto;">
       	 
       	 </div>
       </div>
     </div>
   </div>
 </div>

<div id="contaner">
	<div class="card shadow">
		<div class="card-body" style="overflow:auto; height:880px;">
			<div>
				<div style="width: 100%; position: relative;" class="d-flex bd-highlight mb-3">
					<h1>비품 신청란</h1>
					<button type="button" id="writeWork" class="mainBtn" data-toggle="modal"	data-target=".bd-example-modal-lg2" style="color: white; position: absolute; right: 20px; width: 140px; height: 50px;"><span class="fe fe-edit-2 fe-16 mr-2"></span>비품신청</button>
						
<!-- 					라지모달 테스트 -->
					<div class="modal fade bd-example-modal-lg2" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<jsp:include page="/approval/FurnitureApplicationForm"></jsp:include>						
						</div>
					</div>
<!-- 					라지모달 끝 -->
				</div>
				
				<hr/>
				
				<div>
					<a id="progress" class="gray_font h3 mb-3" href="#" style="border-bottom : solid 3px black;font-size: 1.09375rem;" >나의 비품신청 목록</a>
					<span class="gray_font h3 mb-3" style = "font-size: 1.09375rem; float: right; padding-right:200px;">결재자 사진</span>
				</div>

				<div id="myDocResult" style="margin-top:10px;"></div>

			</div>
		</div>
	</div>
</div>