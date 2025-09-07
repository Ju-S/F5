


let lastHoveredGame = "game1"; // 마지막으로 호버한 게임
let activeGame = null; // 현재 클릭으로 고정된 게임


// right의 메인 게임페이지 생성하는 함수
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
        "1",
        "Penguin",
        "펭귄의 남극기지 순례 대모험..<br>장애물로 등장하는 얼음구멍을 피해 더 오래 모험을 즐기세요!",
        "/index_img/desktop_home_js.svg",
        "Penguin"
    ),
    game2: createGameView(
        "2",
        "Pac-Man !",
        "심플한 룰, 강렬한 몰입 팩맨이 보여주는 아케이드의 정수!",
        "/index_img/desktop_home_jw.svg",
        "game2"
    ),
    game3: createGameView(
        "3",
        "Bubble Shooter",
        "같은 색의 구슬을 모아 점수를 기록하세요!",
        "/index_img/desktop_home_kj.svg",
        "Bubble Shooter"
    ),
    game4: createGameView(
        "4",
        "I hate injections!",
        "어느 날, 벤은 주사를 예약했다는 말과 함께 병원에 갑니다.\n" +
        "                \"주사 맞기 싫어!! 무섭단 말이야!!!\"<br>\n" +
        "                벤은 결국 병원에서 난동을 피우게 되는데...",
        "/index_img/desktop_home_mk.svg",
        "병원으"
    ),
    game5: createGameView(
        "5",
        "Geometry Dash",
        "장애물을 피해 최고점수를 기록해보세요!",
        "/index_img/desktop_home_ys.svg",
        "Geometry Dash"
    )
};


// left의 네비바 움직이는 메소드
function moveLeftMenu($e, toRight) {
    $e.css({
        transform: toRight ? "translateX(50px)" : "translateX(0px)",
        transition: "transform 0.3s ease"
    });
}
// right의 글씨+버튼용 함수
function slideIn($e, slideIn) {
    $e.each(function () {
        this.classList.remove("slide-left", "slide-right"); //이전에 적용되었던 트랜지션 클래스 있으면 중복방지용으로 지움
        void this.offsetWidth;
        this.classList.add(slideIn ? "slide-right" : "slide-left"); //true만 right으로 나감 false면 left로 들어옴
    })
}
// 오른쪽 메인 교체 함수
function changeRightView(target) {
    if (!target || !gameViews[target]) return;
    let $currentElements = $("#right").find(".mainGameTitle, .mainGameContent, .mainGameBtn");
    slideIn($currentElements, false); // right의 글씨+버튼 왼쪽으로 나가도록



    setTimeout(() => {
        const $newView = gameViews[target].clone(); //새로운 타겟 객체의 복사본 만들어서
        $("#right").html("").append($newView); //right비우고 복사본 넣기

        setTimeout(() => {
            $newView.find(".mainGameImg").css("transform", "scale(1)"); //이미지에 대하여 트랜지션
        }, 20);

        slideIn($newView.find(".mainGameTitle, .mainGameContent, .mainGameBtn"), true); // 새로운 타겟 객체의 복사본의 글씨+버튼 오른쪽에서 들어오게
    }, 200);
}


// 왼쪽 게임 클릭
$(".game").on("click", function () {
    const target = $(this).attr("class").split(" ")[1];// game1, game2 이런 클래스 스트링값으로 받음

    if (activeGame === target) {// 방금 클릭했던 게임이 지금 클릭한 게임과 같다면
        // 같은 게임 다시 클릭 → 해제
        moveLeftMenu($(this), false);
        $(this).find("img").removeClass("clicked"); // 보더 제거
        activeGame = null;
        return;
    }

    // 다른 게임이 고정되어 있는 상태면 그 다른게임을 원위치
    if (activeGame && activeGame !== target) {
        moveLeftMenu($(`.${activeGame}`), false);
        $(`.${activeGame}`).find("img").removeClass("clicked");
    }

    // 새 게임 고정 (오른쪽 뷰는 바꾸지 않음)
    moveLeftMenu($(this), true);
    $(this).find("img").addClass("clicked"); // 보더 유지
    activeGame = target;

    //호버후 클릭했을때 두번 로딩되는거 막고싶음 ************
    if(lastHoveredGame===activeGame){
        return;
    }
    changeRightView(target);
    lastHoveredGame = target;
});

// 마우스 올리기 (hover 시에 right 뷰 변경)
$(".game").on("mouseover", function () {
    const target = $(this).attr("class").split(" ")[1]; // game1, game2 이런 클래스 스트링값으로 받음

    // 현재클릭으로 고정된 게임은 hover 무시
    if (activeGame === target) return;

    //직전에 호버했던 게임이라면 hover 무시
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

    //지금 클릭된 게임이 타겟과 다르다면
    if (activeGame && activeGame !== target) {
        changeRightView(activeGame); //클릭된 게임으로 right이미지 바꾸기
        lastHoveredGame = activeGame;   // 클릭한게 lasthover가 되도록
    } else if (!activeGame) {
        lastHoveredGame = null;         // 액티브 된게 없는상태면 lasthover 원상복귀
    }

});





// 로그인/회원가입 버튼
$("#signinBtn").on("click", function () {
    location.href = "/toSigninPage.member";
});
$("#loginBtn").on("click", function () {
    location.href = "/toLoginPage.member";
});
// 버튼 클릭 시 게임 페이지 이동
$(document).on("click", ".mainGameBtn", function () {
    let target = $(this).closest(".mainGame").attr("class").split(" ")[1];
    location.href = "/go_gamepage.game?gameId=" + target;
});