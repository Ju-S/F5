

window.pjw_game = class pjw_game extends Phaser.Scene {
    constructor() {
        super({key:"pjw_game"});

        // ===== 설정 =====
        this.TILE_SIZE = 10;
        this.CLEAR_CENTER = { enabled: true, width: 22, height: 16 };

        this.PLAYER_VISUAL = 20;
        this.PLAYER_SPEED = 100;
        this.ALIGN_EPS_SOFT = 0.6;
        this.ALIGN_EPS_HARD = 0.2;

        this.GHOST_VISUAL = this.PLAYER_VISUAL;
        this.GHOST_SPEED = 70;

        this.GHOST_SPAWNS = [
            { gx: 22, gy: 12 }, { gx: 42, gy: 24 }, { gx: 41, gy: 12 }, { gx: 20, gy: 16 }
        ];

        this.UI_DEPTH = 100000;

        this.COLORS = {
            bg: 0x000000,
            wallBorder: 0x0217fa,
            pellet: 0xffcc00,
            score: "#ffffff",
            overYellow: "#ffdd00ff",
        };
    }

    preload() {
        // 폰트
        /*WebFont.load({
            google: { families: ['Press Start 2P'] },
            active: () => { this.fontReady = true; }
        });*/

        // 고스트 4색(각 4x2 프레임)
        this.load.image("ghost1_raw", "/game/pjw/img/ghost1.png");
        this.load.image("ghost2_raw", "/game/pjw/img/ghost2.png");
        this.load.image("ghost3_raw", "/game/pjw/img/ghost3.png");
        this.load.image("ghost4_raw", "/game/pjw/img/ghost4.png");

        // 플레이어(방향별 2프레임)
        this.load.image("p_left_raw", "/game/pjw/img/left.png");
        this.load.image("p_right_raw", "/game/pjw/img/right.png");
        this.load.image("p_up_raw", "/game/pjw/img/up.png");
        this.load.image("p_down_raw", "/game/pjw/img/down.png");
    }

    // ===== 텍스처 준비 =====
    _prepareGhostSpriteSheets() {
        const make = (idx) => {
            const rawKey = `ghost${idx}_raw`;
            const img = this.textures.get(rawKey).getSourceImage();
            const fw = Math.floor(img.width / 4);
            const fh = Math.floor(img.height / 2);
            const key = `ghosts${idx}`;
            if (this.textures.exists(key)) this.textures.remove(key);
            this.textures.addSpriteSheet(key, img, { frameWidth: fw, frameHeight: fh, endFrame: 7 });
        };
        [1, 2, 3, 4].forEach(make);
    }

    _buildGhostAnimations() {
        const mk = (i, name, frames) => {
            if (this.anims.exists(`ghost${i}-${name}`)) this.anims.remove(`ghost${i}-${name}`);
            this.anims.create({
                key: `ghost${i}-${name}`,
                frames: this.anims.generateFrameNumbers(`ghosts${i}`, { frames }),
                frameRate: 10,
                repeat: -1,
            });
        };
        for (let i = 1; i <= 4; i++) {
            mk(i, "left", [0, 1]);
            mk(i, "right", [2, 3]);
            mk(i, "up", [4, 5]);
            mk(i, "down", [6, 7]);
        }
    }

    _playGhostAnimByDir(sprite) {
        const d = sprite.dir || { x: 0, y: 1 };
        let name = "down";
        if (d.x < 0) name = "left";
        else if (d.x > 0) name = "right";
        else if (d.y < 0) name = "up";
        sprite.anims.play(`ghost${sprite.ghostIndex}-${name}`, true); // ignoreIfPlaying=true
    }

    _preparePlayerSpriteSheets() {
        const prep = (dir) => {
            const raw = this.textures.get(`p_${dir}_raw`).getSourceImage();
            const fw = Math.floor(raw.width / 2); // 이미지가 2등분이 딱 안되어도 안전하게 floor
            const fh = raw.height;
            const key = `player_${dir}`;
            if (this.textures.exists(key)) this.textures.remove(key);
            this.textures.addSpriteSheet(key, raw, { frameWidth: fw, frameHeight: fh, endFrame: 1 });
        };
        ["left", "right", "up", "down"].forEach(prep);
    }

    _buildPlayerAnimations() {
        const mk = (dir) => {
            if (this.anims.exists(`player-${dir}`)) this.anims.remove(`player-${dir}`);
            this.anims.create({
                key: `player-${dir}`,
                frames: this.anims.generateFrameNumbers(`player_${dir}`, { frames: [0, 1] }),
                frameRate: 12,
                repeat: -1,
            });
        };
        ["left", "right", "up", "down"].forEach(mk);
    }

    _playerTexFor(dir) { return `player_${dir}`; }
    _playPlayerAnim(moving) {
        const dir = this.meFacing || "right";
        if (moving) this.me.anims.play(`player-${dir}`, true); // ignoreIfPlaying=true
        else { this.me.anims.stop(); this.me.setTexture(this._playerTexFor(dir)); this.me.setFrame(0); }
    }

    // === “첫 번째로 누른 키만 유효” 헬퍼 ===
    _firstPressedDir() {
        // 현재 눌려있는 방향키들 중 timeDown(가장 먼저 눌린 시간)이 가장 오래된 키를 선택
        const K = this.cursor;
        const cands = [];
        if (K.left.isDown) cands.push({ t: K.left.timeDown, v: new Phaser.Math.Vector2(-1, 0), key: "left" });
        if (K.right.isDown) cands.push({ t: K.right.timeDown, v: new Phaser.Math.Vector2(1, 0), key: "right" });
        if (K.up.isDown) cands.push({ t: K.up.timeDown, v: new Phaser.Math.Vector2(0, -1), key: "up" });
        if (K.down.isDown) cands.push({ t: K.down.timeDown, v: new Phaser.Math.Vector2(0, 1), key: "down" });

        if (cands.length === 0) return new Phaser.Math.Vector2(0, 0);

        // 가장 오래된(timeDown이 가장 작은) 키
        cands.sort((a, b) => a.t - b.t);
        // 동시 입력으로 timeDown이 거의 같은 경우, 현재 바라보는 방향과 같은 게 있으면 우선 유지(깜빡임 방지)
        const facingKey = this.meFacing || "right";
        const youngest = cands[0].t;
        const tie = cands.filter(x => x.t === youngest);
        const pick = tie.find(x => x.key === facingKey) || cands[0];
        return pick.v.clone();
    }

    create() {


        // === 리셋 ===
        this.gameIsOver = false;
        this.remainingPellets = 0;
        this.ghostTimer = null;
        if (this.input?.keyboard) this.input.keyboard.enabled = true;
        this.cameras.main.setBackgroundColor("#000000");

        // ===== 맵 =====
        this.map = [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1],
            [1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1],
            [1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1],

            [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1],
            [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1],
            [1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1],

            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],

            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        ];

        // ===== 레이어/컨테이너 =====
        this.wallLayer = this.add.layer().setDepth(1);
        this.pelletLayer = this.add.layer().setDepth(2);
        this.playerLayer = this.add.layer().setDepth(4);
        this.ghostLayer = this.add.layer().setDepth(5);
        this.uiLayer = this.add.container(0, 0).setDepth(this.UI_DEPTH);

        // ===== 벽 텍스처 =====
        const makeWallTexture = () => {
            const key = 'wall';
            if (this.textures.exists(key)) this.textures.remove(key);
            const g = this.make.graphics({ x: 0, y: 0, add: false });
            const s = this.TILE_SIZE;
            const border = Math.max(2, Math.floor(s * 0.2));
            const radius = Math.max(2, Math.floor(s * 0.7));
            g.fillStyle(this.COLORS.bg, 1);
            g.lineStyle(border, this.COLORS.wallBorder, 1);
            g.fillRoundedRect(0, 0, s, s, radius);
            g.strokeRoundedRect(0, 0, s, s, radius);
            g.generateTexture(key, s, s);
            g.destroy();
        };
        makeWallTexture();

        // ===== 벽 배치 =====
        this.wallGroup = this.physics.add.staticGroup();
        for (let r = 0; r < this.map.length; r++) {
            for (let c = 0; c < this.map[r].length; c++) {
                if (this.map[r][c] === 1) {
                    const w = this.wallGroup.create(
                        c * this.TILE_SIZE + this.TILE_SIZE / 2,
                        r * this.TILE_SIZE + this.TILE_SIZE / 2,
                        'wall'
                    );
                    w.setDisplaySize(this.TILE_SIZE, this.TILE_SIZE);
                    w.refreshBody();
                    w.setDepth(1);
                    this.wallLayer.add(w);
                }
            }
        }

        // ===== 유틸 =====
        this.isOpen = (gx, gy) => (this.map[gy] && this.map[gy][gx] === 0);
        this.cellCenter = (gx, gy) => ({
            x: gx * this.TILE_SIZE + this.TILE_SIZE / 2,
            y: gy * this.TILE_SIZE + this.TILE_SIZE / 2
        });

        // ===== 펠렛 스켈레톤 =====
        this.buildPelletMaskBySkeleton = () => {
            const H = this.map.length;
            const W = this.map[0].length;
            const fg = Array.from({ length: H }, (_, y) =>
                Array.from({ length: W }, (_, x) => (this.map[y][x] === 0 ? 1 : 0))
            );
            const N = (y, x) => [
                fg[y - 1]?.[x] ?? 0, fg[y - 1]?.[x + 1] ?? 0, fg[y]?.[x + 1] ?? 0, fg[y + 1]?.[x + 1] ?? 0,
                fg[y + 1]?.[x] ?? 0, fg[y + 1]?.[x - 1] ?? 0, fg[y]?.[x - 1] ?? 0, fg[y - 1]?.[x - 1] ?? 0,
            ];
            const A = n => { let c = 0; for (let i = 0; i < 8; i++) if (n[i] === 0 && n[(i + 1) % 8] === 1) c++; return c; };
            const B = n => n.reduce((s, v) => s + (v ? 1 : 0), 0);

            let changed = true;
            while (changed) {
                changed = false;
                const del1 = [];
                for (let y = 1; y < H - 1; y++) for (let x = 1; x < W - 1; x++) {
                    if (fg[y][x] !== 1) continue;
                    const n = N(y, x), b = B(n);
                    if (b < 2 || b > 6) continue;
                    if (A(n) !== 1) continue;
                    if ((n[0] && n[2] && n[4]) || (n[2] && n[4] && n[6])) continue;
                    del1.push([y, x]);
                }
                if (del1.length) { changed = true; del1.forEach(([y, x]) => fg[y][x] = 0); }

                const del2 = [];
                for (let y = 1; y < H - 1; y++) for (let x = 1; x < W - 1; x++) {
                    if (fg[y][x] !== 1) continue;
                    const n = N(y, x), b = B(n);
                    if (b < 2 || b > 6) continue;
                    if (A(n) !== 1) continue;
                    if ((n[0] && n[2] && n[6]) || (n[0] && n[4] && n[6])) continue;
                    del2.push([y, x]);
                }
                if (del2.length) { changed = true; del2.forEach(([y, x]) => fg[y][x] = 0); }
            }
            return Array.from({ length: H }, (_, y) =>
                Array.from({ length: W }, (_, x) => fg[y][x] === 1)
            );
        };

        this.erasePelletsRect = (pelletMask, x1, y1, x2, y2) => {
            const H = pelletMask.length, W = pelletMask[0].length;
            x1 = Math.max(0, Math.min(W - 1, x1));
            x2 = Math.max(0, Math.min(W - 1, x2));
            y1 = Math.max(0, Math.min(H - 1, y1));
            y2 = Math.max(0, Math.min(H - 1, y2));
            for (let y = Math.min(y1, y2); y <= Math.max(y1, y2); y++) {
                for (let x = Math.min(x1, x2); x <= Math.max(x1, x2); x++) {
                    pelletMask[y][x] = false;
                }
            }
            return pelletMask;
        };

        // ===== 펠렛 생성 =====
        if (this.textures.exists('pellet')) this.textures.remove('pellet');
        this.textures.generate('pellet', { data: ['33', '33'], pixelWidth: 1, palette: { 3: '#ffcc00' } });

        const PELLET_SIZE = 6;
        this.pelletSprites = [];
        this.pelletMap = [];

        let pelletMask = this.buildPelletMaskBySkeleton();

        // 중앙 사각형 비우기
        this.passRect = null;
        if (this.CLEAR_CENTER.enabled) {
            const H = this.map.length, W = this.map[0].length;
            const cw = this.CLEAR_CENTER.width, ch = this.CLEAR_CENTER.height;
            const cx = Math.floor(W / 2), cy = Math.floor(H / 2);
            const x1 = cx - Math.floor(cw / 2);
            const y1 = cy - Math.floor(ch / 2);
            const x2 = x1 + cw - 1;
            const y2 = y1 + ch - 1;
            pelletMask = this.erasePelletsRect(pelletMask, x1, y1, x2, y2);
            this.passRect = { x1, y1, x2, y2 };
        }
        this.pelletMask = pelletMask;

        // ===== 거리필드 =====
        this.buildDistToPellet = (mask) => {
            const H = this.map.length, W = this.map[0].length;
            const INF = 1e9;
            const dist = Array.from({ length: H }, () => Array(W).fill(INF));
            const q = [];
            for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) {
                if (mask[y][x]) { dist[y][x] = 0; q.push({ x, y }); }
            }
            const DIRS = [[1, 0], [-1, 0], [0, 1], [0, -1]];
            let qi = 0;
            while (qi < q.length) {
                const { x, y } = q[qi++]; const d = dist[y][x] + 1;
                for (const [dx, dy] of DIRS) {
                    const nx = x + dx, ny = y + dy;
                    if (!this.isOpen(nx, ny)) continue;
                    if (dist[ny][nx] > d) { dist[ny][nx] = d; q.push({ x: nx, y: ny }); }
                }
            }
            return dist;
        };
        this.distToPellet = this.buildDistToPellet(this.pelletMask);

        this.remainingPellets = 0;
        for (let r = 0; r < this.map.length; r++) {
            this.pelletSprites[r] = [];
            this.pelletMap[r] = [];
            for (let c = 0; c < this.map[r].length; c++) {
                if (pelletMask[r][c]) {
                    const pos = this.cellCenter(c, r);
                    const dot = this.add.sprite(pos.x, pos.y, 'pellet')
                        .setDisplaySize(PELLET_SIZE, PELLET_SIZE)
                        .setDepth(2);
                    this.pelletLayer.add(dot);
                    this.pelletSprites[r][c] = dot;
                    this.pelletMap[r][c] = true;
                    this.remainingPellets++;
                } else {
                    this.pelletSprites[r][c] = null;
                    this.pelletMap[r][c] = false;
                }
            }
        }

        // ===== 점수 UI =====
        this.score = 0;
        this.scoreText = this.add.text(10, 10, 'SCORE: 0', {
            /*fontFamily: '"Press Start 2P"',*/
            fontSize: '14px',
            color: this.COLORS.score
        }).setScrollFactor(0);
        this.uiLayer.add(this.scoreText);

        // ===== 시트/애니 생성 =====
        this._prepareGhostSpriteSheets();
        this._buildGhostAnimations();
        this._preparePlayerSpriteSheets();
        this._buildPlayerAnimations();

        // ===== 플레이어 =====
        const centerGX = Math.floor(this.map[0].length / 2);
        const centerGY = Math.floor(this.map.length / 2);
        const start = this.cellCenter(centerGX, centerGY);

        this.meFacing = "right";
        this.me = this.physics.add.sprite(start.x, start.y, this._playerTexFor(this.meFacing), 0)
            .setDisplaySize(this.PLAYER_VISUAL, this.PLAYER_VISUAL);
        this.me.setDepth(4);
        this.me.setCollideWorldBounds(true);
        this.me.body.setSize(this.PLAYER_VISUAL - 2, this.PLAYER_VISUAL - 2, true);
        this.physics.add.collider(this.me, this.wallGroup);
        this.playerLayer.add(this.me);

        // 커서 키
        this.cursor = this.input.keyboard.createCursorKeys();

        // 시작 위치 펠렛 제거
        this.eatPelletAt(centerGX, centerGY, true);

        // ===== 유령 스폰 =====
        const DIRS_V2 = [
            new Phaser.Math.Vector2(1, 0), new Phaser.Math.Vector2(-1, 0),
            new Phaser.Math.Vector2(0, 1), new Phaser.Math.Vector2(0, -1)
        ];

        const ghostSpawns = (() => {
            const valid = [];
            const addIfOpen = (gx, gy) => { if (this.isOpen(gx, gy)) valid.push({ gx, gy }); };
            if (this.GHOST_SPAWNS && this.GHOST_SPAWNS.length) {
                this.GHOST_SPAWNS.forEach(p => addIfOpen(p.gx, p.gy));
            }
            if (!valid.length && this.passRect) {
                const cx = Math.floor((this.passRect.x1 + this.passRect.x2) / 2);
                const cy = Math.floor((this.passRect.y1 + this.passRect.y2) / 2);
                addIfOpen(cx, cy); addIfOpen(cx + 1, cy); addIfOpen(cx, cy + 1); addIfOpen(cx + 1, cy + 1);
            }
            if (!valid.length) {
                outer: for (let y = 0; y < this.pelletMask.length; y++)
                    for (let x = 0; x < this.pelletMask[0].length; x++)
                        if (this.pelletMask[y][x]) { addIfOpen(x, y); break outer; }
            }
            return valid;
        })();

        this.ghosts = ghostSpawns.map((p, i) => {
            const pos = this.cellCenter(p.gx, p.gy);
            const colorIdx = (i % 4) + 1;
            const startFrameDown = 6;

            const s = this.add.sprite(pos.x, pos.y, `ghosts${colorIdx}`, startFrameDown)
                .setDisplaySize(this.GHOST_VISUAL, this.GHOST_VISUAL);
            s.setDepth(5);
            s.grid = { x: p.gx, y: p.gy };
            // s.dir = Phaser.Math.RND.pick(DIRS_V2);
            s.dir = DIRS_V2[Math.floor(Math.random() * DIRS_V2.length)];
            s.moving = false;
            s.ghostIndex = colorIdx;

            this._playGhostAnimByDir(s);
            this.ghostLayer.add(s);
            return s;
        });

        this.ghostTimer = this.time.addEvent({ delay: 50, loop: true, callback: () => this.stepGhosts() });
    }

    // ===== 트랙/패스 헬퍼 =====
    isPelletPath(gx, gy) { return this.pelletMask[gy] && this.pelletMask[gy][gx]; }
    isInPass(gx, gy) { const r = this.passRect; return !!r && gx >= r.x1 && gx <= r.x2 && gy >= r.y1 && gy <= r.y2; }
    isTrack(gx, gy) { return this.isPelletPath(gx, gy) || this.isInPass(gx, gy); }

    // ===== 업데이트 =====
    update() {
        if (this.gameIsOver) return;


        // 1) 입력: 동시에 눌렀어도 ‘가장 먼저 눌린’ 키만 채택
        const intent = this._firstPressedDir();

        // 2) 의도 방향으로만 바라보는 방향을 갱신(보정용 vx,vy에 의해 흔들리지 않음)
        if (intent.x !== 0 || intent.y !== 0) {
            if (intent.x < 0) this.meFacing = "left";
            else if (intent.x > 0) this.meFacing = "right";
            else if (intent.y < 0) this.meFacing = "up";
            else if (intent.y > 0) this.meFacing = "down";
        }

        // 3) 실제 이동 계산(보정은 하되, meFacing은 바꾸지 않음)
        const SPEED = this.PLAYER_SPEED;
        const gx = Math.round((this.me.x - this.TILE_SIZE / 2) / this.TILE_SIZE);
        const gy = Math.round((this.me.y - this.TILE_SIZE / 2) / this.TILE_SIZE);
        const cx = gx * this.TILE_SIZE + this.TILE_SIZE / 2;
        const cy = gy * this.TILE_SIZE + this.TILE_SIZE / 2;
        const ox = this.me.x - cx;
        const oy = this.me.y - cy;

        let vx = 0, vy = 0;

        // 가로 의도
        if (intent.x !== 0) {
            if (Math.abs(oy) > this.ALIGN_EPS_SOFT) {
                vy = (oy > 0 ? -1 : 1) * SPEED; // 라인 보정
            } else {
                if (Math.abs(oy) <= this.ALIGN_EPS_HARD) this.me.y = cy;
                const nx = gx + intent.x;
                if (this.isTrack(nx, gy)) { vx = intent.x * SPEED; vy = 0; }
            }
        }
        // 세로 의도
        if (intent.y !== 0) {
            if (Math.abs(ox) > this.ALIGN_EPS_SOFT) {
                vx = (ox > 0 ? -1 : 1) * SPEED; // 라인 보정
            } else {
                if (Math.abs(ox) <= this.ALIGN_EPS_HARD) this.me.x = cx;
                const ny = gy + intent.y;
                if (this.isTrack(gx, ny)) { vy = intent.y * SPEED; vx = 0; }
            }
        }

        if (intent.x === 0 && intent.y === 0) {
            // 입력 없을 때는 셀 중심으로만 스르르 복귀
            this.me.y += (cy - this.me.y) * 0.3;
            this.me.x += (cx - this.me.x) * 0.3;
        }

        this.me.setVelocity(vx, vy);

        // 실제로 움직였을 때만 쩝쩝
        const moving = (vx !== 0 || vy !== 0);
        this._playPlayerAnim(moving);

        this.eatPelletAt(gx, gy, true);
        this.checkPlayerGhostCollision();
    }

    // ===== 펠렛 =====
    eatPelletAt(gx, gy, award) {
        if (!this.pelletMap[gy] || !this.pelletMap[gy][gx]) return;
        this.pelletMap[gy][gx] = false;
        const dot = this.pelletSprites[gy][gx];
        if (dot) { dot.destroy(); this.pelletSprites[gy][gx] = null; }
        if (award) { this.score += 10; this.scoreText.setText('SCORE: ' + this.score); }

        this.remainingPellets--;
        if (this.remainingPellets <= 0) this.triggerGameOver('clear');
    }

    // ===== 유령 이동 =====
    stepGhosts() {
        if (this.gameIsOver) return;

        const DIRS = [
            new Phaser.Math.Vector2(1, 0), new Phaser.Math.Vector2(-1, 0),
            new Phaser.Math.Vector2(0, 1), new Phaser.Math.Vector2(0, -1)
        ];

        this.ghosts.forEach(g => {
            if (g.moving) return;

            const gx = g.grid.x, gy = g.grid.y;
            const onPath = this.isPelletPath(gx, gy);
            const inPass = this.isInPass(gx, gy);

            const neighbors = (filterFn) => {
                const arr = [];
                for (const d of DIRS) {
                    const nx = gx + d.x, ny = gy + d.y;
                    if (!this.isOpen(nx, ny)) continue;
                    if (!filterFn || filterFn(nx, ny, d)) arr.push({ d, nx, ny });
                }
                return arr;
            };

            const openN = neighbors(() => true);
            if (!openN.length) return;

            const notBack = (n) => !(n.d.x === -g.dir.x && n.d.y === -g.dir.y);
            let cand = [];

            if (onPath) {
                const pelletN = openN.filter(n => this.isPelletPath(n.nx, n.ny));
                const passN = openN.filter(n => this.isInPass(n.nx, n.ny));
                const both = pelletN.concat(passN);
                const nb = both.filter(notBack);
                cand = nb.length ? nb : both;

                if (!cand.length) {
                    const curr = this.distToPellet[gy]?.[gx] ?? Infinity;
                    let better = openN.filter(n => (this.distToPellet[n.ny]?.[n.nx] ?? Infinity) < curr).filter(notBack);
                    if (!better.length) {
                        let best = Infinity;
                        for (const n of openN) best = Math.min(best, this.distToPellet[n.ny]?.[n.nx] ?? Infinity);
                        better = openN.filter(n => (this.distToPellet[n.ny]?.[n.nx] ?? Infinity) === best).filter(notBack);
                    }
                    cand = better.length ? better : openN;
                }
            } else if (inPass) {
                const curr = this.distToPellet[gy]?.[gx] ?? Infinity;
                let better = openN.filter(n => (this.distToPellet[n.ny]?.[n.nx] ?? Infinity) < curr);
                let pool = better.length ? better : openN;
                const nb = pool.filter(notBack);
                cand = nb.length ? nb : pool;
            } else {
                const curr = this.distToPellet[gy]?.[gx] ?? Infinity;
                let better = openN.filter(n => (this.distToPellet[n.ny]?.[n.nx] ?? Infinity) < curr);
                if (!better.length) {
                    let best = Infinity;
                    for (const n of openN) best = Math.min(best, this.distToPellet[n.ny]?.[n.nx] ?? Infinity);
                    better = openN.filter(n => (this.distToPellet[n.ny]?.[n.nx] ?? Infinity) === best);
                }
                const nb = better.filter(notBack);
                cand = nb.length ? nb : better;
            }

            if (!cand.length) return;

            /*const pick = cand[Phaser.Math.Between(0, cand.length - 1)];*/
            const pick = cand[Math.floor(Math.random() * cand.length)];
            g.dir = pick.d;
            this._playGhostAnimByDir(g);

            const nx = pick.nx, ny = pick.ny;
            g.moving = true;
            const to = this.cellCenter(nx, ny);
            const duration = (this.TILE_SIZE / this.GHOST_SPEED) * 1000;
            this.tweens.add({
                targets: g, x: to.x, y: to.y, duration,
                onComplete: () => {
                    g.grid.x = nx; g.grid.y = ny; g.moving = false;
                    this.eatPelletAt(nx, ny, false);
                }
            });
        });
    }

    // ===== 충돌 =====
    checkPlayerGhostCollision() {
        for (const g of this.ghosts) {
            if (!g.active) continue;
            if (Phaser.Geom.Intersects.RectangleToRectangle(this.me.getBounds(), g.getBounds())) {
                this.triggerGameOver('hit');
                return;
            }
        }
    }

    // ===== 게임오버 =====
    triggerGameOver(reason) {
        if (this.gameIsOver) return;
        this.gameIsOver = true;

        // ===== 점수 전송(펠릿 점수 기반) =====
        const finalScore = this.score;
        $.ajax({
            url: "/gameover.game",
            type: "POST",
            data: {
                gameId: 2,           // 본인 게임 ID
                score: finalScore,   // 펠릿 점수
                reason: reason || "" // 'hit' | 'clear' 등(옵션)
            }
        }).done(() => {
            console.log("게임 스코어 전송 완료");
        }).fail((xhr) => {
            console.error("스코어 전송 실패:", xhr.status, xhr.responseText);
        });

        this.me.setVelocity(0, 0);
        if (this.ghostTimer) this.ghostTimer.remove();
        this.tweens.killAll();

        const W = this.map[0].length * this.TILE_SIZE;
        const H = this.map.length * this.TILE_SIZE;
        const cx = W / 2, cy = H / 2;

        const ui = this.add.container(0, 0);
        const dim = this.add.rectangle(cx, cy, W, H, 0x000000, 0.45); // dim은 non-interactive

        const title = this.add.text(cx, cy - 40, 'GAME OVER', {
            /*fontFamily: '"Press Start 2P"', */
            fontSize: '40px',
            color: this.COLORS.overYellow
        }).setOrigin(0.5);

        const btnBg = this.add.rectangle(cx, cy + 25, 160, 48, 0xffffff, 1)
            .setStrokeStyle(2, 0xff3333);
        const btnText = this.add.text(cx, cy + 25, 'REPLAY', {
            fontFamily: '"Press Start 2P"',
            fontSize: '20px',
            color: '#000'
        }).setOrigin(0.5);

        const btnHit = this.add.zone(cx, cy + 25, 160, 48).setInteractive({ useHandCursor: true });
        btnHit.on('pointerover', () => btnText.setColor('#ff3333'));
        btnHit.on('pointerout', () => btnText.setColor('#000000'));
        btnHit.once('pointerdown', () => this.restartGame());

        ui.add([dim, title, btnBg, btnText, btnHit]);
        this.uiLayer.add(ui);
    }

    restartGame() {
        // 중복 클릭 방지(선택)
        this.input.enabled = false;

        // 게임오버 UI 제거
        if (this.uiLayer) this.uiLayer.removeAll(true);

        // 씬 재시작(오브젝트/물리/타이머 전부 리셋)
        this.scene.restart();
    }

}