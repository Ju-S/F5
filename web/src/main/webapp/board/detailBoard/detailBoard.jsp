<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/board/detailBoard/detailBoard.css"> <!-- css 링크  -->
    <link rel="stylesheet" href="/common/common.css"> <!-- common css 링크 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/lang/summernote-ko-KR.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- 부트스트랩 케밥메뉴 이미지 -->
</head>
<body>
<jsp:include page="/common/Header.jsp"/>

<form action="/write.board" method="post">
    <div class="container g-0">
        <div class="titleBox">
            <div class="title">제목</div>
            <div class="titleText"><input type="text" placeholder="Title" name="title"></div>
            <input type="hidden" name="writer" value="${sessionScope.loginId}">
        </div>
        <div class="tagsBox d-flex">
            <div class="tag1">
                게임태그
            <label for="gameId"></label>
                <select class="form-select custom-size" id="gameId" name="gameId" aria-label="Default select example" required>
                    <!-- gameId -->
                    <option value="" disabled selected>Game Tag</option>
                    <option value="1">Game1</option>
                    <option value="2">Game2</option>    
                    <option value="3">Game3</option>
                    <option value="4">Game4</option>
                    <option value="5">Game5</option>
                </select>
            </div>
            <div class="tag2">
                태그
                <label for="board_category"></label>
                <select class="form-select custom-size" id="board_category" name="boardCategory" aria-label="Default select example" required>
                    <!-- board_category -->
                    <option value="" disabled selected>Open this select menu</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                </select>
            </div>
        </div>
        <div class="editorBox">
            <textarea id="summernote" name="contents"></textarea>
        </div>
        <div class="completeBox">
            <div class="complete1"></div>
            <div class="complete2">
                <button type="submit" class="btn btn-primary" id="cancel">취소</button>
            </div>
            <div class="complete3">
                <button type="submit" class="btn btn-primary" id="complete">작성완료</button>
            </div>
        </div>
    </div>
</form>

<script src="/board/detailBoard/detailBoard.js"></script><!-- js 링크 -->
</body>
</html>