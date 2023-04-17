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
    
    var distanceToBeach : Int = 100
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
        
        addChild(oceanNode)
        addChild(playerNode)
        addChild(JellyfishNode)
        addChild(collisionNode)
        addChild(distanceIndicator)
        addChild(distanceLabel)
        addChild(indicator)
        addChild(tutorialNode)
        addChild(backgroundJelly)
        addChild(musicNode)
        
        let startSpawn = SKAction.sequence([.wait(forDuration: 3), .run { [weak self] in
            self?.spawnObstacle()
        }])
        
        run(startSpawn)
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
    
    lazy var distanceIndicator: SKSpriteNode = {
        let imageNames = ["Distance0", "Distance1", "Distance2"]
        
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: textures[0], color: .clear, size: CGSize(width: 500, height: 500))
        
        sprite.position = CGPoint(x: UIScreen.main.bounds.minX + 180, y: UIScreen.main.bounds.midY - 100)
        sprite.zPosition = 10
        
        sprite.run(.doodleEffect(with: textures))
        
        return sprite
    }()
    
    lazy var indicator: SKSpriteNode = {
        
        let imageNames = ["indicator0", "indicator1", "indicator2"]
        
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: textures[0], size: CGSize(width: 60, height: 60))
        
        sprite.position = CGPoint(x: UIScreen.main.bounds.minX + 120, y: UIScreen.main.bounds.midY + 60)
        sprite.run(.doodleEffect(with: textures))
        sprite.zPosition = 3
        
        return sprite
    }()
    
    lazy var distanceLabel: SKLabelNode = {
        let label = SKLabelNode(text: "\(distanceToBeach)m")
        
        let cfURL = Bundle.main.url(forResource: "ShortStack", withExtension: "ttf")! as CFURL
        
        CTFontManagerRegisterFontsForURL(cfURL,CTFontManagerScope.process,nil)
        
        label.position = CGPoint(x: UIScreen.main.bounds.minX + 80, y: UIScreen.main.bounds.midY - 430)
        label.fontColor = .black
        label.horizontalAlignmentMode = .center
        label.fontSize = 50
        label.numberOfLines = 2
        label.fontName = "ShortStack"
        label.zPosition = 2
        
        return label
    }()
    
    lazy var backgroundJelly: SKSpriteNode = {
        
        let imageNames = ["backgroundGame0", "backgroundGame1", "backgroundGame2"]
        
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        let sprite = SKSpriteNode(texture: textures[0], color: .clear, size: textures[0].size())
        
        sprite.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 500)
        sprite.zPosition = 0
        
        sprite.run(.doodleEffect(with: textures))
        
        return sprite
    }()
    
    lazy var oceanNode: SKSpriteNode = {
        
        let imageNames = ["ocean0", "ocean1", "ocean2"]
        
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        let oceanNode = SKSpriteNode(texture: textures[0], color: .white, size: CGSize(width: 1100, height: 1100))
        
        oceanNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 250)
        oceanNode.zPosition = 2
        
        oceanNode.run(.doodleEffect(with: textures))
        
        return oceanNode
    }()
    
    lazy var  JellyfishNode: JellyNode = {
        
        let jellyNode = JellyNode()
        jellyNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        
        jellyNode.run(.move(to: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 450), duration: 0.5))
        
        let sequence = SKAction.sequence([.moveBy(x: 0, y: 10, duration: 1), .moveBy(x: 0, y: -10, duration: 1)])
        jellyNode.run(.repeatForever(sequence))
        
        jellyNode.zPosition = 1
        
        return jellyNode
    }()
    
    lazy var playerNode : SKSpriteNode = {
        
        let player = PlayerNode()
        player.position = CGPoint(x: UIScreen.main.bounds.midX + 40, y: UIScreen.main.bounds.midY - 220)
        player.zPosition = 3
        
        let animationSequence = SKAction.sequence([.wait(forDuration: 3), .run(tutorialNode.removeFromParent)])
        
        tutorialNode.run(animationSequence)
        
        return player
    }()
    
    lazy var tutorialNode: SKSpriteNode = {
        
        let imageNames = ["tutorial0", "tutorial1", "tutorial2"]
        
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        let tutorialNode = SKSpriteNode(texture: textures[0], color: .clear, size: CGSize(width: 200, height: 200))
        
        tutorialNode.position = CGPoint(x: UIScreen.main.bounds.midX + 70, y: UIScreen.main.bounds.midY - 390)
        tutorialNode.run(.repeatForever(.animate(with: textures, timePerFrame: 0.1)))
        
        tutorialNode.zPosition = 3
        
        return tutorialNode
    }()
    
    lazy var collisionNode : SKShapeNode = {
        
        let collisionNode = SKShapeNode(rectOf: CGSize(width: 800, height: 100))
        
        collisionNode.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - 760)
        collisionNode.fillColor = .yellow
        collisionNode.zPosition = 6
        
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 100), center: CGPoint(x: 0, y: -150))
        body.categoryBitMask = .wall
        body.collisionBitMask = ~(.contactWithAllCategories(less: [.player, .wall]))
        body.contactTestBitMask = ~(.contactWithAllCategories(less:[.obstacle, .player, .wall]))
        body.affectedByGravity = false
        
        collisionNode.physicsBody = body
        
        return collisionNode
    }()
    
    lazy var musicNode : SKAudioNode = {
        let music = SKAudioNode(fileNamed: "gameMusic")
        
        return music
    }()
    
    func spawnObstacle(){
        
        let imageNames = ["warning0", "warning1", "warning2"]
        
        let textures = [SKTexture].loadTextures(from: imageNames)
        
        for _ in 1...obstacleSpawns{
            let obstacleX: [Double] = [240.0, 540.0, 840,0]
            var randomIndex = Int.random(in: 0...2)
            let obstacle = ObstacleNode()
            let warning = SKSpriteNode(texture: textures[0], color: .clear, size: CGSize(width: 300, height: 300))
            
            if GameController.shared.lastObstacleIndex == randomIndex {
                if randomIndex == 0{
                    randomIndex += 1
                }else if randomIndex == 1 {
                    randomIndex += 1
                }else {
                    randomIndex -= 2
                }
            }
            
            obstacle.position = CGPoint(x: -20, y: 0)
            warning.position = CGPoint(x: obstacleX[randomIndex], y: 900)
            warning.size = CGSize(width: 200, height: 200)
            warning.zPosition = 5
            
            let sequence = SKAction.sequence([.fadeIn(withDuration: timeVelocity),.fadeOut(withDuration: timeVelocity), .fadeIn(withDuration: timeVelocity), .fadeOut(withDuration: timeVelocity), .fadeIn(withDuration: timeVelocity),.fadeOut(withDuration: timeVelocity), .wait(forDuration: timeVelocity)])
            
            addChild(obstacle)
            addChild(warning)
            
            warning.run(.repeatForever(.animate(with: textures, timePerFrame: 0.1)))
            
            warning.run(sequence, completion: {
                warning.removeFromParent()
                obstacle.run(.move(by: CGVector(dx: obstacleX[randomIndex], dy: 1000), duration: 0))
                obstacle.run(.move(to: CGPoint(x: obstacleX[randomIndex], y: -100), duration: self.gameVelocity - 1))
                obstacle.run(.resize(toWidth: 200, duration: self.timeVelocity + 0.2))
                obstacle.run(.resize(toHeight: 200, duration: self.timeVelocity + 0.2))
            })
            GameController.shared.lastObstacleIndex = randomIndex
        }
        
        run(.wait(forDuration: TimeInterval.random(in: gameVelocity...(gameVelocity + 0.5)))) {
            [self] in
            spawnObstacle()
        }
    }
    
    func startDistanceCount(){
        distanceCount = Timer.scheduledTimer(timeInterval: timeVelocity, target: self, selector: #selector(decrementDistance), userInfo: nil, repeats: true)
    }
    
    @objc func decrementDistance(){
        distanceToBeach -= 1
        distanceLabel.text = "\(distanceToBeach)m"
        indicator.position.y -= 3.2
        
        if distanceToBeach == 90 {
            gameVelocity -= 1
            timeVelocity -= 0.1
        }
        
        if distanceToBeach == 60 {
            obstacleSpawns += 1
            gameVelocity -= 1
            timeVelocity -= 0.2
        }
        
        if distanceToBeach <= 0 {
            view?.presentScene(VictoryScene.newScene())
        }
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        guard let playerLaneDelta = getPlayerLaneDelta(for: gesture.direction) else {
            print("No gesture")
            return
        }
        
        let xDelta: CGFloat = 300 * CGFloat(playerLaneDelta)
        let duration: TimeInterval = 0.3
        
        let movePlayer = SKAction.moveBy(x: xDelta, y: 0, duration: duration)
        let rotatePlayer = SKAction.rotate(toAngle: 0, duration: duration)
        let tiltPlayer = SKAction.rotate(toAngle: CGFloat(playerLaneDelta) * -0.1, duration: duration/2, shortestUnitArc: true)
        let moveJellyfish = SKAction.sequence([.wait(forDuration: 0.2), movePlayer])
        let rotateJellyfish = SKAction.rotate(toAngle: 0, duration: duration)
        let tiltJellyfish = SKAction.rotate(toAngle: CGFloat(playerLaneDelta) * -0.1, duration: duration/2, shortestUnitArc: true)
        
        playerNode.run(movePlayer)
        playerNode.run(SKAction.sequence([tiltPlayer, rotatePlayer]))
        
        JellyfishNode.run(moveJellyfish)
        JellyfishNode.run(SKAction.sequence([tiltJellyfish, rotateJellyfish]))
        
        tutorialNode.run(movePlayer)
        playerLane += playerLaneDelta
        
        run(.playSoundFileNamed("swipe", waitForCompletion: false))
    }

    override func willMove(from view: SKView) {
        musicNode.run(SKAction.stop())
        musicNode.run(SKAction.changeVolume(to: 1, duration: 0))
    }
    
    private func getPlayerLaneDelta(for direction: UISwipeGestureRecognizer.Direction) -> Int? {
        switch direction {
        case .left:
            return playerLane > -1 ? -1 : nil
        case .right:
            return playerLane < 1 ? 1 : nil
        default:
            return nil
        }
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
