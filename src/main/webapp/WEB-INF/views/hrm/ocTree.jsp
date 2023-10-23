<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//static.jstree.com/3.3.15/assets/bootstrap/css/bootstrap.min.css" />   
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<!-- jQuery plugin으로 맹글어졌으닝 jquery 필수 포함 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" ></script>
<!-- jstree lib 포함 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js"></script>
</head>
<body>
     <!-- 요거이 따악 기본!, 추가적인 검색과 문서읽기 능력을 키워성 -->
    <!-- jsTree를 넣을 위치를 잡아 줌!-->
    <div id="sujiTree"></div>
    <input type="text"  id="schText" value="">
     <button onclick="fSch()">차자볼까낭</button>
<script>
	
    //찾깅!
    function fSch(){
        // true가 있으면 만들어진 걸 가져오공, 없으면 새로 맹근다고 되어있는뎅,
        // 설명이 쪼메 부족!
        $('#sujiTree').jstree(true).search($("#schText").val());
    }


   console.log("찌거보장1",$.jstree.defaults.core.themes.variant);
   // 디폴트값 강제 설정법!, 리스트는 나중에 찾기롱
   $.jstree.defaults.core.themes.variant = "large";
   console.log("찌거보장2",$.jstree.defaults.core.themes.variant);

   //AJAX 사용!(요게 중요!)
   /* 보통은 이걸로 충분! 
   $('#sujiTree').jstree({
        "plugins" : [ "search" ],   // search시 search 플러그인 추가
        'core' : {
            'data' : {
                'url' : function (node) {
                            return "alldata.json";
                        }
            },
            check_callback: true  // 주의 요거이 없으면, create_node 안먹음
        }
    });*/
 

    /* 위에꺼는 URL과 보내는 data만 쓸 수 있어서, 세세한 제어가 
       불가능한 뎅, 그런 경우 아래처럼 직접 ajax를 넣어서 제어한당!*/
    $('#sujiTree').jstree({
    'core' : {
        'data' : function (obj, cb) {
                let xhr = new XMLHttpRequest();
                xhr.open("get","alldata.json",true);
                xhr.onreadystatechange = function(){
                    if(xhr.readyState == 4 && xhr.status == 200){
                        cb.call(this,JSON.parse(xhr.responseText));
                    }
                }
                // Loading 메세지가 계속 나오는 건 보통 data가 없는 경우
                xhr.send();
        }
    }});
    

  /*이벤트 등록법
   $('#sujiTree').on("changed.jstree", function (e, data) {
        //console.log("체킁:",data); node에 필요한 정보가 없는 경우에 사용
        console.log("실제로 많이 쓰는 건 node정보:",data.node);
        console.log("실제로 많이 쓰는 건 node정보:",data.node.original.hansome);
   });
   */

   // node open이벤토 (이벤트명은 문서에서 껌색해서 복사 붙여넣깅)

   // 상태변수, 요런걸 초보자들이 잘 못해용!
   let isAdded = false;  // 초기값 false, 아직 안 추가 되었다는 의미!

   $('#sujiTree').on("open_node.jstree", function (e, data) {
       console.log("열린노드:", data.node );

       if( !isAdded && data.node.id == 'S4'){
        alert("왔냥???");
            // chile node 강제로 맹글깅
        $("#sujiTree").jstree(true).create_node("S4", 
            {"text":"대전스타일","id":"S42"},
             'last', function() {
                        alert("추가 되었을거예용");
            }
        );
        isAdded = true;  // 추가 되었음!
       }
   });

   // node select(선택) 이벤토
   $('#sujiTree').on("select_node.jstree", function (e, data) {
       console.log("선택한노드:", data.node );
   });



   /* 아래 3개는 같은 동작
   $('#jstree').jstree(true).select_node('child_node_1');
   $('#jstree').jstree('select_node', 'child_node_1');
   $.jstree.reference('#jstree').select_node('child_node_1');
   */
</script>
</body>
</html>