<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #101012;
            color:white;
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
            cursor: pointer
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
            width: 62%;
            height: 90%;
            float: left;
            margin-top: 20px;
            background-color: lightgrey;
            font-size : 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            color:#EC6333;
            border-radius: 30px;
        }

        .ranking_box{
            width : 35%;
            height: 90%;
            float: right;
            margin-top: 20px;
            background-color: #2a2a2a;
            overflow-y: auto;
            border-radius: 30px;
        }

        .ranking_title{
            width: 100%;
            height: 10%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 30px;
            border-color: black;
        }

        .ranking_bar{
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
            border-color: white;
            background-color: #2a2a2a;
            border-radius: 15px;
        }

        .text_reply{
            width: 100%;
            height: 20%;
            display: flex;
            border-radius: 15px;
            border-color: white;
            margin-bottom : auto;
        }

        .reply_area {
            width: 80%;
            height: 100%;
            font-size: 40px;
            border-radius: 15px;

        }

        .reply_area::placeholder {
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
            color:white;
        }

        .reply_btn:hover{
            cursor: pointer;
        }

        .reply_bar{
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
            background-color: black;
            color:white;

            align-items: center;
        }

        .reply_bar_btn:hover{
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
        <div class="navi"> <i class="fa-solid fa-gamepad" style="color: #74C0FC; font-size: 50px;"></i></i></div>
        <div class="navi"> <i class="fa-solid fa-comment-dots" style="font-size: 50px"></i></div>
        <div class="navi"> <i class="fa-solid fa-id-card-clip" style="font-size: 50px"></i></div>

    </div>

    <div class="main">

        <div class="main_top">

            <div class="game_box">Play Game!</div>

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
                    <div clss="ranking_tier">GOLD</div>
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


            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>


            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>

            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>

            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>

            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>

            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>

            <div class="reply_bar">
                <div class="reply_profile"><i class="fa-solid fa-user"></i></div>
                <div class="reply_main">
                    <div class="reply_center">
                        member
                    </div>
                    <div class="reply_center">
                        Subhead
                    </div>
                </div>
                <button class="reply_bar_btn">신고 <i class="fa-solid fa-triangle-exclamation" style="color: #f3127e;"></i></button>
            </div>





            <div class="text_reply">
                <input type="text" class="reply_area" placeholder="write your comment!">
                <button class="reply_btn"><i class="fa-solid fa-keyboard" style="color: #ffffff;"></i></button>
            </div>

        </div> <!-- main_bottom -->

    </div> <!-- main -->


</div> <!-- container -->
</body>
</html>
