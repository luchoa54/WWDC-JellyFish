//
//  JellyNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 03/04/23.
//

import Foundation
import SpriteKit

class JellyNode: SKSpriteNode {
    
    let imageNames = ["Jelly0", "Jelly1", "Jelly2"]
    
    init() {
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        super.init(texture: textures[0], color: .clear, size: CGSize(width: 650, height: 650))
        
        name = "Jelly"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100), center: CGPoint(x: 0, y: -150))
        physicsBody?.categoryBitMask = .jelly
        physicsBody?.collisionBitMask = ~(.contactWithAllCategories(less: [.player, .wall]))
        physicsBody?.contactTestBitMask = ~(.contactWithAllCategories(less:[.obstacle, .player,.wall]))
        physicsBody?.affectedByGravity = false
        
        run(.repeatForever(.animate(with: textures, timePerFrame: 0.1)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
