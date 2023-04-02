//
//  ObstacleNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 01/04/23.
//

import Foundation
import SpriteKit

class ObstacleNode: SKSpriteNode{
    
    let spriteTextures = [
        SKTexture(imageNamed: "Untitled"),
        SKTexture(imageNamed: "Untitled"),
        SKTexture(imageNamed: "Untitled"),
    ]
    
    init() {
        let randomSprite = Int.random(in: 0...spriteTextures.count - 1)
        let spriteTexture = spriteTextures[randomSprite]
        
        super.init(texture: spriteTexture, color: .clear, size: CGSize(width: 200, height: 200))
        
        zPosition = 3
        
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class JellyNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Untitled")
        super.init(texture: texture, color: .clear, size: CGSize(width: 650, height: 650))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

