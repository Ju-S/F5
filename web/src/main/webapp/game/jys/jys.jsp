<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/game/jys/js/gamescene.js"></script>

<div id="gamebox"></div>

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

