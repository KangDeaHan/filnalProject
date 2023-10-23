<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한 설정</title>

<style>
	div {
/*    		border: 1px solid blue;   */
	}
	.divline {
		border: 1px solid rgb(219, 218, 218);
		border-radius: 5px;
		display: inline-block;
		width: 250px;
		height: 150px;
		margin: 3px;
	}
	#auth2InsertBtn {
		vertical-align: top;
		float: right;
		width: 150px;
	}
	#auth2Insert {
		display: inline-block;
		vertical-align: top;
		margin-top: 3px;
	}
	#plus, #chevron-right {
		display: inline-block;
	}
	#auth1TypeHead, #auth2TypeHead {
		display: inline-block;
		margin-top: 10px;
	}
	.modal-content {
	    max-height: 100vh; /* 스크롤 최대 높이 설정 */
	    overflow-y: auto; /* 세로 스크롤 활성화 */
	}
	.basic {
		margin-left: 10px;
	}
	.labelBasic {
		font-weight: bold;
	}
	label {
		font-weight: bold;
	}
	#toggleButton, #toggleButton1 {
		margin-left: 131px;
	}
	.leftDiv {
		display: inline-block;
	}
	.rightDiv {
		float: right;
		width: 300px;
		margin-left: 30px;
	}
	.divAuthImg {
		width: 50px;
		height: 50px;
		display: inline-block;
	}
	.pAuthNm {
		font-weight: bold;
	}
	.dropdown {
		float: right;
	}
	.rightDivInput {
		display: inline-block;
		margin-right: 10px;
	}
	.rdi {
		margin-top: 3px;
	}
	#workApInsertBtn {
		width: 150px;
	}
	#empAddDiv {
		display: inline-block;
		vertical-align: top;
		margin-top: 3px;
	}
	.empDiv {
		margin-top: 1px;
	}
	.empDiv1 {
		display: inline-block;
		width: 90px;
	}
	.empDiv2 {
		display: inline-block;
		width: 90px;
		margin-left: 30px;
	}
	.empDiv3 {
		display: inline-block;
		width: 70px;
		margin-left: 30px;
	}
	.empDiv4 {
		display: inline-block;
		width: 110px;
		margin-left: 15px;
	}
	#empMainHead {
		font-weight: bold;
		font-size: large;
		margin-bottom: 5px;
	}
	.empDivHead {
		font-weight: bold;
		/* margin-bottom: 5px; */
		/* font-size: large; */
	}
	.fe-trash-2.sm {
		vertical-align: top;
	 	width: 16px; 
	 	height: 13px; 
	 	padding-top: 0px;
	 	padding-left: 1px;
	 	padding-bottom: 0px;
	 	text-align: center;
	 	border: none;  
	 	margin-bottom:0px;
	}
	.modal{
 		z-index: 1050; 
	}
	#wetreeJsContaner {
		overflow: auto;
	    display: none; 
	    width: 100%; 
	    height: 100%; 
	    background-color: rgba(240, 240, 240, 0.9); 
	    position: fixed;  
	    z-index: 1055;  
	    padding-left: 350px;	
	    padding-top: 140px;
	}
	#wetreeJs {
	    margin: 50px auto;
	    width: 60%;
	    height: 70%;
	}
	.saveButton {
	background: #3783C6;
	border-radius: 10px;
	padding: 10px 20px;
	color: white;
	border: none;
	font-weight: 900;
	} 
	
	.cancelBtn {
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

<script>

	function fAutoFill() {
		$("#authrtNm").val("중간관리자");
		$("#authrtExpln").val("인사, 근무, 급여 업무를 담당하는 담당자");
		$("#menu11").prop('checked', true);
		$("#menu12").prop('checked', true);
		$("#menu13").prop('checked', false);
		$("#menu21").prop('checked', true);
		$("#menu22").prop('checked', true);
		$("#menu23").prop('checked', true);
		$("#menu31").prop('checked', true);
		$("#menu32").prop('checked', true);
		$("#menu33").prop('checked', true);
		$("#menu41").prop('checked', true);
		$("#menu51").prop('checked', true);
		$("#menu61").prop('checked', true);
		$("#menu71").prop('checked', true);
		$("#menu72").prop('checked', true);
		$("#menu73").prop('checked', true);
		$("#menu74").prop('checked', true);
		$("#menu75").prop('checked', true);
	}
	
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';
	
	function fDel(pthis) {
		console.log("authrtSn::", pthis.id.substr(5));
		
		const authrtSn = pthis.id.substr(5);
		
		Swal.fire({
		    title: '이 항목을 삭제하시겠습니까?',
		    showCancelButton: true,
		    cancelButtonText: '취소',
		    confirmButtonText: '확인',
		}).then((result) => {
		    if (result.isConfirmed) {
		    	$.ajax({
		    		type: "POST",
		    		url: "/setting/authDel",
		    		data: authrtSn,
		    		contentType: "application/json; charset=utf-8",
		    		beforeSend:function(xhr){
				       xhr.setRequestHeader(header, token);
				    },
				    success: function(rslt) {
				    	if(rslt == 0) {
				    		Swal.fire({
								title: "삭제 불가",
						        text: "구성원이 존재하는 권한은 삭제할 수 없습니다.",
						        icon: "error",
						        confirmButtonText: "확인"
							});
				    	} else if(rslt == 1) {
				    		Swal.fire({
								title: "삭제 완료",
						        text: "",
						        icon: "success",
						        confirmButtonText: "확인"
							});
				    		$(pthis).closest('.card-body').remove();
				    	}
				    },
				    error: function (xhr, status, error) {
						console.log("code: " + xhr.status);
						console.log("message: " + xhr.responseText);
						console.log("error: " + error);
						Swal.fire({
							title: "삭제 실패",
					        text: "",
					        icon: "error",
					        confirmButtonText: "확인"
						});
					},
		    	});
		    }
		});
		
	}
	
	function fRemove(pthis) {
		console.log("empNo::",pthis.value);
		
		const empNo = pthis.value;
		const authrtId = $("#authrtId2").val();
		const list = [empNo,authrtId];
		
		Swal.fire({
		    title: '이 항목을 삭제하시겠습니까?',
		    showCancelButton: true,
		    cancelButtonText: '취소',
		    confirmButtonText: '확인'
		}).then((rslt) => {
			if (rslt.isConfirmed) {
				$.ajax({
					type: "POST",
					url: "/setting/authEmpDel",
					data: JSON.stringify(list),
					contentType: "application/json; charset=utf-8",
			  		dataType: "text",
					beforeSend:function(xhr){
				       xhr.setRequestHeader(header, token);
				    },
					success: function (rslt) {
						console.log("rslt : " + rslt);
						if(rslt == 1) {
							Swal.fire({
								title: "삭제 완료",
						        text: "",
						        icon: "success",
						        confirmButtonText: "확인"
						    }).then(function() {
						    	$(pthis).parent().remove();
						    });
						} else {
							Swal.fire({
								title: "삭제 실패",
						        text: "",
						        icon: "error",
						        confirmButtonText: "확인"
						    });
						}
					},
					error: function (xhr, status, error) {
						console.log("code: " + xhr.status);
						console.log("message: " + xhr.responseText);
						console.log("error: " + error);
					},
				});
			}
		});
	}
	
	function fAuthUp() {
		event.preventDefault();
		
		const authrtSn = $("#authrtSn1").val();
		const authrtId = $("#authrtId1").val();
		const authrtNm = $("#authrtNm1").val();
		const authrtExpln = $("#authrtExpln1").val();
		
		const menuNo1 = $("input[name=menuNo1]:checked").map(function() {
		    return this.id.substr(5);
		}).get();
		const menuNo2 = $("input[name=menuNo1]:not(:checked)").map(function() {
		    return this.id.substr(5);
		}).get();
		
		let acntAuthorVO = {
			"authrtNm": authrtNm,
			"authrtExpln": authrtExpln,
			"menuNo1": menuNo1,
			"menuNo2": menuNo2,
			"authrtSn": authrtSn,
			"authrtId": authrtId
		}
		
		console.log("acntAuthorVO::", acntAuthorVO);
		
		$.ajax({
			type: "POST",
			url: "/setting/authUp",
			data: JSON.stringify(acntAuthorVO),
			contentType: "application/json;charset=utf-8",
			cache: false,
			dataType: "text",
			beforeSend: function(xhr){
			    xhr.setRequestHeader(header,token);
			},
			success: function(result){
				console.log("수정 결과::", result);
				
				Swal.fire({
					title: "수정 완료",
			        text: "",
			        icon: "success",
			        confirmButtonText: "확인"
			    }).then(function() {
// 			    	location.reload();
			    	//모달 닫기
			        $(".modal-right1").modal("hide");
			        $("#aythrtNmNo"+authrtSn).html(authrtNm);
			    });
			},
			error: function(xhr, status, error){
	            console.log("code: " + xhr.status)
	            console.log("message: " + xhr.responseText)
	            console.log("error: " + error);
	        }
		});
		
	}
	
	function fAuthAdd() {
		event.preventDefault();
		
		const authrtNm = $("#authrtNm").val();
		const authrtExpln = $("#authrtExpln").val();
		//체크된 모든 input 요소의 id값 가져오기
		const menuNo1 = $("input[name=menuNo]:checked").map(function() {
		    return this.id.substr(4);
		}).get();
		const menuNo2 = $("input[name=menuNo]:not(:checked)").map(function() {
		    return this.id.substr(4);
		}).get();
		
		let acntAuthorVO = {
			"authrtNm": authrtNm,
			"authrtExpln": authrtExpln,
			"menuNo1": menuNo1,
			"menuNo2": menuNo2
		}
		
		console.log("acntAuthorVO::", acntAuthorVO);
		
		$.ajax({
			type: "POST",
			url: "/setting/authAdd",
			data: JSON.stringify(acntAuthorVO),
			contentType: "application/json;charset=utf-8",
			cache: false,
			dataType: "text",
			beforeSend: function(xhr){
			    xhr.setRequestHeader(header,token);
			},
			success: function(result){
				console.log("추가 결과::", result);
				
				Swal.fire({
					title: "추가 완료",
			        text: "",
			        icon: "success",
			        confirmButtonText: "확인"
			    }).then(function() {
			        location.reload();
			    });
			},
			error: function(xhr, status, error){
	            console.log("code: " + xhr.status)
	            console.log("message: " + xhr.responseText)
	            console.log("error: " + error);
	        }
		});
	}
	
	let authAdd;
	let authUp;
	
	$(function () {
		authAdd = document.querySelector("#authAddForm");
		authAdd.addEventListener("submit", fAuthAdd);
		
		authUp = document.querySelector("#authUpForm");
		authUp.addEventListener("submit", fAuthUp);
		
		
		//구성원 목록 모달이 열릴 때 이벤트 리스너 추가
		$('.modal-right2').on('show.bs.modal', function (event) {
			$(".mainEmpDiv").html('');
			var modal = $(this);
			// 클릭한 권한 목록의 ID를 가져와서 해당 근무 종류 정보를 조회
			var authId = $(event.relatedTarget).closest('.edit-auth').data('auth-id');
			
			console.log("authId::" , authId);
			
			$.ajax({
				url: '/setting/getAuthInfo/' + authId,
				method: 'GET',
				success: function(data) {
					console.log("data::", data);
					//가져온 데이터를 모달 창에 적용
					modal.find("#authrtSn2").val(data.acntAuthorVO.authrtSn);
					modal.find("#authrtId2").val(data.acntAuthorVO.authrtId);
					
					//권한보유멤버 출력
					const empList = data.authEmpList;
					for(let i=0; i<empList.length; i++) {
						let html = `<div class="empListDiv">
									<div class="empDiv empDiv1">\${empList[i].empNo}</div>
									<div class="empDiv empDiv2">\${empList[i].dnm}</div>
									<div class="empDiv empDiv3">\${empList[i].ptnCode}</div>
									<div class="empDiv empDiv4">\${empList[i].empNm}</div>
									<button class="btn mb-2 btn-outline-danger fe fe-24 fe-trash-2 sm" 
									value="\${empList[i].empNo}" id="delId\${i}" type="button" onclick="fRemove(this)"></button>
									<hr style="margin-top:1px; margin-bottom:1px;">
									</div>`
						$(".mainEmpDiv").append(html);
					}
				},
				error: function(xhr, status, error){
		            console.log("code: " + xhr.status)
		            console.log("message: " + xhr.responseText)
		            console.log("error: " + error);
		        }
			});
		});
		
		//권한 수정 모달이 열릴 떄 이벤트 리스너 추가
		$('.modal-right1').on('show.bs.modal', function (event) {
			var modal = $(this);
			// 클릭한 권한 목록의 ID를 가져와서 해당 근무 종류 정보를 조회
			var authId = $(event.relatedTarget).closest('.edit-auth').data('auth-id');
			
			console.log("authId::" , authId);
			
			// AJAX 요청을 사용하여 서버에서 권한 종류 정보 가져오기
			$.ajax({
				url: '/setting/getAuthInfo/' + authId,
				method: 'GET',
				success: function(data) {
					console.log("data::", data);
					//가져온 데이터를 모달 창에 적용
					modal.find("#authrtSn1").val(data.acntAuthorVO.authrtSn);
					modal.find("#authrtId1").val(data.acntAuthorVO.authrtId);
					modal.find("#authrtNm1").val(data.acntAuthorVO.authrtNm);
					modal.find("#authrtExpln1").val(data.acntAuthorVO.authrtExpln);
					for(let i=0; i<data.authMenuVOList.length; i++) {
						console.log(data.authMenuVOList[i].menuNo, data.authMenuVOList[i].menuReadCd);
						
						if(data.authMenuVOList[i].menuReadCd == 'Y') {
							modal.find('input[name="menuNo1"][id="uMenu' + data.authMenuVOList[i].menuNo + '"]').prop('checked', true);
						}
						if(data.authMenuVOList[i].menuReadCd == 'N') {
							modal.find('input[name="menuNo1"][id="uMenu' + data.authMenuVOList[i].menuNo + '"]').prop('checked', false);
						}
					}
				},
				error: function(xhr, status, error){
		            console.log("code: " + xhr.status)
		            console.log("message: " + xhr.responseText)
		            console.log("error: " + error);
		        }
			});
		});
	});
	
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
                   console.log("선택한노드:", data.node);
                   if(data.node.original.info != null){
	                   $.ajax({
	                      url : "/approval/selectEmp?keyword=" + data.node.original.info,
	                      dataType : "json",
	                      type : "get",
	                      success : function(result){
	                        console.log("result",result);
	                        
	                        Swal.fire({
	            			    title: '구성원을 추가하시겠습니까?',
	            			    showCancelButton: true,
	            			    cancelButtonText: '취소',
	            			    confirmButtonText: '확인'
	            			}).then((rslt) => {
	            			    if (rslt.isConfirmed) {
	            			    	const authrtId = $("#authrtId2").val();
	            			    	
	            			    	const dataList = [authrtId, result.empNo];
	            			    	
	            			    	console.log("dataList::", dataList);
	            			    	
	            			    	$.ajax({
	            			    		type: "POST",
	            			    		url: "/setting/authEmpAdd",
	            			    		data: JSON.stringify(dataList),
	            			    		contentType: "application/json; charset=utf-8",
	            			    		beforeSend:function(xhr){
	            					       xhr.setRequestHeader(header, token);
	            					    },
	            					    success : function(addResult){
	            							console.log("추가결과:", addResult);
	            							if (addResult == "1") {
		            							Swal.fire({
		            								title: "추가 완료",
		            						        text: "",
		            						        icon: "success",
		            						        confirmButtonText: "확인"
		            						    }).then(function() {
		            						    	$('#sujiTree').jstree("destroy");//트리 초기화
		            		                        $("#myModalClose").click();//모달 닫기버튼
		            		                        
		            		                        $.ajax({
		            		                        	type: "POST",
		        	            			    		url: "/setting/getAddEmp",
		        	            			    		data: result.empNo,
		        	            			    		contentType: "application/json; charset=utf-8",
		        	            			    		beforeSend:function(xhr){
		        	            					       xhr.setRequestHeader(header, token);
		        	            					    },
		        	            					    success : function(empVo){
		        	            					    	console.log("empVo::", empVo);
		        	            					    	
		        	            					    	let html = `<div class="empListDiv">
				        	            					    		<div class="empDiv empDiv1">\${empVo.empNo}</div>
						            									<div class="empDiv empDiv2">\${empVo.dnm}</div>
						            									<div class="empDiv empDiv3">\${empVo.ptnCode}</div>
						            									<div class="empDiv empDiv4">\${empVo.empNm}</div>
						            									<button class="btn mb-2 btn-outline-danger fe fe-24 fe-trash-2 sm" 
					            										value="\${empVo.empNo}" type="button" onclick="fRemove(this)"></button>
					            										<hr style="margin-top:1px; margin-bottom:1px;">
					            										</div>`
				            								$(".mainEmpDiv").append(html);
		        	            					    },
		        	            					    error:function(xhr, status, error){
		        	            				            console.log("code: " + xhr.status)
		        	            				            console.log("message: " + xhr.responseText)
		        	            				            console.log("error: " + error);
		        	            				        }
		            		                        });
		            						    });
	            							} else if (addResult == "0") {
	            								Swal.fire({
		            								title: "추가 불가",
		            						        text: "이미 권한이 있습니다.",
		            						        icon: "error",
		            						        confirmButtonText: "확인"
		            						    })
	            								return false;
	            							}
	            						},
	            						error:function(xhr, status, error){
	            				            console.log("code: " + xhr.status)
	            				            console.log("message: " + xhr.responseText)
	            				            console.log("error: " + error);
	            				        }
	            			    	});
	            			    }
	            			});
	                      }
                      });
                   };
                });
           },
           error:function (data) {
               alert("에러");
           }
       });
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
	});
