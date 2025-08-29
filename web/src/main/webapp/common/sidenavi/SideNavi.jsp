<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
                    <img src="/common/sidenavi/sideNaviIcon/main_game_color.svg" alt="gameIcon">
                </div>
                <!-- active되면 보일 아이콘 여기 들어감 -->
            </div>
        </div>


        <%--보드--%>
        <div id="board" class="naviContent">
            <div id="boardbtn" class="naviContent">
                <%--기본으로 보이는 아이콘--%>
                <div class="icon">
                    <img src="/common/sidenavi/sideNaviIcon/main_massge_color.svg" alt="boardIcon">
                </div>
                <!-- active되면 보일 아이콘 여기 들어감 -->
            </div>
        </div>


        <%--마이페이지--%>
        <div id="mypage" class="naviContent">
            <div id="mypagebtn" class="naviContent">
                <%--기본으로 보이는 아이콘--%>
                <div class="icon">
                    <img src="/common/sidenavi/sideNaviIcon/main_mypage_color.svg" alt="mypageIcon">
                </div>
                <!-- active되면 보일 아이콘 여기 들어감 -->
            </div>
        </div>
    </div>
</div>
<script src="./SideNavi.js"></script>