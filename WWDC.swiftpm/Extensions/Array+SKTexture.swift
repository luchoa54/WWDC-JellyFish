//
//  Array+SKTexture.swift
//  WWDC
//
//  Created by Luciano Uchoa on 12/04/23.
//

import Foundation
import SpriteKit

extension Array where Element == SKTexture {
    static func loadTextures(from imageNames: [String]) -> [SKTexture] {
        var textures = [SKTexture]()
        for imageName in imageNames {
            let texture = SKTexture(imageNamed: imageName)
            textures.append(texture)
        }
        return textures
    }
}
