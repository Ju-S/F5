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
    <script src="/game/jys/js/Jys_gamesene.js"></script>
    <style>
        body {
            margin: 0;
        }

        canvas {
            width: 600px !important;
            height: 400px !important;
            display: block;
        }
    </style>
</head>
<body>
<script>
    const config = {
        type: Phaser.AUTO,
        width: 600,
        height: 400,
        backgroundColor: '#2c2c2c',
        physics: {
            default: 'arcade',
            arcade: {gravity: {y: 0}, debug: false}
        },
        scene: [Jys_gamesene],
        scale: {
            mode: Phaser.Scale.NONE,
            autoCenter: Phaser.Scale.CENTER_BOTH,
            width: 600,
            height: 400
        }
    };

    new Phaser.Game(config);
</script>
</body>
</html>
