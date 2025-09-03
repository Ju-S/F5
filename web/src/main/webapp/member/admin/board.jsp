<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css">
    <link rel="stylesheet" href="css/board_admin.css">
</head>
<body>

<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-1">
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>

        <!-- main 내용 -->
        <div class="col-11 main-content">
            <!-- 필터 & 버튼 -->
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
                            <th>게시글</th>
                            <th>Nickname</th>
                            <th>신고날짜</th>
                            <th>신고횟수</th>
                            <th>삭제</th>
                        </tr>
                        </thead>
                        <tbody id="table-body">
                        <!-- JavaScript로 데이터 삽입 -->
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <nav>
                        <ul class="pagination justify-content-center" id="pagination">
                            <!-- JavaScript로 페이지 번호 삽입 -->
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="js/board_admin.js"></script>
</body>
</html>
