class MainScene extends Phaser.Scene {

    constructor(){
        super({key:"MainScene"}); // 키 값 = MainScene

    }
    preload(){ // 게임에 시작될 이미지 , 음악 , 영상등을 미리 로딩해 놓는 메서드

    }
    create(){ // 게임에 등장할 요소들을 생성해두고 초기화시키는 메서드

        this.speed = 500;

        this.cameras.main.setBackgroundColor("#ffffff"); // 배경색 설정

        this.me = this.physics.add.sprite(250,200,50,50);
        // x좌표,y좌표,넓이,높이

        this.box = this.physics.add.sprite(250,250,50,50);
        this.box.setBounce(1); // 탄성력
        this.box.setDrag(20); // 마찰력 (감속력)
        this.box.setMass(1); // 질량
        this.box.setImmovalbe(true); // 움직이지않음


        this.physics.add.collider(this.me,this.box,function(me,box){
            console.log("점수");

        }); // 사물 서로간의 충돌 정보 추가

        this.physics.world.setBounds(0,0,500,500); //0,0부터 500,500까지 영역 물리엔진

        this.cursor = this.input.keyboard.createCursorKeys();
        // 방향키를 통제하는 객체


        this.me.setCollideWorldBounds(true); // me 라는 sprite가 물리엔진 영역 밖으로 못나가게 설정
        this.box.setCollideWorldBounds(true);
    }
    update(){ // Scene이 렌더링 된 이후로부터 초당 수십~수백번 실행되며 화면을 그리는 메서드

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


        }   else {
            this.me.setVelocityY(0); // 내가 누르지 않으면 멈춤
        }
    }
}