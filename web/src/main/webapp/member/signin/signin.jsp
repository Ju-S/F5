<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 27.
  Time: 오후 8:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/common/Head.jsp"/>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: white;
            height: 100%;
            overflow: hidden;
        }

        #container1 {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        /*오른쪽*/
        #right {
            float: left;
            width: 50%;
            height: 100%;

            position: relative;
        }

        /*웰컴이미지*/
        #rightZindex2 {
            position: absolute; /* 부모 기준 */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
        }

        #rightZindex2 img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /*블러이미지*/
        #rigthZindex3 {
            position: absolute; /* 부모 기준 */
            top: 7.5%; /* 원하는 만큼 내리기 */
            left: 10%;

            width: 80%;
            height: 85%;
            background-color: #ffffff70;
            z-index: 3;
        }

        #rightText {
            font-family: 'Taenada', sans-serif;
            font-size: 90px;
            font-weight: 600;

            margin-top: 35%;
            margin-left: 5%;
        }


        /*왼쪽*/
        #left {
            float: left;
            width: 50%;
            height: 100%;

            display: flex;
            justify-content: center;
            align-items: center;
        }

        #leftBox {
            border: 1px solid red;

            width: 60%;
            height: 75%;
        }

        #leftText {
            border: 1px solid red;

            width: 100%;
            height: 20%;
        }

        #idrow {
            border: 1px solid red;

            width: 100%;
            height: 10%;
        }

        #idrowBox {
            border: 1px solid red;

            width: 100%;
            height: 60%;
        }

        #idrow input {
            width: 60%;
            height: 100%;
        }

        #idrow button {
            margin:0;
            height: 100%;
            border: 0;
        }

        #pwrow {
            border: 1px solid red;

            width: 100%;
            height: 10%;
        }

        #namerow {
            border: 1px solid red;

            width: 100%;
            height: 10%;
        }

        #nicknamerow {
            border: 1px solid red;

            width: 100%;
            height: 10%;
        }

        #emailrow {
            border: 1px solid red;

            width: 100%;
            height: 10%;
        }

        #dashboardrow {
            border: 1px solid red;

            width: 100%;
            height: 10%;
        }

        #agreerow {
            border: 1px solid red;

            width: 100%;
            height: 20%;
        }


    </style>
</head>
<body>

<div id="container1">
    <%--왼쪽--%>
    <div id="left">
        <div id="leftBox">
            <div id="leftText">Create Account</div>
            <div id="idrow">
                <div id="idrowBox">
                    <input type="text" placeholder="id">
                    <button class="btn btn-primary">중복확인</button>
                </div>
            </div>
            <div id="pwrow">패스워드 생성줄</div>
            <div id="namerow">이름 생성줄</div>
            <div id="nicknamerow">닉네임 생성줄</div>
            <div id="emailrow">이메일</div>
            <div id="dashboardrow">성별 칸 태어난 연도</div>
            <div id="agreerow">개인정보 동의 여부</div>
        </div>


    </div>


    <%--오른쪽--%>
    <div id="right">
        <div id="rigthZindex3">
            <div id="rightText">Let's Get<br>Started!</div>
        </div>

        <div id="rightZindex2">
            <img src="/member/login/loginimg.jpg"/> <%--영서가 이미지 주면 바꿀거임--%>
        </div>


    </div>
</div>


</body>
</html>
