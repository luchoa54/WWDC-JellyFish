//
//  JellyNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 03/04/23.
//

import Foundation
import SpriteKit

class JellyNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "Jelly")
        super.init(texture: texture, color: .clear, size: CGSize(width: 650, height: 650))
        
        name = "Jelly"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100), center: CGPoint(x: 0, y: -150))
        physicsBody?.categoryBitMask = .jelly
        physicsBody?.collisionBitMask = ~(.contactWithAllCategories(less: [.player, .wall]))
        physicsBody?.contactTestBitMask = ~(.contactWithAllCategories(less:[.obstacle, .player,.wall]))
        physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
