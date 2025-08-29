<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 프로그램 시작점 : main. html -->
<!-- Scene : 게임의 주인공이 활동하는 각 장면 -->

<div id="gamebox"></div>

<%--<div> 패시브 [동체 시력]  : 공에 맞아 Out 되는 범위를 인지할 수 있습니다. </div><br>--%>
<%--<div> 게임 설명 : 어느 날 , 눈을 떠보니 당신은 새하얀 공간에서 <br>--%>
<%--    피구왕 통키가 되어있었습니다. <br>--%>
<%--    방향키를 이용하여 하늘에서 떨어지는 불꽃 슛을 피해 생존하세요!</div>--%>

<script>
    let config = {
        type : Phaser.AUTO,
        parent : "gamebox",
        width : 600,
        height: 400,

        physics : {
            default : "arcade",
            arcade: {
                debug:true,
                // gravity : { y:300}
            }
        },
        //  scene:[Exam01 , Exam02, MainScene]
        scene: [Exam02 , Gameover]

    };

    let game = new Phaser.Game(config);



</script>
