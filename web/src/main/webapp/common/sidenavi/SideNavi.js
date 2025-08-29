$(document).ready(function () {


// 버튼 열려있는지에 대한 함수
const menuState = {
    gamebtn: false,
    boardbtn: false,
    mypagebtn: false
};

//아이콘 이미지 배열로 넘기기
let gameIcons = [
        { src: "/common/sidenavi/sideNaviIcon/game1.svg", link: "/game1" },
        { src: "/common/sidenavi/sideNaviIcon/game2.svg", link: "/game2" },
        { src: "/common/sidenavi/sideNaviIcon/game3.svg", link: "/game3" },
        { src: "/common/sidenavi/sideNaviIcon/game4.svg", link: "/game4" }
    ];
let boardIcons = [
        { src: "/common/sidenavi/sideNaviIcon/Group.svg", link: "/game/allList.jsp" },
        { src: "/common/sidenavi/sideNaviIcon/game1.svg", link: "/game/game1List.jsp" },
        { src: "/common/sidenavi/sideNaviIcon/game2.svg", link: "/game/game2List.jsp" },
        { src: "/common/sidenavi/sideNaviIcon/game3.svg", link: "/game/game3List.jsp" },
        { src: "/common/sidenavi/sideNaviIcon/game4.svg", link: "/game/game4List.jsp" }
    ];
let mypageIcons = [
    { src: "/common/sidenavi/sideNaviIcon/game1.svg", link: "/myPage1" },
    { src: "/common/sidenavi/sideNaviIcon/game2.svg", link: "/myPage2" }
];


//공통 마우스오버 이벤트 함수
    function mouseoverHandle(buttonId){
        //맨 윗 아이콘에대하여 하얀색 아이콘으로 변경
        const $btn = $(`#${buttonId}`);
        const $firstIcon = $btn.find(".main-icon img");
        if(buttonId==="gamebtn"){//게임버튼 눌렀을 때
            $firstIcon.attr("src","/common/sidenavi/sideNaviIcon/main_game.svg");

        }else if(buttonId==="boardbtn"){
            $firstIcon.attr("src","/common/sidenavi/sideNaviIcon/main_massge.svg");

        }else if(buttonId==="mypagebtn"){
            $firstIcon.attr("src","/common/sidenavi/sideNaviIcon/main_mypage.svg");
        }
    }
//마우스오버 이벤트 바인딩
    $("#gamebtn").on("mouseover", function (e) {
        e.stopPropagation();
        mouseoverHandle("gamebtn",gameIcons);
    });
    $("#boardbtn").on("mouseover", function (e) {
        e.stopPropagation();
        mouseoverHandle("boardbtn",boardIcons);
    });
    $("#mypagebtn").on("mouseover", function (e) {
        e.stopPropagation();
        mouseoverHandle("mypagebtn",mypageIcons);
    });


//공통 마우스리브 이벤트 함수
    function mouseleaveHandle(buttonId){
        // 아이콘 원래 이미지로 복구
        const $btn = $(`#${buttonId}`);
        const $firstIcon = $btn.find(".main-icon img");
        if ($btn.attr("id") === "gamebtn") {
            $firstIcon.attr("src", "/common/sidenavi/sideNaviIcon/main_game_color.svg");
        } else if ($btn.attr("id") === "boardbtn") {
            $firstIcon.attr("src", "/common/sidenavi/sideNaviIcon/main_massge_color.svg");
        } else if ($btn.attr("id") === "mypagebtn") {
            $firstIcon.attr("src", "/common/sidenavi/sideNaviIcon/main_mypage_color.svg");
        }
    }
//마우스리브 이벤트 바인딩
    $("#gamebtn").on("mouseleave", function (e) {
        e.stopPropagation();
        mouseleaveHandle("gamebtn",gameIcons);
    });
    $("#boardbtn").on("mouseleave", function (e) {
        e.stopPropagation();
        mouseleaveHandle("boardbtn",boardIcons);
    });
    $("#mypagebtn").on("mouseleave", function (e) {
        e.stopPropagation();
        mouseleaveHandle("mypagebtn",mypageIcons);
    });




// 공통 클릭 이벤트 함수
function clickHandle(buttonId, iconsArr) {
    const $btn = $(`#${buttonId}`);

    if (!menuState[buttonId]) {// 버튼 열려있지 않으면

        closeAllMenus(); // 일단 다른 메뉴 다 닫고
        menuState[buttonId] = true;//현재것만 true로 변경

        //맨 윗 아이콘에대하여 하얀색 아이콘으로 변경
        const $firstIcon = $btn.find(".main-icon img");
        if(buttonId==="gamebtn"){//게임버튼 눌렀을 때
            $firstIcon.attr("src","/common/sidenavi/sideNaviIcon/main_game.svg");

        }else if(buttonId==="boardbtn"){
            $firstIcon.attr("src","/common/sidenavi/sideNaviIcon/main_massge.svg");

        }else if(buttonId==="mypagebtn"){
            $firstIcon.attr("src","/common/sidenavi/sideNaviIcon/main_mypage.svg");
        }


        //서브메뉴 추가
        const $submenu = $("<div>").addClass("submenu");
        for (let icon of iconsArr) {
            const $img = $("<img>").attr("src", icon.src);
            const $div =$("<div>").addClass("icon").append($img);
            const $iconA = $("<a>").attr("href", icon.link).append($div);
            $submenu.append($iconA);
        }
        $btn.append($submenu);

        //0초 뒤에 open 클래스 주기: submenu크기를 안의 내용물에 맞춰 키운다(max-height)
        setTimeout(() => {
            $submenu.addClass("open");
        }, 100);

    } else { // 버튼 열려있으면 않으면
        menuState[buttonId] = false;
        closeBtn($btn);
    }
}


// 버튼 클릭 이벤트 바인딩
    $("#gamebtn").on("click", function (e) {
        e.stopPropagation();
        clickHandle("gamebtn",gameIcons);
    });
    $("#boardbtn").on("click", function (e) {
        e.stopPropagation();
        clickHandle("boardbtn",boardIcons);
    });
    $("#mypagebtn").on("click", function (e) {
        e.stopPropagation();
        clickHandle("mypagebtn",mypageIcons);
    });




// 닫기 함수
function closeBtn($btn) {
    const $submenu = $btn.find(".submenu");
    $submenu.removeClass("open");


    const $firstIcon = $btn.find(".main-icon img");
    if ($btn.attr("id") === "gamebtn") {
        $firstIcon.attr("src", "/common/sidenavi/sideNaviIcon/main_game_color.svg");
    } else if ($btn.attr("id") === "boardbtn") {
        $firstIcon.attr("src", "/common/sidenavi/sideNaviIcon/main_massge_color.svg");
    } else if ($btn.attr("id") === "mypagebtn") {
        $firstIcon.attr("src", "/common/sidenavi/sideNaviIcon/main_mypage_color.svg");
    }



    setTimeout(() => {
        const $firstIcon = $btn.find(".icon:nth-child(1)");//맨 윗 아이콘에대하여
        $firstIcon.css("margin-bottom","0px");//마진0
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


// 문서 클릭 시 메뉴 닫기
$(document).on("click", function (e) {
    if (
        !$(e.target).closest("#gamebtn").length &&
        !$(e.target).closest("#boardbtn").length &&
        !$(e.target).closest("#mypagebtn").length
    ) {
        closeAllMenus();
    }
});


});
