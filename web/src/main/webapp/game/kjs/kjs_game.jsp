<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/phaser/3.90.0/phaser.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="MainScene.js"></script>
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
        scene: [MainScene]
    };
    let game = new Phaser.Game(config);
</script>
</body>
</html>