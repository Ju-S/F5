class gamescene extends Phaser.Scene {
    constructor() {
        super('gamescene');
        this.baseBPM = 120;
        this.spawnLeadTime = 2000;
    }

    preload() {
        this.load.image('floor', '/game/jys/img/floor.svg');   // 바닥
        this.load.image('player', '/game/jys/img/player.png'); // 플레이어 이미지
        this.load.image('bg', '/game/jys/img/bg.png'); //배경
        this.load.audio('bgm', '/game/jys/mp3/music.mp3'); //음악
    }

    create() {
        // 배경
        this.bg = this.add.tileSprite(0, 0, this.scale.width, this.scale.height, 'bg')
            .setOrigin(0, 0)
            .setScrollFactor(0);
        this.bg.setDisplaySize(this.scale.width, this.scale.height);

        // 바닥
        this.groundGroup = this.physics.add.staticGroup();
        for (let i = 0; i < 100; i++) {
            // floor origin (0,1)이므로 y는 scale.height로
            this.groundGroup.create(i * 64, this.scale.height, 'floor')
                .setOrigin(0, 1)
                .setScale(0.5) // 바닥 크기 줄이기
                .refreshBody();
        }
        // 플레이어 생성 - 바닥 위에 위치시키기 (바닥 y: this.scale.height)
        this.player = this.physics.add.sprite(100, this.scale.height - 70, 'player');
        this.player.setOrigin(0.5, 1); // 아래 중앙이 기준점
        // 플레이어 이미지 크기 조정
        this.player.setDisplaySize(48, 48);
        this.player.setCollideWorldBounds(true);
        this.player.setGravityY(1000);
        this.physics.add.collider(this.player, this.groundGroup);

        // 플레이어 충돌 박스 (이미지 크기와 맞추기)
        this.player.body.setSize(40, 50);
        this.player.body.setOffset(12, 14);

        // spikeGroup 및 충돌
        this.spikeGroup = this.physics.add.group();
        this.physics.add.collider(this.player, this.spikeGroup, () => {
            if (!this.isGameOver) this.gameOver();
        });

        // 카메라 설정
        this.cameras.main.setBounds(0, 0, 6000, this.scale.height);
        this.cameras.main.startFollow(this.player);

        // 음악
        this.music = this.sound.add('bgm');
        this.music.play();

        // 점수
        this.startTime = this.time.now;
        this.score = 0;
        this.scoreText = this.add.text(20, 20, 'Time: 0.0s', {fontSize: '24px', fill: '#fff'}).setScrollFactor(0);

        // 최고 기록
        this.bestTime = parseFloat(localStorage.getItem('bestTime')) || 0;
        this.bestTimeText = this.add.text(20, 50, 'Best: ' + this.bestTime.toFixed(1) + 's', {
            fontSize: '20px',
            fill: '#ff0'
        }).setScrollFactor(0);

        // 게임 오버 텍스트
        this.gameOverText = this.add.text(this.scale.width / 2, this.scale.height / 2, 'Game Over\nPress SPACE to Restart', {
            fontSize: '40px',
            fill: '#f00',
            align: 'center'
        }).setOrigin(0.5).setScrollFactor(0).setVisible(false);

        // 점프 관련
        this.maxJumps = 3;
        this.jumpCount = 0;
        this.isGameOver = false;

        this.input.keyboard.on('keydown-SPACE', () => {
            if (this.isGameOver) return;
            if (this.jumpCount < this.maxJumps) {
                this.player.setVelocityY(-450);
                this.jumpCount++;
            }
        });

        // 초기 점프 (원래 있던 부분 유지)
        this.player.setVelocityY(-450);
        this.jumpCount++;

        // 장애물 미리 스폰 (첫 장애물)
        this._spawnSpike(this.player.x + 500);

        // BPM 장애물 생성 스케줄링
        this.currentBPM = this.baseBPM;
        this.beatCount = 0;
        this.scheduleBeats();
    }

    update() {
        if (this.isGameOver) return;

        this.player.setVelocityX(200);

        if (this.player.body.onFloor()) {
            this.jumpCount = 0;
        }

        const elapsed = (this.time.now - this.startTime) / 1000;
        this.score = elapsed;
        this.scoreText.setText('Time: ' + elapsed.toFixed(1) + 's');

        // 배경 타일 이동 (플레이어 위치 기준)
        this.bg.tilePositionX = this.player.x;
    }

    _spawnSpike(x) {
        const groundY = this.scale.height;

        const obstacleTypes = [
            {width: 32, height: 30, offsetY: 10, color: 0x363A50, air: false},
            {width: 48, height: 30, offsetY: 10, color: 0x363A50, air: false},
            {width: 64, height: 16, offsetY: 5, color: 0x363A50, air: false},

            {width: 64, height: 400, offsetY: 0, color: 0x191D36, air: true},
            {width: 64, height: 350, offsetY: 0, color: 0x191D36, air: true},
        ];

        const type = Phaser.Utils.Array.GetRandom(obstacleTypes);

        const y = type.air
            ? groundY - type.offsetY - type.height
            : groundY - type.height;

        const spike = this.add.rectangle(x, y, type.width, type.height, type.color);
        this.physics.add.existing(spike);
        this.spikeGroup.add(spike);

        spike.setOrigin(0.5, 1);  // 바닥에 붙도록 origin 수정
        spike.body.setAllowGravity(false);
        spike.body.setImmovable(true);
        spike.body.setVelocityX(-200);
    }

    scheduleBeats() {
        const interval = 60000 / this.currentBPM;
        this.time.addEvent({
            delay: interval,
            callback: () => {
                if (this.isGameOver) return;
                this._spawnSpike(this.player.x + 800);
                this.beatCount++;
                if (this.beatCount % 8 === 0) {
                    this.currentBPM += 5;
                }
                this.scheduleBeats();
            }
        });
    }

    gameOver() {
        this.isGameOver = true;
        this.music.stop();
        this.player.setVelocity(0);
        this.player.setTint(0xff0000);
        this.physics.pause();
        this.cameras.main.shake(300, 0.01);
        this.gameOverText.setVisible(true);

        if (this.score > this.bestTime) {
            this.bestTime = this.score;
            localStorage.setItem('bestTime', this.bestTime);
            this.bestTimeText.setText('Best: ' + this.bestTime.toFixed(1) + 's');
        }

        // 서버에 점수 전송 (gameId는 본인 게임 번호로 수정)
        $.ajax({
            url: "/gameover.game",
            type: "post",
            data: {
                gameId: 5,  // 본인 게임 ID
                score: Math.floor(this.score * 10) // 1/10 단위로 변환 (원래 코드대로)
            },
            success: function (res) {
                console.log("점수 저장 성공:", res);
            },
            error: function (xhr, status, error) {
                console.error("점수 저장 실패:", error);
            }
        });

        this.input.keyboard.once('keydown-SPACE', () => {
            this.scene.restart();
        });
    }
}
