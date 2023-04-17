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
    
    var currentStoryImageIndex = 0
    
    class func newScene() -> StoryScene {
        let scene = StoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var storyImage1: SKSpriteNode = {
        
        let imageNames = ["story0", "story1", "story2"]
        
        let texture = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: texture[0], size: CGSize(width: 950, height: 800))
        
        sprite.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY + 230)
        
        sprite.run(.repeatForever(.animate(with: texture, timePerFrame: 0.15)))
        return sprite
    }()
    
    lazy var storyImage2: SKSpriteNode = {
        
        let imageNames = ["story3", "story4", "story5"]
        
        let texture = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: texture[0], size: CGSize(width: 950, height: 800))
        
        sprite.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY + 230)
        
        sprite.run(.repeatForever(.animate(with: texture, timePerFrame: 0.15)))
        
        sprite.isHidden = true
        
        return sprite
    }()
    
    lazy var storyImage3: SKSpriteNode = {
        
        let imageNames = ["story6", "story7", "story8"]
        
        let texture = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: texture[0], size: CGSize(width: 950, height: 800))
        
        sprite.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY + 230)
        
        sprite.run(.repeatForever(.animate(with: texture, timePerFrame: 0.15)))
        
        sprite.isHidden = true
        
        return sprite
    }()
    
    lazy var storyChatBoxNode : SKSpriteNode = {
        
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
    
    lazy var storyTextLabel : SKLabelNode = {
        let label = SKLabelNode(text: "\(storySession[currentStoryImageIndex])")
        
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
    
    lazy var rightArrowButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowRight) { [weak self] in
            self?.currentStoryImageIndex += 1
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
    
    lazy var musicNode: SKAudioNode = {
        let music = SKAudioNode(fileNamed: "mistery")
        music.autoplayLooped = false
        
        return music
    }()
    
    override func didMove(to view: SKView) {
        
        setupScene()
    }
    
    func setupScene() {
        backgroundColor = .white
        
        addChild(storyChatBoxNode)
        storyChatBoxNode.addChild(storyTextLabel)
        addChild(rightArrowButton)
        addChild(nextSceneButton)
        addChild(storyImage1)
        addChild(storyImage2)
        addChild(storyImage3)
        addChild(musicNode)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if currentStoryImageIndex < 3{
            storyTextLabel.text = "\(storySession[currentStoryImageIndex])"
        }
        
        switch currentStoryImageIndex {
        case 1:
            storyImage1.removeFromParent()
            storyImage2.isHidden = false
        case 2:
            storyImage3.isHidden = false
            storyImage2.removeFromParent()
            rightArrowButton.removeFromParent()
            nextSceneButton.isHidden = false
        default:
            break
        }
        
    }
}
