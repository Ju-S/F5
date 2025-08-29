<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 27.
  Time: 오후 3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/member/login/login.css">


</head>


<body>
<div id="container1">
    <div id="left">
        <div id="leftZindex3">
            <div id="leftText">Welcome<br>Back</div>
        </div>

        <div id="leftZindex2">
            <img src="/member/login/loginimg.jpg"/> <%--영서가 이미지 주면 바꿀거임--%>
        </div>


    </div>
    <div id="right">
        <div id="rightBox">
            <div id="loginText">Login</div>
            <div id="loginBox">
                <input type="text" placeholder="ID" id="id">
                <input type="password" placeholder="PW" id="pw">

            </div>

            <div id="loginBtnBox">
                <button class="mainGameBtn btn btn-primary slide-right">로그인</button>
            </div>
            <div id="loginFooter">
                <a href="/" id="findId">아이디 찾기</a>
                <div id="verticalLine"></div> <!-- 수직선 추가 -->
                <a href="/" id="findPw">비밀번호 찾기</a>
            </div>
        </div>
    </div>

</div>


</body>
</html>
