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

<jsp:include page="/game/pmg/pmg_game.jsp"/>
<%-- 공용 푸터 --%>
<%--<jsp:include page="/common/Footer.jsp"/>--%>

</body>
</html>
