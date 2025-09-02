


class Pmg_game extends Phaser.Scene {


    constructor() {
        super({key: "Pmg_game"}); // 키 값 = Pmg_game

        this.frame = 0;
        this.boxes = [];
        this.crutches=[];

    }

    init() { // scene이 시작되기전 점수 초기화 과정

        this.currentTime = 0;
        this.isGameOver = false;

    }

    preload() {

        this.load.spritesheet('walk', '/game/pmg/img/player.png', {frameWidth: 107.625, frameHeight: 130.5})

        // -- 투사체
        this.load.image('needle', '/game/pmg/img/needle.png')
        this.load.image('crutch' , '/game/pmg/img/crutch.png')

        // 배경
        this.load.image('hospital', '/game/pmg/img/hospital.jpg')

        // 이벤트
        this.load.image('spade', '/game/pmg/img/spade.png')
        this.load.image('diamond', '/game/pmg/img/diamond.png')
        this.load.image('heart', '/game/pmg/img/heart.png')
        this.load.image('clover', '/game/pmg/img/clover.png')


    }

    create() {

        this.player_speed = 300;
        this.speed = 200; // 바늘 스피드
        // -- 애니메이션 만들기


        this.anims.create({

            key: 'right',
            frames: this.anims.generateFrameNumbers("walk", {start: 0, end: 7}),
            frameRate: 10,
            repeat: -1

        })
        this.anims.create({

            key: 'left',
            frames: this.anims.generateFrameNumbers("walk", {start: 8, end: 15}),
            frameRate: 10,
            repeat: -1

        })

        this.cameras.main.setBackgroundColor("#ffffff"); // 배경색 설정
        let cameraWidth = this.cameras.main.width; // 카메라 넓이 가져오기
        let cameraHeight = this.cameras.main.height; // 카메라 높이 가져오기

        let bound = this.add.rectangle(cameraWidth / 2, cameraHeight, cameraWidth, 5, 0x000000); // 사각형
        this.physics.add.existing(bound, true); // 사각형을 물리엔진에 등록 ,true 하면 immove (안움직임)

        this.physics.add.collider(this.boxes, bound, (box, bound) => {
            box.destroy(); // box가 땅에 닿으면 사라짐
            this.boxes.splice(this.boxes.indexOf(box), 1); // 배열에서 제거
        });



        this.cursor = this.input.keyboard.createCursorKeys();
        this.physics.world.setBounds(0, 0, 600, 400);

        this.hospital = this.add.image(0, 0, 'hospital') // 배경
        this.hospital.setOrigin(0, 0);
        this.hospital.setDisplaySize(600, 400);


        // ---- text

        this.time_text = this.add.text(10, 360, "시간:", {
            fontSize: "16px",
            fill: "#000000"
        });
        this.score_text = this.add.text(10, 380, "점수:", {
            fontSize: "16px",
            fill: "#000000"
        });


        this.me = this.physics.add.sprite(250, 350, 'walk',0); // 첫프레임 0번으로 설정

        this.physics.add.overlap(this.me, this.boxes, (me, box) => {  // 충돌시 , 점수보내기 + gameover

            this.isGameOver = true;
            this.me.disableBody(true, true); // 충돌 후 플레이어 비활성화

            $.ajax({

                url: "/gameover.game",
                type: "post",
                data: {
                    gameId: 4, /*개개인 game_id 값 넣기*/
                    score: Math.floor(this.currentTime / 10)
                },

                success: (response) => {
                    console.log("서버 응답:", response);


                    this.scene.start("Gameover", {score: Math.floor(this.currentTime / 10)});

                },
                error: (err) => {
                    console.error("점수 전송 실패", err);
                    this.scene.start("Gameover");

                }
            });

        });


        this.me.setCollideWorldBounds(true);

        this.me.setScale(0.5);
        this.me.setOffset(20, 10);


    }

