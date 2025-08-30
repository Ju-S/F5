class first_scene extends Phaser.Scene {

    constructor() {
        super({key:"first_scene"});
    }


    preload(){

    this.load.image('first','/game/pmg/img/first.png')

    }

    create(){

        this.sad = this.add.image(0,0,'first')
        this.sad.setOrigin(0, 0);
        this.sad.setDisplaySize(600, 400);

        let first_Button = this.add.text(
            this.cameras.main.width -30,
            this.cameras.main.height -50,
            ">>",
            {
                padding:{left:10 , right:10 , top:5 , bottom: 10},
                fontSize:"30px",
                fill: "#000000"
            }
        ).setOrigin(0.5).setInteractive();



        first_Button.on("pointerdown",()=>{ // 누를 시

            this.scene.start("second_scene");

        });




    }

}
