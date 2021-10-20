//
//  GameScene.swift
//  ControllerTest
//
//  Created by Julio Cesar Guzman Villanueva on 9/22/21.
//

import SpriteKit
import GameplayKit
import GameController
import CoreGraphics

enum Ataques {
    case basico(AtaqueBasico)
    case noBasico(AtaqueNoBasico)
}

enum AtaqueBasico {
    case rayito
}

enum AtaqueNoBasico {
}

class GameScene: SKScene {

    var player: SKSpriteNode?
    var enemigos: [SKSpriteNode] = []
    
    override func sceneDidLoad() {
        self.physicsWorld.gravity = .zero
        self.player = self.childNode(withName: "player") as? SKSpriteNode
        (1...100).forEach { _ in
            let node = SKSpriteNode(imageNamed: "player")
            enemigos.append(node)
            let x = Int.random(in: 0...1000)
            let y = Int.random(in: 0...1000)
            node.position = CGPoint(x: x, y: y)
            node.scale(to: .init(width: 5, height: 5))
            addChild(node)
        }
        
        let cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        player?.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cameraNode)
        camera = cameraNode
    }
    
    var padDirection: CGVector = .zero
    var playerVelocity: CGVector {
        return .init(dx: padDirection.dx * 10.0, dy: padDirection.dy * 10.0)
    }
    var bulletVelocity: CGVector {
        return .init(dx: playerVelocity.dx * 10.0, dy: playerVelocity.dy * 10)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.player?.run(SKAction.move(by: playerVelocity, duration: 0))
        self.camera?.run(SKAction.move(by: playerVelocity, duration: 0))
    }
    
    func buttonA(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void {
        let bullet = SKSpriteNode.init(imageNamed: "player")
        self.addChild(bullet)
        bullet.position = player!.position
        bullet.physicsBody = .init(circleOfRadius: 10)
        bullet.physicsBody?.applyForce(bulletVelocity)
        bullet.scale(to: .init(width: 10, height: 10))
    }
    
    func thumbStick(_ pad: GCControllerDirectionPad, x: Float, y: Float) -> Void {
        padDirection = CGVector(dx: Double(x), dy: Double(y))
    }
}