    update(time, delta) { // time 시간값 / delta 매 프레임마다 경과한시간
        this.frame++;
        // -- 점수 측정 바
        if (!this.isGameOver) { // 게임오버가 아니라면
            this.currentTime += delta; // 점수값 초기화
        }
        this.time_text.setText('시간: ' + (this.currentTime / 1000).toFixed(2));
        this.score_text.setText('점수: ' + Math.floor(this.currentTime / 10));


        // 상자 주기적 생성

        if (this.frame % 60 == 0) {
            let box = this.physics.add.sprite(Math.random() * 500, 0, 'needle');

            box.setDisplaySize(100, 65);
            box.setOrigin(0, 0);
            box.setVelocityY(this.speed);
            this.boxes.push(box);

            box.body.setSize(100, 100);
            box.body.setOffset(210, 200);


        }

        // --- 컨트롤 영역


        if (this.cursor.left.isDown) { // 만약 왼쪽 방향키 누르면
            this.me.setVelocityX(-this.player_speed); // x좌표를 5만큼 감소
            this.me.play("left", true);
            this.lastDirection = 'left'; // 방향 left로 기억

        } else if (this.cursor.right.isDown) { // 만약 오른쪽 방향키 누르면
            this.me.setVelocityX(this.player_speed); // x좌표를 5만큼 감소
            this.me.play("right", true); // true 넣어야 끊기지 않고 계속 달림
            this.lastDirection = 'right'; // 방향 right 로 기억
        } else {
            this.me.setVelocityX(0); // 내가 누르지 않으면 멈춤
            this.me.anims.stop(); // 애니매이션 멈추기

            if (this.lastDirection === 'left') {
                this.me.setFrame(8); // 왼쪽 idle 프레임 (왼쪽 애니메이션 시작 프레임)
            } else {
                this.me.setFrame(3); // 오른쪽 idle 프레임
            }
        }

        //---  이벤트 발생지점

        if (this.currentTime >= 10000 && this.currentTime <= 19999 && !this.event) { //점수기준 1000점~2000점

            this.event = true; // 이벤트 시작!
            this.speed = 300;


            let dice = Math.floor(Math.random() * 4) + 1;

            switch (dice) {

                case 1 :
                    this.spade = this.physics.add.sprite(265, 50, 'spade');
                    this.spade.setScale(0.1);
                    this.spade.setOrigin(0, 0);

                    this.me.setScale(1); // 메인
                    break;

                case 2 :

                    this.diamond = this.physics.add.sprite(265, 50, 'diamond');
                    this.diamond.setScale(0.1);
                    this.diamond.setOrigin(0, 0);

                    this.me.setScale(0.2); // 메인
                    break;

                case 3 :
                    this.heart = this.physics.add.sprite(265, 50, 'heart');
                    this.heart.setScale(0.1);
                    this.heart.setOrigin(0, 0);

                    this.player_speed = 1000; // 메인
                    break;

                case 4 :
                    this.clover = this.physics.add.sprite(265, 50, 'clover');
                    this.clover.setScale(0.1);
                    this.clover.setOrigin(0, 0);

                    this.player_speed = 100; // 메인
                    break;


                default:
                    console.log("예상치 못한 dice 값:", dice);
            }

        }  // 첫번째 이벤트

        else if (this.currentTime >= 20000 && this.currentTime <= 29999) {

            if (this.event_text) {
                this.event_text.destroy();
                this.event_text = null;
            }

            if(this.spade){
                this.spade.destroy();
                this.spade = null;
            }else if(this.diamond){
                this.diamond.destroy();
                this.diamond = null;
            }else if(this.heart){
                this.heart.destroy();
                this.heart = null;
            }else if(this.clover){
                this.clover.destroy();
                this.clover = null;
            }


            this.me.setScale(0.5);
            this.player_speed = 300;
            this.event = false; // 이벤트 종료
        }

        else if(this.currentTime >= 35000 && this.frame % 60 == 0){

            let crutch = this.physics.add.sprite(0 , Math.random() * 250, 'crutch');

            crutch.setDisplaySize(50, 50);
            crutch.setOrigin(0, 0);
            crutch.setVelocityX(100);
            this.crutches.push(crutch);


            crutch.body.setSize(1000,1000);
            crutch.body.setOffset(-500, 0);

            this.crutches.forEach((crutch, index) => {
                crutch.rotation += 80 * delta/2 ; // 회전 속도 조절

                if (crutch.x > 600) { // 화면 밖 제거
                    crutch.destroy();
                    this.crutches.splice(index, 1);
                }
            });



        } // x축  crutch 등장





        else if (this.currentTime >= 30000 && this.currentTime <= 39999 && !this.event) {

            this.event = true; // 이벤트 시작!
            this.speed = 350;




            let dice = Math.floor(Math.random() * 3) + 1;

            switch (dice) {

                case 1 :
                    this.spade = this.physics.add.sprite(265, 50, 'spade');
                    this.spade.setScale(0.1);
                    this.spade.setOrigin(0, 0);

                    this.me.setScale(1);
                    break;

                case 2 :

                    this.diamond = this.physics.add.sprite(265, 50, 'diamond');
                    this.diamond.setScale(0.1);
                    this.diamond.setOrigin(0, 0);

                    this.me.setScale(0.2);
                    break;

                case 3 :
                    this.heart = this.physics.add.sprite(265, 50, 'heart');
                    this.heart.setScale(0.1);
                    this.heart.setOrigin(0, 0);

                    this.player_speed = 1000;
                    break;

                case 4 :
                    this.clover = this.physics.add.sprite(265, 50, 'clover');
                    this.clover.setScale(0.1);
                    this.clover.setOrigin(0, 0);
                    this.player_speed = 100;
                    break;

            }
        }// 두번째 이벤트

        else if (this.currentTime >= 40000 && this.currentTime <= 49999) {
            if (this.event_text) {
                this.event_text.destroy();
                this.event_text = null;
            }

            if(this.spade){
                this.spade.destroy();
                this.spade = null;
            }else if(this.diamond){
                this.diamond.destroy();
                this.diamond = null;
            }else if(this.heart){
                this.heart.destroy();
                this.heart = null;
            }else if(this.clover){
                this.clover.destroy();
                this.clover = null;
            }


            this.me.setScale(0.5);
            this.player_speed = 300;


        }

    } // update
} // all
