<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal.EmpVO" var="empVO" />
<%--    <div>세션테스트: ${empVO }</div> --%>
</sec:authorize>
<style>
	.vertnav.navbar {
		height: 900px;
		padding-bottom: 30px;
	}
	#menuMain {
		height: 500px;
	}
	#logoImg {
		width: 150px;
		height: 75px;
 		margin-top: 70px;
		margin-left: 40px;
	}
	
</style>
<script>

   ///////////////////////////웹 소켓////////////////////////////////
   let webSocket;
   const myEmpNo = '${empVO.empNo}';
   
   var myCount = window.localStorage.getItem('count');
   if(myCount == null){
	   myCount = 0;
   }
   
   //연결
   connect();
   function connect() {
      webSocket = new WebSocket("ws://localhost/ws-chat"); // End Point
      //이벤트에 이벤트핸들러 뜽록 
      webSocket.onopen = fOpen; // 소켓 접속되면 짜똥 실행할 함수(fOpen)
      webSocket.onmessage = fMessage; // 써버에서 메쎄징 오면  짜똥 실행할 함수(fMessage) 
   }
   //연결 시 자동실행 함수
   function fOpen() {
	  console.log("웹소켓 열림")
	  notifucationCount()
   }
   // 연결 끊깅 함수
   // disconnect();

   //보낼 함수
   //function send() {  // 써버로 메쎄찡 떤쏭하는 함수
		//webSocket.send("서버로 메세지 전송하는 함수");
	//}

   //받은메세지로 실행할 함수
   function fMessage() {
      let data = event.data;
      console.log("웹소켓받으면 실행할 메소드",JSON.parse(data));
      notifucationCount();
      if(data.massage == "중요취소"){
      	myImportant();
      }else{
	    notifucationCount();
	    myDocList();
      }
   }
   function disconnect() { //써버와 인연 끊는 함쑹
	  console.log("웹소켓 닫힘")
      webSocket.close();
   }
   ///////////////////////////웹 소켓////////////////////////////////

   
   var ObjectArray = [];
   
   ObjectArray[1] = "/resources/images/bell3.png";
   ObjectArray[2] = "/resources/images/bell2.png";
   ObjectArray[3] = "/resources/images/bell3.png";
   ObjectArray[4] = "/resources/images/bell2.png";
   ObjectArray[5] = "/resources/images/bell3.png";
   ObjectArray[6] = "/resources/images/bell2.png";
   ObjectArray[7] = "/resources/images/bell3.png";
   ObjectArray[8] = "/resources/images/bell2.png";
   ObjectArray[9] = "/resources/images/bell3.png";
   ObjectArray[10] = "/resources/images/bell2.png";
   
   var nObjectCnt = 0; 
   
   //초마다 이미지 변경
   function ShowDefaultRotate(){
	   nObjectCnt++;
	   if(nObjectCnt < ObjectArray.length){
		   document.querySelector("#newInfo").src = ObjectArray[nObjectCnt];
		   obTimeOut = setTimeout("ShowDefaultRotate()",900); //1초후 자기자신 호출
	   }else{
		   clearTimeout(obTimeOut);//타임아웃 중지
		   nObjectCnt = 0;
	   }
   } 
   
   //새로운소식 확인
   $(document).on("click",".notiCheck",function(){
   	  console.log("출석체크");
	  let $myNtcnId = $(this).next()[0];
   	  let ntcnId = $myNtcnId.value;
   	  console.log("테스트",ntcnId);
   	  data = {
   			"ntcnId":ntcnId
   	  }
   	  
   	  $.ajax({
	   	 url:"/approval/notiCheck",
	   	 data:JSON.stringify(data),
	   	 type:"post",
	   	 dataType:"text",
	   	 contentType:"application/json; charset:utf-8",
	   	 beforeSend:function(xhr){
			 xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		 },
	   	 success:function(result){
   			console.log("값 : ",result);
   			webSocket.send(myEmpNo);
	        notifucationCount();
			$(location).attr('href', '/approval/workflow');
	   	 }
   	  });
   });
   
 

   $(function() {
	   
   //새로운소식 마우스 오버/마우스 아웃
    $(".newInfoContaner").mouseover(function(){
      $(this).css("background-color","#0000002b");
    });

    $(".newInfoContaner").mouseout(function(){
       $(this).css("background-color","white");
    });
    
	  //커멘드
	 let suchBut = document.querySelector("#suchCom");
	 window.addEventListener("keydown", (e)=> myCom(e))
     var temp = false; 
     var tempArray = [];
     function myCom(e) {

       if(tempArray.length != 0 &&(e.key == "b")&&(temp == true)){
         suchBut.click();
         tempArray.length = 0;
         temp = false;
       }

       if(e.key=="Control" && tempArray.length==0){
    	 temp = true;
         tempArray.push(e)
       }else{
    	  tempArray.length = 0;
       }
       
    }

 	
	  var situation = true;
 	  var $myimg = $("#myProfileImg");
	  //모달창 대신 클릭
      let modalBut = document.querySelector("#inModal");
      $("#modal").on("click", function() {
         console.log("모달창 대신 클릭",modalBut)
         
	   	 if(situation){
	   		situation = false;
	   		
	   		$myimg.css({"width":"40px","height":"40px"})
	   		
// 	 	 	console.log("마이이미지2 : ", myimg);
	 	 }else{
	   		situation = true;
	   		console.log("상태2 : ",myimg );
	 		 
	 	 }
         modalBut.click();
      });
      
      //사원검색
      let suchResult = $("#suchResult")
      $("#such").on("keyup",function(){
    	  
   	  let suchText = $("#such").val();
   	  let schURL = "/common/suchEmp/?keyword="+suchText;
    	  $.ajax({
    		  url:schURL,
    		  dataType : "json",
    		  type : "get",
    		  success : function(result){
    			  console.log("통신결과22",result)
    			  let htmlCode = "";
    			  htmlCode += "<table style='width:400px; margin-top:20px;'>";
    			  for(let i=0; i<result.length; i++){
	    			  htmlCode += "<tr>";
	    			  if(result[i].empImg == null){
		    			  htmlCode += "<td style='width: 60px;'><img style='width:50px; height:50px;' src='/resources/images/insight-basic.png'></td>";
	    			  }else{
		    			  htmlCode += `<td style='width: 60px;'><img style='width:50px; height:50px;' src="\${result[i].empImg}"></td>`;
	    			  }
	    			  htmlCode += "<td><a href='/common/myPage?empNo="+result[i].empNo+"'>"+result[i].empNm+"</a></td>";
	    			  htmlCode += "<td>"+result[i].empNo+"</td>";
	    			  htmlCode += "</tr>";
    			  }
    			  htmlCode += "</table>";
    			  suchResult.html(htmlCode);
    		  }
    	  });
      });
      
      
      
      
      
   })//function
   
   function notifucationCount(){
	      $.ajax ({
	            url:"/approval/notifucationCount",
	            dataType:"json",
	            type:"get",
	            success:function(result){
	               let list = result;
	               console.log("웹소켓 리스트 : ",list)
	               console.log("웹소켓 카운트 : ",list.length)
	               console.log("myCount 카운트 : ",myCount)
	               let count = result.length;
	               
	               if((count > 0) || myCount < count){
	                  let htmlCode = `<span class="badge badge-pill badge-primary">\${count}</span>`;
	                  $("#resultNewInfo").html(htmlCode);
	                  
	                  let infoCode ="<table border=1px; class='table table-hover table-sm'>";
	                  $.each(result, function(idx, test){
	                     infoCode += `<tr>
	                                    <td>
	                                       <div class="notiCheck" style="cursor : pointer;">'\${test.sendEmpNm}'님이 보내신 \${test.ntcnTitle}</div>
	                                       <input class="myNtcnId" type="hidden" value="\${test.ntcnId}">
	                                    </td>
	                                 </tr>
	                     `;
	                  })
	                  if(myCount != count){
	                	  window.localStorage.setItem('count',count);
	                	  ShowDefaultRotate();
	                  }
	                  $("#showNewWindow").html(infoCode);
	               }
	            }
	         })
	   }
   
   
  $(document).ready(function(){
	  console.log("###")
	  str ="";
	  $.ajax({
         url:"/setting/asideAjax",
         type:"get",
         dataType:"json",
         success:function(result){
         	console.log("gg?", result);
         	console.log("결과1" , result.authMenuList)
         	console.log("결과22 : " , result.authentication)
         	
         	 var authMenuList = result.authMenuList;
       		 var authentication = result.authentication;
         	
         	str = `
                <li class="nav-item w-100"><a class="nav-link"
                href="/common/home"> <i class="fe fe-home fe-16"></i> <span
                   class="ml-3 item-text">홈 피드</span>
             </a></li>
             <li class="nav-item w-100"><a class="nav-link"
                href="/personnel/emp"> <i class="fe fe-users fe-16"></i> <span
                   class="ml-3 item-text">구성원</span>
             </a></li>
             <li class="nav-item w-100"><a class="nav-link"
                href="/work/work"> <i class="fe fe-watch fe-16"></i> <span
                   class="ml-3 item-text">근무</span>
             </a></li>
             <li class="nav-item w-100"><a class="nav-link"
                href="/vct/main"> <i class="fe fe-battery-charging fe-16"></i> <span
                   class="ml-3 item-text">휴가</span>
             </a></li>`;
             

			let oneBreak = 0;
			$.each(authentication.authorities,function(idx,auth){
				$.each(result.authMenuList,function(idx2,auth2){
					if(auth2.authrtId == auth.authority && auth2.menuReadCd == 'Y' && auth2.menuNo == 11 && oneBreak ==0  ){
						str += `
					         <li class="nav-item w-100">
								<a class="nav-link" href="/approval/workflow"> 
									<i class="fe fe-file-text fe-16"></i> <span class="ml-3 item-text">전자결재</span>
					        	</a>
				        	 </li>
						`;
						oneBreak = 1;
					}
				});
			});

             str += `<li class="nav-item w-100">
             			<a class="nav-link" href="/approval/fixPage"> <i class="fe fe-box fe-16"></i>
             				<span class="ml-3 item-text">비품신청</span>
            		    </a>
           		    </li>
          			<li class="nav-item dropdown"><a href="#profile" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link"> 
	             		<i class="fe fe-dollar-sign fe-16"></i>
	               		<span class="ml-3 item-text">급여</span>
	           			 </a>
                <ul class="collapse list-unstyled pl-4 w-100" id="profile">
                `;
                
				str += `
		               <a class="nav-link pl-3" href="/salary/payStub"><span
	                  class="ml-1">급여명세서</span></a>
				`;
				
             	oneBreak = 0;
			$.each(authentication.authorities,function(idx,auth){
				$.each(result.authMenuList,function(idx2,auth2){
					if(auth2.authrtId == auth.authority && auth2.menuReadCd == 'Y' && auth2.menuNo == 61 && oneBreak ==0  ){
						str += `
				               <a class="nav-link pl-3"
			                  href="/salary/home"><span
			                  class="ml-1">급여정산</span></a>
						`;
						
						oneBreak = 1;
					}
				});
			});
                //////////////////////////////////
                      
             str +=`</ul></li>
                 <li class="nav-item w-100"><a class="nav-link"
                 href="#"> <i class="fe fe-file fe-16"></i> <span
                    class="ml-3 item-text">문서 증명서</span>
              </a></li>
              `;
             
                
            oneBreak = 0;
			$.each(authentication.authorities,function(idx,auth){
				$.each(result.authMenuList,function(idx2,auth2){
					if(auth2.authrtId == auth.authority && auth2.menuReadCd == 'Y' && auth2.menuNo == 12 && oneBreak ==0  ){
						str += `
				            <li class="nav-item w-100"><a class="nav-link"
				            href="/statistics/employee"> <i class="fe fe-pie-chart fe-16"></i> <span
				               class="ml-3 item-text">인사이트</span>
				         </a></li>
						`;
						
						oneBreak = 1;
					}
				});
			});
              
              
            oneBreak = 0;
			$.each(authentication.authorities,function(idx,auth){
				$.each(result.authMenuList,function(idx2,auth2){
					if(auth2.authrtId == auth.authority && auth2.menuReadCd == 'Y' && auth2.menuNo == 13 && oneBreak ==0  ){
						console.log("성공333");
						
						str += `
				            <li class="nav-item w-100"><a class="nav-link"
				            href="/setting/setmain"> <i class="fe fe-settings fe-16"></i> <span
				               class="ml-3 item-text">설정</span>
				         </a></li>
						`;
						
						oneBreak = 1;
					}
				});
			});
         	$("#menuMain").html(str);
         	
 	   	},
         error: function (error) {
             alert("Error!");
         }
	  });
	  
	  $.ajax({
		  type: "POST",
		  url: "/setting/getLogo",
		  beforeSend:function(xhr){
			 xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		 },
	   	 success:function(result){
	   		 console.log("이미지경로::", result);
	   		 
	   		 $("#logoImg").attr("src", result);
	   		 
	   	 },
	   	 error: function (xhr, status, error) {
			 console.log("code: " + xhr.status);
			 console.log("message: " + xhr.responseText);
			 console.log("error: " + error);
		 },
	  });
  });
  

  $(function(){
	  //마우스 올렷을때 권한 보이기
	  $("#myAuth").on("mouseover",function(){
		  $("#myAuthView").css("display","block");
		  console.log("이거유용1");
	  })
	  
	  $("#myAuth").on("mouseout",function(){
		  $("#myAuthView").css("display","none");
		  console.log("이거유용2")
	  })
  })
  
  
