<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<html>
<head>
    <jsp:include page="/game/pmg/GameHead.jsp"/>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel = "stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <link rel="stylesheet" href="/game/pmg/pmg_gamepage.css">
    <!-- ✅ Bootstrap CSS 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <jsp:include page="/common/Head.jsp"/> <%-- 사이드 네비바--%>

</head>

<body>
<div class="container">

    <div class="row">
        <div class="col-12">
            <div class="top">
                <a href="#">
                    <div class="logo">
                        <img src="/game/pmg/img/logo.png">
                    </div>
                </a>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-1">

            <jsp:include page="/common/sidenavi/SideNavi.jsp"/>

        </div>


        <div class="col-11">
            <div class="main">

                <div class="main_top">
                    <%--                    <div class="row">--%>
                    <%--                        <div class="col-md-6">--%>
                    <div class="game_box">
                        Play Game! <br>
                        <button class = "play_btn"> play </button>

                        <script>
                            $(".play_btn").on("click",function (){
                                $(".game_box").empty(); // title play 버튼 지우기
                                $(".game_box").load("/game/pmg/pmg_game.jsp"); //링크게임 내용실행
                            });

                        </script>

                    </div>
                    <%-- </div>--%>



                    <%--  <div class="col-md-6">--%>

                    <div class="ranking_box">
                        <div class="ranking_title">Ranking</div>

                        <c:forEach var= "j" items = "${listranking}">
                            <div class="ranking_bar">
                                <div class="ranking_number">${j.rank}</div>
                                <div class="ranking_name">${j.memberId}</div>
                                <div class="ranking_score">${j.score}</div>
                                <div class="ranking_tier">${j.tier}</div>
                            </div>
                        </c:forEach>


                    </div> <%-- ranking_box--%>

                </div>   <%-- main top--%>


                <div class="main_bottom">

                    <c:forEach var= "i" items = "${list}">
                        <%-- choose , when 사용하여 i.id = sessionScope.id 조건 붙일것--%>
                        <%--<c:choose> <c:when test="${sessionScope.loginId == i.writer}"> 작성자 시점
                        ,  otherwise ~~ 그외 유저 시점 --%>

                        <div class="reply_bar">
                            <div class="reply_profile"><i class="fa-solid fa-user"></i></div>

                            <div class="reply_main">
                                <div class="reply_center "> member ${i.writer} ${i.tier}</div>

                                <div class="reply_center reply_content" name="contents"
                                     value="${i.contents}" contenteditable="false" data-original="${i.contents}">
                                        ${i.contents}
                                </div>
                            </div><%--reply_main--%>
                            <form action="/update_reply.game" method="post" class="update_form">
                                <input type="hidden" name="gameId" value="${i.gameId}">
                                <input type="hidden" name="writedate" value="${i.writeDate}">
                                <input type="hidden" name="contents" class="hidden_contents">

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
                                <input type = "hidden" name="gameId" value="${i.gameId}">
                                <input type = "hidden" name="writedate" value="${i.writeDate}">
                                <button class="btn-delete" style="background-color:#3E459D; color:#fff; font-size:15px; border-radius:10px; border:none; padding: 5px 5px;">삭제</button>
                            </form>

                            <div class="dropdown">
                                    <%-- 원본 class="btn btn btn-dark dropdown-toggle" --%>
                                <button type="button" class="btn btn btn-dark" id="reportPost" data-bs-toggle="dropdown" aria-expanded="false"
                                        style="background: transparent; border: none; padding: 0;">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>

                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item text-danger" href="#">신고하기</a></li>
                                </ul>

                            </div>
                        </div>



                    </c:forEach>

                    <form action="/write_reply.game" method="post">
                        <div class="text_reply">
                            <input type="hidden" name="writer" value="man">
                            <input type="hidden" name="gameId" value="5">
                            <input type="text" class="reply_area" placeholder="write your comment!" name="contents">
                            <button class="reply_btn"><i class="fa-solid fa-paper-plane" style="color: #ffffff;"></i></button>
                        </div>
                    </form>


                </div> <!-- main_bottom -->
            </div> <%-- main --%>
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

    $(".btn-update").on("click", function () {
        const $replyBar = $(this).closest(".reply_bar");
        const $contentDiv = $replyBar.find(".reply_content");
        const $hiddenInput = $(this).closest(".update_form").find(".hidden_contents");

        $hiddenInput.val($contentDiv.text());
        // 폼은 submit 되니 따로 처리 안 해도 됨
    });

</script>







</body>
</html>