</script>

<body>
	<!-- 구성원 목록 모달창 -->
	<div class="modal fade modal-right2 modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="form-control approvePlusBtn" id="workApInsertBtn"
						data-toggle="modal" data-target="#verticalModal">
						<div id="plus">
							<span class="fe fe-24 fe-plus"></span>
						</div>
						<div id="empAddDiv">구성원 추가</div>
					</button>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<input type="hidden" name="authrtSn2" id="authrtSn2" value="">
				<input type="hidden" name="authrtId2" id="authrtId2" value="">
				<div class="modal-body">
					<div id="empMainHead">구성원 목록</div>
					<div class="empDiv1 empDivHead">사번</div>
					<div class="empDiv2 empDivHead">부서</div>
					<div class="empDiv3 empDivHead">직위</div>
					<div class="empDiv4 empDivHead">성명</div>
					<hr style="margin-top: 5px; margin-bottom: 1px;">
					<div class="mainEmpDiv" id="mainEmpDiv"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="cancelBtn"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 권한 수정 모달창 -->
	<div class="modal fade modal-right1 modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>맞춤 권한 수정</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="authUpForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divSetAuth1">
						<h5>기본 설정</h5><br>
						<input type="hidden" name="authrtSn1" id="authrtSn1" value="">
						<input type="hidden" name="authrtId1" id="authrtId1" value="">
	                    <div class="input-group mb-3">
	                        <label for="authrtNm" class="labelBasic">권한명&emsp;</label>
	                        <input type="text" id="authrtNm1" name="authrtNm1" class="form-control basic" required style="width: 150px; margin-left: 65px;">
	                    </div>
						<div class="input-group mb-3">
	                        <label for="authrtExpln" class="labelBasic">권한설명</label>
	                        <textarea class="form-control basic" id="authrtExpln1" name="authrtExpln1" rows="3" style="width: 150px; margin-left: 65px;"></textarea>
                      	</div>
                      	<br><br>
                      	<h5>메뉴 권한 설정</h5><br>
                      	<div class="leftDiv">
                      		<c:forEach var="menu1VO" items="${menuList1}" varStatus="status">
                      			<c:if test="${menu1VO.menuNo eq '1'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '2'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '3'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '4'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '5'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '6'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '7'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      		</c:forEach>
                      	</div>
	                    
	                    <div class="rightDiv">
	                    	<c:forEach var="menu2VO" items="${menuList2}" varStatus="status">
	                    		<c:if test="${menu2VO.parentMno eq '1'}">
									<div class="form-check rightDivInput">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '2'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '3'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '4'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px; margin-right: 150px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '5'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px; margin-right: 150px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '6'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px; margin-right: 150px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '7'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo1" id="uMenu${menu2VO.menuNo}">
										<label class="form-check-label" for="uMenu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
							</c:forEach>
	                    </div>
					</div>
					<br><br><br>
					<div class="modal-footer">
						<button class="saveButton" id="authUp">수정</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 맞춤 권한 추가 모달창 -->
	<div class="modal fade modal-right modal-slide" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5>맞춤 권한 추가</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<form action="" id="authAddForm" method="POST">
				<sec:csrfInput />
					<div class="modal-body" id="divSetAuth">
						<h5>기본 설정</h5><br>
	                    <div class="input-group mb-3">
	                        <label for="authrtNm" class="labelBasic">권한명&emsp;</label>
	                        <input type="text" id="authrtNm" name="authrtNm" class="form-control basic" required style="width: 150px; margin-left: 65px;">
	                    </div>
						<div class="input-group mb-3">
	                        <label for="authrtExpln" class="labelBasic">권한설명</label>
	                        <textarea class="form-control basic" id="authrtExpln" name="authrtExpln" rows="3" style="width: 150px; margin-left: 65px;"></textarea>
                      	</div>
                      	<br><br>
                      	<h5>메뉴 권한 설정</h5><br>
                      	<div class="leftDiv">
                      		<c:forEach var="menu1VO" items="${menuList1}" varStatus="status">
                      			<c:if test="${menu1VO.menuNo eq '1'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '2'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '3'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '4'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '5'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '6'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      			<c:if test="${menu1VO.menuNo eq '7'}">
                      				<label for="${menu1VO.menuNo}" class="leftDivLabel" style="margin-top: 10px;">${menu1VO.menuNm}</label><br>
                      			</c:if>
                      		</c:forEach>
                      	</div>
	                    
	                    <div class="rightDiv">
	                    	<c:forEach var="menu2VO" items="${menuList2}" varStatus="status">
	                    		<c:if test="${menu2VO.parentMno eq '1'}">
									<div class="form-check rightDivInput">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '2'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '3'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '4'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px; margin-right: 150px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '5'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px; margin-right: 150px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '6'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px; margin-right: 150px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
								<c:if test="${menu2VO.parentMno eq '7'}">
									<div class="form-check rightDivInput" style="margin-top: 17.5px;">
										<input class="form-check-input sm rdi" type="checkbox" name="menuNo" id="menu${menu2VO.menuNo}">
										<label class="form-check-label" for="menu${menu2VO.menuNo}">
											${menu2VO.menuNm} 
										</label>
									</div>
								</c:if>
							</c:forEach>
	                    </div>
					</div>
					<br><br><br>
					<div class="modal-footer">
						<button type="button" class="cancelBtn" onclick="fAutoFill()">자동채우기</button>
						<button class="saveButton" id="authSave">저장</button>
						<button type="button" class="cancelBtn"
							data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-top:5px;"><a href="/setting/setmain"><span class="fe fe-24 fe-chevron-left" style="color:black; margin-right:10px;"></span></a>권한 설정</h1>
			<hr>
			<br>
		</div>
		<div class="card shadow mb-4">
			<div class="card-body" id="auth1-body">
				<div id="auth1HeadDiv">
					<h5 id="auth1TypeHead">기본 권한</h5>
				</div>
				<br>
				<c:forEach var="auth1VO" items="${authList1}" varStatus="status">
					<div class="card-body divline edit-auth" data-auth-id="${auth1VO.authrtSn}">
						<img src="/resources/images/setting/administrator1.png" class="divAuthImg">
						<div class="dropdown">
	                        <button class="btn btn-sm dropdown-toggle more-vertical" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                            <span class="text-muted sr-only">Action</span>
	                        </button>
	                        <div class="dropdown-menu dropdown-menu-right" style="">
	                            <div data-toggle="modal" data-target=".modal-right1" class="openModal" id="openModal1"><a class="dropdown-item" href="#">수정하기</a></div>
	                            <div data-toggle="modal" data-target=".modal-right2" class="openModal" id="openModal1"><a class="dropdown-item" href="#">구성원 목록</a></div>
	                        </div>
	                    </div>
						<br><br><br>
						<p class="pAuthNm" id="authrtNmNo${auth1VO.authrtSn}">${auth1VO.authrtNm}</p>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="card shadow mb-4">
			<div class="card-body" id="auth2-body">
				<div id="auth2HeadDiv">
					<h5 id="auth2TypeHead">커스텀 권한</h5>
					<button type="button" class="form-control" id="auth2InsertBtn" data-toggle="modal"
						data-target=".modal-right">
						<div id="plus">
							<span class="fe fe-24 fe-plus"></span>
						</div>
						<div class="authInsert" id="auth2Insert">맞춤 권한 추가</div>
					</button>
				</div>
				<br>
				<!-- this를 쓰거나, divline2.eq(0) 를써서 데이터를 넘긴다 -->
				<c:forEach var="auth2VO" items="${authList2}" varStatus="status">
					<div class="card-body divline edit-auth" data-auth-id="${auth2VO.authrtSn}" <c:if test="${auth2VO.authrtYn eq 'N'}">style="display: none;"</c:if>>
						<img src="/resources/images/setting/administrator2.png" class="divAuthImg">
						<div class="dropdown">
	                        <button class="btn btn-sm dropdown-toggle more-vertical" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                            <span class="text-muted sr-only">Action</span>
	                        </button>
	                        <div class="dropdown-menu dropdown-menu-right" style="">
	                            <div data-toggle="modal" data-target=".modal-right1" class="openModal" id="openModal1"><a class="dropdown-item" href="#">수정하기</a></div>
	                            <div data-toggle="modal" data-target=".modal-right2" class="openModal" id="openModal1"><a class="dropdown-item" href="#">구성원 목록</a></div>
	                            <a class="dropdown-item" id="delNo${auth2VO.authrtSn}" href="#" onclick="fDel(this)">삭제하기</a>
	                        </div>
	                    </div>
						<br><br><br>
						<p class="pAuthNm" id="aythrtNmNo${auth2VO.authrtSn}">${auth2VO.authrtNm}</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>