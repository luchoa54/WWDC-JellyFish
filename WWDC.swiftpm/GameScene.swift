//
//  GameScene.swift
//  WWDC
//
//  Created by Luciano Uchoa on 31/03/23.
//

import Foundation
import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    class func newScene() -> GameScene {
        let scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    let player: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
    let enemy = JellyNode()
    let oceanNode = SKShapeNode(rectOf: CGSize(width: 1100, height: 1100))
    let collisionNode = SKShapeNode(rectOf: CGSize(width: 800, height: 100))
    
    var distanceToBeach : Int = 150
    var distanceCount = Timer()
    var playerLane = 0
    var obstacleSpawns = 1
    var gameVelocity = 5.0
    var timeVelocity = 0.5
    
    override func didMove(to view: SKView) {
        setupGame()
        addSwipeGestureRecognizer()
    }
    
    func setupGame(){
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        backgroundColor = .white
        
        createOcean()
        createPlayer()
        createJellyFish()
        createObstacle()
        createCollisionWall()
        addChild(distanceLabel)
        addChild(distanceLabel1)
        startDistanceCount()
    }
    
    func addSwipeGestureRecognizer(){
        let gestureDirection: [UISwipeGestureRecognizer.Direction] = [.left, .right]
        
        for gestureDirection in gestureDirection {
            let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gestureRecognizer.direction = gestureDirection
            self.view?.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    lazy var distanceLabel: SKLabelNode = {
        let label = SKLabelNode(text: "\(distanceToBeach)")
        
        let cfURL = Bundle.main.url(forResource: "ShortStack", withExtension: "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        label.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 650)
        label.fontColor = .black
        label.horizontalAlignmentMode = .center
        label.fontSize = 50
        label.numberOfLines = 2
        label.fontName = "ShortStack"
        label.zPosition = 2
        
        return label
    }()
    
    lazy var distanceLabel1: SKLabelNode = {
        let label = SKLabelNode(text: "Distance to beach: ")
        
        let cfURL = Bundle.main.url(forResource: "ShortStack", withExtension: "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        label.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 600)
        label.fontColor = .black
        label.horizontalAlignmentMode = .center
        label.fontSize = 50
        label.numberOfLines = 2
        label.fontName = "ShortStack"
        label.zPosition = 2
        
        return label
    }()
    
    func createOcean(){
        
        oceanNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 250)
        oceanNode.fillColor = .blue
        oceanNode.strokeColor = .blue
        oceanNode.zPosition = 1
        
        addChild(oceanNode)
    }
    
    func createJellyFish(){
        
        let sequence = SKAction.sequence([.moveBy(x: 0, y: 10, duration: 1), .moveBy(x: 0, y: -10, duration: 1)])
        enemy.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 500)
        enemy.run(.repeatForever(sequence))
        enemy.zPosition = 0
        
        addChild(enemy)
    }
    
    func createPlayer(){
        
        player.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 200)
        player.fillColor = .green
        player.strokeColor = .green
        player.zPosition = 2
        
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        body.categoryBitMask = .player
        body.collisionBitMask = ~(.contactWithAllCategories(less: [.player, .wall]))
        body.contactTestBitMask = ~(.contactWithAllCategories(less:[.obstacle, .player, .wall]))
        body.affectedByGravity = false
        
        player.physicsBody = body
        
        addChild(player)
    }
    
    func createCollisionWall(){
        
        collisionNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 760)
        collisionNode.fillColor = .yellow
        collisionNode.zPosition = 6
        
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100), center: CGPoint(x: 0, y: -150))
        body.categoryBitMask = .wall
        body.collisionBitMask = ~(.contactWithAllCategories(less: [.player, .wall]))
        body.contactTestBitMask = ~(.contactWithAllCategories(less:[.obstacle, .player, .wall]))
        body.affectedByGravity = false
        
        collisionNode.physicsBody = body
        
        addChild(collisionNode)
    }
    
    func createObstacle(){
        
        for _ in 1...obstacleSpawns{
            let obstacleX: [Double] = [212.0, 512.0, 812,0]
            let randomIndex = Int.random(in: 0...2)
            let obstacle = ObstacleNode()
            let warning = SKSpriteNode(imageNamed: "warning")
            
            obstacle.position = CGPoint(x: -20, y: 0)
            warning.position = CGPoint(x: obstacleX[randomIndex], y: 1000)
            warning.size = CGSize(width: 200, height: 200)
            warning.zPosition = 5
            
            let sequence = SKAction.sequence([.fadeIn(withDuration: 0.5),.fadeOut(withDuration: 0.5), .fadeIn(withDuration: 0.5), .fadeOut(withDuration: 0.5), .fadeIn(withDuration: 0.5),.fadeOut(withDuration: 0.5), .wait(forDuration: 0.5)])
            
            addChild(obstacle)
            addChild(warning)
            
            warning.run(sequence, completion: {
                warning.removeFromParent()
                obstacle.run(.move(by: CGVector(dx: obstacleX[randomIndex], dy: 1000), duration: 0))
                obstacle.run(.move(to: CGPoint(x: obstacleX[randomIndex], y: -100), duration: self.gameVelocity))
                obstacle.run(.resize(toWidth: 200, duration: 0.7))
                obstacle.run(.resize(toHeight: 200, duration: 0.7))
            })
        }
        
        run(.wait(forDuration: TimeInterval.random(in: gameVelocity...(gameVelocity + 0.5)))) {
            [self] in
            createObstacle()
        }
    }
    
    func startDistanceCount(){
        distanceCount = Timer.scheduledTimer(timeInterval: timeVelocity, target: self, selector: #selector(decrementDistance), userInfo: nil, repeats: true)
    }
    
    @objc func decrementDistance(){
        distanceToBeach -= 1
        distanceLabel.text = "\(distanceToBeach)"
        
        if distanceToBeach == 130 {
            gameVelocity -= 1
            timeVelocity -= 0.1
        }
        
        if distanceToBeach == 90 {
            obstacleSpawns += 1
            gameVelocity -= 1
            timeVelocity -= 0.2
        }
        
        if distanceToBeach <= 0 {
            view?.presentScene(VictoryScene.newScene())
        }
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        testContactObstacleWithWall(contactMask,contact: contact)
        testContactPlayerWithObstacle(contactMask, contact: contact)
    }
    
    public func testContactObstacleWithWall(_ contactMaks:UInt32, contact: SKPhysicsContact) {
        if contactMaks == .obstacle | .wall {
            contact.bodyB.node?.removeFromParent()

        }
    }
    
    public func testContactPlayerWithObstacle(_ contactMaks:UInt32, contact: SKPhysicsContact) {
        if contactMaks == .player | .obstacle {
            view?.presentScene(GameOverScene.newScene())
        }
    }
}
