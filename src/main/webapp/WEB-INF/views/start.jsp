<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    .active {
        color:red;
        background-color:pink;
    }
</style>
</head>
<body>
 <div id="wrapper">
    <h1>시작페이지 화면</h1>
    <div >
        <table border="1">
            <thead>
                <tr><th>넘버</th><th>컬럼명</th><th>내용</th></tr>
            </thead>
            <tbody id="list">
            </tbody>
        </table>
        <div id="page">

        </div>
    </div>    
 </div>  
<script>
    const $tbody = $("#list");
    const $page = $("#page");
    $.ajax({
        type:"get",
        url:"/salary/wageEmpListAjax",
        dataType:"json",
        success:function(data){
            console.log("체킁:",data);

            let totalCnt = data.length;  // 전체
            let pageSize = 10;           // 페이지당 뿌릴 갯수             
            let pageCnt =  Math.ceil(totalCnt / pageSize);  // 페이지 수

           // alert(pageCnt);
            curPage = 1;
            //alert(location.href.split("?")[1]);
            if(location.href.split("?")[1]){
                curPage = location.href.split("?")[1].split("=")[1];
            }
            
            let startIndex = (curPage -1)* pageSize +1; 
            let endIndex = startIndex + pageSize;  

            if(endIndex >= totalCnt){
                endIndex = totalCnt; 
            }

            //리스트 맹글깅
            let html = '';
            for(let i=startIndex; i<endIndex; i++){
                console.log("오냥?");
                html +=`
                   <tr>
                    <td>\${data[i].dtCodeNm}</td>
                    <td>\${data[i].entCaseNm}</td>
                    <td>\${data[i].jcodeNm}</td>
                  </tr>
                `
            }
            $tbody.html(html);

            //page 출력
            let pageHtml = "";
            for(let i=1;i<=pageCnt; i++){
                if(i== curPage){
                    pageHtml += `
                    <a href='/suji/start?sPage=\${i}'  class=active > \${i} </a>&nbsp;&nbsp;&nbsp;
                `;
                }else {
                pageHtml += `
                    <a href='/suji/start?sPage=\${i}' > \${i} </a>&nbsp;&nbsp;&nbsp;
                `;
                }
            }
            $page.html(pageHtml);
        }
    })
</script>
</body>
</html>