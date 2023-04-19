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
        SKTexture(imageNamed: "strike0"),
        SKTexture(imageNamed: "strike1"),
        SKTexture(imageNamed: "strike2"),
    ]
    
    init() {
//        let randomSprite = Int.random(in: 0...spriteTextures.count - 1)
//        let spriteTexture = spriteTextures[randomSprite]
        
        super.init(texture: spriteTextures[0], color: .clear, size: CGSize(width: 10, height: 10))
        
        run(.repeatForever(.animate(with: spriteTextures, timePerFrame: 0.15)))
        zPosition = 3
        
        name = "Obstacle"
        
        physicsBody = SKPhysicsBody(texture: spriteTextures[0], size: CGSize(width: 100, height: 200))
        physicsBody?.categoryBitMask = .obstacle
        physicsBody?.collisionBitMask = ~(.contactWithAllCategories())
        physicsBody?.contactTestBitMask = ~(.contactWithAllCategories(less:[.obstacle, .player,.wall]))
        physicsBody?.affectedByGravity = false
        
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


