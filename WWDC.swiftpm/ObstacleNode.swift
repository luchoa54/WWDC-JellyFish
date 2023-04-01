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
        SKTexture(imageNamed: "Jelly(white)"),
        SKTexture(imageNamed: "Jelly(white)"),
        SKTexture(imageNamed: "Jelly(white)"),
    ]
    
    init() {
        let randomSprite = Int.random(in: 0...spriteTextures.count)
        let spriteTexture = spriteTextures[randomSprite]
        
        super.init(texture: spriteTexture, color: .clear, size: spriteTexture.size())
        
        zPosition = 3
        
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
