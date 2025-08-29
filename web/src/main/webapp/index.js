
    // rihgt의 메인 게임페이지 생성자
    function createGameView(gameId, titleText, contentText, imgSrc, buttonText) {
    const $container1 = $("<div>").addClass(`mainGame ${gameId}`);
    const $img = $("<img>").addClass("mainGameImg").attr("src", imgSrc).css("transform", "scale(1.05)");
    const $title = $("<div>").addClass("mainGameTitle").html(titleText);
    const $content = $("<div>").addClass("mainGameContent").html(contentText);
    const $button = $("<button>").addClass("mainGameBtn btn btn-primary").html(buttonText+`로 이동`);

    $container1.append($img, $title, $content, $button);
    return $container1;
}
    const gameViews = {
    game1: createGameView(
    "game1",
    "게임 1 타이틀",
    "게임 1 에 대한 설명 , 게임 1 에 대한 설명 게임 1 에 대한 설명게임 1 에 대한 설명 게임 1 에 대한 설명게임 1 에 대한 설명",
    "/index_img/img1.jpg",
    "game1"
    ),
    game2: createGameView(
    "game2",
    "게임 2 타이틀",
    "게임 2 에 대한 설명 , 게임 2 에 대한 설명 게임 2 에 대한 설명게임 2 에 대한 설명 게임 2 에 대한 설명게임 2 에 대한 설명",
    "/index_img/img2.jpg",
    "game2"
    ),
    game3: createGameView(
    "game3",
    "게임 3 타이틀",
    "게임 3 에 대한 설명 , 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명",
    "/index_img/img1.jpg",
    "game3"
    ),
    game4: createGameView(
    "game4",
    "게임 4 타이틀",
    "게임 4 에 대한 설명 , 게임 4 에 대한 설명 게임 4 에 대한 설명게임 4 에 대한 설명 게임 4 에 대한 설명게임 4 에 대한 설명",
    "/index_img/img2.jpg",
    "game4"
    ),
    game5: createGameView(
    "game5",
    "게임 5 타이틀",
    "게임 5 에 대한 설명 , 게임 5 에 대한 설명 게임 5 에 대한 설명게임 5 에 대한 설명 게임 5 에 대한 설명게임 5 에 대한 설명",
    "/index_img/img1.jpg",
    "game5"
    )
};


    //왼쪽 네비바 움직이는 메소드
    //($쿼리객체, 오른쪽으로 가는것 맞는지 불리언값)
    function moveLeftMenu ($e, toRight){
    $e.css({
        transform: toRight? "translateX(50px)" : "translateX(0px)",
        transition: "transform 0.3s ease"
    });
}

    //right의 메인게임페이지에서 애니메이션 중복 제거용 함수
    // ($쿼리객체, slide-in 인지 불리언값)
    function slideIn($e, slideIn){
    $e.each(function(){
        this.classList.remove("slide-left", "slide-right");
        void this.offsetWidth;
        this.classList.add(slideIn? "slide-right" : "slide-left");
    })
}

    //게임페이지로 이동 버튼 클릭
    $(document).on("click", ".mainGameBtn", function() {
    let target = $(this).closest(".mainGame").attr("class").split(" ")[1]; // 예: "game1"
    location.href = "/toGame.game?gameId=" + target;
});



    let lastHoveredGame = "game1"; // 직전에 호버했던 게임

    //마우스 올리기
    $(".game").on("mouseover", function(){
    isMOverClicked = false;
    moveLeftMenu($(this), true); // this에 해당하는 왼쪽바 오른쪽으로 이동

    let target = $(this).attr("class").split(" ")[1]; //game1, game2등 ... 클래스 이름 가져오기
    if (lastHoveredGame === target) return;// 동일 요소면 리턴
    lastHoveredGame = target; // 동일 요소가 아니면 직전호버게임으로 저장해 놓음


    let $currentElements = $("#right").find(".mainGameTitle, .mainGameContent, .mainGameBtn"); // this의 타이틀, 컨텐츠, 버튼 찾기
    slideIn($currentElements, false);// 기존div 슬라이드 아웃


    setTimeout(() => { //2초 딜레이
    const $newView = gameViews[target].clone(); // 복사본으로 mainGame의 jqeury 가져오기
    $("#right").html("").append($newView); // 화면에 뿌리기


    // 화면에 뿌린 것 중, mainGameImg찾아서 1초 딜레이로 트랜지션 발동
    setTimeout(() => {
    $newView.find(".mainGameImg").css("transform", "scale(1)");
}, 20);
    //화면에 뿌린 것 중 타이틀, 컨텐츠, 버튼
    slideIn( $newView.find(".mainGameTitle, .mainGameContent, .mainGameBtn") , true);

}, 200);
})


    /*마우스 내리기*/
    $(".game").on("mouseleave", function(){
    if(isMOverClicked===true){
    moveLeftMenu($(this),true)// this에 해당하는 왼쪽바 이동하게
    return;
}

    moveLeftMenu($(this),false); // 왼쪽 원래 자리로 이동하게
})

    $("#signinBtn").on("click",function(){
        location.href = "/member/signin/signin.jsp";
    })

    $("#loginBtn").on("click",function(){
        location.href = "/member/login/login.jsp";
    })