class MainScene extends Phaser.Scene {
    constructor() {
        super({key: "MainScene"});
    }

    preload() {
        this.cameras.main.setBackgroundColor("#ffffff");

        this.load.image('gameover', 'Assets/gameover.jpg');

        this.load.image('background', 'Assets/background.png');
        this.load.image('backgroundTile', 'Assets/backgroundTile.png');

        this.load.spritesheet('player', 'Assets/spritesheet.png', {
            frameWidth: 68,
            frameHeight: 102
        })

        this.load.spritesheet('playerJump', 'Assets/spritesheet_jump.png', {
            frameWidth: 67,
            frameHeight: 102
        })

        this.load.image('obstacle', 'Assets/Obstacle.png');
    }

    create() {
        this.background = this.add.sprite(this.cameras.main.centerX, this.cameras.main.centerY, 'background');
        this.background.setDepth(-1);
        this.background.setScale(600 / this.background.width, 400 / this.background.height);

        this.backgroundTileRight = this.add.tileSprite(550, this.cameras.main.centerY, 500, 800, 'backgroundTile');
        this.backgroundTileLeft = this.add.tileSprite(80, this.cameras.main.centerY, 500, 800, 'backgroundTile');
        this.backgroundTileLeft.setDepth(-2);
        this.backgroundTileRight.setDepth(-2);

        this.scoreText = this.add.text(10, 10, 'score: 0', {
            font: '24px Arial',
            fill: '#ffffff',
        }).setOrigin(0, 0);

        this.physics.world.setBounds(0, 0, 600, 400);

        // 장애물 그룹
        this.obstacles = this.physics.add.group();
        this.obstaclesSpeed = 1.5;

        // 타이머: 장애물 생성
        this.obstacleInterval = 2000;
        this.spawnTimer = this.time.addEvent({
            delay: this.obstacleInterval,
            callback: this.spawnObstacle,
            callbackScope: this,
            loop: true
        });

        // 난이도 증가
        this.difficultyTimer = this.time.addEvent({
            delay: this.obstacleInterval * 3,
            callback: () => {
                this.obstaclesSpeed += 1;
                if (this.obstacleInterval > 500) {
                    this.obstacleInterval -= 300;
                }
                this.spawnTimer.reset({
                    delay: this.obstacleInterval,
                    callback: this.spawnObstacle,
                    callbackScope: this,
                    loop: true
                });
            },
            loop: true
        });

        // 플레이어
        this.me = this.physics.add.sprite(300, 300, 'player', 1).setOrigin(0.5, 0.5);
        this.me.setData('state', 'run');
        this.me.displayWidth = 76;
        this.me.displayHeight = 102;
        this.me.setCollideWorldBounds(true);
        // this.me.setGravityY(600);
        this.me.setSize(50, 5);
        this.me.setOffset(10, 92);
        this.me.setDepth(90);

        this.anims.create({
            key: 'run',
            frames: this.anims.generateFrameNumbers('player', {start: 0, end: 3}),
            frameRate: 6,
            repeat: -1,
        });

        this.anims.create({
            key: 'jump',
            frames: this.anims.generateFrameNumbers('playerJump', {start: 0, end: 3}),
            frameRate: 6,
            repeat: 0,
        });

        this.me.play('run');

        this.cursor = this.input.keyboard.createCursorKeys();

        // 충돌 처리
        this.physics.add.overlap(this.me, this.obstacles, (me, obstacles) => {
            if (this.me.getData('state') === 'run') {
                this.showGameOverUI();
            }
        });

        this.isGameOver = false;
        this.score = 0;
    }

    update() {
        if(this.isGameOver){return;}
        this.playerMove();
        this.backgroundTileLeft.tilePositionX += this.obstaclesSpeed;
        this.backgroundTileLeft.tilePositionY -= this.obstaclesSpeed / 2;
        this.backgroundTileRight.tilePositionX -= this.obstaclesSpeed;
        this.backgroundTileRight.tilePositionY -= this.obstaclesSpeed / 2;

        // 장애물 삭제 처리
        this.obstacles.getChildren().forEach(obs => {
            if (obs.update) obs.update();
            if (obs.y > 400) {
                obs.destroy();
                this.score += 100;
                this.scoreText.setText("score: " + this.score);
            }
        });
    }

    playerMove() {
        const speed = 200;

        if (this.cursor.left.isDown) {
            this.me.setVelocityX(-speed);
        }
        if (this.cursor.right.isDown) {
            this.me.setVelocityX(speed);
        }
        if ((this.cursor.right.isDown && this.cursor.left.isDown) ||
            (this.cursor.right.isUp && this.cursor.left.isUp)) {
            this.me.setVelocityX(0);
        }

        if (Phaser.Input.Keyboard.JustDown(this.cursor.space) && this.me.getData('state') === 'run') {
            this.me.setData('state', 'jump');
            this.me.play('jump');
        }

        this.me.on('animationcomplete', (anim, frame) => {
            if (anim.key === 'jump') {
                this.me.setData('state', 'run');
                this.me.play('run');
            }
        });
    }

    spawnObstacle() {
        if(this.isGameOver){return;}
        // 점점 커지는 장애물 구현
        const obs = this.add.sprite(
            Phaser.Math.Between(250, 350), // x 위치 랜덤
            180,
            'obstacle',
            0,
        );

        obs.displayWidth = 20;
        obs.displayHeight = 10;

        this.physics.add.existing(obs);
        obs.setOrigin(0.5, 0.5);

        const speed = this.obstaclesSpeed;
        const speedX = (obs.x - 300) / 20;

        // 커지는 애니메이션
        obs.update = () => {
            obs.displayWidth += speed; // 좌우로 점점 커짐
            obs.displayHeight += speed / 10; // 좌우로 점점 커짐
            obs.body.width = obs.displayWidth;
            obs.body.height = obs.displayHeight;
            obs.y += speed;
            obs.x += speedX;
        };
        this.obstacles.add(obs);
    }

    showGameOverUI(score = 0) {
        this.isGameOver = true;
        // 반투명 배경 오버레이
        const overlay = this.add.rectangle(300, 200, 600, 400, 0x000000, 0.5);
        overlay.setDepth(100);

        // 게임 오버 이미지
        const gameOverImage = this.add.image(600, 400, 'gameover'); // 미리 preload한 이미지여야 함
        gameOverImage.setOrigin(1, 1);
        gameOverImage.setDepth(101);
        gameOverImage.setScale(2.6, 1.5);

        // 점수 텍스트
        const scoreText = this.add.text(300, 200, `점수: ${this.score}`, {
            font: '28px Arial',
            fill: '#ffffff',
            backgroundColor: '#222',
            padding: { x: 10, y: 5 }
        }).setOrigin(0.5);
        scoreText.setDepth(101);

        // 재시작 버튼
        const retryBtn = this.add.text(300, 260, '다시 시작', {
            font: '24px Arial',
            fill: '#00ff00',
            backgroundColor: '#222',
            padding: { x: 10, y: 5 }
        }).setOrigin(0.5).setInteractive();
        retryBtn.setDepth(101);

        retryBtn.on('pointerdown', () => {
            this.scene.restart(); // 현재 씬 재시작
        });
    }
}
