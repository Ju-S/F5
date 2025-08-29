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
    <link href="css/main-style.css">
    <link href="css/edit-content.css">
    <link href="css/ranking-content.css">
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

<div class="custom-container">
    <!-- 서브 네비 -->
    <div class="subnav">네비 서브쪽</div>
    <div class="main">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div style="position: relative;">
                <img src="img/profil.svg" alt="Profile" class="profile-image"/>
                <button class="edit-icon" aria-label="Edit profile">
                    <img src="img/edit.svg" alt="edit" class="edit-image"/>
                </button>
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
                    로그아웃
                </button>
            </div>
        </aside>


        <!-- 메인 콘텐츠 영역 -->
        <div class="main-content">
            <!-- 콘텐츠 1 : 개인정보 수정 -->
            <div class="content-box active" id="content-edit" data-content="profile">
                <h2 class="section-title">개인 정보 수정</h2>

                <!-- Nickname -->
                <div class="form-group row align-items-end nickname-group">
                    <div class="input-label-group nickname-input">
                        <label class="col-form-label col-sm-2 pt-0" for="nickname">닉네임</label>
                        <input type="text" id="nickname" class="form-input" placeholder="Nickname"
                               name="nickname"/>
                    </div>
                    <button class="check-button">중복확인</button>
                </div>

                <!-- Password : 자바스크립트 같은지 확인 -->
                <div class="form-group row">
                    <div class="input-label-group half">
                        <label class="col-form-label col-sm-3 pt-0" for="password1">비밀번호</label>
                        <input type="password" id="password1" class="form-input" placeholder="password"
                               name="password"/>
                    </div>
                    <div class="input-label-group half">
                        <label class="col-form-label col-sm-3 pt-0" for="password2"> 비밀번호 확인</label>
                        <input type="password" id="password2" class="form-input" placeholder="password"/>
                    </div>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label class="col-form-label col-sm-2 pt-0" for="email">이메일</label>
                    <input type="email" id="email" class="form-input" placeholder="email" name="email"/>
                </div>

                <!-- 출생년도 -->
                <div class="d-flex gap-4 mb-3">
                    <!-- 출생년도 -->
                    <div class="flex-fill">
                        <label for="birthYear" class="form-label">출생년도</label>
                        <select id="birthYear" class="form-select" name="birthYear">
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
                                <input class="form-check-input" type="radio" name="gender" id="male" value="male"
                                       checked>
                                <label class="form-check-label" for="male">남자</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="gender" id="female"
                                       value="female">
                                <label class="form-check-label" for="female">여자</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="button-group" id="edit">
                    <button type="button" class="button-primary">수정</button>
                </div>

                <div class="button-group" id="edit_check" style="display: none;">
                    <button class="button-primary">수정완료</button>
                    <button type="button" class="button-secondary">취소</button>
                </div>
            </div>

            <!-- 콘텐츠: 게임 랭킹 -->
            <div class="content-box" id="conten-ranking" data-content="ranking">
                <!-- 게임1 랭킹 -->
                <div class="ranking-card">
                    <h5>게임 1 랭킹</h5>
                    <ol class="list-group list-group-numbered">
                        <li class="list-group-item d-flex justify-content-between align-items-start">
                            <div class="ms-2 me-auto">
                                <div class="fw-bold">게임 1(제목 넣을 예정)</div>
                                Content for list item
                            </div>
                            <span class="badge text-bg-primary rounded-pill">14</span>
                        </li>
                    </ol>
                </div>

                <div class="ranking-card">
                    <h5>게임 2 랭킹</h5>
                    <!-- 동일 구조 반복 -->
                </div>

                <div class="ranking-card">
                    <h5>게임 3 랭킹</h5>
                </div>

                <div class="ranking-card">
                    <h5>게임 4 랭킹</h5>
                </div>

                <div class="ranking-card">
                    <h5>게임 5 랭킹</h5>
                </div>
            </div>


            <!-- 콘텐츠 3 -->
            <div class="content-box" id="content-logout" data-content="logout">
                <h2>로그아웃</h2>
                <p>로그아웃 처리하시겠습니까?</p>
                <button class="button-primary">로그아웃</button>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 연결 -->
<script src="js/move.js"></script>
</body>
</html>
