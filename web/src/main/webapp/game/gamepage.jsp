<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<html>
<head>
    <jsp:include page="/game/pmg/GameHead.jsp"/>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <link rel="stylesheet" href="/game/gamepage.css">
    <!-- ✅ Bootstrap CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <jsp:include page="/common/Head.jsp"/>
    <%-- 사이드 네비바--%>

</head>

<body>
<!-- Header -->
<jsp:include page="/common/header/Header.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-1">

            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>

        </div>


        <div class="col-11">
            <div class="main">

                <div class="main_top row">
                    <%-- <div class="row">--%>
                    <%--  <div class="col-md-6">--%>
                    <div class="game_box col-8">
                        Play Game! <br>
                        <button class="play_btn"> play</button>

                        <script>
                            /* 페이지 입장 시 넘어온 파라미터 {game_id}를 변수로 만듬*/


                            const GAMEID = parseInt("${gameId}", 10);

                            $(".play_btn").on("click", function () {
                                $(".game_box").empty(); // title play 버튼 지우기

                                switch (GAMEID) {

                                    case 1 : {
                                        //주성
                                        $(".game_box").load("/game/kjs/kjs_game.jsp");
                                        break;
                                    }

                                    case 2 : {
                                        //지원
                                        break;
                                    }

                                    case 3 : {
                                        //기준
                                        break;
                                    }

                                    case 4 : {
                                        //민규
                                        $(".game_box").load("/game/pmg/game.jsp"); //링크게임 내용실행
                                        break;
                                    }

                                    case 5: {
                                        $(".game_box").load("/game/jys/jys.jsp");
                                        break;
                                    }

                                }

                            });
                        </script>
                    </div>
                    <%-- </div>--%>


                    <%--  <div class="col-md-6">--%>

                    <div class="ranking_box col-4">
                        <div class="ranking_title">Ranking</div>

                        <c:forEach var="j" items="${listranking}">
                            <div class="ranking_bar">
                                <div class="ranking_number">${j.rank}</div>
                                <div class="ranking_name">${j.memberId}</div>
                                <div class="ranking_score">${j.score}</div>
                                <div class="ranking_tier"><img src="${j.tier}" alt="tier_icon" class="tier_icon"></div>
                            </div>
                        </c:forEach>


                    </div>
                    <%-- ranking_box--%>

                </div>
                <%-- main top--%>


                <div class="main_bottom row">

                    <c:forEach var="i" items="${list}">

                        <c:choose>
                            <c:when test="${sessionScope.loginId == i.writer}"> <%-- 작성자 시점 --%>

                                <div class="reply_bar">
                                    <div class="reply_profile"><img id="img"
                                                                    src="/downloadImgFile.member?memberId=${i.writer}"
                                                                    onerror="this.onerror=null; this.src='/member/my_page/img/profile.svg';"
                                                                    alt="profile"/></div>
                                    <div class="reply_main">
                                        <div class="reply_center"> 작성자 : ${i.writer} <img src="${i.tier}"
                                                                                          alt="tier_icon"
                                                                                          class="tier_icon"></div>

                                        <div class="reply_center reply_content" name="contents"
                                             value="${i.contents}" contenteditable="false"
                                             data-original="${i.contents}">
                                                ${i.contents}
                                        </div>
                                    </div>
                                        <%--reply_main--%>


                                    <form action="/update_reply.game" method="post" class="update_form">
                                        <input type="hidden" name="contents" class="hidden_contents">
                                        <input type="hidden" name="gameId" value="${i.gameId}">
                                        <input type="hidden" name="writer" value="${i.writer}">
                                        <input type="hidden" name="id" value="${i.id}">

                                        <button type="button" class="btn-edit"
                                                style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 5px;">
                                            수정
                                        </button>
                                        <button type="submit" class="btn-update d-none"
                                                style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 5px;">
                                            수정 완료
                                        </button>
                                        <button type="button" class="btn-cancel d-none"
                                                style="background-color:#dc3545; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 5px;">
                                            취소
                                        </button>

                                    </form>

                                    <form action="/delete_reply.game" method="post">
                                        <input type="hidden" name="gameId" value="${i.gameId}">
                                        <input type="hidden" name="writer" value="${i.writer}">
                                        <input type="hidden" name="id" value="${i.id}">
                                        <button class="btn-delete"
                                                style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 5px;">
                                            삭제
                                        </button>
                                    </form>

                                        <%--                                <div class="dropdown">--%>
                                        <%--                                        &lt;%&ndash; 원본 class="btn btn btn-dark dropdown-toggle" &ndash;%&gt;--%>
                                        <%--                                    <form action="/report_reply.game" method="get">--%>
                                        <%--                                        <input type = "hidden" name="gameId" value="${i.gameId}">--%>
                                        <%--                                        <input type = "hidden" name="writer" value="${i.writer}">--%>
                                        <%--                                        <input type = "hidden" name="reportcount" value="${i.report_count}">--%>
                                        <%--                                    <button type="button" class="btn btn btn-dark" id="reportPost" data-bs-toggle="dropdown" aria-expanded="false"--%>
                                        <%--                                            style="background: transparent; border: none; padding: 0;">--%>
                                        <%--                                        <i class="bi bi-three-dots-vertical"></i>--%>
                                        <%--                                    </button>--%>

                                        <%--&lt;%&ndash;                                    <ul class="dropdown-menu dropdown-menu-end">&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;                                        <li><button type="submit" class="dropdown-item text-danger" >신고하기</button></li>&ndash;%&gt;--%>
                                        <%--&lt;%&ndash;                                    </ul>&ndash;%&gt;--%>
                                        <%--                                    </form>--%>
                                        <%--                                </div>--%>
                                        <%--                                --%>
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
                                                                                          class="tier_icon"></div>

                                        <div class="reply_center reply_content" name="contents"
                                             value="${i.contents}" contenteditable="false"
                                             data-original="${i.contents}">
                                                ${i.contents}
                                        </div>
                                    </div>
                                    <div class="dropdown">
                                            <%-- 원본 class="btn btn btn-dark dropdown-toggle" --%>
                                        <form action="/report_reply.game" method="get">
                                            <input type="hidden" name="gameId" value="${i.gameId}">
                                            <input type="hidden" name="writer" value="${i.writer}">
                                            <input type="hidden" name="reportcount" value="${i.report_count}">
                                            <button type="button" class="btn btn btn-dark" id="reportPost"
                                                    data-bs-toggle="dropdown" aria-expanded="false"
                                                    style="background: transparent; border: none; padding: 0;">
                                                <i class="bi bi-three-dots-vertical"></i>
                                            </button>

                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li>
                                                    <button type="submit" class="dropdown-item text-danger">신고하기
                                                    </button>
                                                </li>
                                            </ul>
                                        </form>
                                    </div>
                                </div>


                            </c:otherwise>

                        </c:choose>

                    </c:forEach>


                    <form action="/write_reply.game" method="post">
                        <div class="text_reply">
                            <input type="hidden" name="writer" value="${sessionScope.loginId}">
                            <input type="hidden" name="gameId" value="${gameId}"> <%--${game_id}--%>
                            <input type="text" class="reply_area" placeholder="write your comment!" name="contents">
                            <button id="writing_btn" class="reply_btn"><i class="fa-solid fa-paper-plane"
                                                                          style="color: #ffffff;"></i></button>
                        </div>
                    </form>


                </div> <!-- main_bottom -->
            </div>
            <%-- main --%>
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