</script>


   
<aside class="sidebar-left border-right bg-white shadow"
   id="leftSidebar" data-simplebar>
   <a href="#"
      class="btn collapseSidebar toggle-btn d-lg-none text-muted ml-2 mt-3"
      data-toggle="toggle"> <i class="fe fe-x"><span class="sr-only"></span></i>
   </a>
   <nav class="vertnav navbar navbar-light">
      <!-- nav bar -->
	      <div class="w-100" style="height:150px;">
	         <!-- /////////////////////// -->
	         <ul class="navbar-nav flex-fill w-100 mb-2 ">
	            <li class="nav-item dropdown  d-flex">
	            	<table style="height: 150px; width:100%">
	            		<tr>
	         	   			<td style="text-align:center;">
				            	  <c:if test="${empVO2.empImg!=null}">	  
				            	 	<a href="/common/myPage?empNo=${empVO.empNo}">          	
				                  		<img id="myProfileImg" src="${empVO2.empImg}" alt="..." onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 110px; height:110px;">
				                  	</a>
				                  </c:if>
				                  <c:if test="${empVO2.empImg==null}">
				                	<a  href="/common/myPage?empNo=${empVO.empNo}">
				                  		<img id="myProfileImg" src="${empVO.empImg}" alt="..." onerror="this.src='/resources/images/insight-basic50x50.png'" class="avatar-img rounded-circle" style="width: 110px; height:110px;">
				                  	</a>
				                  </c:if>
	         	   			</td>
	         	   			<td style="width:80px; text-align:center;">
	         	   				<strong style="font-size: 16px;" id="myAuth">${empVO.empNm}님</strong><br/>
		        				<form action="/logout" method="post" style="text-align:center; position:absolute; " >
		        					<div>
						              <button class="btn mb-2 btn-dark" style="width:70px; padding:0px;" type="submit">로그아웃</button>
						              <sec:csrfInput/>
		        					</div>
				                </form>
				        
	         	   			</td>
	            		</tr>
	            	</table>
	            
				   
	            </li>
	            <li>
	            
	            </li>
	         </ul>
	      </div>
      <ul class="navbar-nav flex-fill w-100 mb-2">
         <li class="nav-item dropdown"  data-toggle="modal"
               data-target=".modal-full"><a id="suchCom" href="#" data-toggle="collapse"
            aria-expanded="false" class="nav-link"> <i class="fe fe-zoom-in"></i>
               <span class="ml-3 item-text">빠른 사원 검색</span><span class="sr-only">(current)</span> <span class="badge badge-pill badge-primary">Ctrl + B</span>
         </a>
         </li>
         </ul>
      <ul class="navbar-nav flex-fill w-100 mb-2">
   	    <li class="nav-item w-100" >
   	    	<a class="nav-link" href="#" id="newPosition"> 
    	    	<img src="/resources/images/bell2.png" id="newInfo">
    	    	<span class="ml-3 item-text">새로운소식</span>
    	    	<span style="padding-left : 50px;" id="resultNewInfo"></span>
   	    	</a>
   	    	
   	    </li>
      </ul>
      <ul id="menuMain" class="navbar-nav flex-fill w-100 mb-2">

         

      </ul>

      <a href="/common/home"><img src="" id="logoImg" onerror="this.src='/resources/images/setting/preview/logo.png'"></a>
      <p style="margin-left: 100px;">ⓒ INSIGHT Corp.</p>
   </nav>
   
</aside>