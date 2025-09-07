<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/common.css"> <!-- common css 링크 -->
    <link rel="stylesheet" href="/board/writeBoard/writeBoard.css"> <!-- css 링크  -->

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/lang/summernote-ko-KR.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- 부트스트랩 케밥메뉴 이미지 -->
</head>
<body>
<jsp:include page="/common/header/Header.jsp"/>


<div class="container">
    <form action="/write.board" method="post" accept-charset="UTF-8">
        <div class="row">
            <div class="col-1">
                <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
            </div>
            <div class="col-11 mainContents">
                <div class="titleBox">
                    <div class="title">제목</div>
                    <div class="titleText"><input type="text" placeholder="Title" name="title" required></div>
                    <input type="hidden" name="writer" value="${sessionScope.loginId}">
                </div>
                <div class="tagsBox d-flex">
                    <div class="gameId-box">
                        게임태그
                        <label for="gameId"></label>
                        <select class="form-select custom-size" id="gameId" name="gameId"
                                aria-label="Default select example" required>
                            <!-- gameId -->
                            <option value="" disabled selected>Game Tag</option>
                            <option value="1">Penguin</option>
                            <option value="2">Pac-man</option>
                            <option value="3">Bubble Shooter</option>
                            <option value="4">I hate injections!</option>
                            <option value="5">Geometry Dash</option>
                        </select>
                    </div>
                    <div class="board_category-box">
                        태그
                        <label for="board_category"></label>
                        <select class="form-select custom-size" id="board_category" name="boardCategory"
                                aria-label="Default select example" required>
                            <!-- board_category -->
                            <option value="" disabled selected>Filter</option>
                            <option value="1">정보/공략</option>
                            <option value="2">질문</option>
                            <option value="3">후기</option>
                        </select>
                    </div>
                </div>
                <div class="editorBox">
                    <textarea id="summernote" name="contents"></textarea>
                </div>
                <div class="button-box">
                    <div class="empty-box"></div>

                    <div class="cancelBtn-box">
                        <button type="submit" class="btn btn-primary" id="cancel"
                                onclick="location.href='/board/list/boardListPage.jsp'">취소
                        </button>
                    </div>
                    <div class="completeBtn-box">
                        <button type="submit" class="btn btn-primary" id="complete">작성완료</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>


<script src="/board/writeBoard/writeBoard.js"></script><!-- js 링크 -->
</body>
</html>