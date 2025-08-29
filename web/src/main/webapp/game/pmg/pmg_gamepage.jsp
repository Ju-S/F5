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
<%--                        </div>--%>



<%--                        <div class="col-md-6">--%>
                            <div class="ranking_box">
                                <div class="ranking_title">Ranking <i class="fa-solid fa-crown" style="color: #FFD43B;"></i> </div>

                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>

                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>
                                <div class="ranking_bar">
                                    <div class="ranking_number">1등</div>
                                    <div class="ranking_name">가나다라</div>
                                    <div class="ranking_score">233,100점</div>
                                    <div class="ranking_tier">GOLD</div>
                                </div>



                            </div> <%-- ranking_box--%>

                </div>   <%-- main top--%>


                <div class="main_bottom">

                    <c:forEach var= "i" items = "${list}">

                        <div class= "reply_bar">
                            <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                            <div class="reply_main">
                                <div class="reply_center"> member ${i.writer}</div>
                                <div class="reply_center">subhead <input type = "text" value = "${i.contents}" /></div>
                            </div>



                            <div class="dropdown">

                                <button type="button" class="btn btn btn-dark dropdown-toggle" id="reportPost"
                                        data-bs-toggle="dropdown" aria-expanded="false"
                                        style="background: transparent; border: none; padding: 0;">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>

                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item text-danger" href="#">🚨 신고하기</a></li>
                                </ul>

                            </div>


                        </div>


                    </c:forEach>

                    <form action="/write_reply.game" method="post">
                        <div class="text_reply">
                            <input type="hidden" name="writer" value="writer">
                            <input type="hidden" name="game_id" value="1">
                            <input type="text" class="reply_area" placeholder="write your comment!" name="contents">
                            <button class="reply_btn"><i class="fa-solid fa-keyboard" style="color: #ffffff;"></i></button>
                        </div>
                    </form>

                    <form action="/go_gamepage1.game" method="get">
                        <button type = "submit"> 버튼</button>
                    </form>

                </div> <!-- main_bottom -->
            </div> <%-- main --%>
        </div> <!-- col-11 -->
    </div> <!-- row-->
</div>  <!-- container -->


</body>
</html>
