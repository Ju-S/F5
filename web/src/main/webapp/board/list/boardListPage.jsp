<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css">
    <link rel="stylesheet" href="/board/list/boardListPage.css">
    <script src="/board/list/components/BoardItem.js"></script>
    <script src="/board/list/components/PageNavigation.js"></script>
    <script src="/board/list/boardListPage.js"></script>
</head>
<body>
<jsp:include page="/common/Header.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-1"><!-- 네비게이션 --></div>
        <div class="col-11">
            <div class="row">
                <div class="col-2 filter p-0">
                    <!-- 필터 -->
                    <jsp:include page="/board/list/components/FilterSelect.jsp"/>
                </div>
                <div class="col search p-0">
                    <!-- 검색어 -->
                    <input class="form-control" type="text" placeholder="검색어 입력...">
                </div>
                <div class="col-2 p-0 write">
                    <!-- 글 작성 버튼 -->
                    <button id="writeBtn" class="btn" type="button">글 작성</button>
                </div>
            </div>
            <div class="boardList mt-5">
                <div class="row">
                    <div class="col p-0">
                        <table class="item-list-view"><!-- 게시글 목록 --></table>
                    </div>
                </div>
                <div class="row mt-4">
                    <div id="navPos" class="col"><!-- 게시글 페이지 네비게이션 --></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    setBoardListAndNav(-1);
</script>

</body>
</html>
