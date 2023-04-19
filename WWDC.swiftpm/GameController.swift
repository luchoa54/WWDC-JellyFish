//
//  GameController.swift
//  WWDC
//
//  Created by Luciano Uchoa on 04/04/23.
//

import Foundation

class GameController {
    
    static var shared: GameController = {
        return GameController()
    }()
    
    var initialScene: MainMenuScene {
        .newScene()
    }
    
    var lastObstacleIndex: Int = 0
}
