class Gameover extends Phaser.Scene {
    constructor() {
        super({key:"Gameover"}); // 키 값 = Gameover
    }

    preload(){

    }

    init(data){//스코어 data를 받아옴

        this.end_score = data.score; // 넘겨받을 점수를 this.end_score 변수에 넣음
    }

    create() {

        this.add.text(
            this.cameras.main.width/2 ,
            this.cameras.main.height/2- 80,
            "SCORE: " + this.end_score, // init에서 받은 점수값을 출력
            {
                fontSize:"50px",
                fill: "#34ce42"
            }
        ).setOrigin(0.5);

        this.add.text(
            this.cameras.main.width/2,
            this.cameras.main.height/2,
            "GAME OVER",
            {
                fontSize:"80px",
                fill: "#ff0000"
            }
        ).setOrigin(0.5);

        let restartButton = this.add.text(
            this.cameras.main.width/2,
            this.cameras.main.height/2 + 80,
            "RETRY?",
            {
                padding:{left:10 , right:10 , top:5 , bottom: 10},
                fontSize:"60px",
                fill: "#2c57d7ff"
            }
        ).setOrigin(0.5).setInteractive();


        restartButton.on("pointerdown",()=>{ // 누를 시

            this.scene.start("Pmg_game");

        })


        restartButton.on("pointerover",()=>{ // 터치 시

            restartButton.setBackgroundColor("#242323")
            this.game.canvas.style.cursor = "pointer";

        })


        restartButton.on("pointerout",()=>{ // 터치 밖으로 나갈때

            restartButton.setBackgroundColor("#000000")
            this.game.canvas.style.cursor = "default";

        })



    }



    update() {

    }



}