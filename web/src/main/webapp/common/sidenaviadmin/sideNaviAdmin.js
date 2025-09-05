$(document).ready(function () {

    // 버튼 열려있는지에 대한 함수
    const menuState = {
        admin1btn: false // was gamebtn
    };

    //아이콘 이미지 배열 (이름 변경 없이 사용)
    let gameIcons = [
        {src: "/common/sidenaviadmin/sideNaviAdminIcon/board-admin-1.svg", link: "/go_gamepage.game?gameId=1"},
        {src: "/common/sidenaviadmin/sideNaviAdminIcon/board-admin-2.svg", link: "/go_gamepage.game?gameId=2"},
        {src: "/common/sidenaviadmin/sideNaviAdminIcon/board-admin-3.svg", link: "/go_gamepage.game?gameId=3"}
    ];

    // 공통 클릭 이벤트 함수 (로직 동일)
    function clickHandle(buttonId, iconsArr) {
        const $btn = $(`#${buttonId}`);

        if (!menuState[buttonId]) {
            closeAllMenus();
            menuState[buttonId] = true;

            //맨 윗 아이콘 변경
            const $firstIcon = $btn.find(".main-icon img");
            if (buttonId === "admin1btn") {
                $firstIcon.attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Group_32.svg");
            }

            //서브메뉴 추가
            const $submenu = $("<div>").addClass("submenu");
            for (let icon of iconsArr) {
                const $img = $("<img>").attr("src", icon.src);
                const $div = $("<div>").addClass("icon").append($img);
                const $iconA = $("<a>").attr("href", icon.link).append($div);
                $submenu.append($iconA);
            }
            $btn.append($submenu);

            setTimeout(() => { $submenu.addClass("open"); }, 100);
        } else {
            menuState[buttonId] = false;
            closeBtn($btn);
        }
    }

    // 버튼 클릭 이벤트 바인딩
    $("#admin1btn").on("click", function (e) { // was #gamebtn
        e.stopPropagation();
        clickHandle("admin1btn", gameIcons);     // was "gamebtn"
    });

    $("#mypagebtn").on("click", function (e) {
        e.stopPropagation();
    });

    // 닫기 함수
    function closeBtn($btn) {
        const $submenu = $btn.find(".submenu");
        $submenu.removeClass("open");

        const $firstIcon = $btn.find(".main-icon img");
        if ($btn.attr("id") === "admin1btn") { // was "gamebtn"
            $firstIcon.attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Group_color.svg");
        }

        setTimeout(() => {
            const $firstIcon2 = $btn.find(".icon:nth-child(1)");
            $firstIcon2.css("margin-bottom", "0px");
            $submenu.remove();
        }, 200);
    }

    // 모든 메뉴 닫기
    function closeAllMenus() {
        Object.keys(menuState).forEach(id => {
            if (menuState[id]) {
                closeBtn($(`#${id}`));
                menuState[id] = false;
            }
        });
    }

    // 마이페이지 버튼 hover
    $("#mypagebtn").on("mouseover", function () {
        const $firstIcon = $(this).find("img");
        $firstIcon.attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Admin.svg");
    }).on("mouseleave", function () {
        const $firstIcon = $(this).find("img");
        $firstIcon.attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Admin-color.svg");
    }).on("click", function () {
        const $firstIcon = $(this).find("img");
        $firstIcon.attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Admin.svg");
    });

    // 로그아웃 버튼 hover
    $("#logoutbtn").on("mouseover", function () {
        $(this).find("img").attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/logout.svg");
    }).on("mouseleave", function () {
        $(this).find("img").attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/logout_color.svg");
    }).on("click", function () {
        $(this).find("img").attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/logout.svg");
    });

    // 홈 버튼 hover
    $("#homebtn").on("mouseover", function () {
        $(this).find("img").attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Home-1.svg");
    }).on("mouseleave", function () {
        $(this).find("img").attr("src", "/common/sidenavi/sideNaviIcon/home_color.svg");
    }).on("click", function () {
        $(this).find("img").attr("src", "/common/sidenaviadmin/sideNaviAdminIcon/Home-1.svg");
    });

    // 문서 클릭 시 메뉴 닫기
    $(document).on("click", function (e) {
        if (
            !$(e.target).closest("#admin1btn").length &&
            !$(e.target).closest("#mypagebtn").length
        ) {
            closeAllMenus();
        }
    });

});
