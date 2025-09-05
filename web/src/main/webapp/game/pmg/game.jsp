<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<%--<div id="gamebox"></div>--%>

<script>

        let config = {
            type: Phaser.AUTO,
            parent: "gamebox",
            width: 600,
            height: 400,
            physics: {
                default: "arcade",
                arcade: {
                    // debug: true
                }
            },
            scene: [first_scene, second_scene, Pmg_game, pmg_Gameover]
        };

        let game = new Phaser.Game(config);


</script>
