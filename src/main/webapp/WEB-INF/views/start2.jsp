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
    <select  id="pageSize" onChange="fPage()">
        <option value="5">5개씩</option>
        <option value="10" selected>10개씩</option>
        <option value="15">15개씩</option>
    </select>
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

	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';

    const $tbody = $("#list");
    const $page = $("#page");
    const $pageSize = $("#pageSize");
 
    function ajaxExec(pCurPage){
        let sujiVO  = {
            total:0 ,
            pageSize:$("#pageSize").val(),
            pageCnt:0,
            curPage:pCurPage,       
        }

        $.ajax({
            type:"post",
            url:"/suji/ajaxSuji",
            contentType:"application/json;charset=UTF-8",
            data: JSON.stringify(sujiVO),
            dataType:"json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
        	},
            success:function(data){
                console.log("체킁:",data);
                let pageCnt =  Math.ceil(data.total / sujiVO.pageSize);
                let pageData = data.pageData;

                let listHtml = "";
                for(let i=0; i< pageData.length; i++){
                    let pageCont = pageData[i];
                    listHtml += `
                        <tr>
                            <td>\${i+1}</td>
                            <td>\${pageCont.empNo}</td>
                            <td>\${pageCont.empNm}</td>
                        </tr>
                    `;
                }
                $tbody.html(listHtml);
 
                let pageHtml = "";
                for (let i = 1; i <= pageCnt; i++) {
                    if (i == pCurPage) {
                        pageHtml += `
                    <a href='#' class=active  onclick=fPage(\${i}) > \${i} </a>&nbsp;&nbsp;&nbsp;
                `;
                    } else {
                        pageHtml += `
                    <a href='#'  onclick=fPage(\${i}) > \${i} </a>&nbsp;&nbsp;&nbsp;
                `;
                    }
                }
                $page.html(pageHtml);           



            }
        })
    }
    ajaxExec(1);       // 처음 실행할 때는 1페이지

    function fPage(pPageNum) {
        event.preventDefault();
        if(!pPageNum){
            pPageNum = 1;
        }
        ajaxExec(pPageNum);
    }
</script>
</body>
</html>