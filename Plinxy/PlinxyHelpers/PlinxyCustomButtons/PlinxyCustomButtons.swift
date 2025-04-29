import SwiftUI
import SpriteKit

struct VictoryParticlesView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        let scene = VictoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {}
}

class VictoryScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.clear
        view.allowsTransparency = true
        let textures = SKTexture(imageNamed: "starDaily")
        let addParticleAction = SKAction.run {
            self.addParticle(texture: textures)
        }
        let sequence = SKAction.sequence([
            addParticleAction,
            SKAction.wait(forDuration: 1)
        ])
        run(SKAction.repeatForever(sequence))
    }
    
    private func addParticle(texture: SKTexture) {
        let spriteNode = SKSpriteNode(texture: texture)
        spriteNode.position = CGPoint(
            x: CGFloat.random(in: 0...size.width),
            y: size.height / 0.8
        )
        spriteNode.setScale(CGFloat.random(in: 0.2...0.4))
        addChild(spriteNode)
        let moveAction = SKAction.move(
            to: CGPoint(x: spriteNode.position.x, y: -spriteNode.size.height),
            duration: 5
        )
        let removeAction = SKAction.removeFromParent()
        spriteNode.run(SKAction.sequence([
            SKAction.group([moveAction]),
            removeAction
        ]))
    }
}
