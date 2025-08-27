<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
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
                <div class="col-1">
                    <!-- 필터 -->
                    <jsp:include page="/board/list/components/FilterSelect.jsp"/>
                </div>
                <div class="col">
                    <!-- 검색어 -->
                    <input type="text" placeholder="검색어 입력...">
                </div>
                <div class="col-1">
                    <!-- 글 작성 버튼 -->
                    <button type="button">글 작성</button>
                </div>
            </div>
            <div class="boardList">
                <div class="row">
                    <div class="col">
                        <script>
                            let postList = ${list};
                            let itemPerPage = ${itemPerPage};

                            createBoardList(postList, itemPerPage);
                        </script>
                    </div>
                </div>
                <div class="row">
                    <div id="navPost" class="col">
                        <script>
                            let maxPage = ${maxPage};
                            let curPage = ${curPage};
                            let naviPerPage = ${naviPerPage};

                            createPageNavigation(maxPage, curPage, naviPerPage);
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
