//
//  GameOverScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 04/04/23.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    class func newScene() -> GameOverScene {
        let scene = GameOverScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var endLabel: SKLabelNode = {
        let label = SKLabelNode(text: "     You failed to escape the \ntentacles of the Jellyfish Queen")
        
        let cfURL = Bundle.main.url(forResource: "ShortStack", withExtension: "ttf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        label.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY - 200)
//        label.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 250)
        label.fontColor = .black
        label.horizontalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.fontSize = 50
        label.numberOfLines = 2
        label.fontName = "ShortStack"
        label.zPosition = 2
        
        return label
    }()
    
    lazy var backgroundImage: SKSpriteNode = {
        let texture = SKTexture(imageNamed: "beach")
        texture.filteringMode = .linear
        let sprite = SKSpriteNode(texture: texture, color: .clear, size: UIScreen.main.bounds.size)
        
        sprite.zPosition = 0
        sprite.position = CGPoint(x: size.width/2, y: size.height/2)
        
        return sprite
    }()
    
    lazy var backToMenuButton: ButtonNode = {
        let button = ButtonNode(buttonType: .menu) { [weak self] in
            self?.view?.presentScene(MainMenuScene.newScene())
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 500)
        button.zPosition = 1
        
        return button
    }()
    
    lazy var retryButton: ButtonNode = {
        let button = ButtonNode(buttonType: .playAgain) { [weak self] in
            self?.view?.presentScene(GameScene.newScene())
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 330)
        button.zPosition = 1
        
        return button
    }()
    
    lazy var JellyfishNode: JellyNode = {
        
        let jellyNode = JellyNode()
        
//        jellyNode.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY)
        jellyNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 250)
        
        return jellyNode
    }()
    
    func setupScene(){
        view?.ignoresSiblingOrder = true
        backgroundColor = .white
        
        addChild(endLabel)
        addChild(retryButton)
        addChild(backToMenuButton)
        addChild(JellyfishNode)
        
        run(.playSoundFileNamed("lose", waitForCompletion: false))
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
}
