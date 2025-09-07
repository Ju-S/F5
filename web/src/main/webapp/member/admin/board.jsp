<%@ page import="enums.Authority" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css">
    <link rel="stylesheet" href="/member/admin/css/board_admin.css">
</head>
<body>

<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-1">
            <jsp:include page="/common/sidenaviadmin/sideNaviAdmin.jsp"/>
        </div>

        <!-- main 내용 -->
        <div class="col-11 main-content">
            <!-- 버튼 -->
            <div class="d-flex align-items-center gap-2">
                <div class="form-check d-flex align-items-center">
                    <input class="form-check-input" type="checkbox" id="checkboxNoLabel">
                    <label class="form-check-label ms-2" for="checkboxNoLabel">Add</label>
                </div>
            </div>

            <!-- 블랙리스트 게시물 -->
            <div class="table-content">
                <div class="table-responsive p-3 rounded fixed-height-table">
                    <table class="table table-dark table-hover align-middle">
                        <thead>
                        <tr>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>신고일</th>
                            <th>신고횟수</th>
                            <th>관리</th>
                        </tr>
                        </thead>
                        <tbody id="table-body">
                        <!-- Ajax로 채움 -->
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <nav>
                        <ul class="pagination justify-content-center" id="pagination">
                            <!-- Ajax로 페이지번호 채움 -->
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="/member/admin/js/board_admin.js"></script>

</body>
</html>
