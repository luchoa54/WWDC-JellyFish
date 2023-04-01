//
//  MenuScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 31/03/23.
//

import Foundation
import SpriteKit

class MenuScene : SKScene {
    
    var systemTime : CFTimeInterval = 1.0
    
    override func didMove(to view: SKView) {
        setupMenu()
    }
    
    
    func setupScene(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.systemTime = currentTime
    }
    
    func setupMenu(){
        
    }
}
