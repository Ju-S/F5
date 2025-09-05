<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--  Phaser.js 게임엔진  -->
<div id="time"></div>
<script>
    let config = {
        type: Phaser.AUTO,
        parent: "gamebox",
        width: 600,
        height: 400,
        physics: {
            default: "arcade",
            arcade:{
                // gravity: {y: 1000},
                debug: false
            },
        },
        scene: [Penguin]
    };
    let game = new Phaser.Game(config);
</script>