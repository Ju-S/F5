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

    <c:choose>
        <c:when test="${loginId ==null}">
            <%-- 로그인 안되었을시 M공용 헤더 --%>
            <jsp:include page="/common/Mcommon/MHeader.jsp"/>

        </c:when>

        <c:otherwise>
            <%-- 로그인 되었을시 c공용 헤더 --%>
            <jsp:include page="/common/header/Header.jsp"/>
        </c:otherwise>

    </c:choose>




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
        <div class="mainGame 1 default">
            <img class src="/index_img/desktop_home_js.svg"/>
            <div class="mainGameTitle slide-right">Penguin</div>
            <div class="mainGameContent slide-right">펭귄의 남극기지 순례 대모험..<br>장애물로 등장하는 얼음구멍을 피해 더 오래 모험을 즐기세요!</div>
            <button class="mainGameBtn btn btn-primary slide-right">Penguin로 이동</button>
        </div>
    </div>
</div>

<%--스크립트 임포트--%>
<script src="/index.js"></script>


</body>
</html>