<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>

<head>
    <title>F5</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="/common/common.css">

    <link rel="stylesheet" href="/common/header/Header.css">

    <link rel="stylesheet" href="/common/sidenaviadmin/sideNaviAdmin.css">






    <link rel="stylesheet" href="/board/detailBoard/detailBoard.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">

</head>
<body>
<jsp:include page="/common/header/Header.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-1 navi">
            <!-- 네비게이션 -->
            <jsp:include page="/common/sidenaviadmin/sideNaviAdmin.jsp"/>
        </div>
        <div class="col-11">
            <div class="row  total-card">
                <div class="col-5 post-card "><!-- 게시글 영역 -->
                    <div class="row profile-row"><!-- 프로필 제목 영역 -->
                        <div class="col-1 profile">
                            <!-- 이미지를 그냥 넣으면 경로때문에 지정이안됨. 경로지정해서 넣었음 -->
                            <img id="img"
                                 src="/downloadImgFile.member?memberId=${boardDetail.writer}"
                                 onerror="this.onerror=null; this.src='/member/my_page/img/profile.svg';"
                                 alt="profile"
                                 style="width: 50px; height: 50px;"/>
                        </div>
                        <div class="col-10 writer">
                            ${boardDetail.nickname}
                        </div>
                        <div class="col-1">
                            <div class="reportBox">
                                <button type="button" class="btn btn-sm btn-dark dropdown-toggle" id="reportPost"
                                        data-bs-toggle="dropdown" aria-expanded="false"
                                        style="background: transparent; border: none; padding: 0;">
                                    <i class="bi bi-three-dots-vertical vertical-dots"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end report-menu">
                                    <li><a class="dropdown-item text-danger post-report-btn" style="cursor: pointer">신고하기</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row"> <!-- 게시글 컨텐츠 영역 -->
                        <div class="col-12 post-contents">
                            ${boardDetail.contents}
                        </div>
                    </div>

                    <c:if test="${sessionScope.loginId == boardDetail.writer}">
                        <div class="row post-btn-row"> <!-- 삭제 수정 버튼 영역 -->

                            <div class="col-6 empty-box"></div>

                            <div class="col-3 deleteBtn_box">
                                <button onClick="location.href = `/delete.board?boardId=${boardDetail.id}`"
                                        class="btn btn-primary" id="delete">삭제
                                </button>
                            </div>
                            <div class="col-3 updateBtn_box">
                                <button onClick="location.href = `/update_form.board?boardId=${boardDetail.id}`"
                                        class="btn btn-primary" id="update">수정
                                </button>
                            </div>
                        </div>
                    </c:if>
                </div>

                <div class="col-5 comment-card"> <!-- 댓글영역 -->
                    <!-- 여기가 이제 forEach로 묶일거임 -->
                    <div id="comment-box">
                        <div class="row comments">

                        </div>
                    </div>
                    <div class="row send-btn-row">
                        <div class="col-9">
                            <input type="text" id="commentContents" placeholder="댓글 작성">
                        </div>
                        <div class="col-3 sendBtn_box">
                            <button type="submit" class="btn btn-primary" id="sendBtn"><i
                                    class="fa-solid fa-paper-plane" style="color: #ffffff;"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    let params = new URLSearchParams(window.location.search);
    let boardId = params.get("boardId");

    let loginId = "${sessionScope.loginId}";
</script>
<script src="/board/detailBoard/detailBoard.js"></script>
</body>
</html>
