//
//  AboutScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 05/04/23.
//

import Foundation
import SpriteKit

class AboutScene: SKScene {
    
    class func newScene() -> AboutScene {
        let scene = AboutScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var returnButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowLeft) { [weak self] in
            self?.view?.presentScene(MainMenuScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX - 400, y: UIScreen.main.bounds.midY + 550)
        
        button.zPosition = 1
        
        return button
    }()
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        addChild(returnButton)
    }
    
}
