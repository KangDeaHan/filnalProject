<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설정</title>
<style>
	div{
/*         border:1px solid blue;            */
	}
	#header {
		height:10vh;
	}
	#cont {
		height:65vh;
		padding-left: 60px;
 		width: 35.32cm; 
		margin-left: 89px;
		border: 2px solid lightgrey;
		border-radius: 15px;
		background: white;
		margin-top: 20px;
	}
	.row1 {
		margin: 3px;
		margin-left: 1.44cm;
		margin-top: 40px;
		display: inline-block;
		width:16vw;
		height:25vh;
		vertical-align: top;
	}
	.row2 {
		margin: 3px;
		margin-left: 100px;
		margin-top: 40px;
		display: inline-block;
		width:16vw;
		height:25vh;
		vertical-align: top;
	}
	.jstree-contextmenu {
	    z-index: 1060; /* 모달의 z-index보다 큰 값으로 설정 */
	}
	.plusIcon {
		display: inline-block;
	}
	
	.plus {
		display: inline-block;
		vertical-align: top;
		margin-top: 3px;
	}
	.plusButton {
		width: 120px;
	}
	.openModal {
		width: 130px;
	}
	.modal-content {
	    max-height: 100vh; /* 스크롤 최대 높이 설정 */
	    overflow-y: auto; /* 세로 스크롤 활성화 */
	}
	.mainImg {
		width: 40px;
		height: 40px;
		display: inline-block;
	}
	.mainH {
		display: inline-block;
		margin-left: 5px;
	}
	.mainLi {
		margin-top: 5px;
		margin-left: 25px;
	}
	.updown {
		display: inline-block;
    	border: 1px solid lightgrey;
        width: 0.1px;
        height: 290px;
    }
    .mainHr {
     	border: 1px solid lightgrey; 
   	    margin-left: -60px;
    }
    .mainHr1 {
    	margin-left: 40px;
    }
    .mainHr1 {
    	margin-top: 0px;
    }
    
    hr {
    	margin-top : 0 !important;
    	border-top: 1px solid #e9ecef !important;
    }
    .mainLi {
     	color: black; 
    }
    .mainFont {
     	color: black; 
/*      	color: rgb(27, 104, 255);  */
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
	.searchBtn {
		background: gray;
		border-radius: 10px;
		padding: 3px 10px;
		color: white;
		cursor: pointer;
		border: 1px solid gray;
		font-weight: 900;
	}
</style>

</head>
<script>
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

$(function(){
	
	var pendingChanges = [];   // 조직도설정 저장버튼누르기전에 변경된 사항들 저장할 배열
	var ptnPending = [];  	   // 직위설정 저장버튼누르기전에 변경된 사항들 저장할 배열
	var positionPending = [];  // 직책설정 저장버튼누르기전에 변경된 사항들 저장할 배열
	var jobPending = [];  	   // 직무설정 저장버튼누르기전에 변경된 사항들 저장할 배열
	var grdPending = [];  	   // 직급설정 저장버튼누르기전에 변경된 사항들 저장할 배열
	
	//조직도 트리
	$("#openModal1").on("click",function(){
		//jstree결과값 받기
		$.ajax({
	        type:'get',
	        url:'/approval/organizationChart',
	        dataType:'json',
	        success: function(data) {
	        	let listOne = data.one;
	        	
	            var company = new Array();
	            
	            company.push({ id: "root", parent: "#", text: "조직도" });
	            // 데이터 받아옴
	            $.each(listOne, function(idx, item){
	            	if(item.uprDcode==0){
	            		item.uprDcode = "root";
	            	}
					company.push({id:item.dcode+"", parent:item.uprDcode+"", text:item.dnm});
	            });
	           	console.log("조직도 트리",company);
	           	
				// 트리 생성
	            $('#compTree').jstree({
	                core: {
	                	data: company,    //데이터 연결
	                	"check_callback": true,
	                    },
	                    types: {
                           'default': {
                                'icon': 'jstree-folder'
                            }
	                           
	                    },
	                    plugins: ['wholerow', 'types','search','contextmenu'],
	                    'contextmenu' : {
	                		"items" : {
	                			"test" : { //사실상 "test"라는 이름은 변수에 가깝기 때문에 뭐든 상관없다 생각한다.
	                        		"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "추가하기",
	                				"action" : function(){
		                					var ref = $('#compTree').jstree(true),
	                						sel = ref.get_selected();
	                						    
	                					if (!sel.length) {
	                						return false;
	                					}
	                						    
	                					sel = sel[0];
	                					console.log("선택된노드:",sel);
	                						    
	                					// 선택한 노드의 id 값을 가져옴
	                			        var selectedNodeId = sel;
	                					var children = ref.get_node(sel).children;
	                					var lastChild = children[children.length - 1];
	                					var nextId = parseInt(lastChild) + 1;
	                					
	                			        console.log("추가된id::",nextId);
	                			        
	                			        if(isNaN(nextId) || nextId == "") {
	                			        	nextId = selectedNodeId + 1;
	                			        }
	                			        
	                			        // 새로운 폴더 노드를 생성하고 선택한 노드의 하위로 추가
	                			        var newNode = {
	                			        	"id": nextId+"",
	                			            "text": "새 조직", // 원하는 폴더 이름으로 수정
	                			            "parent": selectedNodeId,
	                			            "type": "add" // 적절한 유형으로 수정
	                			        };
	                			        
	                			        console.log(newNode);
	                			        
	                			        // 새로운 노드를 생성
	                			        var newFolderNode = ref.create_node(sel, newNode);
										
	                			        console.log("newFolderNode:::",newFolderNode);
	                			        
	                			        // 편집 모드 시작
		                		        ref.edit(newFolderNode, null, function (node, status, canceled) {
		                		            if (status) {
		                		                // 노드 텍스트가 업데이트된 경우
		                		                var updatedNode = ref.get_node(node);
		                		                console.log("노드 텍스트가 업데이트됨:", updatedNode.text);

		                		                // 업데이트된 노드 정보를 처리
		                		                newNode.text = updatedNode.text
		                		                pendingChanges.push(newNode);

		                		            }
		                		        });
	                				}
	                			},
	                			"test1" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "이름 변경",
	                				"action" : function(){
	                					var ref = $('#compTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }
	
		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
	
		                		        // 선택한 노드의 id 값을 가져옴
		                		        var selectedNodeId = sel;
		                		        
		                		     	// 편집 모드 시작
		                		        ref.edit(sel, null, function (node, status, canceled) {
		                		            if (status) {
		                		                // 노드 텍스트가 업데이트된 경우
		                		                var updatedNode = ref.get_node(node);
		                		                updatedNode.type = "update";
		                		                console.log("노드 텍스트가 업데이트됨:", updatedNode);

		                		                // 업데이트된 노드 정보를 처리
		                		                pendingChanges.push(updatedNode);
		                		            }
		                		        });
	                				}
	                			},
	                			"test2" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "삭제하기",
	                				"action" : function(){
	                					var ref = $('#compTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }
	
		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
		                		        
		                		        var children = ref.get_node(sel).children;
		                		        
		                		        console.log("하위조직여부::", children);
		                		        console.log("하위조직length여부::", children.length);
	                		            
		                		        if (children && children.length > 0) {
		                		        	Swal.fire({
		        								title: "삭제 불가",
		        						        text: "하위 조직이 있는 경우 삭제할 수 없습니다. 하위 조직을 먼저 삭제해주세요.",
		        						        icon: "error",
		        						        confirmButtonText: "확인"
		        							});
		                		            return false;
		                		        }
		                		        
		                		        $.ajax({
			       	                		 type : "post",
			       	                	   	 url : "/setting/checkEmp",
			       	                		 data : sel,
			       	                		 contentType: "application/json",
			       	                		 dataType : "json",
			       	                		 beforeSend:function(xhr){
			                       		         xhr.setRequestHeader(header, token);
			                       		     },
			       	                		 success : function(result){
			       	                			 result = parseInt(result);
			       	                			 console.log("result : " + result);
			       	                			 if(result > 0){
			       	                				Swal.fire({
				        								title: "삭제 불가",
				        						        text: "사원이 존재하는 조직은 삭제할 수 없습니다. 사원을 먼저 인사발령 해 주세요.",
				        						        icon: "error",
				        						        confirmButtonText: "확인"
				        							});
			       	                				return false;
			       	                			 }
			       	                			 else{
			       	                				 // 삭제를 확인하기 위한 확인 대화 상자를 표시합니다.
			       	                				 Swal.fire({
													     title: '이 항목을 삭제하시겠습니까?',
													     showCancelButton: true,
													     cancelButtonText: '취소',
													     confirmButtonText: '확인',
													 }).then((result) => {
														 if (result.isConfirmed) {
															// 삭제할 노드 정보를 가져옵니다.
				 		                		             var deletedNode = ref.get_node(sel);

				 		                		             // 선택한 노드를 삭제합니다.
				 		                		             ref.delete_node(sel);


				 		                		             // 삭제한 노드의 id와 type를 pendingChanges 배열에 추가
				 		                		             var deletedNodeInfo = {
				 		                		                 id: deletedNode.id,
				 		                		                 type: "delete"
				 		                		             };
			 		                		             pendingChanges.push(deletedNodeInfo);

			 		                		             console.log("노드 삭제됨:", deletedNodeInfo);
				 		                		         }
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
	                			}
	                		}
	                	}  
	             })
	             //트리 로딩 완료 이벤트
	             .on('loaded.jstree', function(event, data){
	                 
	                 $("#save").on("click",function() {
	                	 console.log("pendingChanges:::",pendingChanges);
	                	 $.ajax({
	                		 type : "post",
	                	   	 url : "/setting/compTreeUp",
	                		 data : JSON.stringify(pendingChanges),
	                		 contentType: "application/json",
	                		 dataType : "json",
	                		 beforeSend:function(xhr){
                		         xhr.setRequestHeader(header, token);
                		     },
	                		 success : function(result){
	                			 console.log("result : " + result);
	                			 Swal.fire({
	 								 title: "저장 완료",
	 						         text: "",
	 						         icon: "success",
	 						         confirmButtonText: "확인"
	 							 }).then(function() {
	 						    	 location.reload();
	 						     });
	                		 },
	                		 error: function (xhr, status, error) {
	                			 console.log("code: " + xhr.status);
	                			 console.log("message: " + xhr.responseText);
	                			 console.log("error: " + error);
	                		 },
	                	    	
	                	 });
	                	 
	                 });
	                    
	             })
	             /*
	             .on('select_node.jstree', function(event, data){
	            	 console.log("선택한노드:", data.node);
	            	 if(data.node.original.id != null){
	            		 
						 $.ajax({
							 url : "/approval/selectEmp?keyword=" + data.node.original.id,
							 dataType : "json",
							 type : "get",
							 success : function(result){
							 }
	            		 });

	            	 };
	             });
				 */
	        },
	        error: function (xhr, status, error) {
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
			},
	   });
		
	});
	
	//직위 트리
	$("#openModal2").on("click",function() {
		//jstree결과값 받기
		$.ajax({
	        type:'get',
	        url:'/setting/selectPtn',
	        dataType:'json',
	        success: function(data) {
	        	
	            var ptn = new Array();
	            
	            ptn.push({ id: "A01", parent: "#", text: "직위" });
	            // 데이터 받아옴
	            $.each(data, function(idx, item){
	            	
					ptn.push({id:item.cmCode+"", parent:item.parentCd+"", text:item.cmNm});
	            });
	           	console.log("직위 트리",ptn);
	           	
				// 트리 생성
	            $('#compPtnTree').jstree({
	                core: {
	                	data: ptn,    //데이터 연결
	                	"check_callback": true,
	                    },
	                    types: {
                           'default': {
                                'icon': 'jstree-folder'
                            }
	                           
	                    },
	                    plugins: ['wholerow', 'types','search','contextmenu'],
	                    'contextmenu' : {
	                		"items" : {
	                			"test1" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "이름 변경",
	                				"action" : function(){
	                					var ref = $('#compPtnTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }
	
		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
	
		                		        // 선택한 노드의 id 값을 가져옴
		                		        var selectedNodeId = sel;
		                		        
		                		     	// 편집 모드 시작
		                		        ref.edit(sel, null, function (node, status, canceled) {
		                		            if (status) {
		                		                // 노드 텍스트가 업데이트된 경우
		                		                var updatedNode = ref.get_node(node);
		                		                updatedNode.type = "update";
		                		                console.log("노드 텍스트가 업데이트됨:", updatedNode);

		                		                // 업데이트된 노드 정보를 처리
		                		                ptnPending.push(updatedNode);
		                		            }
		                		        });
	                				}
	                			},
	                			"test2" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "삭제하기",
	                				"action" : function(){
	                					var ref = $('#compPtnTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }
	
		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
		                		        
		                		        $.ajax({
			       	                		 type : "post",
			       	                	   	 url : "/setting/checkPtnEmp",
			       	                		 data : sel,
			       	                		 contentType: "application/json",
			       	                		 dataType : "json",
			       	                		 beforeSend:function(xhr){
			                       		         xhr.setRequestHeader(header, token);
			                       		     },
			       	                		 success : function(result){
			       	                			 result = parseInt(result);
			       	                			 console.log("result : " + result);
			       	                			 if(result > 0){
			       	                				Swal.fire({
														title: "삭제 불가",
												        text: "현재 사용중인 직위는 삭제할 수 없습니다.",
												        icon: "error",
												        confirmButtonText: "확인"
													});
			       	                				return false;
			       	                			 }
			       	                			 else{
			       	                				 // 삭제를 확인하기 위한 확인 대화 상자를 표시합니다.
			       	                				 Swal.fire({
													     title: '이 항목을 삭제하시겠습니까?',
													     showCancelButton: true,
													     cancelButtonText: '취소',
													     confirmButtonText: '확인',
													 }).then((result) => {
													     if (result.isConfirmed) {
													    	// 삭제할 노드 정보를 가져옵니다.
				 		                		             var deletedNode = ref.get_node(sel);

				 		                		             // 선택한 노드를 삭제합니다.
				 		                		             ref.delete_node(sel);


				 		                		             // 삭제한 노드의 id와 type를 pendingChanges 배열에 추가
				 		                		             var deletedNodeInfo = {
				 		                		                 id: deletedNode.id,
				 		                		                 type: "delete"
				 		                		             };
			 		                		             ptnPending.push(deletedNodeInfo);

			 		                		             console.log("노드 삭제됨:", deletedNodeInfo);
													     }
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
	                			}
	                		}
	                	}  
	             })
	             //트리 로딩 완료 이벤트
	             .on('loaded.jstree', function(event, data){
	            	 
	            	 $("#compPtnTree").jstree("open_all");  //트리 펼치기
	            	 
	                 $("#savePtn").on("click",function() {
	                	 console.log("ptnPending:::",ptnPending);
	                	 
	                	 const ptnList = new Array();
	                	 
	                	 $.each(ptnPending, function(idx, item){
	     	            	
	                		 ptnList.push({cmCode:item.id+"", parentCd:item.parent+"", 
	                			 cmNm:item.text+"", cmGroup:item.group+"", type:item.type+""});
	     	             });

	                	 console.log("ptnList:::", ptnList);
	                	 
	                	 $.ajax({
	                		 type : "post",
	                	   	 url : "/setting/ptnUp",
	                		 data : JSON.stringify(ptnList),
	                		 contentType: "application/json",
	                		 dataType : "json",
	                		 beforeSend:function(xhr){
                		         xhr.setRequestHeader(header, token);
                		     },
	                		 success : function(result){
	                			 console.log("result : " + result);
	                			 Swal.fire({
	 								 title: "저장 완료",
	 						         text: "",
	 						         icon: "success",
	 						         confirmButtonText: "확인"
	 							 }).then(function() {
	 						    	 location.reload();
	 						     });
	                		 },
	                		 error: function (xhr, status, error) {
	                			 console.log("code: " + xhr.status);
	                			 console.log("message: " + xhr.responseText);
	                			 console.log("error: " + error);
	                		 },
	                	    	
	                	 });
	                	 
	                 });
	                    
	             })
	        },
	        error: function (xhr, status, error) {
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
		   	},
	    });
	});
	
	//직책 트리
	$("#openModal3").on("click",function() {
		//jstree결과값 받기
		$.ajax({
	        type:'get',
	        url:'/setting/selectPosition',
	        dataType:'json',
	        success: function(data) {
	        	
	            var position = new Array();
	            
	            position.push({ id: "A02", parent: "#", text: "직책" });
	            // 데이터 받아옴
	            $.each(data, function(idx, item){
	            	
	            	position.push({id:item.cmCode, parent:item.parentCd, text:item.cmNm});
	            });
	           	console.log("직책 트리",position);
	           	
				// 트리 생성
	            $('#compPositionTree').jstree({
	                core: {
	                	data: position,    //데이터 연결
	                	"check_callback": true,
	                    },
	                    types: {
                           'default': {
                                'icon': 'jstree-folder'
                            }
	                           
	                    },
	                    plugins: ['wholerow', 'types','search','contextmenu'],
	                    'contextmenu' : {
	                		"items" : {
	                			"test1" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "이름 변경",
	                				"action" : function(){
	                					var ref = $('#compPositionTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }

		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);

		                		        // 선택한 노드의 id 값을 가져옴
		                		        var selectedNodeId = sel;
		                		        
		                		     	// 편집 모드 시작
		                		        ref.edit(sel, null, function (node, status, canceled) {
		                		            if (status) {
		                		                // 노드 텍스트가 업데이트된 경우
		                		                var updatedNode = ref.get_node(node);
		                		                updatedNode.type = "update";
		                		                console.log("노드 텍스트가 업데이트됨:", updatedNode);

		                		                // 업데이트된 노드 정보를 처리
		                		                positionPending.push(updatedNode);
		                		            }
		                		        });
	                				}
	                			},
	                			"test2" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "삭제하기",
	                				"action" : function(){
	                					var ref = $('#compPositionTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }

		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
		                		        
		                		        $.ajax({
			       	                		 type : "post",
			       	                	   	 url : "/setting/checkPositionEmp",
			       	                		 data : sel,
			       	                		 contentType: "application/json",
			       	                		 dataType : "json",
			       	                		 beforeSend:function(xhr){
			                       		         xhr.setRequestHeader(header, token);
			                       		     },
			       	                		 success : function(result){
			       	                			 result = parseInt(result);
			       	                			 console.log("result : " + result);
			       	                			 if(result > 0){
			       	                				Swal.fire({
				       	 								title: "삭제 불가",
				       	 						        text: "현재 사용중인 직책은 삭제할 수 없습니다.",
				       	 						        icon: "error",
				       	 						        confirmButtonText: "확인"
				       	 							});
			       	                				return false;
			       	                			 }
			       	                			 else{
			       	                				 // 삭제를 확인하기 위한 확인 대화 상자를 표시합니다.
			       	                				 Swal.fire({
													     title: '이 항목을 삭제하시겠습니까?',
													     showCancelButton: true,
													     cancelButtonText: '취소',
													     confirmButtonText: '확인',
													 }).then((result) => {
													     if (result.isConfirmed) {
													    	// 삭제할 노드 정보를 가져옵니다.
				 		                		             var deletedNode = ref.get_node(sel);

				 		                		             // 선택한 노드를 삭제합니다.
				 		                		             ref.delete_node(sel);


				 		                		             // 삭제한 노드의 id와 type를 pendingChanges 배열에 추가
				 		                		             var deletedNodeInfo = {
				 		                		                 id: deletedNode.id,
				 		                		                 type: "delete"
				 		                		             };
			 		                		             positionPending.push(deletedNodeInfo);

			 		                		             console.log("노드 삭제됨:", deletedNodeInfo);
				 		                		         }
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
	                			}
	                		}
	                	}  
	             })
	             //트리 로딩 완료 이벤트
	             .on('loaded.jstree', function(event, data){
	            	 
	            	 $("#compPositionTree").jstree("open_all");  //트리 펼치기
	            	 
	                 $("#savePosition").on("click",function() {
	                	 console.log("positionPending:::", positionPending);
	                	 
	                	 const positionList = new Array();
	                	 
	                	 $.each(positionPending, function(idx, item){
	     	            	
	                		 positionList.push({cmCode:item.id+"", parentCd:item.parent+"", 
	                			 cmNm:item.text+"", cmGroup:item.group+"", type:item.type+""});
	     	             });

	                	 console.log("positionList:::", positionList);
	                	 
	                	 $.ajax({
	                		 type : "post",
	                	   	 url : "/setting/positionSave",
	                		 data : JSON.stringify(positionList),
	                		 contentType: "application/json",
	                		 dataType : "json",
	                		 beforeSend:function(xhr){
	            		         xhr.setRequestHeader(header, token);
	            		     },
	                		 success : function(result){
	                			 console.log("result : " + result);
	                			 Swal.fire({
	 								 title: "저장 완료",
	 						         text: "",
	 						         icon: "success",
	 						         confirmButtonText: "확인"
	 							 }).then(function() {
	 						    	 location.reload();
	 						     });
	                		 },
	                		 error: function (xhr, status, error) {
	                			 console.log("code: " + xhr.status);
	                			 console.log("message: " + xhr.responseText);
	                			 console.log("error: " + error);
	                		 },
	                	    	
	                	 });
	                	 
	                 });
	                    
	             })
	        },
	        error: function (xhr, status, error) {
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
		   	},
	    });
	});
	
	//직무 트리
	$("#openModal4").on("click",function() {
		//jstree결과값 받기
		$.ajax({
	        type:'get',
	        url:'/setting/selectJob',
	        dataType:'json',
	        success: function(data) {
	        	
	            var job = new Array();
	            
	            job.push({ id: "A03", parent: "#", text: "직무" });
	            // 데이터 받아옴
	            $.each(data, function(idx, item){
	            	
	            	job.push({id:item.cmCode, parent:item.parentCd, text:item.cmNm});
	            });
	           	console.log("직무 트리",job);
	           	
				// 트리 생성
	            $('#compJobTree').jstree({
	                core: {
	                	data: job,    //데이터 연결
	                	"check_callback": true,
	                    },
	                    types: {
                           'default': {
                                'icon': 'jstree-folder'
                            }
	                           
	                    },
	                    plugins: ['wholerow', 'types','search','contextmenu'],
	                    'contextmenu' : {
	                		"items" : {
	                			"test1" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "이름 변경",
	                				"action" : function(){
	                					var ref = $('#compJobTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }

		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);

		                		        // 선택한 노드의 id 값을 가져옴
		                		        var selectedNodeId = sel;
		                		        
		                		     	// 편집 모드 시작
		                		        ref.edit(sel, null, function (node, status, canceled) {
		                		            if (status) {
		                		                // 노드 텍스트가 업데이트된 경우
		                		                var updatedNode = ref.get_node(node);
		                		                updatedNode.type = "update";
		                		                console.log("노드 텍스트가 업데이트됨:", updatedNode);

		                		                // 업데이트된 노드 정보를 처리
		                		                jobPending.push(updatedNode);
		                		            }
		                		        });
	                				}
	                			},
	                			"test2" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "삭제하기",
	                				"action" : function(){
	                					var ref = $('#compJobTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }

		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
		                		        
		                		        $.ajax({
			       	                		 type : "post",
			       	                	   	 url : "/setting/checkJobEmp",
			       	                		 data : sel,
			       	                		 contentType: "application/json",
			       	                		 dataType : "json",
			       	                		 beforeSend:function(xhr){
			                       		         xhr.setRequestHeader(header, token);
			                       		     },
			       	                		 success : function(result){
			       	                			 result = parseInt(result);
			       	                			 console.log("result : " + result);
			       	                			 if(result > 0){
			       	                				Swal.fire({
				       	 								title: "삭제 불가",
				       	 						        text: "현재 사용중인 직무는 삭제할 수 없습니다.",
				       	 						        icon: "error",
				       	 						        confirmButtonText: "확인"
				       	 							});
			       	                				return false;
			       	                			 }
			       	                			 else{
			       	                				 // 삭제를 확인하기 위한 확인 대화 상자를 표시합니다.
			       	                				 Swal.fire({
													     title: '이 항목을 삭제하시겠습니까?',
													     showCancelButton: true,
													     cancelButtonText: '취소',
													     confirmButtonText: '확인',
													 }).then((result) => {
													     if (result.isConfirmed) {
													    	// 삭제할 노드 정보를 가져옵니다.
				 		                		             var deletedNode = ref.get_node(sel);

				 		                		             // 선택한 노드를 삭제합니다.
				 		                		             ref.delete_node(sel);


				 		                		             // 삭제한 노드의 id와 type를 pendingChanges 배열에 추가
				 		                		             var deletedNodeInfo = {
				 		                		                 id: deletedNode.id,
				 		                		                 type: "delete"
				 		                		             };
			 		                		             jobPending.push(deletedNodeInfo);

			 		                		             console.log("노드 삭제됨:", deletedNodeInfo);
													     }
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
	                			}
	                		}
	                	}  
	             })
	             //트리 로딩 완료 이벤트
	             .on('loaded.jstree', function(event, data){
	            	 
	            	 $("#compJobTree").jstree("open_all");  //트리 펼치기
	            	 
	                 $("#saveJob").on("click",function() {
	                	 console.log("jobPending:::", jobPending);
	                	 
	                	 const jobList = new Array();
	                	 
	                	 $.each(jobPending, function(idx, item){
	     	            	
	                		 jobList.push({cmCode:item.id+"", parentCd:item.parent+"", 
	                			 cmNm:item.text+"", cmGroup:item.group+"", type:item.type+""});
	     	             });

	                	 console.log("jobList:::", jobList);
	                	 
	                	 $.ajax({
	                		 type : "post",
	                	   	 url : "/setting/jobSave",
	                		 data : JSON.stringify(jobList),
	                		 contentType: "application/json",
	                		 dataType : "json",
	                		 beforeSend:function(xhr){
	            		         xhr.setRequestHeader(header, token);
	            		     },
	                		 success : function(result){
	                			 console.log("result : " + result);
	                			 Swal.fire({
	 								 title: "저장 완료",
	 						         text: "",
	 						         icon: "success",
	 						         confirmButtonText: "확인"
	 							 }).then(function() {
	 						    	 location.reload();
	 						     });
	                		 },
	                		 error: function (xhr, status, error) {
	                			 console.log("code: " + xhr.status);
	                			 console.log("message: " + xhr.responseText);
	                			 console.log("error: " + error);
	                		 },
	                	    	
	                	 });
	                	 
	                 });
	                    
	             })
	        },
	        error: function (xhr, status, error) {
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
		   	},
	    });
	});
	
	//직급 트리
	$("#openModal5").on("click",function() {
		//jstree결과값 받기
		$.ajax({
	        type:'get',
	        url:'/setting/selectGrd',
	        dataType:'json',
	        success: function(data) {
	        	
	            var grd = new Array();
	            
	            grd.push({ id: "A05", parent: "#", text: "직급" });
	            // 데이터 받아옴
	            $.each(data, function(idx, item){
	            	
	            	grd.push({id:item.cmCode, parent:item.parentCd, text:item.cmNm});
	            });
	           	console.log("직급 트리",grd);
	           	
				// 트리 생성
	            $('#compGrdTree').jstree({
	                core: {
	                	data: grd,    //데이터 연결
	                	"check_callback": true,
	                    },
	                    types: {
                           'default': {
                                'icon': 'jstree-folder'
                            }
	                           
	                    },
	                    plugins: ['wholerow', 'types','search','contextmenu'],
	                    'contextmenu' : {
	                		"items" : {
	                			"test1" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "이름 변경",
	                				"action" : function(){
	                					var ref = $('#compGrdTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }

		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);

		                		        // 선택한 노드의 id 값을 가져옴
		                		        var selectedNodeId = sel;
		                		        
		                		     	// 편집 모드 시작
		                		        ref.edit(sel, null, function (node, status, canceled) {
		                		            if (status) {
		                		                // 노드 텍스트가 업데이트된 경우
		                		                var updatedNode = ref.get_node(node);
		                		                updatedNode.type = "update";
		                		                console.log("노드 텍스트가 업데이트됨:", updatedNode);

		                		                // 업데이트된 노드 정보를 처리
		                		                grdPending.push(updatedNode);
		                		            }
		                		        });
	                				}
	                			},
	                			"test2" : {
	                				"separator_before" : false,
	                				"separator_after" : true,
	                				"label" : "삭제하기",
	                				"action" : function(){
	                					var ref = $('#compGrdTree').jstree(true),
	                		            sel = ref.get_selected();

		                		        if (!sel.length) {
		                		            return false;
		                		        }

		                		        sel = sel[0];
		                		        console.log("선택된 노드:", sel);
		                		        
		                		        $.ajax({
			       	                		 type : "post",
			       	                	   	 url : "/setting/checkGrdEmp",
			       	                		 data : sel,
			       	                		 contentType: "application/json",
			       	                		 dataType : "json",
			       	                		 beforeSend:function(xhr){
			                       		         xhr.setRequestHeader(header, token);
			                       		     },
			       	                		 success : function(result){
			       	                			 result = parseInt(result);
			       	                			 console.log("result : " + result);
			       	                			 if(result > 0){
			       	                				Swal.fire({
				       	 								title: "삭제 불가",
				       	 						        text: "현재 사용중인 직급은 삭제할 수 없습니다.",
				       	 						        icon: "error",
				       	 						        confirmButtonText: "확인"
				       	 							});
			       	                				return false;
			       	                			 }
			       	                			 else{
			       	                				 // 삭제를 확인하기 위한 확인 대화 상자를 표시합니다.
			       	                				 Swal.fire({
			       	                				     title: '이 항목을 삭제하시겠습니까?',
			       	                				     showCancelButton: true,
			       	                				     cancelButtonText: '취소',
			       	                				     confirmButtonText: '확인',
			       	                				 }).then((result) => {
			       	                				     if (result.isConfirmed) {
					 		                		        	 // 삭제할 노드 정보를 가져옵니다.
					 		                		             var deletedNode = ref.get_node(sel);

					 		                		             // 선택한 노드를 삭제합니다.
					 		                		             ref.delete_node(sel);


					 		                		             // 삭제한 노드의 id와 type를 pendingChanges 배열에 추가
					 		                		             var deletedNodeInfo = {
					 		                		                 id: deletedNode.id,
					 		                		                 type: "delete"
					 		                		             };
				 		                		             grdPending.push(deletedNodeInfo);

				 		                		             console.log("노드 삭제됨:", deletedNodeInfo);
					 		                		     }
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
	                			}
	                		}
	                	}  
	             })
	             //트리 로딩 완료 이벤트
	             .on('loaded.jstree', function(event, data){
	            	 
	            	 $("#compGrdTree").jstree("open_all");  //트리 펼치기
	            	 
	                 $("#saveGrd").on("click",function() {
	                	 console.log("grdPending:::", grdPending);
	                	 
	                	 const grdList = new Array();
	                	 
	                	 $.each(grdPending, function(idx, item){
	     	            	
	                		 grdList.push({cmCode:item.id+"", parentCd:item.parent+"", 
	                			 cmNm:item.text+"", cmGroup:item.group+"", type:item.type+""});
	     	             });

	                	 console.log("grdList:::", grdList);
	                	 
	                	 $.ajax({
	                		 type : "post",
	                	   	 url : "/setting/grdSave",
	                		 data : JSON.stringify(grdList),
	                		 contentType: "application/json",
	                		 dataType : "json",
	                		 beforeSend:function(xhr){
	            		         xhr.setRequestHeader(header, token);
	            		     },
	                		 success : function(result){
	                			 console.log("result : " + result);
	                			 Swal.fire({
	 								 title: "저장 완료",
	 						         text: "",
	 						         icon: "success",
	 						         confirmButtonText: "확인"
	 							 }).then(function() {
	 						    	 location.reload();
	 						     });
	                		 },
	                		 error: function (xhr, status, error) {
	                			 console.log("code: " + xhr.status);
	                			 console.log("message: " + xhr.responseText);
	                			 console.log("error: " + error);
	                		 },
	                	    	
	                	 });
	                	 
	                 });
	                    
	             })
	        },
	        error: function (xhr, status, error) {
				console.log("code: " + xhr.status);
				console.log("message: " + xhr.responseText);
				console.log("error: " + error);
		   	},
	    });
	});

    //직위 추가
    $("#ptnPlus").on("click", function() {
    	var ptnRef = $('#compPtnTree').jstree(true),
    	ptnSel = ptnRef.get_node('A01')
    		    
    	console.log("선택된노드:",ptnSel);
    		    
    	// 선택한 노드의 id 값을 가져옴
    	var children = ptnRef.get_node(ptnSel).children;
    	var lastChild = children[children.length - 1];
    	var nextId = parseInt(lastChild.substring(2)) + 1;
    	nextId = "A0"+nextId;
    	
        console.log("추가된id::",nextId);
        
        // 새로운 폴더 노드를 생성하고 선택한 노드의 하위로 추가
        var newNode = {
        	"id": nextId,
            "text": "새 직위", // 원하는 폴더 이름으로 수정
            "parent": ptnSel.id,
            "type": "add", // 적절한 유형으로 수정
            "group": "spot"
        };
        
        console.log(newNode);
        
        // 새로운 노드를 생성
        var newFolderNode = ptnRef.create_node(ptnSel, newNode);
    	
        console.log("newFolderNode:::",newFolderNode);
        
        // 편집 모드 시작
        ptnRef.edit(newFolderNode, null, function (node, status, canceled) {
            if (status) {
                // 노드 텍스트가 업데이트된 경우
                var updatedNode = ptnRef.get_node(node);
                console.log("노드 텍스트가 업데이트됨:", updatedNode.text);

                // 업데이트된 노드 정보를 처리
                newNode.text = updatedNode.text
                ptnPending.push(newNode);

            }
        });
    });
    
  	//직책 추가
    $("#positionPlus").on("click", function() {
    	var positionRef = $('#compPositionTree').jstree(true),
    	positionSel = positionRef.get_node('A02')
    		    
    	console.log("선택된노드:", positionSel);
    		    
    	// 선택한 노드의 id 값을 가져옴
    	var children = positionRef.get_node(positionSel).children;
    	var lastChild = children[children.length - 1];
    	var nextId = parseInt(lastChild.substring(2)) + 1;
    	nextId = "A0"+nextId;
    	
        console.log("추가된id::",nextId);
        
        // 새로운 폴더 노드를 생성하고 선택한 노드의 하위로 추가
        var newNode = {
        	"id": nextId,
            "text": "새 직책", // 원하는 폴더 이름으로 수정
            "parent": positionSel.id,
            "type": "add", // 적절한 유형으로 수정
            "group": "position"
        };
        
        console.log(newNode);
        
        // 새로운 노드를 생성
        var newFolderNode = positionRef.create_node(positionSel, newNode);
    	
        console.log("newFolderNode:::",newFolderNode);
        
        // 편집 모드 시작
        positionRef.edit(newFolderNode, null, function (node, status, canceled) {
            if (status) {
                // 노드 텍스트가 업데이트된 경우
                var updatedNode = positionRef.get_node(node);
                console.log("노드 텍스트가 업데이트됨:", updatedNode.text);

                // 업데이트된 노드 정보를 처리
                newNode.text = updatedNode.text
                positionPending.push(newNode);

            }
        });
    });
  	
  	//직무 추가
    $("#jobPlus").on("click", function() {
    	var jobRef = $('#compJobTree').jstree(true),
    	jobSel = jobRef.get_node('A03')
    		    
    	console.log("선택된노드:", jobSel);
    		    
    	// 선택한 노드의 id 값을 가져옴
    	var children = jobRef.get_node(jobSel).children;
    	var lastChild = children[children.length - 1];
    	var nextId = parseInt(lastChild.substring(2)) + 1;
    	nextId = "A0"+nextId;
    	
        console.log("추가된id::",nextId);
        
        // 새로운 폴더 노드를 생성하고 선택한 노드의 하위로 추가
        var newNode = {
        	"id": nextId,
            "text": "새 직무", // 원하는 폴더 이름으로 수정
            "parent": jobSel.id,
            "type": "add", // 적절한 유형으로 수정
            "group": "job"
        };
        
        console.log(newNode);
        
        // 새로운 노드를 생성
        var newFolderNode = jobRef.create_node(jobSel, newNode);
    	
        console.log("newFolderNode:::",newFolderNode);
        
        // 편집 모드 시작
        jobRef.edit(newFolderNode, null, function (node, status, canceled) {
            if (status) {
                // 노드 텍스트가 업데이트된 경우
                var updatedNode = jobRef.get_node(node);
                console.log("노드 텍스트가 업데이트됨:", updatedNode.text);

                // 업데이트된 노드 정보를 처리
                newNode.text = updatedNode.text
                jobPending.push(newNode);
            }
        });
    });
  	
  	//직급 추가
    $("#grdPlus").on("click", function() {
    	var grdRef = $('#compGrdTree').jstree(true),
    	grdSel = grdRef.get_node('A05')
    		    
    	console.log("선택된노드:", grdSel);
    		    
    	// 선택한 노드의 id 값을 가져옴
    	var children = grdRef.get_node(grdSel).children;
    	var lastChild = children[children.length - 1];
    	var nextId = parseInt(lastChild.substring(2)) + 1;
    	nextId = "A0"+nextId;
    	
        console.log("추가된id::",nextId);
        
        // 새로운 폴더 노드를 생성하고 선택한 노드의 하위로 추가
        var newNode = {
        	"id": nextId,
            "text": "새 직급", // 원하는 폴더 이름으로 수정
            "parent": grdSel.id,
            "type": "add", // 적절한 유형으로 수정
            "group": "hobong"
        };
        
        console.log(newNode);
        
        // 새로운 노드를 생성
        var newFolderNode = grdRef.create_node(grdSel, newNode);
    	
        console.log("newFolderNode:::",newFolderNode);
        
        // 편집 모드 시작
        grdRef.edit(newFolderNode, null, function (node, status, canceled) {
            if (status) {
                // 노드 텍스트가 업데이트된 경우
                var updatedNode = grdRef.get_node(node);
                console.log("노드 텍스트가 업데이트됨:", updatedNode.text);

                // 업데이트된 노드 정보를 처리
                newNode.text = updatedNode.text
                grdPending.push(newNode);
            }
        });
    });
    
//     $("#close").on("click",function() {
//     	location.reload();  //조직도 트리 초기화
// 	});
    
//     $("#closePtn").on("click",function() {
//     	location.reload();  //직위 트리 초기화
// 	});
    
//     $("#closePosition").on("click",function() {
//     	location.reload();  //직위 트리 초기화
// 	});
    
//     $("#closeJob").on("click",function() {
//     	location.reload();  //직무 트리 초기화
// 	});
    
//     $("#closeGrd").on("click",function() {
//     	location.reload();  //직급 트리 초기화
// // 		$('#compGrdTree').jstree("destroy");  //직급 트리 초기화
// 	});
	
	//조직도 jsTree 열고/닫기
	let openTreeTemp = false;
	
    $("#openTree").on("click", function () {
    	if(openTreeTemp == false){
   		 	$("#compTree").jstree("open_all");
	   	}else{
	   	 	$("#compTree").jstree("close_all");
	   	}
	   	openTreeTemp = !openTreeTemp;
    });
	
}); //$function 끝

//찾기!
function fSch() { 
    $('#compTree').jstree(true).search($("#schTreeText").val());
}

function fPtnSch() { 
    $('#compPtnTree').jstree(true).search($("#schPtnText").val());
}

function fPositionSch() { 
    $('#compPositionTree').jstree(true).search($("#schPositionText").val());
}

function fJobSch() { 
    $('#compJobTree').jstree(true).search($("#schJobText").val());
}

function fGrdSch() { 
    $('#compGrdTree').jstree(true).search($("#schGrdText").val());
}

</script>

<body>
	
	<!-- 조직도 설정 모달 -->
	<div class="modal fade modal-right1 modal-slide" id="rightModal1" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4>조직도 설정</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<h7>마우스 우클릭 버튼으로 설정해 주세요.</h7><br><br>
					 <button type="button" class="btn mb-2 btn-outline-link" id="openTree"><span class="fe fe-24 fe-book-open"></span></button>
				     <div id="compTree"></div><br>    
				     <input type="text" id="schTreeText" value="">
<!-- 				     <button class="btn mb-2 btn-secondary" onclick="fSch()">검색</button> 검색기능 -->
				     <button class="searchBtn" onclick="fSch()"><span class="fe fe-search fe-16 mr-2"></span>검색</button> <!--검색기능-->
				</div>
				<div class="modal-footer">
					<button class="saveButton" type="button" id="save">저장</button>
					<button type="button" class="cancelBtn" id="close"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 직위 설정 모달 -->
	<div class="modal fade modal-right2 modal-slide" id="rightModal2" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4>직위 설정</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<h7>마우스 우클릭 버튼으로 설정해 주세요.</h7><br><br>
					 <button type="button" class="form-control plusButton" id="ptnPlus"
						 data-toggle="modal" data-target=".modal-right">
						 <div class="plusIcon">
							 <span class="fe fe-24 fe-plus"></span>
						 </div>
						 <div class="plus">직위 추가</div>
					 </button>
					 <br>
				     <div id="compPtnTree"></div><br>    
				     <input type="text" id="schPtnText" value="">
<!-- 				     <button class="btn mb-2 btn-secondary" onclick="fPtnSch()">검색</button> 검색기능 -->
				     <button class="searchBtn" onclick="fPtnSch()"><span class="fe fe-search fe-16 mr-2"></span>검색</button> <!--검색기능-->
				</div>
				<div class="modal-footer">
					<button class="saveButton" type="button" id="savePtn">저장</button>
					<button type="button" class="cancelBtn" id="closePtn"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 직책 설정 모달 -->
	<div class="modal fade modal-right3 modal-slide" id="rightModal3" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4>직책 설정</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<h7>마우스 우클릭 버튼으로 설정해 주세요.</h7><br><br>
					 <button type="button" class="form-control plusButton" id="positionPlus"
						 data-toggle="modal" data-target=".modal-right">
						 <div class="plusIcon">
							 <span class="fe fe-24 fe-plus"></span>
						 </div>
						 <div class="plus">직책 추가</div>
					 </button>
					 <br>
				     <div id="compPositionTree"></div><br>    
				     <input type="text" id="schPositionText" value="">
<!-- 				     <button class="btn mb-2 btn-secondary" onclick="fPositionSch()">검색</button> 검색기능 -->
				     <button class="searchBtn" onclick="fPositionSch()"><span class="fe fe-search fe-16 mr-2"></span>검색</button> <!--검색기능-->
				</div>
				<div class="modal-footer">
					<button class="saveButton" type="button" id="savePosition">저장</button>
					<button type="button" class="cancelBtn" id="closePosition"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 직무 설정 모달 -->
	<div class="modal fade modal-right4 modal-slide" id="rightModal4" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4>직무 설정</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<h7>마우스 우클릭 버튼으로 설정해 주세요.</h7><br><br>
					 <button type="button" class="form-control plusButton" id="jobPlus"
						 data-toggle="modal" data-target=".modal-right">
						 <div class="plusIcon">
							 <span class="fe fe-24 fe-plus"></span>
						 </div>
						 <div class="plus">직무 추가</div>
					 </button>
					 <br>
				     <div id="compJobTree"></div><br>    
				     <input type="text" id="schJobText" value="">
<!-- 				     <button class="btn mb-2 btn-secondary" onclick="fJobSch()">검색</button> 검색기능 -->
				     <button class="searchBtn" onclick="fJobSch()"><span class="fe fe-search fe-16 mr-2"></span>검색</button> <!--검색기능-->
				</div>
				<div class="modal-footer">
					<button class="saveButton" type="button" id="saveJob">저장</button>
					<button type="button" class="cancelBtn" id="closeJob"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 직급 설정 모달 -->
	<div class="modal fade modal-right5 modal-slide" id="rightModal5" tabindex="-1"
		role="dialog" aria-labelledby="defaultModalLabel"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4>직급 설정</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<h7>마우스 우클릭 버튼으로 설정해 주세요.</h7><br><br>
					 <button type="button" class="form-control plusButton" id="grdPlus"
						 data-toggle="modal" data-target=".modal-right">
						 <div class="plusIcon">
							 <span class="fe fe-24 fe-plus"></span>
						 </div>
						 <div class="plus">직급 추가</div>
					 </button>
					 <br>
				     <div id="compGrdTree"></div><br>    
				     <input type="text" id="schGrdText" value="">
<!-- 				     <button class="btn mb-2 btn-secondary" onclick="fGrdSch()">검색</button> 검색기능 -->
				     <button class="searchBtn" onclick="fGrdSch()"><span class="fe fe-search fe-16 mr-2"></span>검색</button> <!--검색기능-->
				</div>
				<div class="modal-footer">
					<button class="saveButton" type="button" id="saveGrd">저장</button>
					<button type="button" class="cancelBtn" id="closeGrd"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div id="myWrap">
		<div id="header" style="margin-left: 15px;">
			<h1 style="margin-left: 25px;margin-top:5px;">설정</h1>
			<hr>
<!-- 			<hr class="mainHr mainHr1"><br> -->
		</div>
		<div id="cont">
			<div class="row1">
				<img src="/resources/images/setting/setmain/company.png" class="mainImg">
				<h5 class="mainH">회사 정보 설정</h5><br><br>
				<li class="mainLi"><a href="/setting/companyinfo" class="mainFont">회사 정보 설정</a></li>
				<li class="mainLi"><a href="/setting/companyseal" class="mainFont">회사 직인 설정</a></li>
				<li class="mainLi"><a href="/setting/companyholiday" class="mainFont">회사 휴일 설정</a></li><br><br>
			</div>
			<div class="updown"></div>
			<div class="row1" style="margin-left: 3.44cm;">
				<img src="/resources/images/setting/setmain/organization.png" class="mainImg">
				<h5 class="mainH">인사 정보 설정</h5><br><br>
				<div data-toggle="modal" data-target=".modal-right1" class="openModal" id="openModal1"><li class="mainLi"><a href="#" class="mainFont">조직도 설정</a></li></div>
				<div data-toggle="modal" data-target=".modal-right2" class="openModal" id="openModal2"><li class="mainLi"><a href="#" class="mainFont">직위 설정</a></li></div>
				<div data-toggle="modal" data-target=".modal-right3" class="openModal" id="openModal3"><li class="mainLi"><a href="#" class="mainFont">직책 설정</a></li></div>
				<div data-toggle="modal" data-target=".modal-right4" class="openModal" id="openModal4"><li class="mainLi"><a href="#" class="mainFont">직무 설정</a></li></div>
				<div data-toggle="modal" data-target=".modal-right5" class="openModal" id="openModal5"><li class="mainLi"><a href="#" class="mainFont">직급 설정</a></li></div>
			</div>
			<div class="updown"></div>
			<div class="row1" style="margin-left:3.44cm;">
				<img src="/resources/images/setting/setmain/work-time.png" class="mainImg">
				<h5 class="mainH">근무 설정</h5><br><br>
				<li class="mainLi"><a href="/setting/setWork" class="mainFont">근무 설정</a><br><br><br><br><br><br>
			</div>
			<div class="updown" style="border:none;"></div>
			<hr class="mainHr mainHr2" style="width: 69.3vw;">
			<div class="row2" style="margin-left: 1.44cm;">
				<img src="/resources/images/setting/setmain/holiday2.png" class="mainImg">
				<h5 class="mainH">휴가 설정</h5><br><br>
				<li class="mainLi"><a href="/setting/setVacation" class="mainFont">휴가 설정</a><br><br><br><br><br>
			</div>
			<div class="updown updown2"></div>
			<div class="row2" style="margin-left: 3.44cm;">
				<img src="/resources/images/setting/setmain/accounts.png" class="mainImg">
				<h5 class="mainH">계정 설정</h5><br><br>
				<li class="mainLi"><a href="/setting/setAuth" class="mainFont">권한 설정</a><br><br><br><br><br>
			</div>
			<div class="updown updown2"></div>
			<div class="row2" style="margin-left: 3.44cm;">
				<img src="/resources/images/setting/setmain/people.png" class="mainImg">
				<h5 class="mainH">만든 사람들</h5><br><br>
				<li class="mainLi"><a href="/setting/setContact" class="mainFont">만든 사람들</a><br><br><br><br><br>
			</div>
		</div>
	</div>
	
</body>
</html>