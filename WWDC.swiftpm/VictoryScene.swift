//
//  VictoryScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 06/04/23.
//

import Foundation
import SpriteKit

class VictoryScene: SKScene {
    
    class func newScene() -> VictoryScene {
        let scene = VictoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var endLabel: SKLabelNode = {
        let label = SKLabelNode(text: "You escaped \n    safely!")
        
        let cfURL = Bundle.main.url(forResource: "ShortStack", withExtension: "ttf")! as CFURL

        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

        
        label.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 250)
        label.fontColor = .black
        label.horizontalAlignmentMode = .center
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
    
    lazy var backToMenuButton: ButtonNode = {
        let button = ButtonNode(buttonType: .menu) { [weak self] in
            self?.view?.presentScene(MainMenuScene.newScene())
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 330)
        button.zPosition = 1
        
        return button
    }()
    
    lazy var winNodePose: SKSpriteNode = {
        let imageNames = ["winBoy0", "winBoy1"]
        
        let texture = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: texture[0], size: CGSize(width: 400, height: 400))
        
        sprite.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY)
        
        sprite.run(.repeatForever(.animate(with: texture, timePerFrame: 0.15)))
        return sprite
    }()
    
    func setupScene(){
        view?.ignoresSiblingOrder = true
        backgroundColor = .white
        
        addChild(endLabel)
        addChild(backToMenuButton)
        addChild(winNodePose)
        
        run(.playSoundFileNamed("win", waitForCompletion: false))
        
//        Music by Hot_Music from Pixabay
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
}
