<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<div id="gamebox"></div>

<script>

    <%--const GAMEID = Number("${gameId}");--%>


    <%--let sceneMap = {--%>
    <%--    1: [first_scene, second_scene, JusungGame, Gameover],--%>
    <%--    2: [first_scene, SecondGameScene, JiwonGame, Gameover],--%>
    <%--    3: [StartScene, MidScene, GijunGame, Gameover],--%>
    <%--    4: [first_scene, second_scene, Pmg_game, Gameover], // 민규--%>
    <%--    5: [IntroScene, MainScene, YoungseoGame, Gameover]--%>
    <%--};--%>


    <%--if (sceneMap[GAMEID]) {--%>
    <%--    let config = {--%>
    <%--        type: Phaser.AUTO,--%>
    <%--        parent: "gamebox", // HTML에 이 id가 있어야 함--%>
    <%--        width: 600,--%>
    <%--        height: 400,--%>
    <%--        physics: {--%>
    <%--            default: "arcade",--%>
    <%--            arcade: {--%>
    <%--                debug: true--%>
    <%--            }--%>
    <%--        },--%>
    <%--        scene: sceneMap[GAMEID]--%>
    <%--    };--%>

    <%--    let game = new Phaser.Game(config);--%>
    <%--}--%>



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

       scene: [first_scene,second_scene,Pmg_game, Gameover]

   };

   let game = new Phaser.Game(config);



</script>
