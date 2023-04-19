//
//  AboutScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 05/04/23.
//

import Foundation
import SpriteKit

class AboutScene: SKScene {
    
    let aboutBackgroundWidht: CGFloat = UIScreen.main.bounds.width - 90
    
    class func newScene() -> AboutScene {
        let scene = AboutScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var aboutBackground : SKSpriteNode = {
        
        let imageNames = ["aboutBackground0", "aboutBackground1", "aboutBackground2"]
        let backgroundTexture = [SKTexture].loadTextures(from: imageNames)
        
        let shape = SKSpriteNode(texture: backgroundTexture[0], size: CGSize(width: UIScreen.main.bounds.width - 90, height: UIScreen.main.bounds.height - 250))
        
        shape.run(.doodleEffect(with: backgroundTexture))
        shape.position = CGPoint(x: size.width / 2, y: (size.height / 2) - 80)
        shape.texture?.filteringMode = .nearest
        return shape
    }()
    
    lazy var photoNode: SKShapeNode = {
        let shape = SKShapeNode(rectOf: CGSize(width: 180, height: 180))
        
        shape.position = CGPoint(x: 180, y: 1000)
        shape.strokeColor = .black
        shape.lineWidth = 5
        
        return shape
    }()
    
    lazy var photoTexture : SKSpriteNode = {
        let sprite = SKSpriteNode(texture: SKTexture(imageNamed: "appCreator"), color: .clear, size:  CGSize(width: 180, height: 180))
        
        sprite.position = CGPoint(x: 0, y: 0)
        
        return sprite
    }()
    
    lazy var returnButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowRight) { [weak self] in
            self?.view?.presentScene(MainMenuScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX - 400, y: UIScreen.main.bounds.midY + 570)
        button.xScale = -1
        button.zPosition = 1
        
        return button
    }()
    
    lazy var nameLabel: SKLabelNode = {
        let label = SKLabelNode(text: "Hey! I'm Luciano, a software engineering student :)")
        
        let cfURL = Bundle.main.url( forResource: "ShortStack", withExtension:
                                        "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        
        label.fontSize = 50
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 360
        label.fontName = "ShortStack"
        label.position = CGPoint(x: 600, y: 1000)
        label.fontColor = .black
        
        return label
    }()
    
    lazy var textLabel1: SKLabelNode = {
        let label = SKLabelNode(text: "Thank you for experiencing this adventure together with me!")
        
        let cfURL = Bundle.main.url( forResource: "ShortStack", withExtension:
                                        "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        
        label.fontSize = 25
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 160
        label.fontName = "ShortStack"
        label.position = CGPoint(x: aboutBackgroundWidht / 12.5, y: 800)
        label.fontColor = .black
        
        return label
    }()
    
    lazy var textLabel2: SKLabelNode = {
        let label = SKLabelNode(text: "Have you ever managed to make the best of a bad event?       I had the exact same experience while having a family conversation.  I related the incident of my trip to Maceió, where I got severely burned by a bunch of jellyfish. But instead of focusing on the bad, my niece was motivated to sketch a picture based on the narrative. The magic took place there, in that case. Together, we brought the drawing to life, transforming a difficult experience into a lovely and motivational project. This experience has shown me the value of teamwork and the limitless potential of creativity. I hope it motivates you as well!")
        
        let cfURL = Bundle.main.url( forResource: "ShortStack", withExtension:
                                        "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        
        label.fontSize = 25
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 160
        label.fontName = "ShortStack"
        label.position = CGPoint(x: aboutBackgroundWidht / 12.5, y: 580)
        label.fontColor = .black
        
        return label
    }()
    
    lazy var textLabel3: SKLabelNode = {
        let label = SKLabelNode(text: "Use your skill and agility to safely escape the JellyFish Queen, dodging its attacks by swiping left or right with your finger.")
        
        let cfURL = Bundle.main.url( forResource: "ShortStack", withExtension:
                                        "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        
        label.fontSize = 25
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 160
        label.fontName = "ShortStack"
        label.position = CGPoint(x: aboutBackgroundWidht / 12.5, y: 320)
        label.fontColor = .black
        
        return label
    }()
    
    lazy var textLabel4: SKLabelNode = {
        let label = SKLabelNode(text: "I hope you enjoyed it, and that I did my niece Clarinha's artistic skills justice! :)")
        
        let cfURL = Bundle.main.url( forResource: "ShortStack", withExtension:
                                        "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        
        label.fontSize = 25
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 160
        label.fontName = "ShortStack"
        label.position = CGPoint(x: aboutBackgroundWidht / 12.5, y: 220)
        label.fontColor = .black
        
        return label
    }()
    
    func setupScene(){
        addChild(returnButton)
        addChild(aboutBackground)
        addChild(photoNode)
        photoNode.addChild(photoTexture)
        addChild(nameLabel)
        addChild(textLabel1)
        addChild(textLabel2)
        addChild(textLabel3)
        addChild(textLabel4)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        setupScene()
    }
    
    
}
