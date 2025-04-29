import SwiftUI
import SpriteKit

class GameData: ObservableObject {
    @Published var isPause = false
    @Published var isMenu = false
    @Published var isWin = false
    @Published var isLose = false
    @Published var isRules = false
    @Published var score = 0
    @Published var scene = SKScene()

}

class GameSpriteKit: SKScene, SKPhysicsContactDelegate {
    var game: GameData?
 
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        size = UIScreen.main.bounds.size
        setupMain()
    }
    
    func setupMain() {
        let gameBackground = SKSpriteNode(imageNamed: "gameBG1")
        gameBackground.size = CGSize(width: size.width, height: size.height)
        gameBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameBackground)
    }
}

struct PlinxyGameView: View {
    @StateObject var plinxyGameModel =  PlinxyGameViewModel()
    @StateObject var gameModel = GameData()
    
    var body: some View {
        ZStack {
            SpriteView(scene: plinxyGameModel.createGameScene(gameData: gameModel))
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    PlinxyGameView()
}

