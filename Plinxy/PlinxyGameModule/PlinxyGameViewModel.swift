import SwiftUI

class PlinxyGameViewModel: ObservableObject {
    let contact = PlinxyGameModel()

    func createGameScene(gameData: GameData, level: Int) -> GameSpriteKit {
        let scene = GameSpriteKit(level: level)
        scene.game  = gameData
        return scene
    }
}
