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
    let enemy = JellyNode()
    let oceanNode = SKShapeNode(rectOf: CGSize(width: 1100, height: 1100))
    let collisionNode = SKShapeNode(rectOf: CGSize(width: 1100, height: 5))
    var obstacleInScene: [ObstacleNode] = []
    var speedConstant: CGFloat = 1.2
    var systemTime : CFTimeInterval = 1.0
    var playerLane = 0
    var numberOfWaves = 20
    
    override func didMove(to view: SKView) {
        setupGame()
        addSwipeGestureRecognizer()
        
    }
    
    func setupGame(){
        
        player.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 100)
        player.fillColor = .green
        player.strokeColor = .green
        player.zPosition = 2
        print(UIScreen.main.bounds.midX)
        
        oceanNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 250)
        oceanNode.fillColor = .blue
        oceanNode.strokeColor = .blue
        oceanNode.zPosition = 1
        
        let sequence = SKAction.sequence([.moveBy(x: 0, y: 10, duration: 1), .moveBy(x: 0, y: -10, duration: 1)])
        enemy.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 500)
        enemy.run(.repeatForever(sequence))
        enemy.zPosition = 0
        
        collisionNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 300)
        collisionNode.strokeColor = .clear
        collisionNode.zPosition = 2
        
        self.addChild(enemy)
        self.addChild(oceanNode)
        self.addChild(collisionNode)
        self.addChild(player)
        
        createObstacle()
    }
    
    func addSwipeGestureRecognizer(){
        let gestureDirection: [UISwipeGestureRecognizer.Direction] = [.left, .right]
        
        for gestureDirection in gestureDirection {
            let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gestureRecognizer.direction = gestureDirection
            self.view?.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func createObstacle(){
        
        let obstacleX: [Double] = [212.0, 512.0, 812,0]
        let randomIndex = Int.random(in: 0...2)
        let obstacle = ObstacleNode()
        obstacle.position = CGPoint(x: 0, y: 0)
        obstacle.run(.move(by: CGVector(dx: obstacleX[randomIndex], dy: 0), duration: 0))
        obstacle.run(.move(to: CGPoint(x: obstacleX[randomIndex], y: 1300), duration: 3))
        
//        addChild(obstacle)
//        
//        run(.wait(forDuration: TimeInterval.random(in: 2...2.5))) {
//            [self] in
//            createObstacle()
//        }
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
        for obstacle in obstacleInScene {
            if obstacle.position.y > 1200 {
                self.removeFromParent()
            }
        }
    }
}
