//
//  HistoryScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 05/04/23.
//

import Foundation
import SpriteKit

class StoryScene: SKScene {
    
    var storySession: [String] = ["Parte1", "Parte2", "Parte3"]
    var storyIndex = 0
    
    class func newScene() -> StoryScene {
        let scene = StoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    lazy var storyBar : SKShapeNode = {
        let shape = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 100, height: 200), cornerRadius: 10)
        
        shape.fillColor = .black
        shape.strokeColor = .black
        shape.position = CGPoint(x: size.width / 2, y: UIScreen.main.bounds.midY - 350)
        return shape
    }()
    
    lazy var storyLabel : SKLabelNode = {
        let label = SKLabelNode(text: "\(storySession[storyIndex])")
        
        label.fontSize = 20
        label.fontName = "ShortStack"
        label.position = CGPoint(x: 0, y: 0)
        label.fontColor = .white
        
        return label
    }()
    
    lazy var leftArrow: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowLeft) { [weak self] in
            self?.storyIndex -= 1
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX - 200, y: UIScreen.main.bounds.midY - 550)
        
        button.zPosition = 1
        button.isHidden = true
        
        return button
    }()
    
    lazy var rightArrow: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .arrowRight) { [weak self] in
            self?.storyIndex += 1
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX + 200, y:UIScreen.main.bounds.midY - 550)
        
        button.zPosition = 1
        
        return button
    }()
    
    lazy var nextSceneButton: ButtonNode = {
        let transition = SKTransition.crossFade(withDuration: 0.5)
        let button = ButtonNode(buttonType: .about) { [weak self] in
            self?.view?.presentScene(GameScene.newScene(), transition: transition)
        }
        
        button.position = CGPoint(x: UIScreen.main.bounds.midX + 200, y:UIScreen.main.bounds.midY - 550)
        
        button.zPosition = 1
        button.isHidden = true
        
        return button
    }()
    
    //    lazy var player: SKSpriteNode = {
    //        let sprite = SKSpriteNode(imageNamed: "")
    //    }()
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        addChild(storyBar)
        storyBar.addChild(storyLabel)
        addChild(leftArrow)
        addChild(rightArrow)
        addChild(nextSceneButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if storyIndex > 0 {
            leftArrow.isHidden = false
        }else {
            leftArrow.isHidden = true
        }
        
        if storyIndex < 3{
            storyLabel.text = "\(storySession[storyIndex])"
        }
        
        if storyIndex == 2 {
            rightArrow.isHidden = true
            nextSceneButton.isHidden = false
        }else {
            rightArrow.isHidden = false
            nextSceneButton.isHidden = true
        }
    }
}
