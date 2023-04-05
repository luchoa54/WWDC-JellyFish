//
//  HistoryScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 05/04/23.
//

import Foundation
import SpriteKit

class HistoryScene: SKScene {
    
    class func newScene() -> HistoryScene {
        let scene = HistoryScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
//    lazy var player: SKSpriteNode = {
//        let sprite = SKSpriteNode(imageNamed: "")
//    }()
    
}
