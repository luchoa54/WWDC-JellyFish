//
//  UInt32+BitMasks.swift
//  WWDC
//
//  Created by Luciano Uchoa on 03/04/23.
//

import Foundation

extension UInt32 {
    static let base: UInt32 = 0b1
    static let player = UInt32.base << 0
    static let jelly = UInt32.base << 1
    static let obstacle = UInt32.base << 2
    static let wall = UInt32.base << 3
    
    static let allMasks: [UInt32] = [
        .player,
        .jelly,
        .obstacle,
        .wall
    ]
    
    static func contactWithAllCategories(less: [UInt32] = []) -> UInt32 {
        var result: UInt32 = 0b00
        
        for category in UInt32.allMasks {
            if !less.contains(category) {
                result |= category
            }
        }
        
        return result
    }
}
