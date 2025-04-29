import SwiftUI

class PlinxyGameViewModel: ObservableObject {
    let contact = PlinxyGameModel()

    func createGameScene(gameData: GameData) -> GameSpriteKit {
        let scene = GameSpriteKit()
        scene.game  = gameData
        return scene
    }
}
