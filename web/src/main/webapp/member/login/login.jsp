<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 27.
  Time: 오후 3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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


        /*왼쪽*/
        #left{
            float: left;
            width: 50%;
            height: 100%;

            position: relative;
        }
        /*웰컴이미지*/
        #leftZindex2{
            position: absolute; /* 부모 기준 */
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            z-index: 2;
        }
        #leftZindex2 img{
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        /*블러이미지*/
        #leftZindex3{
            position: absolute; /* 부모 기준 */
            top: 7.5%;  /* 원하는 만큼 내리기 */
            left: 10%;

            width: 80%;
            height: 85%;
            background-color: #ffffff70;
            z-index: 3;
        }
        #leftText{
            font-family: 'Taenada', sans-serif;
            font-size: 90px;
            font-weight: 600;

            margin-top: 35%;
            margin-left: 5%;
        }


        /*오른쪽*/
        #right{
            float: left;
            width: 50%;
            height: 100%;

            display: flex;
            justify-content: center;

        }
        #rightBox{
            /*border: 1px solid red;*/

            margin-top: 27%;
            width: 45%;
            height: 50%;

        }
        #loginText{
            /*border: 1px solid red;*/
            width: 100%;
            height: 25%;

            font-family: 'Taenada', sans-serif;
            font-size: 40px;
            font-weight: 600;
            padding-top: 4%;
        }
        #loginBox{
            /*border: 1px solid red;*/
            width: 100%;
            height: 40%;
            padding-top: 2%;
        }
        #loginBox input{

            border-radius: 11px;
            background-color: white;
            border: 1.5px solid #949494;
            padding-left: 4%;

            width: 100%;
            height: 28%;
        }
        #loginBox input:nth-child(2) {
            margin-top: 6%;
        }

        #loginBtnBox{
            /*border: 1px solid red;*/
            width: 100%;
            height: 10%;
        }
        #loginBtnBox button{
            background-color:#3E459D;
            border-radius: 11px;

            width: 100%;
            height: 100%;
        }
        #loginFooter{
            /*border: 1px solid red;*/
            width: 100%;
            height: 25%;

            display: flex;
            justify-content: center;

        }
        #loginFooter a{
            margin-top: 7%;
            /*border: 1px solid red;*/
            color: #949494;
        }
        #verticalLine{
            border-left: 1px solid #949494;
            height: 25%;
            margin-top: 7%;
            margin-right: 4%;
            margin-left: 4%;
            display: inline;
        }


    </style>


</head>


<body>
<div id="container1">
    <div id="left">
        <div id="leftZindex3">
            <div id="leftText">Welcome<br>Back</div>
        </div>

        <div id="leftZindex2">
            <img src="/member/login/loginimg.jpg"/> <%--영서가 이미지 주면 바꿀거임--%>
        </div>


    </div>
    <div id="right">
        <div id="rightBox">
            <div id="loginText">Login</div>
            <div id="loginBox">
                <input type="text" placeholder="ID" id="id">
                <input type="password" placeholder="PW" id="pw">

            </div>

            <div id="loginBtnBox">
                <button class="mainGameBtn btn btn-primary slide-right">로그인</button>
            </div>
            <div id="loginFooter">
                <a href="/" id="findId">아이디 찾기</a>
                <div id="verticalLine"></div> <!-- 수직선 추가 -->
                <a href="/" id="findPw">비밀번호 찾기</a>
            </div>
        </div>
    </div>

</div>


</body>
</html>
