<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/manager-style.css">
</head>
<body>
<!-- Header -->
<div class="log">
    <nav class="navbar bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="img/log.svg" alt="Logo" width="32" class="d-inline-block align-text-top"/>
            </a>
        </div>
    </nav>
</div>

<div class="container">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-1 sidebar">
            <button title="Home">1카테고리</button>
        </div>

        <!-- main 내용 -->
        <div class="col-11 main-content">
            <!-- 필터 & 버튼 -->
            <div class="mb-3 d-flex gap-2 custom-margin-bottom">
                <button class="btn btn-secondary" style="background-color: #3b3f9b; border-color: #3b3f9b;">
                    <input class="form-check-input" type="checkbox" id="checkboxNoLabel">
                    <label class="form-check-label" for="checkDefault">
                        Add
                    </label>
                </button>
                <button class="btn btn-secondary">Filter ⚙</button>
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

<script src="js/manager-move.js"></script>
</body>
</html>
