<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<html>
<head>
    <jsp:include page="/game/pmg/GameHead.jsp"/>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel = "stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #101012;
            color:#fff;
        }


        .container {
            margin: auto;

        }

        .top {
            width: 1200px;
            height: 100px;
            border: 1px solid black;
        }

        .logo {
            width: 50px;
            height: 50px;

        }

        .logo>img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .left_Navi{
            width: 100px;
            height: 800px;
            float: left;
            border: 1px solid black;
        }

        .navi{
            width: 100%;
            height: 100px;
            align-items: center;

        }

        .navi:hover {
            cursor: pointer;
        ;
        }

        .main{
            width: 1000px;
            height: 800px;
            float: left;
            border: 1px solid black;
        }

        .main_top{
            width: 100%;
            height: 60%;
        }

        .game_box{

            font: var(--title-font);

            width: 62%;
            height: 90%;
            float: left;
            margin-top: 20px;
            background-color: #2a2a2a;
            /*var(--primary-subcolor);*/
            font-size : 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color:#EC6333;
            border-radius: 30px;


        }

        .play_btn{
            width: 150px;
            height: 50px;
            font-size : 30px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: var(--primary-color);
            color:#fff;
            border-radius: 10px;
            margin-top: 30px;

        }

        .play_btn:hover{

            cursor: pointer;
        }

        .ranking_box{

            width : 35%;
            height: 90%;
            float: right;
            margin-top: 20px;
            background-color:  #2a2a2a;
            /*var(--primary-subcolor);*/
            overflow-y: auto;
            border-radius: 30px;
        }

        .ranking_title{
            font: var(--title-font);
            width: 100%;
            height: 10%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 30px;
            border-color: var(--primary-color);
        }

        .ranking_bar{
            font: var(--sub-font);
            width: 100%;
            height: 10%;
            display: flex;

        }

        .ranking_bar > div {
            display: flex;
            justify-content: center;
            align-items: center;

        }

        .ranking_number{ width: 20%; }
        .ranking_name{ width: 30%; }
        .ranking_score{ width: 30%; }
        .ranking_tier{ width: 20%; }

        .main_bottom{
            width: 100%;
            height: 40%;
            float: left;
            overflow-y : auto;
            border-color: #fff;
            background-color:  #2a2a2a;
            /*var(--primary-subcolor);*/
            border-radius: 15px;
        }

        .text_reply{
            width: 100%;
            height: 20%;
            display: flex;
            border-radius: 15px;
            border-color: #fff;
            margin-bottom : auto;
        }

        .reply_area {
            width: 80%;
            height: 100%;
            font-size: 40px;
            border-radius: 15px;
            font: var(--sub-font);
        }

        .reply_area::placeholder {
            font: var(--title-font);
            font-size: 40px;
            text-align: center;
        }

        .reply_btn{
            width: 20%;
            height: 100%;
            font-size: 30px;
            border-radius: 15px;
            margin-right: 10px;
            margin-left : 10px;
            background-color: #3E459D;
            color:#fff;
        }

        .reply_btn:hover{
            cursor: pointer;
        }

        .reply_bar{
            font: var(--title-font);
            width: 100%;
            height: 100px;
            background-color: #2a2a2a;
            display: flex;
            align-items: center;
            margin-top: 10px;
            margin-bottom: 10px;
            padding: 10px;
        }

        .reply_profile{
            width: 15%;
            text-align: center;
            font-size: 20px;
        }

        .reply_main{
            width:70%;
            text-align: center;
        }

        .reply_center{
            width: 100%;
            height: 50%;
            text-align: left;
            float:left;
        }



        .reply_bar_btn{
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 15px;
            background-color: var(--primary-color);
            color:#fff;

            align-items: center;
        }

        .reply_bar_btn:hover{
            font: var(--sub-font);
            cursor: pointer;
        }

    </style>
</head>

<body>
<div class="container">

    <div class="top">
        <a href="#">
            <div class="logo">
                <img src="/game/pmg/img/logo.png">
            </div>
        </a>
    </div>

    <div class="left_Navi">


        <div class="navi"> <i class="fa-solid fa-house" style="font-size: 50px"></i></div>
        <div class="navi"> <i class="fa-solid fa-gamepad" style="color: #74C0FC; font-size: 50px;"></i></div>
        <div class="navi"> <i class="fa-solid fa-comment-dots" style="font-size: 50px"></i></div>
        <div class="navi"> <i class="fa-solid fa-id-card-clip" style="font-size: 50px"></i></div>

    </div>

    <div class="main">

        <div class="main_top">

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



            </div>
        </div>

        <div class="main_bottom">

            <c:forEach var= "i" items = "${list}">

                <div class= "reply_bar">
                    <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                    <div class="reply_main">
                        <div class="reply_center"> member ${i.writer}</div>
                        <div class="reply_center">subhead <input type = "text" value = "${i.contents}" /></div>
                    </div>
                    <button class="reply_bar_btn"> 신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
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

    </div> <!-- main -->


</div> <!-- container -->







</body>
</html>
