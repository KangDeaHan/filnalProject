<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.prof {
    margin: 20px;
    margin-right: 40px;
}
.det {
	margin: 20px;
}
#prof {
    height: 180px;
    width: 180px;
    border-radius: 40px;
}
#upd {
    height: 40px;
    width: 40px;
}
#overlay
{
    padding:10px;
    position: absolute;
    margin-left: 140px;
    margin-top: 140px;
    color: aliceblue;
    background-color: rgb(75, 75, 236);
    border-radius: 40px;
}
</style>

<script>
$(function() {
	$('#prof').before(`<span id="overlay" class="fe fe-24 fe-camera" ></span>`);
});

</script>


<body>

    <div>header
        <h6>구성원/<h6></h6></h6>
    </div>

    <div>body
        <div style="position: relative; display: flex; align-items: stretch; width: 100%;">
            <div class="prof">
                <img id="prof" src="/resources/images/채원.PNG" alt="프로필사진">              
            </div>
            <div class="det">
                <div id="nm">
                    <h3>이름받기</h3>
                </div>
                <div id="if">
                    <p>조직 정보입력</p>
                    <p>직무 정보입력</p>
                </div>
                <div id="butn" style="position: relative; display: flex; align-items: stretch; width: 100%;">
                    <span class="fe fe-24 fe-phone"></span>
                    <span class="fe fe-24 fe-mail"></span>
                    <span>재직상태</span>
                </div>
            </div>
        
        </div>



    </div>


    <div>footer</div>



</body>
</html>