


class Exam02 extends Phaser.Scene{


    constructor() {
        super({key:"Exam02"}); // 키 값 = Exam02
        this.frame = 0;
        this.boxes = [];

    }


    preload() {

        this.load.image('player','/game/pmg/img/player.png')
        this.load.image('ball','/game/pmg/img/ball.png')
    }

    create() {

        this.speed = (Math.random()*300+100);

        this.cameras.main.setBackgroundColor("#ffffff"); // 배경색 설정

        let cameraWidth = this.cameras.main.width; // 카메라 넓이 가져오기
        let cameraHeight = this.cameras.main.height; // 카메라 높이 가져오기

        let bound = this.add.rectangle(cameraWidth/2 , cameraHeight , cameraWidth , 5,0x000000); // 사각형
        this.physics.add.existing(bound,true); // 사각형을 물리엔진에 등록 ,true 하면 immove (안움직임)

        this.physics.add.collider(this.boxes,bound,(box,bound)=>{
            box.destroy(); // box가 땅에 닿으면 사라짐
            this.boxes.splice(this.boxes.indexOf(box),1); // 배열에서 제거
        });

        this.cursor = this.input.keyboard.createCursorKeys();
        this.physics.world.setBounds(0,0,500,800);

        this.me = this.physics.add.sprite(250,1000,'player');

        this.physics.add.overlap(this.me,this.boxes,(me,box)=>{  // 충돌시 , 점수보내기 + gameover
            this.me.disableBody(true, true); // 충돌 후 플레이어 비활성화
            $.ajax({
            url: "/gameover.game" ,
            type : "get",
            data : {
                //score : this.currentTime
                score: Math.floor(this.currentTime)

            },
            success: (response) => {
                console.log("서버 응답:", response);
                this.scene.start("Gameover");
            },
            error: (err) => {
                console.error("점수 전송 실패", err);
                this.scene.start("Gameover");
            }
        });

        });


        this.me.setCollideWorldBounds(true);
//  this.box = this.physics.add.sprite(0,0,50,50);
//  this.box.setOrigin(0,0);

        this.me.setScale(0.3);

    }

    update(time) {
        this.frame++;

        document.getElementById("timebox").innerHTML = (time/1000).toFixed(2);
        document.getElementById("scorebox").innerHTML = time;

        if(this.frame% 60 == 0){
            let box =
                this.physics.add.sprite(Math.random()*500,0,'ball');
            this.boxes.push(box);
            box.setDisplaySize(70,70);
            box.setVelocityY(this.speed);
            box.setOrigin(0,0);


        }

        if(this.cursor.left.isDown){ // 만약 왼쪽 방향키 누르면
            this.me.setVelocityX(-this.speed); // x좌표를 5만큼 감소

        }else if(this.cursor.right.isDown){ // 만약 오른쪽 방향키 누르면
            this.me.setVelocityX(this.speed); // x좌표를 5만큼 감소

        }else {
            this.me.setVelocityX(0); // 내가 누르지 않으면 멈춤
        }

        if(this.cursor.up.isDown){ // 만약 위쪽 방향키 누르면
            this.me.setVelocityY(-this.speed); // y좌표를 5만큼 감소

        }else if(this.cursor.down.isDown){ // 만약 아래쪽 방향키 누르면
            this.me.setVelocityY(this.speed);  // y좌표를 5만큼 증가


        }else {
            this.me.setVelocityY(0); // 내가 누르지 않으면 멈춤
        }

        this.currentTime = time;


    }

}

