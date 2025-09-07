<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<html>
<head>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.90.0/phaser.min.js"
            integrity="sha512-/tJYyDCrI7hnHWp45P189aOwPa6lTREosRhlxEIqx8skB4A3a3rD3iz4o335SJd4sORqjVHw5y1S2hq4hciwLw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <jsp:include page="/common/Head.jsp"/>
    <jsp:include page="/game/pmg/GameHead.jsp"/>
    <jsp:include page="/game/kjs/kjsGameHead.jsp"/>
    <jsp:include page="/game/pjw/pjw_gameHead.jsp"/>
    <jsp:include page="/game/kgj/kgj_gameHead.jsp"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <link rel="stylesheet" href="/game/gamepage.css">
</head>

<body>
<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container g-0">
    <div class="row g-0" id="row0">

        <!-- 사이드 네비 -->
        <div class="col-1">
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>

        <!-- 메인 영역 -->
        <div class="col-11">
            <div class="main_top row g-0" id="row1">

                <!-- 게임 박스 -->
                <div class="col-7" id="gamecontainer">
                    <div id="gamebox">
                        <div id="gameboxContent" class="game_box">
                            Play Game! <br>
                            <button class="play_btn"> play</button>
                            <script>
                                const GAMEID = parseInt("${gameId}", 10);
                                $(".play_btn").on("click", function () {
                                    $("#gamebox").empty();
                                    switch (GAMEID) {
                                        case 1 : $("#gamebox").load("/game/kjs/kjs_game.jsp"); break;
                                        case 2 : $("#gamebox").load("/game/pjw/pjw_game.jsp"); break;
                                        case 3 : $("#gamebox").load("/game/kgj/kgj_game.jsp"); break;
                                        case 4 : $("#gamebox").load("/game/pmg/game.jsp"); break;
                                        case 5 : $("#gamebox").load("/game/jys/jys.jsp"); break;
                                    }
                                });
                            </script>
                        </div>
                    </div>
                </div>

                <!-- 랭킹 박스 -->
                <div class="col-5" id="gamerankbox">
                    <div id="gamerank">
                        <div id="gamerankHeader">Ranking</div>
                        <div id="gamerankBody">
                            <c:forEach var="j" items="${listranking}">
                                <div class="ranking_bar">
                                    <div class="ranking_number">${j.rank}</div>
                                    <div class="ranking_name">${j.nickname}</div>
                                    <div class="ranking_score">${j.score}</div>
                                    <div class="ranking_tier">
                                        <img src="${j.tier}" alt="tier_icon" class="tier_icon">
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="gamerankFooter"></div>
                    </div>
                </div>
            </div>

            <!-- 댓글 영역 -->
            <div class="row g-0" id="row2">
                <div class="col-12" id="inputrowCol-12">
                    <div id="inputbox">

                        <div id="replyrow">
                            <c:forEach var="i" items="${list}">
                                <div class="reply_bar">
                                    <div class="reply_profile">
                                        <img id="img"
                                             src="/downloadImgFile.member?memberId=${i.writer}"
                                             onerror="this.onerror=null; this.src='/member/my_page/img/profile.svg';"
                                             alt="profile"/>
                                    </div>

                                    <div class="reply_main">
                                        <div class="reply_center">
                                            ${i.nickname}
                                            <img src="${i.tier}" alt="tier_icon" class="tier_icon">
                                        </div>

                                        <div class="reply_content"
                                             name="contents"
                                             value="${i.contents}"
                                             contenteditable="false"
                                             data-original="${i.contents}">
                                                ${i.contents}
                                        </div>
                                    </div>

                                    <div class="reply_last">
                                        <c:choose>
                                            <c:when test="${sessionScope.loginId == i.writer}">
                                                <!-- 작성자 시점 -->
                                                <form action="/update_reply.game" method="post" class="update_form">
                                                    <input type="hidden" name="contents" class="hidden_contents">
                                                    <input type="hidden" name="gameId" value="${i.gameId}">
                                                    <input type="hidden" name="writer" value="${i.writer}">
                                                    <input type="hidden" name="id" value="${i.id}">

                                                    <button type="button" class="btn-edit"
                                                            style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding:5px 10px;">
                                                        수정
                                                    </button>
                                                    <button type="submit" class="btn-update d-none"
                                                            style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding:5px 10px;">
                                                        완료
                                                    </button>
                                                    <button type="button" class="btn-cancel d-none"
                                                            style="background-color:#dc3545; color:#fff; font-size:15px; border-radius:10px; border:none; padding:5px 10px;">
                                                        취소
                                                    </button>
                                                </form>

                                                <form action="/delete_reply.game" method="post" class="delete_form">
                                                    <input type="hidden" name="gameId" value="${i.gameId}">
                                                    <input type="hidden" name="writer" value="${i.writer}">
                                                    <input type="hidden" name="id" value="${i.id}">
                                                    <button class="btn-delete"
                                                            style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding:5px 10px;">
                                                        삭제
                                                    </button>
                                                </form>
                                            </c:when>

                                            <c:otherwise>
                                                <!-- 작성자 외 시점 -->
                                                <form action="/report_reply.game" method="get" class="report_form">
                                                    <input type="hidden" name="gameId" value="${i.gameId}">
                                                    <input type="hidden" name="writer" value="${i.writer}">
                                                    <input type="hidden" name="reportcount" value="${i.report_count}">
                                                    <button type="button" class="btn btn btn-dark" data-bs-toggle="dropdown"
                                                            aria-expanded="false"
                                                            style="background:transparent; border:none; padding:0;">
                                                        <i class="bi bi-three-dots-vertical"></i>
                                                    </button>
                                                    <ul class="dropdown-menu dropdown-menu-end">
                                                        <li>
                                                            <button type="submit" class="dropdown-item text-danger">
                                                                신고하기
                                                            </button>
                                                        </li>
                                                    </ul>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- 입력창 -->
                        <form action="/write_reply.game" method="post">
                            <div class="text_reply" id="inputrow">
                                <input type="hidden" name="writer" value="${sessionScope.loginId}">
                                <input type="hidden" name="gameId" value="${gameId}">
                                <input type="text" class="reply_area" placeholder="reply .. (35자)"
                                       name="contents" id="replyInput" maxlength="35" oninput="checkLength()">
                                <button id="writing_btn" class="reply_btn">
                                    <i class="fa-solid fa-paper-plane" style="color:#ffffff;"></i>
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div> <!-- col-11 -->
    </div> <!-- row-->
