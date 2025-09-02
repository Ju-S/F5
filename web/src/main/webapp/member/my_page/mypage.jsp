<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="css/main-style.css">
    <link rel="stylesheet" href="css/edit-content.css">
    <link rel="stylesheet" href="css/ranking-content.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <%-- 파일 업로드 관련 링크 --%>
</head>
<body>
<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-1 subnav">
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>

        <div class="col-11 main-content">
            <!-- 사이드바, 이미지 업로드 등 여기에 배치 -->
            <aside class="sidebar">
                <div style="position: relative;">
                    <%-- 파일 이미지 불러오기 --%>
                    <form id="profileUploadForm" enctype="multipart/form-data">
                        <img src="/downloadImgFile.member?ts=<%=System.currentTimeMillis()%>"
                             onerror="this.onerror=null; this.src='/member/my_page/img/profile.svg';" />

                        <input type="file" name="file" id="fileInput" style="display: none;" accept="image/*"/>
                        <button type="button" class="edit-icon" id="imgFileBtn">
                            <img src="/member/my_page/img/edit.svg" alt="edit"/>
                        </button>
                    </form>
                </div>
                <div class="textMember">
                    <h4>Nickname</h4>
                    <p>ID number</p>
                </div>

                <!-- 버튼 -->
                <div class="btn">
                    <button class="menu-button active" data-target="profile" data-img-default="img/mypage_color.svg"
                            data-img-active="img/mypage.svg" type="button">
                        <img src="img/mypage.svg" alt="mypage" class="menu-img">
                        개인 정보 수정
                    </button>

                    <button class="menu-button" data-target="ranking" data-img-default="img/ranking_color.svg"
                            data-img-active="img/ranking.svg" type="button">
                        <img src="img/ranking.svg" alt="ranking" class="menu-img">
                        게임 랭킹
                    </button>

                    <button class="menu-button" data-target="logout" data-img-default="img/logout_color.svg"
                            data-img-active="img/logout.svg" type="button">
                        <img src="img/logout.svg" alt="logout" class="menu-img">
                        회원탈퇴
                    </button>
                </div>
            </aside>


            <!-- 메인 콘텐츠 영역 -->
            <div class="main">
                <!-- 콘텐츠 1 : 개인정보 수정 -->
                <div class="content-box active" id="content-edit" data-content="profile">
                    <h2 class="section-title">개인 정보 수정</h2>

                    <!-- ID -->
                    <div class="form-group">
                        <label class="col-form-label col-sm-2 pt-0" for="email">아이디</label>
                        <input type="text" id="id" class="form-input" placeholder="id" name="id" readonly/>
                    </div>

                    <!-- name -->
                    <div class="form-group">
                        <label class="col-form-label col-sm-2 pt-0" for="email">이름</label>
                        <input type="text" id="name" class="form-input" placeholder="name" name="name" readonly/>
                    </div>

                    <!-- Nickname -->
                    <div class="form-group row align-items-end nickname-group">
                        <div class="input-label-group nickname-input">
                            <label class="col-form-label col-sm-2 pt-0" for="nickname">닉네임</label>
                            <input type="text" id="nickname" class="form-input" placeholder="Nickname"
                                   name="nickname" readonly/>
                        </div>
                        <button class="check-button">중복확인</button>
                    </div>

                    <!-- Email -->
                    <div class="form-group row align-items-end nickname-group">
                        <div class="input-label-group nickname-input">
                            <label class="col-form-label col-sm-2 pt-0" for="nickname">이메일</label>
                            <input type="email" id="email" class="form-input" placeholder="email" name="email"
                                   readonly/>
                        </div>
                        <button class="check-button">인증확인</button>
                    </div>

                    <!-- 출생년도 -->
                    <div class="d-flex gap-4 mb-3">
                        <!-- 출생년도 -->
                        <div class="flex-fill">
                            <label for="birthYear" class="form-label">출생년도</label>
                            <select id="birthYear" class="form-select" name="birthYear" readonly>
                                <option selected disabled class="option_text">출생년도 선택</option>
                                <option value="1990">1990년</option>
                                <option value="1991">1991년</option>
                                <option value="1992">1992년</option>
                                <!-- 추가 -->
                            </select>
                        </div>

                        <!-- 성별 -->
                        <div class="flex-fill">
                            <label class="form-label d-block">성별</label>
                            <div class="d-flex align-items-center gap-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="sex" id="male"
                                           value="male"
                                           checked>
                                    <label class="form-check-label" for="male">남자</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="sex" id="female"
                                           value="female">
                                    <label class="form-check-label" for="female">여자</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="button-group" id="edit">
                        <button type="button" class="button-primary w-50">수정</button>
                    </div>

                    <div class="button-group" id="edit_check" style="display: none;">
                        <button class="button-primary">수정완료</button>
                        <button type="button" class="button-secondary">취소</button>
                    </div>
                </div>

                <!-- 콘텐츠: 게임 랭킹 -->
                <div class="content-box" id="content-ranking" data-content="ranking">
                    <!-- 게임1 랭킹 -->
                    <div class="ranking-list-wrapper">
                        <div class="ranking-card">
                            <h5 style="color: var(--danger-color)">Antarctic Adventure</h5>
                            <ol class="list-group list-group-numbered">
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div class="ms-2 me-auto">
                                        <div class="fw-bold">
                                            게임 랭킹 들어갈 자리
                                        </div>
                                    </div>
                                    <span class="badge text-bg-primary rounded-pill">랭킹</span>
                                </li>
                            </ol>
                        </div>

                        <div class="ranking-card">
                            <h5 style="color: var(--danger-color)">Packman</h5>
                            <ol class="list-group list-group-numbered">
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div class="ms-2 me-auto">
                                        <div class="fw-bold">
                                            게임 랭킹 들어갈 자리
                                        </div>
                                    </div>
                                    <span class="badge text-bg-primary rounded-pill">랭킹</span>
                                </li>
                            </ol>
                        </div>

                        <div class="ranking-card">
                            <h5 style="color: var(--danger-color)">Bubble Shooter</h5>
                            <ol class="list-group list-group-numbered">
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div class="ms-2 me-auto">
                                        <div class="fw-bold">
                                            게임 랭킹 들어갈 자리
                                        </div>
                                    </div>
                                    <span class="badge text-bg-primary rounded-pill">랭킹</span>
                                </li>
                            </ol>
                        </div>

                        <div class="ranking-card">
                            <h5 style="color: var(--danger-color)">I hate injections!</h5>
                            <ol class="list-group list-group-numbered">
                                <li class="list-group-item d-flex justify-content-between align-items-start">
                                    <div class="ms-2 me-auto">
                                        <div class="fw-bold">
                                            게임 랭킹 들어갈 자리<i class="fa-solid fa-hospital"
                                                           style="background-color: white;"></i>
                                        </div>
                                    </div>
                                    <span class="badge text-bg-primary rounded-pill">랭킹</span>
                                </li>
                            </ol>
                        </div>
                    </div>

                    <div class="ranking-card">
                        <h5 style="color: var(--danger-color)">Geometry Dash</h5>
                        <ol class="list-group list-group-numbered">
                            <li class="list-group-item d-flex justify-content-between align-items-start">
                                <div class="ms-2 me-auto">
                                    <div class="fw-bold">
                                        게임 랭킹 들어갈 자리
                                    </div>
                                </div>
                                <span class="badge text-bg-primary rounded-pill">랭킹</span>
                            </li>
                        </ol>
                    </div>
                </div>

            </div>


            <!-- 콘텐츠 3 -->
            <div class="content-box" id="content-logout" data-content="logout">
                <h2>회원탈퇴</h2><br>
                <p>회원탈퇴를 하시겠습니까?</p>
                <a class="btn button-primary">회원탈퇴</a>
            </div>
        </div>
    </div>
</div>
</div>

<!-- 스크립트 연결 -->
<script src="/member/my_page/js/move.js"></script>
</body>
</html>
