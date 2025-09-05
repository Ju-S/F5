<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>

<head>
    <title>F5</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
            crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="/common/common.css">

    <link rel="stylesheet" href="/common/header/Header.css">

    <link rel="stylesheet" href="/common/sidenaviadmin/sideNaviAdmin.css">


    <%--
        <link rel="stylesheet" href="/board/detailBoard/detailBoard.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">--%>


    <style>


        .container {
            width: 100%;
            height: 100%;
            margin: auto;
            padding: 0;
        }

        /*네비바와 나머지 나눔*/
        #row0 {
            height: 100%; /* row가 container를 가득 채움 */
        }

        .col-1, .col-11 {
            height: 100%; /* row 안에서 꽉 차도록 */
        }

        #naviBar {
            background-color: #989898;
            height: 100%;
        }

        /* co-11의 1층*/
        #row1 {
            display: flex; /* row를 flex로 */
            /*    gap: 20px;             !* 원하는 간격 *!*!*/
            height: 48%;
        }

        #row1 .col-7, #row1 .col-5 {
            height: 100%;
        }

        #gamebox {
            background-color: var(--primary-subcolor);
            border-radius: 22px;
            margin-left: 10px;
            width: calc(100% - 10px);
            height: 100%;

            display: flex;
            align-items: center;
            justify-content: center;
        }
        #gameboxContent{
            width: 600px;
            height: 400px;
            background-color: #ffbbbb;
        }
        #gamerank {
            border-radius: 22px;
            background-color: var(--primary-subcolor);

            margin-left: 24px;
            width: 416px;
            height: 100%;
        }

        #gamerankHeader {
            width: 100%;
            height: 20%;
        }

        #gamerankBody {
            width: 100%;
            height: 70%;
            overflow-y: auto;
        }

        .gamerankBodyrow {
            width: 100%;
            height: 70px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .order {
            float: left;
            width: 10%;
            height: 100%;
            border: 1px solid red;
        }

        .orderProfile {
            float: left;
            width: 20%;
            height: 100%;
            border: 1px solid red;
        }

        .orderRight {
            float: left;
            width: 70%;
            height: 100%;
            border: 1px solid red;
        }

        .orderName {
            width: 100%;
            height: 60%;
            border: 1px solid red;
        }

        .orderTime {
            width: 100%;
            height: 40%;
            border: 1px solid red;
        }

        #gamerankFooter {
            width: 100%;
            height: 10%;
        }


        /* co-11의 2층*/
        #row2 {
            width: 100%;
            height: 52%;
            /*gap: 10px;*/

        }

        #inputrowCol-12 {
            width: 95%;
            height: 68%;

            margin-top: 24px;
            margin-left: 10px;


        }

        #inputbox {
            width: 100%;
            height: 100%;

            border-radius: 22px;
            background-color: var(--primary-subcolor);
            position: relative; /*부모요소여서 줘야함*/
            overflow: hidden;
        }

        #inputrow {
            display: flex;
            gap: 10px; /* 필요하면 버튼과 인풋 사이 간격 */
            width: 100%;
            height: 20%;

            position: absolute;
            bottom: 0; /*부모 요소에 딱 붙게*/
        }

        #replyInput {
            margin-bottom: 20px;
            margin-left: 20px;

            flex: 8; /* 전체 중 8 비율 */
            height: 80%;

            border-radius: 11px;
        }

        #replyBtn {
            margin-bottom: 20px;
            margin-right: 20px;
            border-radius: 11px;

            flex: 1; /* 전체 중 2 비율 */
            height: 80%;
        }

        #replyrow {
            height: 80%;
            width: 100%;
            overflow-y: auto; /*y축 스크롤*/
            scrollbar-gutter: stable;

            padding: 12px 12px 0 12px;
            position: absolute;
            bottom: 20%;
        }

        .eachReplyRow {
            height: 80px;
            width: 100%;
            border-bottom: 1px solid red ;
        }


    </style>


</head>
<body>
<jsp:include page="/common/header/Header.jsp"/>

<div class="container g-0">
    <div class="row g-0" id="row0">
        <div class="col-1">
            <!-- 네비게이션 -->
            <jsp:include page="/common/sidenaviadmin/sideNaviAdmin.jsp"/>

        </div>


        <div class="col-11">
            <div class="row g-0" id="row1">

                <div class="col-7" id="gamecontainer">
                    <div id="gamebox">
                        <div id="gameboxContent">
                            진짜게임
                        </div>

                    </div>
                </div>
                <div class="col-5" id="gamerankbox">
                    <div id="gamerank">
                        <div id="gamerankHeader">
                            Ranking
                        </div>
                        <div id="gamerankBody">


                            <!-- 여기에 foreach 돌려서 가져오기-->
                            <div class="gamerankBodyrow">
                                <div class="order">순위</div>
                                <div class="orderProfile">순위프로필</div>
                                <div class="orderRight">
                                    <div class="orderName">순위이름</div>
                                    <div class="orderTime">클리어타임</div>
                                </div>
                            </div>
                            <div class="gamerankBodyrow">
                                <div class="order">순위</div>
                                <div class="orderProfile">순위프로필</div>
                                <div class="orderRight">
                                    <div class="orderName">순위이름</div>
                                    <div class="orderTime">클리어타임</div>
                                </div>
                            </div>
                            <div class="gamerankBodyrow">
                                <div class="order">순위</div>
                                <div class="orderProfile">순위프로필</div>
                                <div class="orderRight">
                                    <div class="orderName">순위이름</div>
                                    <div class="orderTime">클리어타임</div>
                                </div>
                            </div>
                            <div class="gamerankBodyrow">
                                <div class="order">순위</div>
                                <div class="orderProfile">순위프로필</div>
                                <div class="orderRight">
                                    <div class="orderName">순위이름</div>
                                    <div class="orderTime">클리어타임</div>
                                </div>
                            </div>
                            <div class="gamerankBodyrow">
                                <div class="order">순위</div>
                                <div class="orderProfile">순위프로필</div>
                                <div class="orderRight">
                                    <div class="orderName">순위이름</div>
                                    <div class="orderTime">클리어타임</div>
                                </div>
                            </div>


                        </div>
                        <div id="gamerankFooter">

                        </div>

                    </div>
                </div>


            </div>
            <div class="row g-0" id="row2">
                <div class="col-12" id="inputrowCol-12">
                    <div id="inputbox">
                        <div id="inputrow">
                            <input type="text" id="replyInput">
                            <button type="button" id="replyBtn">덧글</button>
                        </div>

                        <div id="replyrow">

                            <%--+ 여기에 foreach돌려서 댓글 가져와야함--%>
                            <div class="eachReplyRow">과거1</div>
                            <div class="eachReplyRow">과거2</div>


                            <!--여기에 댓글 추가됨-->

                        </div>
                    </div>
                </div>

            </div>
        </div>


    </div>
</div>

<script>

    /*댓글 ajax로 보내서 추가하기*/
    $("#replyBtn").on("click", function () {

        //1. 최상위 row 인스턴스 만들고
        let div = $("<div>").addClass("eachReplyRow row g-0").text("new");


        /*여기서 ajax로 보내서 서버도 댓글저장*/


        $("#replyrow").prepend(div); /*최신게 위로 -> 위로 추가되도록*/

        return false;
    })


</script>


</body>
</html>
