<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            rity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/phaser@3/dist/phaser.js"></script>
    <script src="../geometry_gameScene.js"></script>
    <style>
        body {
            margin: 0;
        }

        canvas {
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<script>
    const config = {
        type: Phaser.AUTO,
        width: 700,
        height: 400,
        backgroundColor: '#222',
        physics: {
            default: 'arcade',
            arcade: {gravity: {y: 0}, debug: false}
        },
        scene: [GameScene],
        scale: {
            mode: Phaser.Scale.FIT,             // 비율 유지하며 맞춤
            autoCenter: Phaser.Scale.CENTER_BOTH
        }
    };

    new Phaser.Game(config);
</script>
</body>
</html>
