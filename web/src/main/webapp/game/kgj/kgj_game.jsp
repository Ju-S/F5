<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<div id="time"></div>
<script>
    let config = {
        type: Phaser.AUTO,
        parent: "gamebox",
        width: 600,
        height: 400,
        physics: {
            default: "arcade",
            arcade: {
                // gravity: {y: 1000},
                debug: false
            },
        },
        scene: [BubbleShooterScene]
    };
    let game = new Phaser.Game(config);
</script>
