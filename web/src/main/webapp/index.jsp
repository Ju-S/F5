<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%-- 공용 헤드 --%>
        <jsp:include page="/common/Head.jsp"/>
    <%--박민규 게임페이지 헤더--%>
    <jsp:include page="/game/pmg/GameHead.jsp"/>
</head>
<body>
<%-- 공용 헤더 --%>
<jsp:include page="/common/Header.jsp"/>

<%--박민규 게임페이지 바디--%>

<jsp:include page="/game/pmg/pmg_gamepage.jsp"/>
<랭킹>

<댓글>
    

<%-- 공용 푸터 --%>
<jsp:include page="/common/Footer.jsp"/>
</body>
</html>
