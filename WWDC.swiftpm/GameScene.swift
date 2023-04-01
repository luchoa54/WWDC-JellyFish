//
//  GameScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 31/03/23.
//

import Foundation
import SpriteKit
import UIKit

class GameScene: SKScene {
    
    let player: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
    let enemy: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 300, height: 300))
    var speedConstant: CGFloat = 1.2
    var systemTime : CFTimeInterval = 1.0
    var playerLane = 0
    var numberOfWaves = 20
    
    override func didMove(to view: SKView) {
        setupGame()
        addSwipeGestureRecognizer()
        
        objectSpawner()
    }
    
    func setupGame(){
        
        player.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 100)
        player.fillColor = .blue
        player.strokeColor = .blue
        player.zPosition = 1
        
        enemy.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 400)
        enemy.fillColor = .red
        enemy.strokeColor = .red
        enemy.zPosition = 0
        
        self.addChild(enemy)
        self.addChild(player)
    }
    
    func addSwipeGestureRecognizer(){
        let gestureDirection: [UISwipeGestureRecognizer.Direction] = [.left, .right]
        
        for gestureDirection in gestureDirection {
            let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gestureRecognizer.direction = gestureDirection
            self.view?.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func objectSpawner(){
        
        let positionIndex = Int.random(in: 0...2)
        let objectXPosition = [512, 812, 212]
        
        let target = ObstacleNode(position: CGPoint(x: Double(objectXPosition[positionIndex]), y: UIScreen.main.bounds.midY))
        
        self.addChild(target)
        
        target.run(SKAction.move(to: CGPoint(x: Double(objectXPosition[positionIndex]), y: 1000), duration: 8))
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer){
        if let gesture = gesture as? UISwipeGestureRecognizer {
            switch gesture.direction {
            case .left:
                if playerLane > -1{
                    player.run(
                        SKAction.moveTo(x: player.position.x - 300, duration: 0.3)
                    )
                    playerLane -= 1
                }
                print(player.position.x)
            case .right:
                if playerLane < 1{
                    player.run(
                        SKAction.moveTo(x: player.position.x + 300, duration: 0.3)
                    )
                    playerLane += 1
                }
            default:
                print("No gesture")
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
