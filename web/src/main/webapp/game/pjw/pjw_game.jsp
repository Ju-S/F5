<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <%--j쿼리--%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>


    <script src="/game/pjw/pjw_game.js"></script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.90.0/phaser.min.js"
            integrity="sha512-/tJYyDCrI7hnHWp45P189aOwPa6lTREosRhlxEIqx8skB4A3a3rD3iz4o335SJd4sORqjVHw5y1S2hq4hciwLw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script> <%--페이저--%>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/webfont/1.6.26/webfont.js"></script> &lt;%&ndash;폰트&ndash;%&gt;--%>


    <style>
        #gamebox{
            border: 1px solid black;
            width: 600px;
            height: 400px;
        }
    </style>
</head>
<body>
<!--  Phaser.js 게임엔진  -->

<div id="gamebox">

</div>
<div id="time"></div>
<script>
    let config = {
        type: Phaser.AUTO, //어떤 장치로 렌더링을 할지(cpu, gpu등등): gpu 사용가능하면 gpu, 아니면 cpu사용
        parent: "gamebox",
        width: 600,
        height: 400,
        physics: { //어떤 물리엔진 적용할건지
            default: "arcade",
            arcade: { debug: false } // 충돌영역 보이게
        },
        scene: [window.pjw_game]//씬 여러개면 배열로 지정[]
    };

    let game = new Phaser.Game(config); // 생성자 만들기


</script>
</body>
</html>