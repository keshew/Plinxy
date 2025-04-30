import SwiftUI
import SpriteKit

class GameData: ObservableObject {
    @Published var isPause = false
    @Published var isMenu = false
    @Published var isWin = false
    @Published var isLose = false
    @Published var isExit = false
    @Published var time = 120
    @Published var score = 0
    @Published var scene = SKScene()
}

struct PhysicsCategory {
    static let staticBall: UInt32 = 0x1 << 0
    static let dynamicBall: UInt32 = 0x1 << 1
    static let border: UInt32 = 0x1 << 2
    static let removeBall: UInt32 = 0x1 << 3
}

class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData?
    var mainBall: SKSpriteNode!
    let verticalSpacing: CGFloat = 30
    let horizontalSpacing: CGFloat = 30
    var startY: CGFloat = 0
    var timer: Timer!
    var timerLabel: SKLabelNode!
    var scoresLabel: SKLabelNode!
    var isBombMode = false
    var level: Int
    var isMainBallFlying = false
    var bombCountLabel: SKLabelNode!
    var timeCountLabel: SKLabelNode!
    @State var ud = UserDefaultsManager()
    
    init(level: Int) {
        self.level = level
        super.init(size: UIScreen.main.bounds.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        physicsBody?.categoryBitMask = PhysicsCategory.border
        physicsBody?.contactTestBitMask = PhysicsCategory.dynamicBall
        physicsBody?.collisionBitMask = PhysicsCategory.dynamicBall
        startY = size.height / 2 + 160
        setupMain()
        setupTappedNode()
        createScoreBacks()
        createMainBall()
        createBalls()
        addBottomBorder()
        startTimer()
    }
    
    func setupMain() {
        let gameBackground = SKSpriteNode(imageNamed: "gameBG1")
        gameBackground.size = CGSize(width: size.width, height: size.height)
        gameBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameBackground)
        
        let levelLabel = SKLabelNode(fontNamed: "Super Bubble")
        levelLabel.attributedText = NSAttributedString(string: "LEVEL \(level + 1)", attributes: [
            NSAttributedString.Key.font: UIFont(name: "Super Bubble", size: 30)!,
            NSAttributedString.Key.foregroundColor: UIColor(red: 151/255, green: 26/255, blue: 192/255, alpha: 1),
            NSAttributedString.Key.strokeColor: UIColor.white,
            NSAttributedString.Key.strokeWidth: -3.5
        ])
        levelLabel.position = CGPoint(x: size.width / 1.18 , y: size.height / 1.15)
        addChild(levelLabel)
    }
    
    func createScoreBacks() {
        let timeBack = SKSpriteNode(imageNamed: "scoreBack")
        timeBack.size = CGSize(width: 145, height: 48)
        timeBack.position = CGPoint(x: size.width / 1.18, y: size.height / 1.3)
        addChild(timeBack)
        
        let time = SKSpriteNode(imageNamed: "timeGameIcon")
        time.size = CGSize(width: 28, height: 29)
        time.position = CGPoint(x: -timeBack.size.width / 2 + 40, y: 0)
        timeBack.addChild(time)
        
        let timeLabel = SKLabelNode(fontNamed: "SuezOne-Regular")
        timeLabel.text = "TIME"
        timeLabel.fontSize = 12
        timeLabel.position = CGPoint(x: 10 , y: 0)
        timeBack.addChild(timeLabel)
        
        timerLabel = SKLabelNode(fontNamed: "SuezOne-Regular")
        timerLabel.text = "\(game!.time/60):\(game!.time % 60)"
        timerLabel.fontSize = 12
        timerLabel.fontColor = UIColor(red: 10/255, green: 77/255, blue: 249/255, alpha: 1)
        timerLabel.position = CGPoint(x: 10, y: -12)
        timeBack.addChild(timerLabel)
        
        //MARK: - score
        let scoreBack = SKSpriteNode(imageNamed: "scoreBack")
        scoreBack.size = CGSize(width: 145, height: 48)
        scoreBack.position = CGPoint(x: size.width / 1.18, y: size.height / 1.58)
        addChild(scoreBack)
        
        let star = SKSpriteNode(imageNamed: "star")
        star.size = CGSize(width: 30, height: 27)
        star.position = CGPoint(x: -scoreBack.size.width / 2 + 40, y: 0)
        scoreBack.addChild(star)
        
        let scoreLabel = SKLabelNode(fontNamed: "SuezOne-Regular")
        scoreLabel.text = "SCORE"
        scoreLabel.fontSize = 12
        scoreLabel.position = CGPoint(x: 10 , y: 0)
        scoreBack.addChild(scoreLabel)
        
        scoresLabel = SKLabelNode(fontNamed: "SuezOne-Regular")
        scoresLabel.text = "\(game!.score)\\100"
        scoresLabel.fontSize = 12
        scoresLabel.fontColor = UIColor(red: 10/255, green: 77/255, blue: 249/255, alpha: 1)
        scoresLabel.position = CGPoint(x: 10, y: -12)
        scoreBack.addChild(scoresLabel)
    }
    
    func setupTappedNode() {
        let gameBackground = SKSpriteNode(imageNamed: "pause")
        gameBackground.size = CGSize(width: 56, height: 44)
        gameBackground.position = CGPoint(x: size.width / 7, y: size.height / 1.15)
        gameBackground.name = "pause"
        addChild(gameBackground)
        
        let addTime = SKSpriteNode(imageNamed: "timeGame")
        addTime.size = CGSize(width: 80, height: 61)
        addTime.name = "time"
        addTime.position = CGPoint(x: size.width / 7, y: size.height / 8.15)
        addChild(addTime)
        
        let countTime = SKSpriteNode(imageNamed: "countBonus")
        countTime.size = CGSize(width: 36, height: 27)
        countTime.position = CGPoint(x: 43, y: -addTime.size.height / 2 - countTime.size.height / 2 + 25)
        addTime.addChild(countTime)
        
        timeCountLabel = SKLabelNode(fontNamed: "SuezOne-Regular")
        timeCountLabel.text = "\(UserDefaultsManager.defaults.integer(forKey: Keys.time.rawValue))"
        timeCountLabel.fontSize = 25
        timeCountLabel.position = CGPoint(
            x: countTime.position.x - 1,
            y: countTime.position.y - countTime.size.height / 2 - timeCountLabel.fontSize / 2 + 18
        )
        addTime.addChild(timeCountLabel)
        
        let bomb = SKSpriteNode(imageNamed: "bombGame")
        bomb.size = CGSize(width: 80, height: 61)
        bomb.name = "bomb"
        bomb.position = CGPoint(x: size.width / 1.15, y: size.height / 8.15)
        addChild(bomb)
        
        let countBonus = SKSpriteNode(imageNamed: "countBonus")
        countBonus.size = CGSize(width: 36, height: 27)
        countBonus.position = CGPoint(x: -40, y: -bomb.size.height / 2 - countBonus.size.height / 2 + 25)
        bomb.addChild(countBonus)
        
        bombCountLabel = SKLabelNode(fontNamed: "SuezOne-Regular")
        bombCountLabel.text = "\(UserDefaultsManager.defaults.integer(forKey: Keys.bomb.rawValue))"
        bombCountLabel.fontSize = 25
        bombCountLabel.position = CGPoint(x: countBonus.position.x - 1, y: countBonus.position.y - countBonus.size.height / 2 - bombCountLabel.fontSize / 2 + 18)
        bomb.addChild(bombCountLabel)
        
    }
    
    func getRandomBallImage() -> String {
        return ["ball1", "ball2", "ball3", "ball4", "ball5", "ball6"].randomElement() ?? ""
    }
    
    func createBalls() {
        let ballsPerRow = [12, 10, 8, 6, 4, 3, 2, 1]
        let ballSize = CGSize(width: 33, height: 30)
        let verticalSpacing: CGFloat = 30
        let horizontalSpacing: CGFloat = 30
        let startY = size.height / 2
        
        for (rowIndex, ballsCount) in ballsPerRow.enumerated() {
            let yPos = startY - CGFloat(rowIndex) * verticalSpacing
            let totalRowWidth = CGFloat(ballsCount - 1) * horizontalSpacing
            for ballIndex in 0..<ballsCount {
                let ballImageName = getRandomBallImage()
                let ball = SKSpriteNode(imageNamed: ballImageName)
                ball.size = ballSize
                let xPos = size.width / 2 - totalRowWidth / 2 + CGFloat(ballIndex) * horizontalSpacing
                ball.position = CGPoint(x: xPos, y: yPos + 160)
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.width / 2)
                ball.name = ballImageName
                ball.physicsBody?.isDynamic = false
                ball.physicsBody?.categoryBitMask = PhysicsCategory.staticBall
                ball.physicsBody?.contactTestBitMask = PhysicsCategory.dynamicBall
                ball.physicsBody?.collisionBitMask = PhysicsCategory.dynamicBall | PhysicsCategory.border
                addChild(ball)
            }
        }
    }
    
    func createMainBall() {
        let ballImageName = getRandomBallImage()
        let ballSize = CGSize(width: 33, height: 30)
        let mainBall = SKSpriteNode(imageNamed: ballImageName)
        mainBall.size = ballSize
        mainBall.position = CGPoint(x: size.width / 2, y: size.height / 8.15)
        mainBall.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.width / 2)
        mainBall.physicsBody?.isDynamic = true
        mainBall.name = ballImageName
        mainBall.physicsBody?.affectedByGravity = false
        mainBall.physicsBody?.allowsRotation = false
        mainBall.physicsBody?.categoryBitMask = PhysicsCategory.dynamicBall
        mainBall.physicsBody?.contactTestBitMask = PhysicsCategory.staticBall | PhysicsCategory.border
        mainBall.physicsBody?.collisionBitMask = PhysicsCategory.staticBall | PhysicsCategory.border
        addChild(mainBall)
        self.mainBall = mainBall
    }
    
    func areNodesNearby(_ node1: SKNode, _ node2: SKNode, threshold: CGFloat = 40) -> Bool {
        let dx = node1.position.x - node2.position.x
        let dy = node1.position.y - node2.position.y
        let distance = sqrt(dx*dx + dy*dy)
        return distance <= threshold
    }
    
    func checkNearbyNodes(node: SKNode) {
        guard let targetName = node.name else { return }
        
        var visited = Set<SKNode>()
        var toVisit = [node]
        
        while !toVisit.isEmpty {
            let current = toVisit.removeLast()
            visited.insert(current)
            
            let neighbors = self.children.filter { otherNode in
                guard otherNode != current,
                      otherNode.name == targetName,
                      !visited.contains(otherNode),
                      areNodesNearby(current, otherNode) else {
                    return false
                }
                return true
            }
            
            toVisit.append(contentsOf: neighbors)
        }
        
        if visited.count >= 3 {
            for ball in visited {
                ball.removeFromParent()
                incrementScore()
            }
            
            let destroyedRowIndex = getRowIndex(forY: node.position.y, startY: startY, verticalSpacing: verticalSpacing)
            handleRowsBelowDestroyed(rowIndex: destroyedRowIndex, startY: startY, verticalSpacing: verticalSpacing)
        }
    }
    
    func getRowIndex(forY y: CGFloat, startY: CGFloat, verticalSpacing: CGFloat) -> Int {
        return Int((startY - y) / verticalSpacing)
    }
    
    func handleRowsBelowDestroyed(rowIndex: Int, startY: CGFloat, verticalSpacing: CGFloat) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        let thresholdY = startY - CGFloat(rowIndex) * verticalSpacing
        
        for node in self.children {
            guard let ball = node as? SKSpriteNode else { continue }
            if ball.position.y < thresholdY {
                if ball.physicsBody?.isDynamic == false {
                    ball.physicsBody?.isDynamic = true
                    ball.physicsBody?.affectedByGravity = true
                    ball.physicsBody?.contactTestBitMask = PhysicsCategory.removeBall
                    ball.physicsBody?.collisionBitMask = PhysicsCategory.removeBall
                    ball.physicsBody?.categoryBitMask = PhysicsCategory.removeBall
                    incrementScore()
                }
            }
        }
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run { [weak self] in
                self?.physicsWorld.gravity = .zero
            }
        ]))
    }
    
    func addBottomBorder() {
        let borderHeight: CGFloat = 10
        let border = SKNode()
        border.position = CGPoint(x: size.width / 2, y: borderHeight / 2)
        border.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: borderHeight))
        border.physicsBody?.isDynamic = false
        border.physicsBody?.categoryBitMask = PhysicsCategory.border
        border.physicsBody?.contactTestBitMask = PhysicsCategory.removeBall
        border.physicsBody?.collisionBitMask = 0
        addChild(border)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isMainBallFlying else { return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        if let tappedNode = self.atPoint(location) as? SKSpriteNode,
           tappedNode.name != "pause", tappedNode.name != "bomb", tappedNode.name != "time" {
            let dx = location.x - mainBall.position.x
            let dy = location.y - mainBall.position.y
            
            let speedFactor: CGFloat = 0.2
            let vector = CGVector(dx: dx * speedFactor, dy: dy * speedFactor)
            mainBall.physicsBody?.applyImpulse(vector)
            isMainBallFlying = true
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node as? SKSpriteNode,
              let nodeB = contact.bodyB.node as? SKSpriteNode else { return }

        let isDynamicA = contact.bodyA.categoryBitMask == PhysicsCategory.dynamicBall
        let isStaticB = contact.bodyB.categoryBitMask == PhysicsCategory.staticBall
        let isDynamicB = contact.bodyB.categoryBitMask == PhysicsCategory.dynamicBall
        let isStaticA = contact.bodyA.categoryBitMask == PhysicsCategory.staticBall

        if (isDynamicA && isStaticB) || (isDynamicB && isStaticA) {
            let dynamicBall = isDynamicA ? nodeA : nodeB
            let staticBall = isDynamicA ? nodeB : nodeA

            if isBombMode, dynamicBall.texture?.description.contains("bomb1") == true {
                let rowIndex = getRowIndex(forY: staticBall.position.y, startY: startY, verticalSpacing: verticalSpacing)
                var totalRemoved = 0
                
                for i in -1...1 {
                    let rowToRemove = rowIndex - i
                    if rowToRemove >= 0 {
                        totalRemoved += removeRow(at: rowToRemove)
                    }
                }
                
                incrementScore(by: totalRemoved)
                dynamicBall.removeFromParent()
                isBombMode = false
                isMainBallFlying = false
                createMainBall()
                shiftRowsDown(by: verticalSpacing)
                addTopRow()
                handleRowsBelowDestroyed(rowIndex: rowIndex, startY: startY, verticalSpacing: verticalSpacing)
                return
            }
            
            //MARK: - ball
            dynamicBall.physicsBody?.velocity = .zero
            dynamicBall.physicsBody?.isDynamic = false
            dynamicBall.physicsBody?.categoryBitMask = PhysicsCategory.staticBall
            dynamicBall.physicsBody?.contactTestBitMask = PhysicsCategory.dynamicBall | PhysicsCategory.border
            dynamicBall.physicsBody?.collisionBitMask = PhysicsCategory.dynamicBall | PhysicsCategory.border
            
            let dx = dynamicBall.position.x - staticBall.position.x
            let dy = dynamicBall.position.y - staticBall.position.y
            let distance = sqrt(dx*dx + dy*dy)
            let radiusSum = (dynamicBall.size.width + staticBall.size.width) / 2
            isMainBallFlying = false
            if distance != 0 {
                let correctionFactor = radiusSum / distance
                let correctedX = staticBall.position.x + dx * correctionFactor
                let correctedY = staticBall.position.y + dy * correctionFactor
                dynamicBall.position = CGPoint(x: correctedX, y: correctedY)
            } else {
                dynamicBall.position = CGPoint(x: staticBall.position.x, y: staticBall.position.y + radiusSum)
            }
            
            checkNearbyNodes(node: dynamicBall)
            createMainBall()
            shiftRowsDown(by: verticalSpacing)
            addTopRow()
        }

        if contact.bodyA.categoryBitMask == PhysicsCategory.border,
           contact.bodyB.categoryBitMask == PhysicsCategory.removeBall {
            nodeB.removeFromParent()
        } else if contact.bodyB.categoryBitMask == PhysicsCategory.border,
                  contact.bodyA.categoryBitMask == PhysicsCategory.removeBall {
            nodeA.removeFromParent()
        }
    }
    
    func incrementScore(by points: Int = 1) {
        game!.score += points
        DispatchQueue.main.async {
            self.scoresLabel.text = "\(self.game!.score)\\ 100"
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.game!.isPause == false, self.game!.isExit == false {
                self.updateTimer()
            }
        }
    }
    
    func updateTimer() {
        if game?.time ?? 0 > 0 {
            game?.time -= 1
            timerLabel.text = "\(game!.time/60):\(game!.time % 60)"
        } else {
            if game!.isWin != true {
                game?.isLose = true
                scene?.isPaused = true
                timer?.invalidate()
            }
        }
    }
    
    func shiftRowsDown(by offset: CGFloat) {
        for node in children {
            if let ball = node as? SKSpriteNode,
               ball.physicsBody?.categoryBitMask == PhysicsCategory.staticBall {
                ball.physicsBody?.isDynamic = false
                let newPos = CGPoint(x: ball.position.x, y: ball.position.y - offset)
                let moveAction = SKAction.move(to: newPos, duration: 0.3)
                ball.run(moveAction) {
                    ball.physicsBody?.isDynamic = false
                }
            }
        }
    }
    
    func addTopRow() {
        let ballsCount = 12
        let ballSize = CGSize(width: 33, height: 30)
        let horizontalSpacing: CGFloat = 30
        let yPos = startY + verticalSpacing
        
        let totalRowWidth = CGFloat(ballsCount - 1) * horizontalSpacing
        
        for ballIndex in 0..<ballsCount {
            let ballImageName = getRandomBallImage()
            let ball = SKSpriteNode(imageNamed: ballImageName)
            ball.size = ballSize
            let xPos = size.width / 2 - totalRowWidth / 2 + CGFloat(ballIndex) * horizontalSpacing
            ball.position = CGPoint(x: xPos, y: yPos - 30)
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.width / 2)
            ball.name = ballImageName
            ball.physicsBody?.isDynamic = false
            ball.physicsBody?.categoryBitMask = PhysicsCategory.staticBall
            ball.physicsBody?.contactTestBitMask = PhysicsCategory.dynamicBall
            ball.physicsBody?.collisionBitMask = PhysicsCategory.dynamicBall | PhysicsCategory.border
            addChild(ball)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkBottomBallPosition()
        
        if isWin() {
            game!.isWin = true
        }
    }
    
    func checkBottomBallPosition() {
        let staticBalls = children.compactMap { node -> SKSpriteNode? in
            guard let ball = node as? SKSpriteNode,
                  ball.physicsBody?.categoryBitMask == PhysicsCategory.staticBall else { return nil }
            return ball
        }
        
        guard !staticBalls.isEmpty else { return }
        
        let bottomBall = staticBalls.min(by: { $0.position.y < $1.position.y })
        
        if let bottomBall = bottomBall, bottomBall.position.y <= 70 {
            game?.isLose = true
            scene?.isPaused = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            pauseTapped(touchLocation: touchLocation)
            timeTapped(touchLocation: touchLocation)
            bombTapped(touchLocation: touchLocation)
        }
    }
    
    func isWin() -> Bool {
        guard let game = game else { return false }
        return game.score >= 100
    }
    
    func pauseTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "pause" {
            print("pause")
            game!.isPause = true
            game!.scene = scene!
            scene?.isPaused = true
        }
    }
    
    func bombTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "bomb" {
            
            if UserDefaultsManager.defaults.integer(forKey: Keys.bomb.rawValue) >= 1 {
                isBombMode = true
                mainBall.texture = SKTexture(imageNamed: "bomb1")
                UserDefaultsManager.defaults.set(UserDefaultsManager.defaults.integer(forKey: Keys.bomb.rawValue) - 1, forKey: Keys.bomb.rawValue)
                bombCountLabel.text = "\(UserDefaultsManager.defaults.integer(forKey: Keys.bomb.rawValue))"
            }
        }
    }
    
    func timeTapped(touchLocation: CGPoint) {
        if let tappedNode = self.atPoint(touchLocation) as? SKSpriteNode,
           tappedNode.name == "time" {
            if UserDefaultsManager.defaults.integer(forKey: Keys.time.rawValue) >= 1 {
                game!.time += 30
                UserDefaultsManager.defaults.set(UserDefaultsManager.defaults.integer(forKey: Keys.time.rawValue) - 1, forKey: Keys.time.rawValue)
                timeCountLabel.text = "\(UserDefaultsManager.defaults.integer(forKey: Keys.time.rawValue))"
            }
        }
    }
    
    func removeRow(at rowIndex: Int) -> Int {
        let yRow = startY - CGFloat(rowIndex) * verticalSpacing
        var removedCount = 0
        guard rowIndex >= 0 else { return 0 }

        for node in children {
            if let ball = node as? SKSpriteNode,
               abs(ball.position.y - yRow) < verticalSpacing / 2,
               ball.physicsBody?.categoryBitMask == PhysicsCategory.staticBall {

                ball.removeFromParent()
                removedCount += 1
            }
        }
        return removedCount
    }

    
    override func willMove(from view: SKView) {
        physicsWorld.contactDelegate = nil
        self.removeAllActions()
        self.removeAllChildren()
        self.timer.invalidate()
    }
}

