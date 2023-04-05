//
//  MainMenuScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 04/04/23.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    class func newScene() -> MainMenuScene {
        let scene = MainMenuScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var backgroundImage: SKSpriteNode = {
        let backgroundTexture: [SKTexture] = [
            SKTexture(imageNamed: "background0"),
            SKTexture(imageNamed: "background1"),
            SKTexture(imageNamed: "background2"),
        ]
        let sprite = SKSpriteNode(texture: backgroundTexture[0], size: backgroundTexture[0].size())
        
        sprite.run(.repeatForever(.animate(with: backgroundTexture, timePerFrame: 0.1)))
        sprite.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return sprite
    }()
    
    lazy var playButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .play) { [weak self] in
            self?.view?.presentScene(GameScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX - 20, y: UIScreen.main.bounds.midY - 90)
        
        button.zPosition = 1
        
        return button
    }()
    
    lazy var aboutButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .about) { [weak self] in
            self?.view?.presentScene(AboutScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX - 20, y: UIScreen.main.bounds.midY - 250)
        button.size = CGSize(width: 300, height: 300)
        button.zPosition = 1
        
        return button
    }()
    
    func setupScene(){
        view?.ignoresSiblingOrder = false
        
        addChild(backgroundImage)
        addChild(playButton)
        addChild(aboutButton)
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
}
