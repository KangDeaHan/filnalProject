<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.EmpVO" var="empVO" />
</sec:authorize>

<script>

$(function(){
	
	//현재 탭 상태
	var Protab = "진행중";
	
	
	//진행중 클릭
	$("#progress").on("click",function(){
		Protab ="진행중";
		myDocList();
	});
	 myDocList()
	 
	 
	//완료 클릭
	$("#complete").on("click",function(){
		Protab = "완료";
		$.ajax({
			url:"/approval/myDocList",
			dataType:"json",
			type:"get",
			success:function(result){
				let dateSolt = result.sort(function(a,b){
					return b.applicationDate - a.applicationDate;
				});
				console.log("result값들",result)
				let htmlCode = "<table class='table table-hover'>";
					$.each(dateSolt, function(idx, test){
					const timeResult = convertTimeToRelative(test.applicationDate)
						
						if((test.apbPro == '승인' || test.apbPro =='반려') && test.dockind =="비품신청"){
							htmlCode +=`<tr class="myAop">
										<td style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
										<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
											<span class="h5 mb-3">\${test.subject}</span>  <span class="text-muted">\${timeResult}</span>
											<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span> 
											<input type="hidden" class="children" value="\${test.dftNo}">
										`
										if(test.apbPro == '승인' ){
											htmlCode +=`<span class="badge rounded-pill bg-success text-white">\${test.apbPro}</span> <br/>`
										}else{
											htmlCode +=`<span class="badge rounded-pill bg-danger text-white">\${test.apbPro}</span> <br/>`
										} 
										htmlCode +=`<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${test.fixName}　 <strong>수량 : </strong>\${test.fixNumber}　 <strong>단가 : </strong>\${test.fixPrice}　 <strong>총금액 : </strong>\${test.fixTotal}　 <strong>사유 : </strong>\${test.fixUsage}</span>
										</td>
										<td style="width:300px;"><div id="myImg">`;
							$.each(test.apboxEmpList, function(idx, apbox){
								if(apbox.myImg == null || !apbox.myImg){
									htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
								}else{
									htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
								}
							});
							htmlCode +=`</div>
											<div id="myChoice">
												<input type="hidden" class="mydftNo" value="\${test.dftNo}">
												<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
											</div>
										</td>
										</tr>`;
						}else if((test.apbPro == '승인' || test.apbPro =='반려') && test.dockind =="휴가신청"){
							htmlCode +=`<tr class="myAop">
										<td style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
										<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
											<span class="h5 mb-3">\${test.vacTypeName}</span>  <span class="text-muted">\${timeResult}</span>
											<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span> 
											<input type="hidden" class="children" value="\${test.dftNo}">
										`
										if(test.apbPro == '승인' ){
											htmlCode +=`<span class="badge rounded-pill bg-success text-white">\${test.apbPro}</span> <br/>`
										}else{
											htmlCode +=`<span class="badge rounded-pill bg-danger text-white">\${test.apbPro}</span> <br/>`
										} 
										htmlCode +=`<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${test.vaapRsn}　 <strong>기간 : </strong>\${test.vaapStart.split(" ",1)} ~ \${test.vaapEnd.split(" ",1)} (\${test.vaapDays}일) </span>
										</td>
										<td style="width:300px;"><div id="myImg">`;
							$.each(test.apboxEmpList, function(idx, apbox){
								if(apbox.myImg == null || !apbox.myImg){
									htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
								}else{
									htmlCode +=`<img src="\${apbox.myImg}"  alt="결제자사진" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
								}
							});
							htmlCode +=`</div>
											<div id="myChoice">
												<input type="hidden" class="mydftNo" value="\${test.dftNo}">
												<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
											</div>
										</td>
										</tr>`;
						}else if((test.apbPro == '승인' || test.apbPro =='반려') && test.dockind == "근무신청"){
							
							htmlCode +=`<tr class="myAop">
								<td style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
								<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
									<span class="h5 mb-3">\${test.waType}</span>  <span class="text-muted">\${timeResult}</span>
									<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span> 
									<input type="hidden" class="children" value="\${test.dftNo}">
								`
								if(test.apbPro == '승인' ){
									htmlCode +=`<span class="badge rounded-pill bg-success text-white">\${test.apbPro}</span> <br/>`
								}else{
									htmlCode +=`<span class="badge rounded-pill bg-danger text-white">\${test.apbPro}</span> <br/>`
								} 
								htmlCode +=`<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${test.waArsn}　 <strong>근무일자 : </strong>\${test.waDate.split(" ",1)}　 <strong>시간 : </strong>\${test.waStime.split(" ")[1].substring(0, 5)} - \${test.waEtime.split(" ")[1].substring(0, 5)} </span>
								</td>
								<td style="width:300px;"><div id="myImg">`;
								$.each(test.apboxEmpList, function(idx, apbox){
									if(apbox.myImg == null || !apbox.myImg){
										htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
									}else{
										htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
									}
								});
								htmlCode +=`</div>
												<div id="myChoice">
													<input type="hidden" class="mydftNo" value="\${test.dftNo}">
													<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
												</div>
											</td>
											</tr>`;
						}else if((test.apbPro == '승인' || test.apbPro =='반려') && test.dockind == "휴직신청"){
							htmlCode +=`<tr class="myAop">
								<td style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
								<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
									<span class="h5 mb-3">\${test.bkNm}</span>  <span class="text-muted">\${timeResult}</span>
									<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span> 
									<input type="hidden" class="children" value="\${test.dftNo}">
								`
								if(test.apbPro == '승인' ){
									htmlCode +=`<span class="badge rounded-pill bg-success text-white">\${test.apbPro}</span> <br/>`
								}else{
									htmlCode +=`<span class="badge rounded-pill bg-danger text-white">\${test.apbPro}</span> <br/>`
								} 
								htmlCode +=`<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${test.bkRsn}　 <strong>신청일자 : </strong>\${test.apDate.split(" ",1)}　 <strong>기간 : </strong>\${test.bkSdate.split(" ",1)} - \${test.bkEdate.split(" ",1)} </span>
								</td>
								<td style="width:300px;"><div id="myImg">`;
								$.each(test.apboxEmpList, function(idx, apbox){
									if(apbox.myImg == null || !apbox.myImg){
										htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
									}else{
										htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
									}
								});
								htmlCode +=`</div>
												<div id="myChoice">
													<input type="hidden" class="mydftNo" value="\${test.dftNo}">
													<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
												</div>
											</td>
											</tr>`;
						}
					})
					htmlCode +=	"</table>";
					$("#myDocResult").html(htmlCode);
			}
		})
	});
	
	//중요 클릭
	$("#important").on("click",function(){
		Protab = "중요";
		myImportant();
	});
	
	//상세보기 버튼 클릭시
	$(document).on("click",".dtailInfo",function(){
		let parant = $(this).parents("td").siblings(".myDetailInfo")[0];
		parant.click();
	});
	
	//승인/반려/중요 버튼 생성/히든
	$(document).on("mouseover",".myAop",function(){
		let myChoice = $(this).find("#myChoice")[0]
		let aopImg = $(this).find("#myImg")[0]
		myChoice.style.display="block";
		aopImg.style.display="none";
	})
	
	//승인/반려/중요 버튼 생성/히든
	$(document).on("mouseout",".myAop",function(){
		let myChoice = $(this).find("#myChoice")[0]
		let aopImg = $(this).find("#myImg")[0]
		myChoice.style.display="none";
		aopImg.style.display="block";
	})
	
	//승인 및 반려 및 중요 클릭시
	$(document).on("click",".myAopImgs",function(){
		let apbPro = $(this).val(); //진행여부
		let mydftNo = $(this).siblings(".mydftNo")[0].value;
		let rejRsn = $("input[name='rejRsn']").val();
		
		console.log("반려사유 : ",rejRsn )
		let apboxVO = {};
		
		if(apbPro=="반려"){
			apboxVO = {
				"apbPro" : apbPro,
				"dftNo" : mydftNo,
				"rejRsn" : rejRsn
			}
		}else{
			apboxVO = {
				"apbPro" : apbPro,
				"dftNo" : mydftNo,
			}
		}
		
		console.log(apboxVO);
		Swal.fire({
		title: "'"+apbPro+"'처리 하시겠습니까?!!",
		text: "한번 더 확인해 주세요!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#b3b3b3',
		confirmButtonText: 'save'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url : "/approval/updateApbox",
					data : JSON.stringify(apboxVO),
					dataType : "text",
					type : "put",
					contentType : "application/json; charset:utf-8",
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success : function(result){
						console.log("result", result);
						if(result > 0){
							Swal.fire({
							position: 'top-end',
							icon: 'success',
							title: '정상 처리 되었습니다.',
							showConfirmButton: false,
							timer: 1500
						})
						if(apbPro=="중요취소"){
							myImportant();
						}else{
							myDocList();
						}
							
						let myName = "${empVO.empNm}";
						let myMassage = "결제 성공";
						let myData = "결제";
						messageVO = {
							setter:myName,
							massage:apbPro,
							data:myData
						};
					 	 webSocket.send(JSON.stringify(messageVO));								 
						}
					}
				});
			}
		})
	});

	//나의문서 상세정보
	$(document).on("click",".myDetailInfo",function(){
		let dftNo = $(this).children(".children").val();
		let docKind = $(this).children(".dockind").text();
		console.log("체킁1 : ",docKind)
		console.log("체킁2 : ",dftNo)
		$.ajax({
			url : "/approval/selectDetailInfo/"+dftNo+"/"+docKind,
			dataType : "json",
			type:"get",
			success : function(result){
				console.log("통신결과",result);
				let htmlCode = "";
				if(result.dockind == "비품신청"){
					if(result.apbPro == "진행중"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-info morInfo rounded-pill text-dark">진행중</p>`;
					}else if(result.apbPro == "승인"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-success primary rounded-pill text-dark">승인</p>`;
					}else{
						htmlCode += `<p style="margin-left:5px;" class="btn btn-danger morInfo rounded-pill text-dark">반려</p>`;
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
	                                          <img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
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
											</div>`;
											if(result.apbPro=="진행중"){
												htmlCode +=`<div>
																<strong>반려사유  작성 </strong> <br>
				                          		     			<input class="form-control" type="text" name="rejRsn">
				                          		     		</div>`;
											}
                              		     	for(let i=0; i<result.apboxEmpList.length; i++){
                                  		     	if(result.apboxEmpList[i].rejRsn!=null){
                                 		     		htmlCode +=`<div>
														<strong>\${result.apboxEmpList[i].empNm} 님의 반려사유   </strong> <br>
	                                  		     		<input class="form-control" type="text" value="\${result.apboxEmpList[i].rejRsn}" disabled>
	                                  		     	</div>`;
                                  		     	}
                              		     	}
								htmlCode +=`</div>
										</div>	`;
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
				}else if(result.dockind == "휴가신청"){
					if(result.apbPro == "진행중"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-info morInfo rounded-pill text-dark">진행중</p>`;
					}else if(result.apbPro == "승인"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-success primary rounded-pill text-dark">승인</p>`;
					}else{
						htmlCode += `<p style="margin-left:5px;" class="btn btn-danger morInfo rounded-pill text-dark">반려</p>`;
					}
					htmlCode += `
	                              <div class="modal-header">
	                                 <h1 class="modal-title" id="defaultModalLabel">휴가 신청</h1>`
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
                                        <h5 id="modalUpdateName" style= "display:flex;"></h5>&nbsp;
                                        <div id="VacTypeUseDate" class="badge badge-pill badge-success" style="color:white;">
                                           <span class="badge badge-pill badge-success">\${result.vacTypeName}</span>
                                       </div>
	                                    &nbsp;
	                                 <br>
	                                 <hr/>
	                              </div>
	                              <div>
	                              <div class="">
	                                 <p class="mb-2">
	                                    <strong><font style="vertical-align: inherit;">
	                                          <img
	                                          src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
	                                          data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
	                                          alt="느낌표 " title="느낌표 " width="20" height="20"
	                                          class="lzy lazyload--done"
	                                          srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
	                                          <font style="vertical-align: inherit;">휴가 일정</font>
	                                    </font></strong>
	                                 </p>
	                              </div>
	                                    <input type="hidden" name="dftNo" value="">
	                                    <div>
	                                       <strong>휴가 신청 기간</strong><br>
	                                       <input id= "vaapDays" name="vaapDays" class="btn mb-2 btn-outline-success" role="alert" style="width:600px;" value="\${result.vaapDays} 일 " readonly/>
	                                    </div>
	                                    &nbsp;
	                                    <div>
	                                       <strong>휴가 시작일   </strong>
	                                       <input class="form-control" id="start-date" type="text" name="startDate" value="\${result.vaapStart.split(' ',1)} " disabled/>
	                                    </div>
	                                    &nbsp;
	                                    <div>
	                                       <strong>휴가 종료일   </strong>
	                                       <input class="form-control" id="end-date" type="text" name="endDate" value="\${result.vaapEnd.split(' ',1)} " disabled/>
										   </div>
										   &nbsp;`;
										   if(result.vaapType != null){
											   htmlCode += `
											   <div id="halfTime">
												<strong>반차 시간:</strong>
												<select class="form-control" id="example-select" name="vacType">
													<option disabled selected>\${result.vaapType}</option>
													</select>
													</div>`;
												}
												
												htmlCode += `<div class="form-group mb-3">
													<label for="example-textarea">
															<strong>휴가 사유   </strong>
															<font style="vertical-align: inherit;"></font>
														</label>
													<textarea class="form-control" id="example-textarea" rows="10" style="width: 600px; height: 90px;" name="rsn" readonly>\${result.vaapRsn}</textarea>
                                  		     	</div>`;
                                  		     	if(result.apbPro=="진행중"){
                                  		     		htmlCode +=`<div>
														<strong>반려사유 작성 </strong> <br>
	                                  		     		<input class="form-control" type="text" name="rejRsn">
	                                  		     	</div>`;
                                  		     	}
                                  		     	for(let i=0; i<result.apboxEmpList.length; i++){
	                                  		     	if(result.apboxEmpList[i].rejRsn!=null){
	                                 		     		htmlCode +=`<div>
															<strong>\${result.apboxEmpList[i].empNm} 님의 반려사유   </strong> <br>
		                                  		     		<input class="form-control" type="text" value="\${result.apboxEmpList[i].rejRsn}" disabled>
		                                  		     	</div>`;
	                                  		     	}
                                  		     	}
                                  		    htmlCode +=`</div>
											</div>`;
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
				}else if(result.dockind == "근무신청"){
					if(result.apbPro == "진행중"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-info morInfo rounded-pill text-dark">진행중</p>`;
					}else if(result.apbPro == "승인"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-success primary rounded-pill text-dark">승인</p>`;
					}else{
						htmlCode += `<p style="margin-left:5px;" class="btn btn-danger morInfo rounded-pill text-dark">반려</p>`;
					}
					htmlCode += `
	                              <div class="modal-header">
	                                 <h1 class="modal-title" id="defaultModalLabel">근무 신청</h1>`
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
	                                 <p class="mb-2">
	                                    <strong>
	                                    	<font style="vertical-align: inherit;">
	                                          <img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
	                                          <font style="vertical-align: inherit;">근무 신청정보</font>
	                                    	</font>
                                    	</strong>
	                                 </p>
	   
	                                 <div class="card" style="margin: 3%; width: 600px; height: 108px; pointer-events: none;">
	                                    <div class="card-body" style="display: flex; align-items: center;">
	                                        <h5 id="modalUpdateName" style= "display:flex;"></h5>&nbsp;
	                                        <div id="VacTypeUseDate" class="badge badge-pill badge-success" style="color:white;">
	                                           <span class="badge badge-pill badge-success">\${result.waType}</span>
	                                       </div>
	                                    </div>
	   
	                                    &nbsp;
	                                    <div class="card-body">
	                                         <p id="vacationInfo"></p>
	                                         <p id="vacTypeNo" style="display:none;"></p>
	                                    </div>
	                                 </div>
	                                 <br>
	                              </div>
	                              <div>
	                              <div class="">
	                                 <p class="mb-2">
	                                    <strong><font style="vertical-align: inherit;">
	                                          <img src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png" alt="느낌표 " title="느낌표 " width="20" height="20" class="lzy lazyload--done" srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
	                                          <font style="vertical-align: inherit;">근무 날짜</font>
	                                    </font></strong>
	                                 </p>
	                              </div>
	                                    <input type="hidden" name="dftNo" value="\${result.dftNo}">
	                                    <div>
	                                       <strong>근무 일</strong><br>
	                                       <input class="form-control" id="start-date" type="text" name="startDate" value="\${result.waDate.split(' ',1)}" disabled/>
	                                    </div>
	                                    &nbsp;
	                                    
	                                    <div>
	                                       <strong>근무 시작시간</strong><br>
	                                       <input class="form-control" id="start-date" type="text" name="startDate" value="\${result.waStime.split(' ')[1]}" disabled/>
	                                    </div>
	                                    &nbsp;
	                                    
	                                    <div>
	                                       <strong>근무 종료시간</strong>
	                                       <input class="form-control" id="start-date" type="text" name="startDate" value="\${result.waEtime.split(' ')[1]}" disabled/>
	                                    </div>
	                                    &nbsp;
										
											<div class="form-group mb-3">
												<label for="example-textarea">
													<strong>근무신청 사유   </strong>
													<font style="vertical-align: inherit;"></font>
												</label>
												<textarea class="form-control" id="example-textarea" rows="10" style="width: 600px; height: 108px;" name="rsn" readonly>\${result.waArsn} </textarea>
											</div>`;
											
											if(result.apbPro=="진행중"){
												htmlCode += `<div>
													<strong>반려사유  작성 </strong> <br>
	                          		     			<input class="form-control" type="text" name="rejRsn">
	                      		     			</div>`
											}
											
                              		     	for(let i=0; i<result.apboxEmpList.length; i++){
                                  		     	if(result.apboxEmpList[i].rejRsn!=null){
                                 		     		htmlCode +=`<div>
														<strong>\${result.apboxEmpList[i].empNm} 님의 반려사유   </strong> <br>
	                                  		     		<input class="form-control" type="text" value="\${result.apboxEmpList[i].rejRsn}" disabled>
	                                  		     	</div>`;
                                  		     	}
                              		     	}
									htmlCode +=`</div>
											</div>	`;
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
				}else if(result.dockind == "휴직신청"){
					if(result.apbPro == "진행중"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-info morInfo rounded-pill text-dark">진행중</p>`;
					}else if(result.apbPro == "승인"){
						htmlCode += `<p style="margin-left:5px;" class="btn btn-success primary rounded-pill text-dark">승인</p>`;
					}else{
						htmlCode += `<p style="margin-left:5px;" class="btn btn-danger morInfo rounded-pill text-dark">반려</p>`;
					}
					htmlCode += `
	                              <div class="modal-header">
	                                 <h1 class="modal-title" id="defaultModalLabel">휴직 신청</h1>`
								htmlCode += `<div class="row">`;
								$.each(result.apboxEmpList, function(idx, test){
									htmlCode += `
													<table border="1" >
													<tr style ="background-color : #c0c1c2; padding:10px; text-align:center" >
														<th>\${test.bkNm}</th>
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
                                        <h5 id="modalUpdateName" style= "display:flex;"></h5>&nbsp;
                                        <div id="VacTypeUseDate" class="badge badge-pill badge-success" style="color:white;">
                                           <span class="badge badge-pill badge-success">\${result.bkNm}</span>
                                       </div>
	                                    &nbsp;
	                                 <br>
	                                 <hr/>
	                              </div>
	                              <div>
	                              <div class="">
	                                 <p class="mb-2">
	                                    <strong><font style="vertical-align: inherit;">
	                                          <img
	                                          src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
	                                          data-src="https://cdn-icons-png.flaticon.com/128/8426/8426913.png"
	                                          alt="느낌표 " title="느낌표 " width="20" height="20"
	                                          class="lzy lazyload--done"
	                                          srcset="https://cdn-icons-png.flaticon.com/128/8426/8426913.png 4x">
	                                          <font style="vertical-align: inherit;">휴직 일정</font>
	                                    </font></strong>
	                                 </p>
	                              </div>
	                                    <input type="hidden" name="dftNo" value="">
	                                    <div>
	                                       <strong>휴직 신청 일</strong><br>
	                                       <input id= "vaapDays" name="vaapDays" class="btn mb-2 btn-outline-success" role="alert" style="width:600px;" value="\${result.apDate} 일 " readonly/>
	                                    </div>
	                                    &nbsp;
	                                    <div>
	                                       <strong>휴직 시작일   </strong>
	                                       <input class="form-control" id="start-date" type="text" name="startDate" value="\${result.bkSdate.split(' ',1)} " disabled/>
	                                    </div>
	                                    &nbsp;
	                                    <div>
	                                       <strong>휴직 종료일   </strong>
	                                       <input class="form-control" id="end-date" type="text" name="endDate" value="\${result.bkEdate.split(' ',1)} " disabled/>
										   </div>
										   &nbsp;`;
												htmlCode += `<div class="form-group mb-3">
													<label for="example-textarea">
															<strong>휴직 사유   </strong>
															<font style="vertical-align: inherit;"></font>
														</label>
													<textarea class="form-control" id="example-textarea" rows="10" style="width: 600px; height: 90px;" name="rsn" readonly>\${result.bkRsn}</textarea>
                                  		     	</div>`;
                                  		     	if(result.apbPro=="진행중"){
                                  		     		htmlCode +=`<div>
														<strong>반려사유 작성 </strong> <br>
	                                  		     		<input class="form-control" type="text" name="rejRsn">
	                                  		     	</div>`;
                                  		     	}
                                  		     	for(let i=0; i<result.apboxEmpList.length; i++){
	                                  		     	if(result.apboxEmpList[i].rejRsn!=null){
	                                 		     		htmlCode +=`<div>
															<strong>\${result.apboxEmpList[i].empNm} 님의 반려사유   </strong> <br>
		                                  		     		<input class="form-control" type="text" value="\${result.apboxEmpList[i].rejRsn}" disabled>
		                                  		     	</div>`;
	                                  		     	}
                                  		     	}
                                  		    htmlCode +=`</div>
											</div>`;
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
				
			}
		});
	});
	
	
	//진행중 완료 클릭시css변화
	$(".gray_font").on("click",function(){
		$(".gray_font").css({"color":"gray","border":"none"});
		$(this).css({"color":"black","border-bottom":"solid 3px black"});
	});
	
	
	
	//결재문서, 검색 클릭시
	var $suchText = $("#suchText");
	var $kindSelect = $("#kindSelect");
	$("#writeWork").on("click",function(){
		
		let kindSelect = $kindSelect[0].value;
		let suchText = $suchText.val();
		console.log("kindSelect , suchText = ",kindSelect,"/",suchText )
		
		//$(".proLsit").css({"color":"black","border":"none"});
		
		$.ajax({
			url :"/approval/myDocList",
			dataType : "json",
			type : "get",
			success : function(result){
				if(kindSelect == "전체"){
					 myDocListSuch(Protab)
				}else if(kindSelect == "휴가"){
					
				}else if(kindSelect == "신청자"){
					myDocListSuchName(suchText,Protab)
				}else if(kindSelect == "휴직"){
					
				}else if(kindSelect == "비품"){
					
				}else if(kindSelect == "근무"){
					
				}else if(kindSelect == "문서번호"){
					
				}
			} 
		})
	});
	
	
	
	
	
	
	
})//function


//등록일자 시간나타내기
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
   }
var page = 1;


//나의 중요문서
function myImportant(){
	Protab="중요"
	$.ajax({
		url:"/approval/myDocList",
		dataType:"json",
		type:"get",
		success:function(result){
			console.log("result값들",result)
			let htmlCode = "<table class='table table-hover'>";
				$.each(result, function(idx, test){
					const timeResult = convertTimeToRelative(test.applicationDate)
					if(test.apbImportant == '중요' && test.dockind == '비품신청'){
						htmlCode +=`<tr class="myAop">
										<td style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
										<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
											<span class="h5 mb-3">\${test.subject}</span>  <span class="text-muted">\${timeResult}</span>
											<span class="badge rounded-pill bg-warning text-white">\${test.apbImportant}</span>  <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span>  <br/>
											<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${test.fixName}　 <strong>수량 : </strong>\${test.fixNumber}　 <strong>단가 : </strong>\${test.fixPrice}　 <strong>총금액 : </strong>\${test.fixTotal}　 <strong>사유 : </strong>\${test.fixUsage}</span>
											<input type="hidden" class="children" value="\${test.dftNo}">
										</td>
									<td style="width:300px;"><div id="myImg">`;
						$.each(test.apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${test.dftNo}">
											<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요취소"/>
										</div>
									</td>
									</tr>`;
					}else if(test.apbImportant == '중요' && test.dockind == '휴가신청'){
						htmlCode +=`<tr class="myAop">
							<td style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
								<span class="h5 mb-3">\${test.vacTypeName}</span>  <span class="text-muted">\${timeResult}</span>
								<span class="badge rounded-pill bg-warning text-white">\${test.apbImportant}</span>  <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span>  <br/>
								<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${test.vaapRsn}　 <strong>기간 : </strong>\${test.vaapStart.split(" ",1)} ~ \${test.vaapEnd.split(" ",1)} (\${test.vaapDays}일) </span>
								<input type="hidden" class="children" value="\${test.dftNo}">
							</td>
						<td style="width:300px;"><div id="myImg">`;
						$.each(test.apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${test.dftNo}">
											<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요취소"/>
										</div>
									</td>
									</tr>`;
					}else if(test.apbImportant == '중요' && test.dockind == '근무신청'){
						htmlCode +=`<tr class="myAop">
							<td style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
								<span class="h5 mb-3">\${test.waType}</span>  <span class="text-muted">\${timeResult}</span>
								<span class="badge rounded-pill bg-warning text-white">\${test.apbImportant}</span>  <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span>  <br/>
								<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${test.waArsn}　 <strong>근무일자 : </strong>\${test.waDate.split(" ",1)}　 <strong>시간 : </strong>\${test.waStime.split(" ")[1].substring(0, 5)} - \${test.waEtime.split(" ")[1].substring(0, 5)} </span>
								<input type="hidden" class="children" value="\${test.dftNo}">
							</td>
						<td style="width:300px;"><div id="myImg">`;
						$.each(test.apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${test.dftNo}">
											<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요취소"/>
										</div>
									</td>
									</tr>`;							
					}else if(test.apbImportant == '중요' && test.dockind == '휴직신청'){
							htmlCode +=`<tr class="myAop">
							<td style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right">
								<span class="h5 mb-3">\${test.bkNm}</span>  <span class="text-muted">\${timeResult}</span>
								<span class="badge rounded-pill bg-warning text-white">\${test.apbImportant}</span>  <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${test.empNm}</span>  <br/>
								<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${test.dockind}</span>  <span class="text-muted"><strong>휴직 사유 : </strong>\${test.bkRsn}　 <strong>휴직 신청 일자 : </strong>\${test.apDate.split(" ",1)}　 <strong>기간 : </strong>\${test.bkSdate.split(" ",1)} - \${test.bkEdate.split(" ",1)} </span>
								<input type="hidden" class="children" value="\${test.dftNo}">
							</td>
						<td style="width:300px;"><div id="myImg">`;
						$.each(test.apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/insight-basic.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${test.dftNo}">
											<input class="btn btn-success dtailInfo" type="button" value="상세보기"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요취소"/>
										</div>
									</td>
									</tr>`;				
					}
				})
				htmlCode +=	"</table>";
				$("#myDocResult").html(htmlCode);
		}
	})
}

//나의문서 가져오기
function myDocList(){
	$.ajax({
		url:"/approval/myDocList",
		dataType:"json",
		type:"get",
		success:function(result){
			let DateSort = result.sort(function(a,b){
				return b.applicationDate - a.applicationDate;
			});
			console.log("ArraySort된 result값들",result)
			let htmlCode = "<table class='table table-hover'>";
				for(let i=0; i<result.length; i++){
				const timeResult = convertTimeToRelative(result[i].applicationDate)
				
					if(result[i].apbPro == '진행중' && result[i].dockind=='비품신청'){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span> 
										<span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span> <span class="text-muted">\${timeResult}</span> <br/>
										<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
										<input type="hidden" class="children" value="\${result[i].dftNo}">
									</td>
									<td style="width:300px;"><div id="myImg">`;
									
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						
						
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
									
									
					}else if(result[i].apbPro == '진행중' && result[i].dockind=='휴가신청'){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span> 
								<span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>  <span class="text-muted">\${timeResult}</span> <br/>
								<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
								<input type="hidden" class="children" value="\${result[i].dftNo}">
							</td>
							<td style="width:300px;"><div id="myImg">`;
							
							
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
								</tr>`;
						
					}else if(result[i].apbPro == '진행중' && result[i].dockind=='근무신청'){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>
								<span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>  <span class="text-muted">\${timeResult}</span>  <br/>
								<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
								<input type="hidden" class="children" value="\${result[i].dftNo}">
							</td>
							<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].apbPro == '진행중' && result[i].dockind=='휴직신청'){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>
								<span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span> <span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>  <span class="text-muted">\${timeResult}</span>  <br/>
								<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
								<input type="hidden" class="children" value="\${result[i].dftNo}">
							</td>
							<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
					}
				}
				htmlCode +=	"</table>";
				$("#myDocResult").html(htmlCode);
		}
	})
}//end myDocList



//나의전체 결재문서 가져오기
function myDocListSuch(Protab){
	$.ajax({
		url:"/approval/myDocList",
		dataType:"json",
		type:"get",
		success:function(result){
			let DateSort = result.sort(function(a,b){
				return b.applicationDate - a.applicationDate;
			});
			console.log("ArraySort된 result값들",result)
			let htmlCode = "<table class='table table-hover'>";
				for(let i=0; i<result.length; i++){
				const timeResult = convertTimeToRelative(result[i].applicationDate)
					if(Protab == "완료"){
						if(result[i].dockind=='비품신청' && ( result[i].apbPro != "진행중")){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span>`;
										if(result[i].apbPro == "승인"){
											htmlCode +=` <span class="badge rounded-pill bg-success text-white">승인</span>`
										}else{
											htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
										}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
					}else if(result[i].dockind=='휴가신청' && result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span>` 
							if(result[i].apbPro == "승인"){
								htmlCode +=`<span class="badge rounded-pill bg-success text-white">승인</span>`
							}else{
								htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
							}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].dockind=='근무신청' &&  result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>`;
								if(result[i].apbPro == "승인"){
									htmlCode +=`<span class="badge rounded-pill bg-success text-white">승인</span>`
								}else{
									htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].dockind=='휴직신청' &&  result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>`
								
								if(result[i].apbPro == "승인"){
									htmlCode +=`<span class="badge rounded-pill bg-success text-white">승인</span>`
								}else{
									htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}
								
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}
					}else if(Protab == "진행중"){
						if(result[i].dockind=='비품신청' && ( result[i].apbPro == Protab)){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span>`;
										if(result[i].apbPro == "승인"){
											htmlCode +=` <span class="badge rounded-pill bg-primary text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
										}else if(result[i].apbPro == "진행중"){
											htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
										}else{
											htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
										}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
					}else if(result[i].dockind=='휴가신청' && result[i].apbPro == Protab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span>` 
							if(result[i].apbPro == "승인"){
								htmlCode +=` <span class="badge rounded-pill bg-primary text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
							}else if(result[i].apbPro == "진행중"){
								htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
							}else{
								htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
							}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].dockind=='근무신청' && result[i].apbPro == Protab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>`;
								if(result[i].apbPro == "승인"){
									htmlCode +=` <span class="badge rounded-pill bg-primary text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}else if(result[i].apbPro == "진행중"){
									htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}else{
									htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].dockind=='휴직신청' && result[i].apbPro == Protab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>`
								
								if(result[i].apbPro == "승인"){
									htmlCode +=` <span class="badge rounded-pill bg-primary text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}else if(result[i].apbPro == "진행중"){
									htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}else{
									htmlCode +=` <span class="badge rounded-pill bg-danger  text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
								}
								
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}
					}else if(Protab == "중요"){
						if(result[i].dockind=='비품신청' && result[i].apbImportant == Protab){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span>`;
										if(result[i].apbImportant == Protab){
											htmlCode +=`<span class="badge rounded-pill bg-warning text-white">중요</span></span>`
										}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
					}else if(result[i].dockind=='휴가신청' && result[i].apbImportant == Protab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span>` 
								if(result[i].apbImportant == Protab){
											htmlCode +=` <span class="badge rounded-pill bg-warning text-white">중요</span></span>`
								}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].dockind=='근무신청' && result[i].apbImportant == Protab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>`;
								if(result[i].apbImportant == Protab){
									htmlCode +=`<span class="badge rounded-pill bg-warning text-white">중요</span>`
								}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}else if(result[i].dockind=='휴직신청' && result[i].apbImportant == Protab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>`
								if(result[i].apbImportant == Protab){
									htmlCode +=`<span class="badge rounded-pill bg-warning text-white">중요</span>`
								}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
					}
					}
				
				
				
				}
				htmlCode +=	"</table>";
				$("#myDocResult").html(htmlCode);
		}
	})
}//end myDocListSuch

//나의전체 결재문서 이름으로 가져오기
function myDocListSuchName(name,proTab){
	$.ajax({
		url:"/approval/myDocList",
		dataType:"json",
		type:"get",
		success:function(result){
			let DateSort = result.sort(function(a,b){
				return b.applicationDate - a.applicationDate;
			});
			console.log("ArraySort된 result값들",result)
			let htmlCode = "<table class='table table-hover'>";
				for(let i=0; i<result.length; i++){
				const timeResult = convertTimeToRelative(result[i].applicationDate)
					if(proTab == "진행중"){
						if(result[i].dockind=="비품신청" && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span>`;
										
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
						}else if(result[i].dockind=='휴가신청' && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span>` 
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}else if(result[i].dockind=='근무신청' && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>`;
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}else if(result[i].dockind=='휴직신청' && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>`
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}
					}else if(proTab == "완료"){
						if(result[i].dockind=="비품신청" && result[i].empNm == name && result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span>`;
										
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
						}else if(result[i].dockind=='휴가신청' && result[i].empNm == name && result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span>` 
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}else if(result[i].dockind=='근무신청' && result[i].empNm == name && result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>`;
						htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}else if(result[i].dockind=='휴직신청' && result[i].empNm == name && result[i].apbPro != "진행중"){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>`
						if(result[i].apbPro =="승인"){
							htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}else{
							htmlCode +=` <span class="badge rounded-pill bg-danger text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}
					}else if(proTab == "중요"){
						if(result[i].dockind=="비품신청" && result[i].empNm == name && result[i].important == "중요"){
						htmlCode +=`<tr class="myAop" >
									<td  style="width: 50px; height:50px;" ><img src="https://cdn-icons-png.flaticon.com/512/1363/1363564.png" style="width:100%; height:100%;"></td>
									<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
										<span class="h5 mb-3">\${result[i].subject}</span>`;
										
						if(result[i].apbPro =="승인"){
							htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}else{
							htmlCode +=` <span class="badge rounded-pill bg-danger text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>품명 : </strong>\${result[i].fixName}　 <strong>수량 : </strong>\${result[i].fixNumber}　 <strong>단가 : </strong>\${result[i].fixPrice}　 <strong>총금액 : </strong>\${result[i].fixTotal}　 <strong>사유 : </strong>\${result[i].fixUsage}</span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\{apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
										<div id="myChoice">
											<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
											<input class="btn btn-success myAopImgs" type="button" value="승인"/>
											<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
											<input class="btn btn-light myAopImgs" type="button" value="중요" />
										</div>
									</td>
									</tr>`;
						}else if(result[i].dockind=='휴가신청' && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="https://png.pngtree.com/element_pic/00/16/07/105782278879ba2.jpg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].vacTypeName}</span>` 
						if(result[i].apbPro =="승인"){
							htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}else{
							htmlCode +=` <span class="badge rounded-pill bg-danger text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span> <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>  <span class="text-muted"><strong>신청 사유 : </strong>\${result[i].vaapRsn}　 <strong>기간 : </strong>\${result[i].vaapStart.split(" ",1)} ~ \${result[i].vaapEnd.split(" ",1)} (\${result[i].vaapDays}일) </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}else if(result[i].dockind=='근무신청' && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/setting/workIcon/working-hours.png" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].waType}</span>`;
						if(result[i].apbPro =="승인"){
							htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}else{
							htmlCode +=` <span class="badge rounded-pill bg-danger text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].waArsn}　 <strong>근무일자 : </strong>\${result[i].waDate.split(" ",1)}　 <strong>시간 : </strong>\${result[i].waStime.split(" ")[1].substring(0, 5)} - \${result[i].waEtime.split(" ")[1].substring(0, 5)} </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}else if(result[i].dockind=='휴직신청' && result[i].empNm == name && result[i].apbPro == proTab){
						htmlCode +=`<tr class="myAop" >
							<td  style="width: 50px; height:50px;" ><img src="/resources/images/휴직신청.jpeg" style="width:100%; height:100%;"></td>
							<td class="myDetailInfo" data-toggle="modal" data-target=".modal-right" >
								<span class="h5 mb-3">\${result[i].bkNm}</span>`
						if(result[i].apbPro =="승인"){
							htmlCode +=` <span class="badge rounded-pill bg-info text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}else{
							htmlCode +=` <span class="badge rounded-pill bg-danger text-white" style="padding: 5px;">\${result[i].apbPro}</span>`
						}
						htmlCode +=`<span class="h6 mb-3" style="margin-right: 10px;">신청자 : \${result[i].empNm}</span>
									<span class="text-muted">\${timeResult}</span>  <br/>
									<span class="h6 mb-3 dockind" style="margin-right: 10px;">\${result[i].dockind}</span>
									<span class="text-muted"><strong>신청 사유 : </strong>\${result[i].bkRsn}　 <strong>휴직일자 : </strong>\${result[i].bkSdate.split(" ",1)} ~ \${result[i].bkEdate.split(" ",1)}   </span>
									<input type="hidden" class="children" value="\${result[i].dftNo}">
								</td>
								<td style="width:300px;"><div id="myImg">`;
						$.each(result[i].apboxEmpList, function(idx, apbox){
							if(apbox.myImg == null || !apbox.myImg){
								htmlCode +=`<img src="/resources/images/user2.png" alt="결제자사진" class="avatar-img rounded-circle" style="width: 40px; height: 40px;">`
							}else{
								htmlCode +=`<img src="\${apbox.myImg}" alt="\${apbox.myImg}" onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 40px; height:40px;">`
							}
						});
						htmlCode +=`</div>
							<div id="myChoice">
								<input type="hidden" class="mydftNo" value="\${result[i].dftNo}">
								<input class="btn btn-success myAopImgs" type="button" value="승인"/>
								<input class="btn btn-danger myAopImgs" type="button" value="반려"/>
								<input class="btn btn-light myAopImgs" type="button" value="중요" />
							</div>
						</td>
						</tr>`;
						}						
					}
				
					
				}
				htmlCode +=	"</table>";
				$("#myDocResult").html(htmlCode);
		}
	})
}//end myDocListSuch




</script>

<style>
.gray_font{
	margin:0px 10px;
}

.myAopImgs {
	margin: 0px 7px;
}

#myChoice {
	margin: 0px 10px;
	display: none;
}

a {
	text-decoration: none;
	color: black;
}

/* .card-body { */
/* 	height: 1000px; */
/* } */

#contaner {
	width: 90%;
}

#resultFild {
	margin-top: 20px;
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
	overflow: auto;
	
}

#wetreeJs {
	margin: 50px auto;
	width: 60%;
	height: 70%;
}

.mainBtn {
   background: linear-gradient(to right, #05CA1B, #11C2C0);
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
.fe.fe-send {
    vertical-align: middle;
}
.text-muted {
	font-weight: 700;
	font-size: 0.75rem;
	color: gray !important;
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
					<h1 style="padding-left: 12px;">전자결재 문서함</h1>
					<input  id="suchText" type="text" class="form-control" style="position: absolute; right: 99px; width: 200px; height: 40px; border-radius : 10px;">
					<button type="button" id="writeWork" class="mainBtn" style="color: white; position: absolute; right: 20px; width: 70px; height: 40px;">검색</button>
					<select id="kindSelect" style ="border-radius : 10px; position: absolute; right: 308px; width: 80px; height: 40px;">
						<option>전체</option>
						<option>신청자</option>
						<option>휴가</option>
						<option>휴직</option>
						<option>비품</option>
						<option>근무</option>
						<option>문서번호</option>
					</select>					
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
					<a id="progress" class="gray_font h3 mb-3 proLsit" href="#" style="border-bottom : solid 3px black;font-size: 1.09375rem;" >진행중</a>
					<a id="complete" class="gray_font h3 mb-3 proLsit" href="#" style="color : gray;font-size: 1.09375rem;">완료</a> 
					<a id="important" class="gray_font h3 mb-3 proLsit" href="#" style="color : gray;font-size: 1.09375rem;">중요</a>
					<span class="gray_font h3 mb-3" style = "font-size: 1.09375rem; float: right; padding-right:200px;">결재자 사진</span>
				</div>

				<div id="myDocResult" style="margin-top:10px;"></div>

			</div>
		</div>
	</div>
</div>
