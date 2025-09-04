<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Game Test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/phaser@3/dist/phaser.js"></script>
    <script src="/game/jys/js/gamesene.js"></script>
    <style>
        body {
            background-color: #000;
        }
        .game_box {
            width: 600px;
            height: 400px;
            border: 3px solid #fff;
            overflow: hidden; /* ✅ 게임이 박스 밖으로 안 나가게 */
        }

        canvas {
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div id="gameContainer" class="game_box"></div>
<script>
    const config = {
        type: Phaser.AUTO,
        width: 600,
        height: 400,
        parent: 'gameContainer', // div id를 지정하면 Phaser가 이 안에 canvas를 넣음
        physics: {
            default: 'arcade',
            arcade: {
                gravity: { y: 0 },
                debug: false
            }
        },
        scene: [gamescene]
    };

    const game = new Phaser.Game(config);
</script>
</body>
</html>