struct PlinxyGameView: View {
    @StateObject var plinxyGameModel =  PlinxyGameViewModel()
    @StateObject var gameModel = GameData()
    var level: Int
    var body: some View {
        ZStack {
            SpriteView(scene: plinxyGameModel.createGameScene(gameData: gameModel, level: level))
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
            
            if gameModel.isLose {
                PlinxyLoseView(level: level, score: gameModel.score)
            }
            
            if gameModel.isWin {
                PlinxyWinView(level: level, score: gameModel.score)
                    .onAppear {
                        let levelScores = UserDefaultsManager().getLevelScores()
                        if levelScores.count <= 14 {
                            if level + 1 >= UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) {
                                UserDefaultsManager().increaseLevel()
                            }
                        }
                        UserDefaultsManager().saveLevelScore(level: level + 1, score: gameModel.score)
                        UserDefaultsManager().daily()
                    }
            }
            
            if gameModel.isPause {
                PlinxyPauseView(game: gameModel, scene: gameModel.scene)
            }
            
            if gameModel.isExit {
                PlinxyExitView(game: gameModel, scene: gameModel.scene)
            }
        }
        .onAppear() {
            print(level)
            OrientationManager.setLandscapeOrientation()
        }
    }
}

#Preview {
    PlinxyGameView(level: 1)
}
