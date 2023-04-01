//
//  ObstacleNode.swift
//  WWDC
//
//  Created by Luciano Uchoa on 01/04/23.
//

import Foundation
import SpriteKit

enum ObstacleType {
    case log, rock, boat
    
    var color: UIColor{
        switch self{
        case .log:
            return .brown
        case .rock:
            return .systemGray
        case .boat:
            return .yellow
        }
    }
}

class ObstacleNode: SKShapeNode {
    
    var type = ObstacleType.rock
    var movingVector = CGPoint(x: 0, y: 0)
    
    init(position: CGPoint) {
        super.init()
        
        self.strokeColor = type.color
        self.fillColor = type.color
        self.position = position
        
        self.physicsBody!.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
