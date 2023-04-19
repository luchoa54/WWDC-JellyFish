//
//  SKAction+Animation.swift
//  WWDC
//
//  Created by Luciano Uchoa on 12/04/23.
//

import Foundation
import SpriteKit

extension SKAction {
    static func doodleEffect(with texture: [SKTexture]) -> SKAction {
        return .repeatForever(.animate(with: texture, timePerFrame: 0.15))
    }
}

