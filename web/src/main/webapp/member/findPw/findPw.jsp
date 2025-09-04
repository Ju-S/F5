<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 27.
  Time: 오후 3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <jsp:include page="/common/Mcommon/MHead.jsp"/>
    <link rel="stylesheet" href="/member/findPw/findPw.css">

</head>


<body>
<div id="container1">
    <div id="left">
        <div id="leftZindex3">
            <div id="leftText">Find<br>PW</div>
        </div>

        <div id="leftZindex2">
            <img src="/member/signin/login.png"/>
        </div>


    </div>
    <div id="right">
        <div id="rightBox">

            <c:choose>
                <c:when test="${not codeVerified}">
                <!-- step1/step2 영역 -->

            <div id="findPwText">비밀번호 찾기</div>

            <div id="findPwBox">
                <input type="text" placeholder="id" id="id" name="id">
                <input type="text" placeholder="email" id="email">
                <button class="mainGameBtn btn btn-primary slide-right" type="button" id="emailBtn">email 인증</button>
            </div>

            <form method="post" action="/IdEmailCode.member">
            <div id="emailCodeBox">
                <input type="text" placeholder="code" id="emailCode" disabled>
                <button class="mainGameBtn btn btn-primary slide-right disabled" type="submit" id="emailCodeBtn" disabled>인증 코드</button>
                <input type="hidden" id="code" name="code">
                <input type="hidden" id="emailHidden" name="email">
                <input type="hidden" id="idHidden" name="id">
            </div>
            </form>
                </c:when>



                <c:otherwise>
                    <form id="change" method="post" action="/changePw.member">
                <!-- 비밀번호 재설정 form 표시 -->
                    <div id="pwChange">비밀번호 변경</div>
                    <input type="text" placeholder="pw" id="pw" name="pw">
                    <input type="text" placeholder="pwCheck" id="pwCheck">
                    <input type="hidden" name="id" value="${verifiedId}">

                    <div id="pwbtnsBox">
                    <button class="btn btn-primary" id="completeBtn" type="submit">비밀번호 변경</button>
                    <button class="btn btn-primary" id="delBtn" type="button">취소</button>
                    </div>
                    </form>
                </c:otherwise>

            </c:choose>

        </div>
    </div>

</div>

<%--스크립트 임포트--%>
<script src="/member/findPw/findPw.js"></script>





</body>
</html>
