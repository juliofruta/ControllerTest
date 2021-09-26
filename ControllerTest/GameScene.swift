//
//  GameScene.swift
//  ControllerTest
//
//  Created by Julio Cesar Guzman Villanueva on 9/22/21.
//

import SpriteKit
import GameplayKit
import GameController

class GameScene: SKScene {

    var player: SKSpriteNode?
    override func sceneDidLoad() {
        self.player = self.childNode(withName: "player") as? SKSpriteNode
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func buttonA(_ button: GCControllerButtonInput, _ value: Float, _ pressed: Bool) -> Void {
        return
    }
    
    func thumbStick(_ pad: GCControllerDirectionPad, x: Float, y: Float) -> Void {
        
        self.player?.run(
            SKAction.run {
                self.player?.position.x = CGFloat(x) + self.player!.position.x
                self.player?.position.y = CGFloat(y) + self.player!.position.y
            }
        )
        
        return
    }
}
