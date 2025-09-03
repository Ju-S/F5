<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<div id="gamebox"></div>

<script>

    <%--const GAMEID = Number("${gameId}");--%>


    <%--let sceneMap = {--%>
    <%--    1: [first_scene, second_scene, JusungGame, Gameover], //주성--%>
    <%--    2: [first_scene, SecondGameScene, JiwonGame, Gameover], // 지원--%>
    <%--    3: [MainScene], // 기준--%>
    <%--    4: [first_scene, second_scene, Pmg_game, Gameover], // 민규--%>
    <%--    5: [geometry_gameScene], // 영서--%>
    <%--};--%>


    <%--if (sceneMap[GAMEID]) {--%>
    <%--    let config = {--%>
    <%--        type: Phaser.AUTO,--%>
    <%--        parent: "gamebox",
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
