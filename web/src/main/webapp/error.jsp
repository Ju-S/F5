<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css">
    <style>
        .btn-primary {
            --bs-btn-color: #fff;
            --bs-btn-bg: var(--danger-color);
            --bs-btn-border-color: var(--danger-color);
            --bs-btn-hover-color: #b5b5b5;
            --bs-btn-hover-bg: #b84c27;
            --bs-btn-hover-border-color: #b84c27;
            --bs-btn-focus-shadow-rgb: #fff;
            --bs-btn-active-color: var(--sub-btn-color);
            --bs-btn-active-bg: #a14323;
            --bs-btn-active-border-color: #a14323;
            --bs-btn-active-shadow: #fff;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center vh-100 text-center">

<div class="container">
    <h1 class="display-1 fw-bold text-danger">404</h1>
    <h2 class="mb-3">페이지를 찾을 수 없습니다</h2>
    <p class="mb-4 text-muted">요청하신 페이지가 존재하지 않거나 삭제되었습니다.</p>
    <a href="/" class="btn btn-primary">홈으로 돌아가기</a>
</div>

</body>
</html>
