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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-1">
            <!-- 네비게이션 -->
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>
        <div class="col-11 vh-100">
            <div class="row toolbar">
                <div class="col-2 filter">
                    <!-- 필터 -->
                    <jsp:include page="/board/list/components/FilterSelect.jsp"/>
                </div>
                <div class="col-4 search">
                    <!-- 검색어 -->
                    <jsp:include page="/board/list/components/SearchBar.jsp"/>
                </div>
                <div class="col-4"></div>
                <div class="col-2 write">
                    <!-- 글 작성 버튼 -->
                    <button id="writeBtn" onClick="location.href = '/write_board.page'" class="btn"
                            type="button">글 작성
                    </button>
                </div>
            </div>
            <div class="boardList">
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
    let params = new URLSearchParams(window.location.search);
    let filter = params.get("filter");
    let page = params.get("page");
    let searchQuery = params.get("searchQuery");
    let gameId = params.get("gameId");
    setBoardListAndNav(filter, page, searchQuery, gameId);
</script>

</body>
</html>
