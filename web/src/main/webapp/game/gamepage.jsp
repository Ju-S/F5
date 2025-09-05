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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <link rel="stylesheet" href="/game/gamepage.css">

    <%-- 사이드 네비바--%>

</head>

<body>
<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container g-0">
    <div class="row g-0" id="row0">

        <%--네비게이션--%>
        <div class="col-1">
            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>
        </div>

        <%--오른쪽 부분--%>
        <div class="col-11">
            <%--<div class="main">--%>

            <div class="main_top row g-0" id="row1">

                <%-- <div class="row">--%>
                <%--  <div class="col-md-6">--%>
                <div class="col-7" id="gamecontainer">
                    <div id="gamebox">
                        <div id="gameboxContent" class="game_box">
                            Play Game! <br>
                            <button class="play_btn"> play</button>
                            <script>
                                /* 페이지 입장 시 넘어온 파라미터 {game_id}를 변수로 만듬*/
                                const GAMEID = parseInt("${gameId}", 10);
                                $(".play_btn").on("click", function () {
                                    $("#gamebox").empty(); // title play 버튼 지우기
                                    switch (GAMEID) {
                                        case 1 : {
                                            //주성
                                            $("#gamebox").load("/game/kjs/kjs_game.jsp");
                                            break;
                                        }
                                        case 2 : {
                                            //지원
                                            $("#gamebox").load("/game/pjw/pjw_game.jsp");
                                            break;
                                        }
                                        case 3 : {
                                            //기준
                                            $("#gamebox").load("/game/kgj/kgj_game.jsp");
                                            break;
                                        }
                                        case 4 : {
                                            //민규
                                            $("#gamebox").load("/game/pmg/game.jsp"); //링크게임 내용실행
                                            break;
                                        }
                                        case 5 : {
                                            //영서
                                            $("#gamebox").load("/game/jys/jys.jsp");
                                            break;
                                        }
                                    }
                                });
                            </script>
                        </div>
                    </div>
                </div>
                <%-- </div>--%>
                <%--  <div class="col-md-6">--%>
                <%--랭킹창--%>
                <div class="col-5" id="gamerankbox">
                    <div id="gamerank">
                        <%--헤더--%>
                        <div id="gamerankHeader">Ranking</div>
                        <%--바디--%>
                        <div id="gamerankBody">
                            <c:forEach var="j" items="${listranking}">
                                <div class="ranking_bar">
                                    <div class="ranking_number">${j.rank}</div>
                                    <div class="ranking_name">${j.memberId}</div>
                                    <div class="ranking_score">${j.score}</div>
                                    <div class="ranking_tier"><img src="${j.tier}" alt="tier_icon" class="tier_icon">
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <%--푸터--%>
                        <div id="gamerankFooter"></div>
                    </div>
                </div>
                <%-- ranking_box--%>
            </div>
            <%-- main top--%>


            <%--<div class="main_bottom row">--%>
            <%--2층--%>
            <div class="row g-0" id="row2">
                <div class="col-12" id="inputrowCol-12">
                    <div id="inputbox">

                        <%--댓글영역--%>
                        <div id="replyrow">
                            <c:forEach var="i" items="${list}">

                                <c:choose>
                                    <c:when test="${sessionScope.loginId == i.writer}"> <%-- 작성자 시점 --%>

                                        <div class="reply_bar">
                                            <div class="reply_profile">

                                                <img id="img"
                                                     src="/downloadImgFile.member?memberId=${i.writer}"
                                                     onerror="this.onerror=null; this.src='/member/my_page/img/profile.svg';"
                                                     alt="profile"/>
                                            </div>

                                            <div class="reply_main">
                                                <div class="reply_center"> 작성자 : ${i.writer} <img src="${i.tier}"
                                                                                                  alt="tier_icon"
                                                                                                  class="tier_icon">
                                                </div>

                                                <div class="reply_content" name="contents"
                                                     value="${i.contents}" contenteditable="false"
                                                     data-original="${i.contents}">
                                                        ${i.contents}
                                                </div>
                                            </div>
                                                <%--reply_main--%>

                                            <div id="reply_last">
                                                <form action="/update_reply.game" method="post" id="update_form">
                                                    <input type="hidden" name="contents" class="hidden_contents">
                                                    <input type="hidden" name="gameId" value="${i.gameId}">
                                                    <input type="hidden" name="writer" value="${i.writer}">
                                                    <input type="hidden" name="id" value="${i.id}">

                                                    <button type="button" class="btn-edit"
                                                            style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 10px;"
                                                            id="update">
                                                        수정
                                                    </button>
                                                    <button type="submit" class="btn-update d-none"
                                                            style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 10px;"
                                                            id="update_complete">
                                                        수정 완료
                                                    </button>
                                                    <button type="button" class="btn-cancel d-none"
                                                            style="background-color:#dc3545; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 10px;">
                                                        취소
                                                    </button>

                                                </form>

                                                <form action="/delete_reply.game" method="post" id="delete_form">
                                                    <input type="hidden" name="gameId" value="${i.gameId}">
                                                    <input type="hidden" name="writer" value="${i.writer}">
                                                    <input type="hidden" name="id" value="${i.id}">
                                                    <button class="btn-delete"
                                                            style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 10px;">
                                                        삭제
                                                    </button>
                                                </form>
                                            </div>


                                        </div>


                                    </c:when>

                                    <c:otherwise> <%--작성자 외 시점--%>

                                        <div class="reply_bar">
                                            <div class="reply_profile">
                                                <img id="img"
                                                     src="/downloadImgFile.member?memberId=${i.writer}"
                                                     onerror="this.onerror=null; this.src='/member/my_page/img/profile.svg';"
                                                     alt="profile"/>
                                            </div>

                                            <div class="reply_main">
                                                <div class="reply_center"> 작성자 : ${i.writer} <img src="${i.tier}"
                                                                                                  alt="tier_icon"
                                                                                                  class="tier_icon">
                                                </div>

                                                <div class="reply_content" name="contents"
                                                     value="${i.contents}" contenteditable="false"
                                                     data-original="${i.contents}">
                                                        ${i.contents}
                                                </div>
                                            </div>
                                            <div id="reply_last">
                                                <div class="dropdown">
                                                        <%-- 원본 class="btn btn btn-dark dropdown-toggle" --%>
                                                    <form action="/report_reply.game" method="get" id="report_form">
                                                        <input type="hidden" name="gameId" value="${i.gameId}">
                                                        <input type="hidden" name="writer" value="${i.writer}">
                                                        <input type="hidden" name="reportcount"
                                                               value="${i.report_count}">
                                                        <button type="button" class="btn btn btn-dark" id="reportPost"
                                                                data-bs-toggle="dropdown" aria-expanded="false"
                                                                style="background: transparent; border: none; padding: 0;">
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
                                                </div>
                                            </div>
                                        </div>


                                    </c:otherwise>

                                </c:choose>

                            </c:forEach>
                        </div>

                        <%--입력창 부분--%>
                        <form action="/write_reply.game" method="post">
                            <div class="text_reply" id="inputrow">
                                <input type="hidden" name="writer" value="${sessionScope.loginId}">
                                <input type="hidden" name="gameId" value="${gameId}"> <%--${game_id}--%>
                                <input type="text" class="reply_area" placeholder="reply .. (35자)" name="contents"
                                       id="replyInput">
                                <button id="writing_btn" class="reply_btn"><i class="fa-solid fa-paper-plane"
                                                                              style="color: #ffffff;"></i></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%--</div> <!-- main_bottom -->--%>
            <%--</div>
            &lt;%&ndash; main &ndash;%&gt;--%>
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
        $form.find(".btn-edit").addClass("d-none"); // 수정버튼 감추기
        $form.find(".btn-update").removeClass("d-none");
        $form.find(".btn-cancel").removeClass("d-none")
        $replyBar.find(".btn-delete").addClass("d-none"); // 삭제버튼 감추기

    });

    $(".btn-cancel").on("click", function () {
        const $replyBar = $(this).closest(".reply_bar");
        const $contentDiv = $replyBar.find(".reply_content");

        $contentDiv.text($contentDiv.data("original"));
        $contentDiv.attr("contenteditable", "false");

        // 버튼 토글
        const $form = $(this).closest(".update_form");
        $form.find(".btn-edit").removeClass("d-none"); // 수정버튼 보이게
        $form.find(".btn-update").addClass("d-none");
        $form.find(".btn-cancel").addClass("d-none");
        $replyBar.find(".btn-delete").removeClass("d-none"); // 삭제버튼 보이게

    });

    $(".btn-update").on("click", function (e) {
        e.preventDefault(); // 자동 submit 방지 seq 값이 변하지 않고 수정하기 위함

        const $replyBar = $(this).closest(".reply_bar");
        const $form = $(this).closest(".update_form");
        const $contentDiv = $replyBar.find(".reply_content");

        const updatedText = $contentDiv.text().trim();

        $form.find(".hidden_contents").val(updatedText);

        $form.submit(); // 직접 submit 실행
    });


</script>


</body>
</html>




