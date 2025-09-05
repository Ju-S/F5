<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="/game/jys/js/gamescene.js"></script>
<script>

    let config = {
        type: Phaser.AUTO,
        parent: "gamebox",
        width: 600,
        height: 400,
        physics: {
            default: "arcade",
            arcade: {
                debug: false
            }
        },
        scene: [gamescene]
    };

    let game = new Phaser.Game(config);

</script>

