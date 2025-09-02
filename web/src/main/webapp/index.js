// right의 메인 게임페이지 생성자
function createGameView(gameId, titleText, contentText, imgSrc, buttonText) {
    const $container1 = $("<div>").addClass(`mainGame ${gameId}`);
    const $img = $("<img>").addClass("mainGameImg")
        .attr("src", imgSrc)
        .css("transform", "scale(1.05)");
    const $title = $("<div>").addClass("mainGameTitle").html(titleText);
    const $content = $("<div>").addClass("mainGameContent").html(contentText);
    const $button = $("<button>").addClass("mainGameBtn btn btn-primary").html(buttonText + `로 이동`);

    $container1.append($img, $title, $content, $button);
    return $container1;
}

const gameViews = {
    game1: createGameView(
        "game1",
        "게임 1 타이틀",
        "게임 1 에 대한 설명 , 게임 1 에 대한 설명 게임 1 에 대한 설명게임 1 에 대한 설명 게임 1 에 대한 설명게임 1 에 대한 설명",
        "/index_img/desktop_home_js.svg",
        "game1"
    ),
    game2: createGameView(
        "game2",
        "게임 2 타이틀",
        "게임 2 에 대한 설명 , 게임 2 에 대한 설명 게임 2 에 대한 설명게임 2 에 대한 설명 게임 2 에 대한 설명게임 2 에 대한 설명",
        "/index_img/desktop_home_jw.svg",
        "game2"
    ),
    game3: createGameView(
        "game3",
        "게임 3 타이틀",
        "게임 3 에 대한 설명 , 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명",
        "/index_img/desktop_home_kj.svg",
        "game3"
    ),
    game4: createGameView(
        "game4",
        "게임 4 타이틀",
        "게임 4 에 대한 설명 , 게임 4 에 대한 설명 게임 4 에 대한 설명게임 4 에 대한 설명 게임 4 에 대한 설명게임 4 에 대한 설명",
        "/index_img/desktop_home_mk.svg",
        "game4"
    ),
    game5: createGameView(
        "game5",
        "게임 5 타이틀",
        "게임 5 에 대한 설명 , 게임 5 에 대한 설명 게임 5 에 대한 설명게임 5 에 대한 설명 게임 5 에 대한 설명게임 5 에 대한 설명",
        "/index_img/desktop_home_ys.svg",
        "game5"
    )
};

// 왼쪽 네비바 움직이는 메소드
function moveLeftMenu($e, toRight) {
    $e.css({
        transform: toRight ? "translateX(50px)" : "translateX(0px)",
        transition: "transform 0.3s ease"
    });
}

// right의 메인게임페이지에서 애니메이션 중복 제거용 함수
function slideIn($e, slideIn) {
    $e.each(function () {
        this.classList.remove("slide-left", "slide-right");
        void this.offsetWidth;
        this.classList.add(slideIn ? "slide-right" : "slide-left");
    })
}

// 오른쪽 메인 교체 함수
function changeRightView(target) {
    let $currentElements = $("#right").find(".mainGameTitle, .mainGameContent, .mainGameBtn");
    slideIn($currentElements, false);

    setTimeout(() => {
        const $newView = gameViews[target].clone();
        $("#right").html("").append($newView);

        setTimeout(() => {
            $newView.find(".mainGameImg").css("transform", "scale(1)");
        }, 20);

        slideIn($newView.find(".mainGameTitle, .mainGameContent, .mainGameBtn"), true);
    }, 200);
}

// 버튼 클릭 시 게임 페이지 이동
$(document).on("click", ".mainGameBtn", function () {
    let target = $(this).closest(".mainGame").attr("class").split(" ")[1];
    location.href = "/toGame.game?gameId=" + target;
});

// 상태 변수
let lastHoveredGame = "game1";
let activeGame = null; // 현재 클릭으로 고정된 게임

// 왼쪽 게임 클릭
$(".game").on("click", function () {
    const target = $(this).attr("class").split(" ")[1];

    if (activeGame === target) {
        // 같은 게임 다시 클릭 → 해제
        moveLeftMenu($(this), false);
        $(this).find("img").removeClass("clicked"); // 보더 제거
        activeGame = null;
        return;
    }

    // 다른 게임이 고정돼 있으면 원위치
    if (activeGame && activeGame !== target) {
        moveLeftMenu($(`.${activeGame}`), false);
        $(`.${activeGame}`).find("img").removeClass("clicked");
    }

    // 새 게임 고정 (오른쪽 뷰는 바꾸지 않음)
    moveLeftMenu($(this), true);
    $(this).find("img").addClass("clicked"); // 보더 유지
    activeGame = target;
});

// 마우스 올리기 (hover 시에만 right 뷰 변경)
$(".game").on("mouseover", function () {
    const target = $(this).attr("class").split(" ")[1];

    // 클릭으로 고정된 게임은 hover 무시
    if (activeGame === target) return;

    if (lastHoveredGame === target) return;
    lastHoveredGame = target;

    moveLeftMenu($(this), true);
    changeRightView(target); // hover일 때만 오른쪽 뷰 교체
});

// 마우스 내리기
$(".game").on("mouseleave", function () {
    const target = $(this).attr("class").split(" ")[1];

    // 고정된 게임은 원위치 안 시킴
    if (activeGame === target) return;

    moveLeftMenu($(this), false);
});

// 로그인/회원가입 버튼
$("#signinBtn").on("click", function () {
    location.href = "/member/signin/signin.jsp";
});

$("#loginBtn").on("click", function () {
    location.href = "/member/login/login.jsp";
});
