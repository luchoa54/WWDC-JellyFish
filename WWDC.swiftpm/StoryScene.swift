//
//  HistoryScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 05/04/23.
//

import Foundation
import SpriteKit

class StoryScene: SKScene {
    
    var storySession: [String] = [
        "It was a beautiful day for a swim in the sea, so Luciano and his family decided to go to the beach to relax",
        "Everything was going well, the waves were strangely calm , however during his bath, Luciano came across something unexpected...",
        "A giant Jellyfish appears in the middle of the open sea and begins to chase Luciano, who flees into his father's arms..."]
    var textures3: [SKTexture] = [
        SKTexture(imageNamed: "story6"),
        SKTexture(imageNamed: "story7"),
        SKTexture(imageNamed: "story8")
    ]
    
    var storyIndex = 0
    
    class func newScene() -> StoryScene {
        let scene = StoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var storyImage: SKShapeNode = {
        let shape = SKShapeNode(rectOf: CGSize(width: 950, height: 800), cornerRadius: 10)
        
        shape.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY + 230)
        shape.fillColor = .black
        
        return shape
    }()
    
    lazy var storyImage3: SKSpriteNode = {
        let texture : [SKTexture] = [
            SKTexture(imageNamed: "story6"),
            SKTexture(imageNamed: "story7"),
            SKTexture(imageNamed: "story8")
        ]
        
        let sprite = SKSpriteNode(texture: texture[0], size: CGSize(width: 950, height: 800))
        
        sprite.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY + 230)
        
        sprite.run(.repeatForever(.animate(with: texture, timePerFrame: 0.15)))
        return sprite
    }()
    
    lazy var storyBar : SKSpriteNode = {
        
        let texture : [SKTexture] = [
            SKTexture(imageNamed: "storyBar0"),
            SKTexture(imageNamed: "storyBar1"),
            SKTexture(imageNamed: "storyBar2")
        ]
        
        let sprite = SKSpriteNode(texture: texture[0], size: CGSize(width: 1000, height: 300))
        
        sprite.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY - 350)
        
        sprite.run(.repeatForever(.animate(with: texture, timePerFrame: 0.15)))
        return sprite
    }()
    
    
    lazy var storyLabel : SKLabelNode = {
        let label = SKLabelNode(text: "\(storySession[storyIndex])")
        
        let cfURL = Bundle.main.url( forResource: "ShortStack", withExtension:
        "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        label.fontSize = 36
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 170
        label.fontName = "ShortStack"
        label.position = CGPoint(x: 0, y: 0)
        label.fontColor = .black
        
        return label
    }()
    
    lazy var rightArrow: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowRight) { [weak self] in
            self?.storyIndex += 1
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX, y:UIScreen.main.bounds.midY - 550)
        
        button.zPosition = 1
        
        return button
    }()
    
    lazy var nextSceneButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .play) { [weak self] in
            self?.view?.presentScene(GameScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX, y:UIScreen.main.bounds.midY - 550)
        
        button.zPosition = 1
        button.isHidden = true
        
        return button
    }()
    
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        addChild(storyBar)
        storyBar.addChild(storyLabel)
        addChild(rightArrow)
        addChild(nextSceneButton)
        addChild(storyImage3)
        addChild(storyImage)
        
        storyImage3.isHidden = true
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if storyIndex < 3{
            storyLabel.text = "\(storySession[storyIndex])"
        }
        
        if storyIndex == 2 {
            rightArrow.isHidden = true
            nextSceneButton.isHidden = false
            storyImage.removeFromParent()
            storyImage3.isHidden = false
        }else {
            rightArrow.isHidden = false
            nextSceneButton.isHidden = true
        }
    }
}
