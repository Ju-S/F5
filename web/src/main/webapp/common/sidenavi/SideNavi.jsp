<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 29.
  Time: 오전 8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/common/Head.jsp"/>
    <link rel="stylesheet" href="/common/header/Header.css">
    <link rel="stylesheet" href="/common/sidenavi/SideNavi.css">


</head>
<body>
<%--헤더--%>
<jsp:include page="/common/header/Header.jsp"/>


<div id="container g-0">
    <div class="row g-0">


        <div class="col-1" id="sideNavi">
            <div class="row g-0">

                <%--홈버튼--%>
                <div id="homebox" class="col-12">
                    <div id="home">home</div>
                </div>


                <div id="navibox" class="col-12">

                    <%--게임--%>
                    <div id="game" class="naviContent">
                        <div id="gamebtn" class="naviContent">
                            <%--기본으로 보이는 아이콘--%>
                            <div class="icon">
                                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916598.png" alt="game">
                            </div>
                            <!-- active되면 보일 아이콘 여기 들어감 -->
                        </div>
                    </div>


                    <%--보드--%>
                    <div id="board" class="naviContent">
                        <div id="boardbtn" class="naviContent">
                            <%--기본으로 보이는 아이콘--%>
                            <div class="icon">
                                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916598.png" alt="game">
                            </div>
                            <!-- active되면 보일 아이콘 여기 들어감 -->
                        </div>
                    </div>


                    <%--마이페이지--%>
                    <div id="mypage" class="naviContent">
                        <div id="mypagebtn" class="naviContent">
                            <%--기본으로 보이는 아이콘--%>
                            <div class="icon">
                                <img src="https://cdn-icons-png.flaticon.com/128/3916/3916598.png" alt="game">
                            </div>
                            <!-- active되면 보일 아이콘 여기 들어감 -->
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <%-- 다른 영역 --%>
        <div class="col-11">
            <div id="other">사이드네비</div>
        </div>
    </div>
</div>


<script src="./SideNavi.js"></script>


</body>
</html>