</div>  <!-- container -->

<script>
    $(".btn-edit").on("click", function () {
        const $replyBar = $(this).closest(".reply_bar");
        const $contentDiv = $replyBar.find(".reply_content");

        $contentDiv.attr("contenteditable", "true").focus();

        // 버튼 토글
        const $form = $(this).closest(".update_form");
        $form.find(".btn-edit").addClass("d-none");
        $form.find(".btn-update").removeClass("d-none");
        $form.find(".btn-cancel").removeClass("d-none");
        $replyBar.find(".btn-delete").addClass("d-none");
    });

    $(".btn-cancel").on("click", function () {
        const $replyBar = $(this).closest(".reply_bar");
        const $contentDiv = $replyBar.find(".reply_content");

        $contentDiv.text($contentDiv.data("original"));
        $contentDiv.attr("contenteditable", "false");

        // 버튼 토글
        const $form = $(this).closest(".update_form");
        $form.find(".btn-edit").removeClass("d-none");
        $form.find(".btn-update").addClass("d-none");
        $form.find(".btn-cancel").addClass("d-none");
        $replyBar.find(".btn-delete").removeClass("d-none");
    });

    $(".btn-update").on("click", function (e) {
        e.preventDefault();

        const $replyBar = $(this).closest(".reply_bar");
        const $form = $(this).closest(".update_form");
        const $contentDiv = $replyBar.find(".reply_content");

        const updatedText = $contentDiv.text().trim();
        $form.find(".hidden_contents").val(updatedText);
        $form.submit();
    });

    function checkLength() {
        const input = document.getElementById("replyInput");
        if (input.value.length === input.maxLength) {
            alert("최대 35자까지 입력할 수 있습니다!");
        }
    }
</script>

</body>
</html>
