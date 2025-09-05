class BubbleShooterScene extends Phaser.Scene {
    constructor() {
        super({ key: "BubbleShooterScene" });

        // 상태 변수들
        this.arrow = null;
        this.bubblesGroup = null;
        this.initialBubble = null;
        this.nextBubble = null;
        this.leftWall = null;
        this.rightWall = null;
        this.topWall = null;
        this.grid = [];

        // 🔧 사이즈 조정
        this.bubbleSize = 32;        // 버블 크기 줄임
        this.canvasHeight = 400;     // 캔버스 높이
        this.canvasWidth = 600;      // 캔버스 너비
        this.colors = ["red","pink","blue","green","yellow","purple"];
        this.rows = 12;              // 줄 수 (높이 맞춰 조정)
        this.columns = 16;           // 열 수 (너비 맞춰 조정)
        this.filledRows = 7;         // 시작 시 채워질 줄 수
        this.marginX = this.bubbleSize;
        this.marginY = this.bubbleSize;

        this.currentBubbleColor = Phaser.Utils.Array.GetRandom(this.colors);
        this.nextBubbleColor = Phaser.Utils.Array.GetRandom(this.colors);

        this.extraBubbles = [];
        this.extraBubbleCount = 5;
        this.lifeCount = 5;
        this.isGameOver = false;
        this.score = 0;
        this.scoreText = null;
    }

    preload() {
        this.load.image("red","/game/kgj/assets/red.png");
        this.load.image("pink","/game/kgj/assets/pink.png");
        this.load.image("blue","/game/kgj/assets/blue.png");
        this.load.image("green","/game/kgj/assets/green.png");
        this.load.image("yellow","/game/kgj/assets/yellow.png");
        this.load.image("purple","/game/kgj/assets/purple.png");
        this.load.image("arrow","/game/kgj/assets/arrow.png");
        this.load.image("backgroundImage","/game/kgj/assets/background.png");
        this.load.image("restartButtonImage","/game/kgj/assets/restart.png");
        this.load.image("shadowBubbles","/game/kgj/assets/shadowbubble.png");
        this.load.image("lifeBubbles","/game/kgj/assets/lifebubble.png");
    }

    create() {
        this.setCanvasStyle();
        this.createBackground();
        this.createWalls();
        this.createRestartButton();
        this.createBubbleElements();
        this.setupInputHandlers();
        this.createScoreText();
    }

    setCanvasStyle() {
        const canvas = this.sys.game.canvas;
        canvas.style.borderRadius = "20px";
    }

    createBackground() {
        const bg = this.add.image(this.canvasWidth/2,this.canvasHeight/2,"backgroundImage");
        bg.setDisplaySize(this.canvasWidth,this.canvasHeight);
        bg.setOrigin(0.5);
    }

    createWalls() {
        const createWall = (x,y,w,h) => {
            const wall = this.add.rectangle(x,y,w,h,0x000000,0);
            this.physics.add.existing(wall,true);
            wall.body.setSize(w,h);
            return wall;
        };
        this.leftWall = createWall(10,this.canvasHeight/2,10,this.canvasHeight); // 왼쪽 벽
        this.rightWall = createWall(this.canvasWidth-10,this.canvasHeight/2,10,this.canvasHeight); // 오른쪽 벽
        this.topWall = createWall(this.canvasWidth/2,5,this.canvasWidth,10); // 상단 벽
    }

    createRestartButton() {
        const restartButton = this.add.image(this.canvasWidth-40,30,"restartButtonImage").setScale(0.5).setInteractive();
        restartButton.on("pointerdown",()=>{
            this.scene.restart();
            this.grid = [];
            this.isGameOver = false;
            this.extraBubbleCount = 5;
            this.lifeCount = 5;
            this.score = 0;
        });
    }

    createBubbleElements() {
        this.bubblesGroup = this.physics.add.group();
        this.createBubbles();

        this.arrow = this.add.image(this.canvasWidth/2, this.canvasHeight-40,"arrow")
            .setOrigin(0.5,1).setScale(0.25);

        this.initialBubble = this.add.image(
            this.canvasWidth/2,
            this.canvasHeight-40-this.bubbleSize/2,
            this.currentBubbleColor
        ).setOrigin(0.5,0);

        this.nextBubble = this.add.image(
            this.bubbleSize*2,
            this.canvasHeight-40-this.bubbleSize/2,
            this.nextBubbleColor
        ).setOrigin(0.5,0);

        this.extraBubbles = [];
        this.fillExtraBubbles(this.extraBubbleCount);
    }

    setupInputHandlers() {
        this.input.on("pointermove",(pointer)=>{
            let angle = Phaser.Math.Angle.Between(this.arrow.x,this.arrow.y,pointer.x,pointer.y)+Math.PI/2;
            this.arrow.setRotation(angle);
        });
        this.input.on("pointerdown",(pointer)=>{
            if(pointer.y>(this.rows+0.5)*this.bubbleSize) return;
            this.shootBubble();
        });
    }

    createScoreText() {
        this.scoreText = this.add.text(this.canvasWidth-150,60,"Score: 0",{
            fontSize : "16px",
            fill: "#283747",
            fontFamily:"Arial",
            fontStyle:"bold",
        });
    }

    createBubbles() {
        for(let row=1; row<=this.rows; row++) {
            const rowArray = [];
            for(let col=1; col<=this.columns; col++) {
                const x = col*this.bubbleSize-(row%2===0?this.bubbleSize/2:this.bubbleSize)+this.marginX;
                const y = row*this.bubbleSize-this.bubbleSize+this.marginY;
                const centerX = x+this.bubbleSize/2;
                const centerY = y+this.bubbleSize/2;
                if(row<=this.filledRows) {
                    const color = Phaser.Utils.Array.GetRandom(this.colors);
                    const bubble = this.physics.add.image(centerX,centerY,color);
                    bubble.setImmovable(true);
                    this.bubblesGroup.add(bubble);
                    rowArray.push({centerX,centerY,color,bubble});
                } else {
                    rowArray.push({centerX,centerY,color:"blank",bubble:null});
                }
            }
            this.grid.push(rowArray);
        }
    }

    fillExtraBubbles(length) {
        for (let i = 0; i < length; i++) {
            const extra = this.add.image(30 * (i + 1) + 5, 575, "lifeBubbles").setOrigin(0.5, 0.5).setScale(0.8);
            this.extraBubbles.push(extra);
        }
    }

    shootBubble() {
        if (this.isGameOver) return;
        const angle = this.arrow.rotation;
        const bubble = this.createMovingBubble(angle);
        this.updateNextBubbleTextures();
        this.physics.add.collider(bubble, this.leftWall);
        this.physics.add.collider(bubble, this.rightWall);
        this.physics.add.overlap(bubble, [this.bubblesGroup, this.topWall], async (movingBubble, stationary) => {
            await this.handleBubbleCollision(movingBubble, stationary);
            if (this.lifeCount == -1) {
                let newColors = this.createNewRowColors();
                this.addNewRowToTop(newColors);
                this.lifeCount = this.extraBubbleCount;
                this.isGameOver = this.checkForEndgame();
            }
        });
    }

    addNewRowToTop(newRowColors) {
        this.shiftRowsDown();
        this.createNewTopRow(newRowColors);
    }

    shiftRowsDown() {
        for (let r = this.grid.length - 1; r >= 0; r--) {
            for (let c = 0; c < this.grid[r].length; c++) {
                this.shiftBubble(r, c);
                if (r + 1 < this.grid.length) this.grid[r + 1][c] = this.grid[r][c];
            }
        }
    }

    shiftBubble(row, col) {
        const shiftx = (row % 2 === 0 ? 1 : -1) * (this.bubbleSize / 2);
        if (this.grid[row][col].bubble) {
            this.grid[row][col].bubble.y += this.bubbleSize;
            this.grid[row][col].bubble.x += shiftx;
        }
        this.grid[row][col].centerX += shiftx;
        this.grid[row][col].centerY += this.bubbleSize;
    }

    createBubble(x, y, color) {
        const bubble = this.physics.add.image(x, y, color);
        bubble.setOrigin(0.5, 0.5);
        bubble.body.setImmovable(true);
        bubble.body.setCircle(this.bubbleSize / 2);
        return bubble;
    }

    createNewTopRow(newRowColors) {
        for (let col = 0; col < newRowColors.length; col++) {
            const centerX = this.grid[0][col].centerX - this.bubbleSize / 2;
            const centerY = this.marginY + this.bubbleSize / 2;
            const color = newRowColors[col];
            const newBubble = this.createBubble(centerX, centerY, color);
            this.grid[0][col] = { centerX, centerY, color, bubble: newBubble };
            this.bubblesGroup.add(newBubble);
        }
    }

    createNewRowColors() {
        const newRowColors = [];
        for (let col = 0; col < this.columns; col++) newRowColors.push(Phaser.Utils.Array.GetRandom(this.colors));
        return newRowColors;
    }

    createMovingBubble(angle) {
        const bubble = this.physics.add.image(this.arrow.x, this.arrow.y, this.currentBubbleColor);
        bubble.body.setCircle(this.bubbleSize / 5);
        bubble.body.setVelocity(Math.cos(angle - Math.PI / 2) * 800, Math.sin(angle - Math.PI / 2) * 800);
        bubble.body.setBounce(1);
        return bubble;
    }

    updateNextBubbleTextures() {
        if (this.colors.includes(this.nextBubbleColor)) {
            this.currentBubbleColor = this.nextBubbleColor;
        } else {
            this.currentBubbleColor = Phaser.Utils.Array.GetRandom(this.colors);
        }
        this.initialBubble.setTexture(this.currentBubbleColor);
        this.nextBubbleColor = Phaser.Utils.Array.GetRandom(this.colors);
        this.nextBubble.setTexture(this.nextBubbleColor);
    }

    async handleBubbleCollision(movingBubble, stationaryObject) {
        const dx = movingBubble.x - stationaryObject.x;
        const dy = movingBubble.y - stationaryObject.y;
        const distance = Math.sqrt(dx * dx + dy * dy);

        if (distance > this.bubbleSize && stationaryObject !== this.topWall) return;

        movingBubble.body.stop();
        let closestSquare = this.findClosestEmptySquare(movingBubble.x, movingBubble.y);
        let snappedX = closestSquare.centerX;
        let snappedY = closestSquare.centerY;

        movingBubble.destroy();

        const snappedBubble = this.physics.add.image(snappedX, snappedY, movingBubble.texture.key);
        snappedBubble.setOrigin(0.5, 0.5);
        snappedBubble.setImmovable(true);
        snappedBubble.body.setCircle(this.bubbleSize / 2);
        this.bubblesGroup.add(snappedBubble);

        this.updateGridWithBubble(snappedX, snappedY, movingBubble.texture.key, snappedBubble);
        let connectedBalls = this.findConnectedBalls(snappedX, snappedY, movingBubble.texture.key);

        await this.removeConnectedBalls(connectedBalls);
        await this.removeFloatingIslands();
        this.updateAvailableColors();

    }

    updateAvailableColors() {
        const presentColors = new Set();
        for (let row of this.grid) for (let cell of row) if (cell.bubble) presentColors.add(cell.color);
        if (this.colors.length != presentColors.size) {
            this.colors = this.colors.filter((c) => presentColors.has(c));
            this.updateNextBubbleTextures();
        }
    }

    findClosestEmptySquare(x, y) {
        let closestSquare = null;
        let closestDistance = Infinity;
        for (let row = 0; row < this.grid.length; row++) {
            for (let col = 0; col < this.grid[row].length; col++) {
                const square = this.grid[row][col];
                if (square.color === "blank") {
                    const distance = Math.sqrt(Math.pow(square.centerX - x, 2) + Math.pow(square.centerY - y, 2));
                    if (distance < closestDistance) {
                        closestDistance = distance;
                        closestSquare = square;
                    }
                }
            }
        }
        return closestSquare;
    }

    updateGridWithBubble(x, y, color, bubble) {
        const col = Math.floor(((x - this.marginX) - this.bubbleSize / 2) / this.bubbleSize);
        const row = Math.floor(((y - this.marginY) - this.bubbleSize) / this.bubbleSize) + 1;
        if (row >= 0 && row < this.rows && col >= 0 && col < this.columns) {
            this.grid[row][col] = {
                centerX: col * this.bubbleSize + this.bubbleSize / 2 + (row % 2 === 0 ? 0 : this.bubbleSize / 2) + this.marginX,
                centerY: row * this.bubbleSize + this.bubbleSize / 2 + this.marginY,
                color: color,
                bubble: bubble,
            };
        }
    }

    findConnectedBalls(x, y, color) {
        const col = Math.floor(((x - this.marginX) - this.bubbleSize / 2) / this.bubbleSize);
        const row = Math.floor(((y - this.marginY) - this.bubbleSize) / this.bubbleSize) + 1;
        const visited = new Set();
        const connectedBalls = [];
        const dfs = (r, c) => {
            const key = `${r},${c}`;
            if (r < 0 || r >= this.rows || c < 0 || c >= this.columns || visited.has(key) || this.grid[r][c].color !== color)
                return;
            visited.add(key);
            connectedBalls.push({ row: r, col: c, ...this.grid[r][c] });
            const offsets =
                r % 2 === 0 ? [[-1, -1], [-1, 0], [0, -1], [0, 1], [1, -1], [1, 0]] : [[-1, 0], [-1, 1], [0, -1], [0, 1], [1, 0], [1, 1]];
            for (const [dr, dc] of offsets) dfs(r + dr, c + dc);
        };
        dfs(row, col);
        return connectedBalls.length > 2 ? connectedBalls : [];
    }

    removeConnectedBalls(connectedBalls) {
        return new Promise((resolve) => {
            if (connectedBalls.length === 0) {
                this.isGameOver = this.checkForEndgame();
                if (this.isGameOver) return resolve();
                if (this.lifeCount > 0) this.extraBubbles[this.lifeCount - 1].setTexture("shadowBubbles");
                this.lifeCount--;
                if (this.lifeCount == -1) {
                    this.extraBubbleCount--;
                    if (this.extraBubbleCount == 0) this.extraBubbleCount = 5;
                    this.updateBubblesTextures(this.extraBubbleCount);
                }

                return resolve();
            }
            let delay = 0;
            let completed = 0;
            this.score += (connectedBalls.length - 3) * 20 + 30;
            this.scoreText.setText("Score:" + this.score);
            connectedBalls.forEach(({ row, col }) => {
                setTimeout(() => {
                    const bubble = this.grid[row][col].bubble;
                    if (bubble) {

                        bubble.destroy();
                    }
                    this.grid[row][col] = { ...this.grid[row][col], color: "blank", bubble: null };
                    completed++;
                    if (completed === connectedBalls.length) resolve();
                }, delay);
                delay += 80;
            });
        });
    }

    removeFloatingIslands() {
        const visited = Array.from({ length: this.grid.length }, () => Array(this.columns).fill(false));
        const dfs = (r, c) => {
            if (r < 0 || r >= this.rows || c < 0 || c >= this.columns || visited[r][c] || !this.grid[r][c].bubble) return;
            visited[r][c] = true;
            const neighbors = [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1], [r - 1, c + (r % 2 === 0 ? -1 : 1)], [r + 1, c + (r % 2 === 0 ? -1 : 1)]];
            for (const [nr, nc] of neighbors) dfs(nr, nc);
        };
        for (let c = 0; c < this.columns; c++) if (this.grid[0][c].bubble && !visited[0][c]) dfs(0, c);
        let floatingBalls = [];
        for (let r = 0; r < this.rows; r++) {
            for (let c = 0; c < this.columns; c++) {
                if (this.grid[r][c].bubble && !visited[r][c]) {
                    floatingBalls.push({ row: r, col: c, bubble: this.grid[r][c].bubble });
                    this.grid[r][c].bubble.destroy();
                    this.grid[r][c] = { ...this.grid[r][c], color: "blank", bubble: null };
                }
            }
        }
        if (floatingBalls.length > 0) {
            this.score += floatingBalls.length * 100;
            this.scoreText.setText("Score: " + this.score);
        }
    }

    updateBubblesTextures(length) {
        for (let i = 0; i < length; i++) this.extraBubbles[i].setTexture("lifeBubbles");
    }

    checkForEndgame() {
        for (let row of this.grid) {
            for (let cell of row) {
                if (cell.bubble && cell.centerY >= 340) {
                    this.showFinalScore(); // 여기서 바로 호출
                    return true;
                }
            }
        }
        return false;
    }

    showFinalScore() {
        const text = this.add.text(this.sys.game.config.width / 2, this.sys.game.config.height / 2 - 50, "Game Over", {
            fontSize: "30px",
            fill: "#283747",
            fontFamily: "Arial",
            fontStyle: "bold",
        });
        text.setOrigin(0.5);
        this.add.text(this.sys.game.config.width / 2, this.sys.game.config.height / 2, "Score: " + this.score, {
            fontSize: "30px",
            fill: "#283747",
            fontFamily: "Arial",
            fontStyle: "bold",
        }).setOrigin(0.5);
        $.ajax({

            url: "/gameover.game",
            type: "post",
            data: {
                gameId: 3, /*본인 game_id 값 넣기*/
                score: this.score // 점수계산 값을 score 에 넣기
            }
    })
    }

}
