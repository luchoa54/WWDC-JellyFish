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
    
    lazy var aboutBackground : SKShapeNode = {
        let shape = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 300), cornerRadius: 20)
        
        shape.fillColor = .black
        shape.position = CGPoint(x: size.width / 2, y: (size.height / 2) - 80)
        
        return shape
    }()
    
    lazy var returnButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowRight) { [weak self] in
            self?.view?.presentScene(MainMenuScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX - 400, y: UIScreen.main.bounds.midY + 550)
        button.xScale = -1
        button.zPosition = 1
        
        return button
    }()
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        addChild(returnButton)
        addChild(aboutBackground)
    }
    
}
