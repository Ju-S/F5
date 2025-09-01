<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Mcommon/MHead.jsp"/>

    <link rel="stylesheet" href="/index.css">
    <link rel="stylesheet" href="/common/Mcommon/MHeader.css">

</head>


<body>

<%--컨테이너--%>
<div id="container1">


<%-- M공용 헤더 --%>
<%--<jsp:include page="/common/Mcommon/MHeader.jsp"/>--%>
<div class="header">
    <div class="logoBox">
        <img src="/index_img/Union.svg"/>
    </div>

    <div class="headerBtn">
        <button type="button" class="btn btn-outline-light" id="signinBtn">회원가입</button>
        <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
    </div>
</div>







    <%--왼쪽 게임 네비--%>
    <div id="left">
        <div class="game game1"><img src="/index_img/home_sub_js.svg"/></div>
        <div class="game game2"><img src="/index_img/home_sub_jw.svg"/></div>
        <div class="game game3"><img src="/index_img/home_sub_kj.svg"/></div>
        <div class="game game4"><img src="/index_img/home_sub_mk.svg"/></div>
        <div class="game game5"><img src="/index_img/home_sub_ys.svg"/></div>
    </div>

    <%--오른쪽 메인게임--%>
    <div id="right">
        <div class="mainGame game1 default">
            <img class src="/index_img/desktop_home_js.svg"/>
            <div class="mainGameTitle slide-right">게임 1 타이틀</div>
            <div class="mainGameContent slide-right">게임 1에 대한 설명, 게임 1에 대한 설명 게임1에대한 설명 게임 1에대한 설명</div>
            <button class="mainGameBtn btn btn-primary slide-right">game1로 이동</button>
        </div>
    </div>
</div>

<%--스크립트 임포트--%>
<script src="/index.js"></script>


</body>
</html>