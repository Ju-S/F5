<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="row g-0">
    <%--홈버튼--%>
    <div id="homebox" class="col-12">
        <div id="home">
            <a href="/index.jsp" id="homebtn"><img src="/common/sidenaviadmin/sideNaviAdminIcon/home_color.svg" alt="homeIcon"></a>
        </div>
    </div>

    <div id="navibox" class="col-12">

        <div id="admin1" class="naviContent">
            <div id="admin1btn" class="naviContent">
                <%--기본으로 보이는 아이콘--%>
                <div class="icon main-icon">
                    <img src="/common/sidenaviadmin/sideNaviAdminIcon/Group_color.svg" alt="gameIcon">
                </div>
                <!-- active되면 보일 아이콘 여기 들어감 -->
            </div>
        </div>


        <div id="admin2box" class="naviContent">
            <div id="admin2">
                <a href="/mypage.member" id="mypagebtn">
                    <img src="/common/sidenaviadmin/sideNaviAdminIcon/Admin-color.svg" alt="mypageIcon">
                </a>
            </div>
        </div>
    </div>

    <%--로그아웃 버튼--%>
    <div id="logoutbox" class="col-12">
        <div id="logout">
            <a href="#" id="logoutbtn"><img src="/common/sidenaviadmin/sideNaviAdminIcon/logout_color.svg" alt="logout"></a>
        </div>
    </div>

</div>
<script src="/common/sidenaviadmin/sideNaviAdmin.js"></script>
