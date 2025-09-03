<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>

<head>
    <jsp:include page="/common/Head.jsp"/>
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
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>
        <div class="col-11">
            <div class="row  total-card">
                <div class="col-5 post-card "><!-- 게시글 영역 -->
                    <div class="row profile-row"><!-- 프로필 제목 영역 -->
                        <div class="col-1 profile">
                                        <!-- 이미지를 그냥 넣으면 경로때문에 지정이안됨. 경로지정해서 넣었음 -->
                            <img src="/board/detailBoard/profile_img/profile.jpeg" class="rounded-circle profile-img" alt="..."
                                 style="width: 50px; height: 50px;">
                        </div>
                        <div class="col-10 writer">
                            ${boardDetail.writer}
                        </div>
                        <div class="col-1">
                            <div class="reportBox">
                                <button type="button" class="btn btn-sm btn-dark dropdown-toggle" id="reportPost"
                                        data-bs-toggle="dropdown" aria-expanded="false"
                                        style="background: transparent; border: none; padding: 0;">
                                    <i class="bi bi-three-dots-vertical vertical-dots"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end report-menu">
                                    <li><a class="dropdown-item text-danger" href="#">신고하기</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="row"> <!-- 게시글 컨텐츠 영역 -->
                        <div class="col-12 post-contents">
                            ${boardDetail.contents}
                        </div>
                    </div>
                    <div class="row post-btn-row"> <!-- 삭제 수정 버튼 영역 -->

                        <div class="col-6 empty-box"></div>
                        <div class="col-3 deleteBtn_box">
                            <button type="submit" class="btn btn-primary" id="delete">삭제</button>
                        </div>
                        <div class="col-3 updateBtn_box">
                            <button type="submit" class="btn btn-primary" id="update">수정</button>
                        </div>
                        <!-- 수정완료 버튼 (초기에는 숨김) -->
                        <div class="col-9 d-none" id="update-complete-box">
                            <button type="submit" class="btn btn-success w-100" id="update-complete">수정완료</button>
                        </div>

                        <!-- 취소 버튼 (초기에는 숨김) -->
                        <div class="col-3 d-none" id="cancel-box">
                            <button type="button" class="btn btn-secondary w-100" id="cancel">취소</button>
                        </div>
                    </div>
                </div>


                <div class="col-5 comment-card"> <!-- 댓글영역 -->
                    <!-- 여기가 이제 forEach로 묶일거임 -->
                    <div class="comment-box">
                        <div class="row comments">
                            <div class="col-1 profile">
                                <img src="/board/detailBoard/profile_img/replyProfile.jpg" class="rounded-circle profile-img" alt="..."
                                     style="width: 50px; height: 50px;">
                            </div>
                            <div class="col-10">
                                <div class="row">
                                    <div class="col-12 comment-writer">
                                        작성자
                                    </div>
                                    <div class="col-12 comment-contents">
                                        댓글내용~~~
                                    </div>
                                </div>
                            </div>
                            <div class="col-1">
                                <div class="reportBox">
                                    <button type="button" class="btn btn-sm btn-dark dropdown-toggle" id="reportComment"
                                            data-bs-toggle="dropdown" aria-expanded="false"
                                            style="background: transparent; border: none; padding: 0;">
                                        <i class="bi bi-three-dots-vertical vertical-dots"></i>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end report-menu">
                                        <li><a class="dropdown-item text-danger" href="#">신고하기</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row send-btn-row">
                        <div class="col-9">
                            <input type="text" placeholder="댓글 작성">
                        </div>
                        <div class="col-3 sendBtn_box">
                            <button type="submit" class="btn btn-primary" id="sendBtn"><i class="fa-solid fa-paper-plane" style="color: #ffffff;"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/board/detailBoard/detailBoard.js"></script>
</body>
</html>
