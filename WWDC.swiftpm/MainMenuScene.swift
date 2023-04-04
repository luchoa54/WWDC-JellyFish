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
    
    lazy var titleLabel: SKLabelNode = {
        let label = SKLabelNode(text: "JellyFish \n Attack")
        
        let cfURL = Bundle.main.url(forResource: "ShortStack", withExtension: "ttf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

        
        label.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 150)
        label.fontColor = .black
        label.fontSize = 100
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
    
    lazy var playButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 2)
        let button = ButtonNode(buttonTexture: "playButton") { [weak self] in
            self?.view?.presentScene(GameScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 150)
        button.size = CGSize(width: 100, height: 100)
        button.zPosition = 1
        
        return button
    }()
    
    func setupScene(){
        view?.ignoresSiblingOrder = true
        backgroundColor = .white
        
        addChild(titleLabel)
        addChild(playButton)
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
}
