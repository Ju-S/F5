<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- 프로그램 시작점 : main. html -->
<!-- Scene : 게임의 주인공이 활동하는 각 장면 -->

<div id="gamebox"></div>

<script>
    let config = {
        type : Phaser.AUTO,
        parent : "gamebox",
        width : 600,
        height: 400,
        physics : {
            default : "arcade",
            arcade: {
                // debug:true,
                // gravity : { y:300}
            }
        },

        scene: [first_scene,second_scene,Pmg_game , Gameover]

    };

    let game = new Phaser.Game(config);



</script>
