class GameScene extends Phaser.Scene {
    constructor() {
        super('GameScene');
        this.baseBPM = 120;
        this.spawnLeadTime = 2000;
    }

    preload() {
        this.load.image('bg', 'img/bg.png');         // 배경
        this.load.image('floor', 'img/floor.svg');   // 바닥
        this.load.image('player', 'img/player.png'); // 플레이어 이미지
        this.load.audio('bgm', 'mp3/music.mp3'); // 음악
    }

    create() {
        // 배경
        this.bg = this.add.tileSprite(0, 0, this.scale.width, this.scale.height, 'bg')
            .setOrigin(0, 0)
            .setScrollFactor(0);

        // 바닥
        this.groundGroup = this.physics.add.staticGroup();
        for (let i = 0; i < 100; i++) {
            this.groundGroup.create(i * 70, this.scale.height - 1, 'floor')
                .setOrigin(0, 1)
                .refreshBody();
        }


        // this.physics.world.createDebugGraphic(); // 디버그 그래픽 제거

        // 플레이어
        this.player = this.physics.add.sprite(100, this.scale.height - 84, 'player');
        this.player.setOrigin(0.5, 0); // 또는 주석 처리 기준점 : 아래 중앙
        this.player.setDisplaySize(64, 64); // 보이는 크기
        this.player.setCollideWorldBounds(true);
        this.player.setGravityY(1000);
        this.physics.add.collider(this.player, this.groundGroup);

        // 충돌 박스 사이즈 조절 (실제 충돌 감지 영역)
        this.player.body.setSize(64, 64); // ← 너비 40, 높이 50
        this.player.body.setOffset(30, 30); // ← 이미지 기준 위치로 충돌 박스 이동

        // 장애물 그룹
        this.spikeGroup = this.physics.add.group();
        this.physics.add.collider(this.player, this.spikeGroup, () => {
            if (!this.isGameOver) this.gameOver();
        });

        // 점프
        this.maxJumps = 3; // 최대 3번 점프 가능
        this.jumpCount = 0;

        this.input.keyboard.on('keydown-SPACE', () => {
            if (this.isGameOver) return;

            if (this.jumpCount < this.maxJumps) {
                this.player.setVelocityY(-450);
                this.jumpCount++;
            }
        });

        // 점프 에어 효과
        this.player.setVelocityY(-450);
        this.jumpCount++;

        // 예: 점프 파티클
        this.add.circle(this.player.x, this.player.y + 20, 5, 0xffffff).setAlpha(0.5).setDepth(-1);


        // 카메라
        this.cameras.main.startFollow(this.player);
        this.cameras.main.setBounds(0, 0, 99999, this.scale.height);

        // 음악
        this.music = this.sound.add('bgm');
        this.music.play();

        // 점수 (시간 기반)
        this.startTime = this.time.now;
        this.score = 0;
        this.scoreText = this.add.text(20, 20, 'Time: 0.0s', {
            fontSize: '24px',
            fill: '#ffffff'
        }).setScrollFactor(0);

        // 최고 기록
        this.bestTime = parseFloat(localStorage.getItem('bestTime')) || 0;
        this.bestTimeText = this.add.text(20, 50, 'Best: ' + this.bestTime.toFixed(1) + 's', {
            fontSize: '20px',
            fill: '#ffff00'
        }).setScrollFactor(0);

        // 게임 오버 텍스트
        this.gameOverText = this.add.text(this.scale.width / 2, this.scale.height / 2, 'Game Over\nPress SPACE to Restart', {
            fontSize: '40px',
            fill: '#ff0000',
            align: 'center'
        }).setOrigin(0.5).setScrollFactor(0).setVisible(false);

        this.isGameOver = false;

        // BPM 장애물 생성
        this.currentBPM = this.baseBPM;
        this.scheduleBeats();
    }

    update() {
        if (this.isGameOver) return;

        this.player.setVelocityX(200);

        // 점프 바닥 체크 시 리셋
        if (this.player.body.onFloor()) {
            this.lastOnGroundTime = this.time.now;
            this.jumpCount = 0; // 바닥 닿았을 때 점프 카운트 초기화
        }

        // 시간 기반 점수 계산
        const elapsed = (this.time.now - this.startTime) / 1000;
        this.score = elapsed;
        this.scoreText.setText('Time: ' + elapsed.toFixed(1) + 's');

        this.bg.tilePositionX = this.player.x;
        console.log(elapsed); //리셋 되는지 확인 과정

        if (this.player.body.onFloor()) {
            this.lastOnGroundTime = this.time.now;
        }
    }

    _spawnSpike(x) {
        const groundY = this.scale.height;

        const obstacleTypes = [
            // 바닥 장애물 (offsetY 반영되도록 수정 필요)
            { width: 32, height: 30, offsetY: 85, color: 0x363A50, air: false },
            { width: 48, height: 30, offsetY: 85, color: 0x363A50, air: false },
            { width: 64, height: 16, offsetY: 85, color: 0x363A50, air: false },

            // 공중 장애물
            { width: 64, height: 100, offsetY: 400, color: 0x191D36, air: true },
            { width: 64, height: 150, offsetY: 400, color: 0x191D36, air: true },
        ];

        const type = Phaser.Utils.Array.GetRandom(obstacleTypes);

        // y 좌표 계산 (offsetY 반영)
        const y = type.air
            ? groundY - type.offsetY
            : groundY - type.height - type.offsetY;

        const spike = this.add.rectangle(x, y, type.width, type.height, type.color);
        this.physics.add.existing(spike);
        this.spikeGroup.add(spike);

        spike.setOrigin(0.5, 0); // 상단 기준
        spike.body.setAllowGravity(false);
        spike.body.setImmovable(true);
        spike.body.setVelocityX(-200);
    }

    scheduleBeats() {
        let beatCount = 0;
        const spawn = () => {
            const interval = 60000 / this.currentBPM;
            this._spawnSpike(this.player.x + 800);

            beatCount++;
            if (beatCount % 8 === 0) {
                this.currentBPM += 5;
            }

            this.time.delayedCall(interval, spawn);
        };

        this.time.delayedCall(this.spawnLeadTime, spawn);
    }

    gameOver() {
        this.isGameOver = true;
        this.music.stop();
        this.player.setVelocity(0);
        this.player.setTint(0xff0000);
        this.physics.pause();
        this.cameras.main.shake(300, 0.01);
        this.gameOverText.setVisible(true);

        // 최고 기록 갱신
        if (this.score > this.bestTime) {
            this.bestTime = this.score;
            localStorage.setItem('bestTime', this.bestTime);
            this.bestTimeText.setText('Best: ' + this.bestTime.toFixed(1) + 's');
        }

        this.input.keyboard.once('keydown-SPACE', () => {
            this.scene.restart();
        });
    }
}
