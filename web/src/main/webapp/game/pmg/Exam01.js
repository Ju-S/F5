class Exam01 extends Phaser.Scene{
    constructor() {
        super({key:"Exam01"}); // 키 값 = Exam01

    }




    preload() {

    }

    create() {

        this.first_speed = (Math.random()*(300-100+1)+100);
        this.second_speed = (Math.random()*(300-100+1)+100);
        this.third_speed = (Math.random()*(300-100+1)+100);

        this.cameras.main.setBackgroundColor("#ffffff"); // 배경색 설정

        this.first = this.physics.add.sprite(50,10,50,50);
        this.second = this.physics.add.sprite(150,10,50,50);
        this.third = this.physics.add.sprite(300,10,50,50);

        this.first.setBounce(0.7);
        this.second.setBounce(0.5);
        this.third.setBounce(1);

        this.cursor = this.input.keyboard.createCursorKeys();

        this.physics.world.setBounds(0,0,500,500);


        this.first.setCollideWorldBounds(true);
        this.second.setCollideWorldBounds(true);
        this.third.setCollideWorldBounds(true);

    }

    update(time) {
        if(this.cursor.down.isDown){

            this.first.setVelocityY(this.first_speed);
            this.second.setVelocityY(this.second_speed);
            this.third.setVelocityY(this.third_speed);
        };


    }
}