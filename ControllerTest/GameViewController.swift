//
//  GameViewController.swift
//  Videojuego
//
//  Created by Julio Cesar Guzman Villanueva on 9/7/21.
//

import UIKit
import SpriteKit
import GameplayKit
import GameController

class GameViewController: UIViewController {
    
    var gameScene: GameScene?

    private lazy var gameController : GCVirtualController = {
        var config = GameController.GCVirtualController.Configuration.init()
        config.elements = [
            GCInputButtonB,
            GCInputLeftThumbstick,
            GCInputRightThumbstick
        ]
        let gameController = GameController.GCVirtualController.init(configuration: config)
        gameController.connect { error in
            print(error as Any)
        }
        return gameController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                gameScene = sceneNode
                
                sceneNode.scaleMode = .aspectFill
                registerGameController(gameController)
                
                
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.presentScene(sceneNode)
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func registerGameController(_ gameController: GCVirtualController) {
        let buttonB = gameController.controller?.extendedGamepad?.buttonB
        let leftThumbstick = gameController.controller?.extendedGamepad?.leftThumbstick
        let rightThumbstick = gameController.controller?.extendedGamepad?.rightThumbstick
        buttonB?.valueChangedHandler = gameScene?.buttonB(_:_:_:)
        leftThumbstick?.valueChangedHandler = gameScene?.leftThumbstick(_:x:y:)
        rightThumbstick?.valueChangedHandler = gameScene?.rightThumbstick(_:x:y:)
        rightThumbstick?.down.pressedChangedHandler = gameScene?.rightThumbstickPressed(_:_:_:)
    }
    

}
