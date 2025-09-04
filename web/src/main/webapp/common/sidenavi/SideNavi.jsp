<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="row g-0">

    <%--홈버튼--%>
    <div id="homebox" class="col-12">
        <div id="home">
            <a href="/index.jsp" id="homebtn"><img src="/common/sidenavi/sideNaviIcon/home_color.svg" alt="homeIcon"></a>
        </div>
    </div>


    <div id="navibox" class="col-12">

        <%--게임--%>
        <div id="game" class="naviContent">
            <div id="gamebtn" class="naviContent">
                <%--기본으로 보이는 아이콘--%>
                <div class="icon main-icon">
                    <img src="/common/sidenavi/sideNaviIcon/main_game_color.svg" alt="gameIcon">
                </div>
                <!-- active되면 보일 아이콘 여기 들어감 -->
            </div>
        </div>


        <%--보드--%>
        <div id="board" class="naviContent">
            <div id="boardbtn" class="naviContent">
                <%--기본으로 보이는 아이콘--%>
                <div class="icon main-icon">
                    <img src="/common/sidenavi/sideNaviIcon/main_massge_color.svg" alt="boardIcon">
                </div>
                <!-- active되면 보일 아이콘 여기 들어감 -->
            </div>
        </div>


        <%--마이페이지--%>
        <div id="mypagebox" class="naviContent">

                <div id="mypage">
                    <a href="/mypage.member" id="mypagebtn"><img src="/common/sidenavi/sideNaviIcon/main_mypage_color.svg" alt="mypageIcon"></a>
                </div>


        </div>
    </div>


        <%--로그아웃 버튼--%>
        <div id="logoutbox" class="col-12">
            <div id="logout">
                <a href="#" id="logoutbtn"><img src="/common/sidenavi/sideNaviIcon/logout_color.svg" alt="logout"></a>
            </div>
        </div>

</div>
<script src="./SideNavi.js"></script>