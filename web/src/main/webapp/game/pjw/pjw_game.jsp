<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--  Phaser.js 게임엔진  -->

<div id="time"></div>
<script>
    let config = {
        type: Phaser.AUTO, //어떤 장치로 렌더링을 할지(cpu, gpu등등): gpu 사용가능하면 gpu, 아니면 cpu사용
        parent: "gamebox",
        width: 600,
        height: 400,
        physics: { //어떤 물리엔진 적용할건지
            default: "arcade",
            arcade: { debug: false } // 충돌영역 보이게
        },
        scene: [window.pjw_game]//씬 여러개면 배열로 지정[]
    };

    let game = new Phaser.Game(config); // 생성자 만들기
</script>