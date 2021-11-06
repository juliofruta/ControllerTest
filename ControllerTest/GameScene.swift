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
    
    var leftPadDelta: CGVector = .zero
    var rightPadDelta: CGVector = .zero
    
    var rightPadDirection: CGVector {
        let magnitude = sqrt(rightPadDelta.dx * rightPadDelta.dx + rightPadDelta.dy * rightPadDelta.dy )
        return .init(dx: rightPadDelta.dx / magnitude, dy: rightPadDelta.dy / magnitude)
    }
    
    var playerVelocity: CGVector {
        return .init(dx: leftPadDelta.dx * 10.0, dy: leftPadDelta.dy * 10.0)
    }
    
    var bulletVelocity: CGVector {
        let magnitude = 500.0
        return .init(dx: rightPadDirection.dx * magnitude, dy: rightPadDirection.dy * magnitude)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.player?.run(SKAction.move(by: playerVelocity, duration: 0))
        self.camera?.run(SKAction.move(by: playerVelocity, duration: 0))
    }
    
    private func shoot() {
        let bullet = SKSpriteNode.init(imageNamed: "player")
        self.addChild(bullet)
        bullet.position = player!.position
        bullet.physicsBody = .init(circleOfRadius: 10)
        bullet.physicsBody?.applyForce(bulletVelocity)
        bullet.scale(to: .init(width: 10, height: 10))
    }
    
    func buttonB(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) {
        shoot()
    }
    
    func leftThumbstick(_ pad: GCControllerDirectionPad, x: Float, y: Float) {
        leftPadDelta = CGVector(dx: Double(x), dy: Double(y))
    }
    
    func rightThumbstick(_ pad: GCControllerDirectionPad, x: Float, y: Float) {
        rightPadDelta = CGVector(dx: Double(x), dy: Double(y))
        shoot()
    }
    
    
    
    
}
