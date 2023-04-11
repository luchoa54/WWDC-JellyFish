//
//  PlayerNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 11/04/23.
//

import Foundation
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    let textures : [SKTexture] = [
        SKTexture(imageNamed: "player0"),
        SKTexture(imageNamed: "player1"),
        SKTexture(imageNamed: "player2")
    ]
    
    init(){
        super.init(texture: textures[0], color: .clear, size: textures[0].size())
        
        let sequence = SKAction.sequence([
            .animate(with: textures, timePerFrame: 0.1),
            .run {self.xScale = -1},
            .animate(with: textures, timePerFrame: 0.1),
            .run {self.xScale = 1}])
        
        run(.repeatForever(sequence))
        
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        body.categoryBitMask = .player
        body.collisionBitMask = ~(.contactWithAllCategories(less: [.player, .wall]))
        body.contactTestBitMask = ~(.contactWithAllCategories(less: [.obstacle, .player, .wall]))
        body.affectedByGravity = false
        
        physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
