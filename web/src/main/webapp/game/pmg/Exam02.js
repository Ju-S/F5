


class Exam02 extends Phaser.Scene{


    constructor() {
        super({key:"Exam02"}); // 키 값 = Exam02

        this.frame = 0;
        this.boxes = [];


    }

    init(){ // scene이 시작되기전 점수 초기화 과정

        this.currentTime = 0;
        this.isGameOver = false;
    }

    preload() {

        this.load.spritesheet('walk','/game/pmg/img/player.png',{frameWidth:107.625,frameHeight:130.5})
        this.load.image('needle','/game/pmg/img/needle.png')
    }

    create() {


        this.speed = (Math.random()*300+100);

        // -- 애니메이션 만들기

        this.anims.create({

            key:'right',
            frames:this.anims.generateFrameNumbers("walk",{start:0,end:7}),
            frameRate:10,
            repeat:-1

        })
        this.anims.create({

            key:'left',
            frames:this.anims.generateFrameNumbers("walk",{start:8,end:15}),
            frameRate:10,
            repeat:-1

        })

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
        this.physics.world.setBounds(0,0,600,400);


        this.time_text  = this.add.text(10,10, "시간:",{
            fontSize:"16px",
            fill:"#000000"
        });
        this.score_text = this.add.text(10,30, "점수:",{
            fontSize:"16px",
            fill:"#000000"
        });

        this.me = this.physics.add.sprite(250,350,'player');
        this.physics.add.overlap(this.me,this.boxes,(me,box)=>{  // 충돌시 , 점수보내기 + gameover

            this.isGameOver = true;
            this.me.disableBody(true, true); // 충돌 후 플레이어 비활성화
            $.ajax({
                url: "/gameover.game" ,
                type : "post",
                data : {

                    score: Math.floor(this.currentTime/10)
                },
                success: (response) => {
                    console.log("서버 응답:", response);

                    this.scene.start("Gameover",{score : Math.floor(this.currentTime/10)});

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

    update(time,delta ) { // time 시간값 / delta 매 프레임마다 경과한시간
        this.frame++;

        if (!this.isGameOver) { // 게임오버가 아니라면
            this.currentTime += delta; // 점수값 초기화
        }
        this.time_text.setText('생존 시간: ' + (this.currentTime / 1000).toFixed(2));
        this.score_text.setText('점수: ' + Math.floor(this.currentTime / 10));

        if(this.frame% 60 == 0){
            let box = this.physics.add.sprite(Math.random()*500,0,'needle');

            box.setDisplaySize(50,100);
            box.setOrigin(0,0);
            box.setVelocityY(this.speed);
            this.boxes.push(box);

            box.body.setSize(200,100);
            box.body.setOffset(200,100);


        }


        if(this.cursor.left.isDown){ // 만약 왼쪽 방향키 누르면
            this.me.setVelocityX(-this.speed); // x좌표를 5만큼 감소
            this.me.play("left");
        }else if(this.cursor.right.isDown){ // 만약 오른쪽 방향키 누르면
            this.me.setVelocityX(this.speed); // x좌표를 5만큼 감소
            this.me.play("right");
        }else {
            this.me.setVelocityX(0); // 내가 누르지 않으면 멈춤
        }



    }

}

