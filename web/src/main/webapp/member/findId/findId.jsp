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
    <jsp:include page="/common/Mcommon/MHead.jsp"/>
    <link rel="stylesheet" href="/member/findId/findId.css">
</head>


<body>
<div id="container1">
    <div id="left">
        <div id="leftZindex3">
            <div id="leftText">Welcome<br>Back</div>
        </div>

        <div id="leftZindex2">
            <img src="/member/signin/login.png"/> <%--영서가 이미지 주면 바꿀거임--%>
        </div>


    </div>
    <div id="right">
        <div id="rightBox">

            <form method="post" action="/isLoginOk.member">
                <div id="loginText">아이디 찾기</div>
                <div id="loginBox">
                    <input type="text" placeholder="ID" id="id" name="id">
                    <input type="password" placeholder="PW" id="pw" name="pw">
                </div>

                <div id="loginBtnBox">
                    <button class="mainGameBtn btn btn-primary slide-right" type="submit">로그인</button>
                </div>
            </form>

            <div id="loginFooter">
                <a href="/toFindIdPage.member" id="findId">아이디 찾기</a>
                <div id="verticalLine"></div> <!-- 수직선 추가 -->
                <a href="/toFindPwPage.member" id="findPw">비밀번호 찾기</a>
            </div>

        </div>
    </div>

</div>

<%--스크립트 임포트--%>
<script src="/member/login/login.js"></script>





</body>
</html>
