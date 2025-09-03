class second_scene extends Phaser.Scene {

    constructor() {
        super({key:"second_scene"});
    }

    preload(){

        this.load.image('second_scene','/game/pmg/img/go.png')

    }

    create(){

        this.second = this.add.image(0,0,'second_scene')
        this.second.setOrigin(0, 0);
        this.second.setDisplaySize(600, 400);

        let second_Button = this.add.text(
            this.cameras.main.width -100,
            this.cameras.main.height -50,
            "Game Start",
            {
                padding:{left:10 , right:10 , top:5 , bottom: 10},
                fontSize:"30px",
                fill: "#eaea16"
            }
        ).setOrigin(0.5).setInteractive();



        second_Button.on("pointerdown",()=>{ // 누를 시

            this.scene.start("Pmg_game");

        });

        second_Button.on("pointerover",()=>{ // 터치 시

            this.game.canvas.style.cursor = "pointer";

        })


    }

}
