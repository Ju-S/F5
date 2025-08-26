<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>

<style>
    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Thin.woff') format('woff');
        font-weight: 100;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraLight.woff') format('woff');
        font-weight: 200;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Light.woff') format('woff');
        font-weight: 300;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
        font-weight: 400;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Medium.woff') format('woff');
        font-weight: 500;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-SemiBold.woff') format('woff');
        font-weight: 600;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Bold.woff') format('woff');
        font-weight: 700;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraBold.woff') format('woff');
        font-weight: 800;
        font-display: swap;
    }

    @font-face {
        font-family: 'Pretendard';
        src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Black.woff') format('woff');
        font-weight: 900;
        font-display: swap;
    }




    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }
    body {
        background-color: #101012;
        padding: 1%;
        height: 100%;
        position: relative;
        overflow: hidden;
    }
    #container1{
        position: absolute;
        width: 100%; /* 화면 가로 전체 */
        height: 90%; /* 화면 세로 전체 */
        bottom: 0;
    }

    #left {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 20%; /* 원하는 너비 */
        height: 100%;
        z-index: 10; /* 오른쪽보다 위에 있도록 */
    }
    .game {
        position: relative; /* 기준 요소 */
        z-index: 4; /* 여기서 z-index 작동 */

        height: 17%;
        width: 100%;
        border: 1px solid #989898;
        margin-left: 12px;
        margin-bottom: 12px;
    }
    .game img{
        width: auto;
        height: 100%;
    }


    #right {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%; /* 화면 전체 너비 */
        height: 100%;
        z-index: 5; /* 왼쪽 네비보다 아래 */
        overflow: hidden;
    }

    .mainGame {
        width: 100%;
        height: 100%;
        overflow: hidden;
        transition: transform 0.3s ease;
        border: 1px solid #989898;
        position: relative; /* 기준 요소 */

    }

    .mainGame img{
        width: 100%;
        height: 100%;
        object-fit: cover;
        position: relative; /* 기준 요소 */
        z-index: 2; /* 여기서 z-index 작동 */
    }



    .mainGameTitle {
        position:absolute;
        top:400px;
        left: 650px;

        font-size: 24px;
        font-weight: bold;
        color: white;

        z-index: 3; /* 여기서 z-index 작동 */
    }
    .mainGameContent {
        position:absolute;
        top:450px;
        left: 650px;
        margin-right:30px;

        font-size: 16px;
        color: white;
        z-index: 3; /* 여기서 z-index 작동 */
    }
    .mainGameBtn{
        position:absolute;
        top:520px;
        left: 970px;
        margin-right:30px;

        font-size: 16px;
        z-index: 3; /* 여기서 z-index 작동 */
    }
    .mainGameImg {
        transition: transform 0.2s ease-in-out;
        transform: scale(1.05);
    }



    /* 제목/내용: 오른쪽에서 왼쪽으로 들어오기 */
    @keyframes slideInRight {
        from {
            opacity: 0;
            transform: translateX(50px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    .slide-right {
        animation: slideInRight 0.5s ease forwards;
    }

    /* 제목/내용: 왼쪽에서 오른쪽으로 나가기 */
    @keyframes slideOutLeft {
        from {
            opacity: 1;
            transform: translateX(0);
        }
        to {
            opacity: 0;
            transform: translateX(-100px);
        }
    }
    .slide-left {
        animation: slideOutLeft 0.5s ease forwards;
    }


</style>



</head>


<body>
<%-- 공용 헤더 --%>
<jsp:include page="/common/Header.jsp"/>


<%--컨테이너--%>
<div id="container1">

    <%--왼쪽 게임 네비--%>
    <div id="left">
        <div class="game game1"><img src="gameimg.png"/></div>
        <div class="game game2"><img src="gameimg.png"/></div>
        <div class="game game3"><img src="gameimg.png"/></div>
        <div class="game game4"><img src="gameimg.png"/></div>
        <div class="game game5"><img src="gameimg.png"/></div>
    </div>

    <%--오른쪽 메인게임--%>
    <div id="right">
        <div class="mainGame game1 default"><img src="img1.jpg"/></div>
    </div>
</div>





<script>


    let lastHoveredGame = "game1"; // 직전에 호버했던 게임


    // rihgt의 메인 게임페이지 생성자
    function createGameView(gameId, titleText, contentText, imgSrc, buttonText) {
        const $container1 = $("<div>").addClass(`mainGame ${gameId}`);
        const $img = $("<img>").addClass("mainGameImg").attr("src", imgSrc).css("transform", "scale(1.05)");
        const $title = $("<div>").addClass("mainGameTitle").html(titleText);
        const $content = $("<div>").addClass("mainGameContent").html(contentText);
        const $button = $("<button>").addClass("mainGameBtn").html(buttonText+`로 이동`);

        $container1.append($img, $title, $content, $button);
        return $container1;
    }
    const gameViews = {
        game1: createGameView(
            "game1",
            "게임 1 타이틀",
            "게임 1 에 대한 설명 , 게임 1 에 대한 설명 게임 1 에 대한 설명게임 1 에 대한 설명 게임 1 에 대한 설명게임 1 에 대한 설명",
            "/img1.jpg",
            "game1"
        ),
        game2: createGameView(
            "game2",
            "게임 2 타이틀",
            "게임 2 에 대한 설명 , 게임 2 에 대한 설명 게임 2 에 대한 설명게임 2 에 대한 설명 게임 2 에 대한 설명게임 2 에 대한 설명",
            "/img2.jpg",
            "game2"
        ),
        game3: createGameView(
            "game3",
            "게임 3 타이틀",
            "게임 3 에 대한 설명 , 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명 게임 3 에 대한 설명",
            "/img1.jpg",
            "game3"
        ),
        game4: createGameView(
            "game4",
            "게임 4 타이틀",
            "게임 4 에 대한 설명 , 게임 4 에 대한 설명 게임 4 에 대한 설명게임 4 에 대한 설명 게임 4 에 대한 설명게임 4 에 대한 설명",
            "/img2.jpg",
            "game4"
        ),
        game5: createGameView(
            "game5",
            "게임 5 타이틀",
            "게임 5 에 대한 설명 , 게임 5 에 대한 설명 게임 5 에 대한 설명게임 5 에 대한 설명 게임 5 에 대한 설명게임 5 에 대한 설명",
            "/img1.jpg",
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

    /*게임 이동 버튼 클릭*/
    $(document).on("click", ".mainGameBtn", function() {
        let target = $(this).closest(".mainGame").attr("class").split(" ")[1]; // 예: "game1"
        location.href = "/toGame.game?gameId=" + target;
    });



    //마우스 올리기
    $(".game").on("mouseover", function(){
        isMOverClicked = false;
        moveLeftMenu($(this), true); // this에 해당하는 왼쪽바 오른쪽으로 이동

        let target = $(this).attr("class").split(" ")[1]; //game1, game2등 ... 클래스 이름 가져오기
        if (lastHoveredGame === target) return;// 동일 요소면 처리하지 않음
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
        } // 누군가 마우스 올린 상태로 클릭했으면 메인게임 페이지 고정되도록 리턴시키기

        moveLeftMenu($(this),false); // 왼쪽 원래 자리로 이동하게
    })

</script>





<%-- 공용 푸터 --%>
<%--<jsp:include page="/common/Footer.jsp"/>--%>
</body>
</html>
