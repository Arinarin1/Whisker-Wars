//
//  battleOfCatmixia5.swift
//  Whisker Wars
//
//  Created by Arin Waichulis on 3/18/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class battleOfCatmixia5: SKScene, SKPhysicsContactDelegate {

    let scoreLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    var coinsLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    var livesNumber = 3
    let livesLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    
    var levelNumber = 0
    
    let player = SKSpriteNode(imageNamed: "commanderKitty.png")
    let catmixiaPlanet = SKSpriteNode(imageNamed: "planetCatmixia")
    
    
    let bulletSound = SKAction.playSoundFileNamed("Cat-meow-10.mp3", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("explosion_01.wav", waitForCompletion: false)
    let coinSound = SKAction.playSoundFileNamed("coinSound.mp3", waitForCompletion: false)
    
    
    
    // let themeSound = SKAction.playSoundFileNamed("themeSound.mp3", waitForCompletion: false)
    
    
    var audioPlayer = SKAudioNode()
    
    
    enum gameState {
        
        case preGame // before the game state
        case inGame // during the game
        case afterGame // when the state is after the game
        
        
    }
    
    
    var currentGameState = gameState.inGame
    
    
    struct PhysicsCategories {
        
        static let None : UInt32 = 0
        static let Player : UInt32 = 0b1 // 1
        static let Bullet : UInt32 = 0b10 // 2
        static let Enemy : UInt32 = 0b100 // 4
        static let superMeteor: UInt32 = 0b1000 // 6
        static let Meteor: UInt32 = 0b10000 // 8
        static let FishShip: UInt32 = 0b100000 // 10
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
        
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    
    
    var gameArea = CGRect()
    
    override init(size: CGSize) {
        
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        super.init(size: size)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let leftArm = SKSpriteNode(imageNamed: "leftArm.png")
    
    override func didMove(to view: SKView) {
        
        //  let fishShipImg = UIImageView()
        // fishShipImg.image = UIImage(named: ("nameofasset"))
        
        // audioPlayer = SKAudioNode(fileNamed: "Cat-meow-10.mp3")
        // self.addChild(audioPlayer)
        
        leftArm.physicsBody = SKPhysicsBody(rectangleOf: leftArm.size)
        // leftArm.physicsBody!.isDynamic = true
        leftArm.position = CGPoint(x: self.size.width / 1.9, y: self.size.height * 0.2)
        leftArm.anchorPoint = CGPoint(x: 0, y: 0)
        
        gameScore = 0
        coinsFromGame = 0
        self.physicsWorld.contactDelegate = self
        
        //   player.physicsBody!.isDynamic = false
        player.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2)
        player.setScale(1.6)
        player.zPosition = 2
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody!.affectedByGravity = false
        player.physicsBody!.categoryBitMask = PhysicsCategories.Player
        player.physicsBody!.collisionBitMask = PhysicsCategories.None
        player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        
        self.addChild(player)
       // self.addChild(leftArm)
        
        // let myJoint = SKPhysicsJointPin.joint(withBodyA: leftArm.physicsBody!, bodyB: player.physicsBody!, anchor: CGPoint(x: self.size.width / 0.6, y: self.size.height * 0.2))
        
        // self.physicsWorld.add(myJoint)
        
        
        let background = SKSpriteNode(imageNamed: "WWFINAL.png")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        
        // self.addChild(player)
        
        
        
        coinsLabel.text = "0"
        coinsLabel.fontSize = 68
        coinsLabel.fontColor = SKColor.yellow
        coinsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinsLabel.position = CGPoint(x: self.size.width*0.15, y:self.size.height*0.85)
        coinsLabel.zPosition = 101
        self.addChild(coinsLabel)
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width*0.15, y:self.size.height*0.9)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        
        livesLabel.text = "Lives: 3"
        livesLabel.fontSize = 77
        livesLabel.fontColor = SKColor.white
        livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        livesLabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.9)
        livesLabel.zPosition = 100
        self.addChild(livesLabel)
        
        
        
        startNewDifficulty()
        
    }
    
    
    func loseALife() {
        
        livesNumber -= 1
        livesLabel.text = "Lives: \(livesNumber)"
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber == 0 {
            runGameOver()
        }
        
        if livesNumber == 2 {
            
            let background = SKSpriteNode(imageNamed: "WWHitOnce.png")
            background.size = self.size
            background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            background.zPosition = 0
            self.addChild(background)
            
        }
        
        if livesNumber == 1 {
            
            let background = SKSpriteNode(imageNamed: "WWHitTwice.png")
            background.size = self.size
            background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            background.zPosition = 0
            self.addChild(background)
        }
        
        if livesLabel.text! == "Lives: 2" {
            
            let background = SKSpriteNode(imageNamed: "WWHitOnce.png")
            background.size = self.size
            background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            background.zPosition = 0
            self.addChild(background)
            
        }
        
        if livesLabel.text! == "Lives: 1" {
            
            let background = SKSpriteNode(imageNamed: "WWHitTwice.png")
            background.size = self.size
            background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            background.zPosition = 0
            self.addChild(background)
            
        }
        
    }
    
    
    
    
    func addScore() {
        
        
        gameScore += 1
        scoreLabel.text = "\(gameScore)"
        scoreLabel.fontSize = 100
        //coinsFromGame += 1
        coinsLabel.text = "\(coinsFromGame)"
        
        
        
        if gameScore == 1 || gameScore == 2 || gameScore == 20 || gameScore == 40 || gameScore == 250 || gameScore == 300 {
            startNewDifficulty()
            startNewMeteorDifficulty()
            startNewSuperMeteorDifficulty()
            startNewFishShipDifficulty()
            
            
        } else if gameScore == 5000 {
            
            
            runGameWon()
            
            
        }
        
        
        
    }
    
    func add10ToScore() {
        
        
        gameScore += 10
        scoreLabel.text = "\(gameScore)"
        scoreLabel.fontSize = 100
        coinsFromGame += 1
        
        let audioSound = SKAction.playSoundFileNamed("coinSound.mp3", waitForCompletion: false)
        let playSoundSequence = SKAction.sequence([audioSound])
        self.run(playSoundSequence)
    }
    
    
    
    
    func runGameWon() {
        
        currentGameState = gameState.afterGame
        
        
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet") {
            bullet, stop in
            
            bullet.removeAllActions()
            
            
        }
        
        self.enumerateChildNodes(withName: "Enemy") {
            
            enemy, stop in
            enemy.removeAllActions()
            
        }
        
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneAction)
        
        
        
        
    }
    
    
    
    func runGameOver() {
        
        
        currentGameState = gameState.afterGame
        
        audioPlayer.run(SKAction.stop())
        
        self.removeAllActions()
        
        self.enumerateChildNodes(withName: "Bullet") {
            bullet, stop in
            
            bullet.removeAllActions()
            
            
        }
        
        self.enumerateChildNodes(withName: "Enemy") {
            
            enemy, stop in
            enemy.removeAllActions()
            
        }
        
        
        let changeSceneAction = SKAction.run(changeScene)
        let waitToChangeScene = SKAction.wait(forDuration: 1)
        let changeSceneSequence = SKAction.sequence([waitToChangeScene, changeSceneAction])
        self.run(changeSceneAction)
        
        
        
        
        
    }
    
    func changeToWonScene() {
        
        
        
    }
    
    func changeScene() {
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        // let myTransition = SKTransition.fade(withDuration: 0.5)
        self.view!.presentScene(sceneToMoveTo)
        
        
    }
    
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        func GetImage(someValueWhichDrivesLogic: Int)->UIImage
        {
            if (someValueWhichDrivesLogic == 1)
                
            {
                let fishShipImg = UIImageView()
                fishShipImg.image = UIImage(named: ("fishShipH1"))
            }
            else if (someValueWhichDrivesLogic == 2)
                
            {
                
            }
            
            
            return UIImage(named: ("fishShipH1"))!
            
        }
        
        
        var body1 = SKPhysicsBody()
        var body2 = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            
            body1 = contact.bodyA
            body2 = contact.bodyB
            
            
        } else {
            
            
            body1 = contact.bodyB
            body2 = contact.bodyA
            
        }
        
        // if player hits meteor
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Meteor {
            
            
            
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
                
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
            
            runGameOver()
            
        }
        
        
        
        // if player hits the enemy
        if body1.categoryBitMask == PhysicsCategories.Player && body2.categoryBitMask == PhysicsCategories.Enemy {
            
            
            
            if body1.node != nil {
                spawnExplosion(spawnPosition: body1.node!.position)
                
            }
            
            if body2.node != nil {
                spawnExplosionWPoints(spawnPosition2: body2.node!.position)
                
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
            
            runGameOver()
            
        }
        
        // if bullet hits the enemy
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && (body2.node?.position.y)! < self.size.height {
            
            
            addScore()
            
            if body2.node != nil {
                spawnExplosionWPoints(spawnPosition2: body2.node!.position)
                
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
            
        }
        
        // if bullet hits the enemy
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.FishShip && (body2.node?.position.y)! < self.size.height {
            
            
            addScore()
            
            if body2.node != nil {
                spawnExplosionWPoints(spawnPosition2: body2.node!.position)
                
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            // body2.texture = SKTexture(imageNamed: "player1")
            
            
        }
        
        
        
        
        
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.superMeteor && (body2.node?.position.y)! < self.size.height {
            
            if body2.node != nil {
                
                spawnSuperGoldExplosion(spawnPositionGoldMeteor: body2.node!.position)
                
                
            }
            
            body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
            
        }
        
    }
    
    
    
    
    func spawnExplosion(spawnPosition: CGPoint) {
        
        let explosion = SKSpriteNode(imageNamed: "explosionWhiskerWars.png")
        explosion.position = spawnPosition
        explosion.zPosition = 3
        explosion.setScale(0.4)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        
        explosion.run(explosionSequence)
        
        
        
        
    }
    
    func spawnExplosionWPoints(spawnPosition2: CGPoint) {
        
        let explosion = SKSpriteNode(imageNamed: "explosionWhiskerWars.png")
        explosion.position = spawnPosition2
        explosion.zPosition = 3
        explosion.setScale(0.4)
        self.addChild(explosion)
        
        let point = SKLabelNode(fontNamed: "House-Paint-Slab")
        point.position = spawnPosition2
        point.text = "+1"
        point.fontSize = 50
        point.fontColor = SKColor.white
        point.zPosition = 4
        self.addChild(point)
        
        let scaleInPoint = SKAction.scale(to: 2, duration: 0.35)
        let fadeOutPoint = SKAction.fadeOut(withDuration: 0.35)
        let deletePoint = SKAction.removeFromParent()
        
        
        let explosionSequencePoints = SKAction.sequence([scaleInPoint, fadeOutPoint, deletePoint])
        
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.15)
        let fadeOut = SKAction.fadeOut(withDuration: 0.15)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete])
        
        
        
        
        explosion.run(explosionSequence)
        point.run(explosionSequencePoints)
        
        
        
    }
    
    func spawnExplosion10Points2Coins(spawnPosition2: CGPoint) {
        
        coinsFromGame += 2
        
        let explosion = SKSpriteNode(imageNamed: "explosionWhiskerWars.png")
        explosion.position = spawnPosition2
        explosion.zPosition = 3
        explosion.setScale(0.4)
        self.addChild(explosion)
        
        let point = SKLabelNode(fontNamed: "House-Paint-Slab")
        point.position = spawnPosition2
        point.text = "+10"
        point.fontSize = 50
        point.fontColor = SKColor.white
        point.zPosition = 4
        self.addChild(point)
        
        let scaleInPoint = SKAction.scale(to: 2, duration: 0.35)
        let fadeOutPoint = SKAction.fadeOut(withDuration: 0.35)
        let deletePoint = SKAction.removeFromParent()
        
        
        let explosionSequencePoints = SKAction.sequence([scaleInPoint, fadeOutPoint, deletePoint])
        
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.15)
        let fadeOut = SKAction.fadeOut(withDuration: 0.15)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, fadeOut, delete, coinSound])
        
        
        
        
        explosion.run(explosionSequence)
        point.run(explosionSequencePoints)
        
        
        
    }
    
    
    func spawnSuperGoldExplosion(spawnPositionGoldMeteor: CGPoint) {
        
        coinsFromGame += 10
        
        let explosion = SKSpriteNode(imageNamed: "explosionWhiskerWars.png")
        explosion.position = spawnPositionGoldMeteor
        explosion.zPosition = 3
        explosion.setScale(0.4)
        self.addChild(explosion)
        
        let point = SKLabelNode(fontNamed: "House-Paint-Slab")
        point.position = spawnPositionGoldMeteor
        point.text = "+10"
        point.fontSize = 50
        point.fontColor = SKColor.white
        point.zPosition = 4
        self.addChild(point)
        
        let scaleInPoint = SKAction.scale(to: 2, duration: 0.35)
        let fadeOutPoint = SKAction.fadeOut(withDuration: 0.35)
        let deletePoint = SKAction.removeFromParent()
        
        
        let explosionSequencePoints = SKAction.sequence([scaleInPoint, fadeOutPoint, deletePoint])
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([explosionSound, scaleIn, coinSound, fadeOut, delete])
        
        explosion.run(explosionSequence)
        point.run(explosionSequencePoints)
        
        
        
        
        
    }
    
    
    func startNewDifficulty() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 6
        case 2: levelDuration = 6
        case 3: levelDuration = 6
        case 4: levelDuration = 3
        case 5: levelDuration = 3
        case 6: levelDuration = 2
            
        default:
            levelDuration = 3
            print("Cannot find level info")
        }
        
        
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningEnemies")
        
        
        
    }
    
    
    func startNewMeteorDifficulty() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawningMeteors") != nil {
            
            self.removeAction(forKey: "spawningMeteors")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 5.0
        case 2: levelDuration = 5.0
        case 3: levelDuration = 3.0
        case 4: levelDuration = 2.0
        case 5: levelDuration = 2.0
        case 6: levelDuration = 3.0
            
        default:
            levelDuration = 3
            print("Cannot find level info")
        }
        
        
        
        
        let spawnMeteor = SKAction.run(spawnMeteors)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawnMeteor])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningMeteors")
        
        
        
    }
    
    func startNewSuperMeteorDifficulty() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawnSuperMeteors") != nil {
            
            self.removeAction(forKey: "spawnSuperMeteors")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 1.0
        case 2: levelDuration = 3.0
        case 3: levelDuration = 2.0
        case 4: levelDuration = 20.0
        case 5: levelDuration = 25.0
        case 6: levelDuration = 40.0
            
            
        default:
            levelDuration = 1
            print("Cannot find level info")
        }
        
        
        
        
        let spawnMeteor = SKAction.run(spawnSuperMeteors)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawnMeteor])
        let spawnRepeat = SKAction.repeat((spawnSequence), count: 1)
        self.run(spawnRepeat, withKey: "spawnSuperMeteors")
        
        
        
    }
    
    func startNewFishShipDifficulty() {
        
        levelNumber += 1
        
        if self.action(forKey: "FishShip") != nil {
            
            self.removeAction(forKey: "FishShip")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 1.0
        case 2: levelDuration = 2.0
        case 3: levelDuration = 3.0
        case 4: levelDuration = 20.0
        case 5: levelDuration = 25.0
        case 6: levelDuration = 40.0
            
            
        default:
            levelDuration = 1
            print("Cannot find level info")
        }
        
        let spawnShips = SKAction.run(spawnFishShip)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawnShips])
        let spawnRepeat = SKAction.repeat((spawnSequence), count: 1)
        self.run(spawnRepeat, withKey: "FishShip")
        
        
        
    }
    
    
    func fireBullet() {
        
        
        let bullet = SKSpriteNode(imageNamed: "hairBall.png")
        bullet.name = "Bullet"
        bullet.setScale(1.4)
        bullet.position = player.position
        bullet.zPosition = 1
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        let moveBullet =  SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1)
        let deleteBullet = SKAction.removeFromParent()
        let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
        bullet.run(bulletSequence)
        
        
        
        
    }
    
    
    func spawnFishShip() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "fishShip.png")
        enemy.name = "FishShip"
        enemy.setScale(2.5)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.FishShip
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 30)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
        
        if currentGameState == gameState.inGame {
            enemy.run(enemySequence)
            
        }
        
        
    }
    
    func spawnEnemy() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "meowbot2.png")
        enemy.name = "Enemy"
        enemy.setScale(1.4)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.Enemy
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 5.1)
        let deleteEnemy = SKAction.removeFromParent()
        let loseALifeAction = SKAction.run(loseALife)
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
        
        if currentGameState == gameState.inGame {
            enemy.run(enemySequence)
            
        }
        
        
    }
    
    
    func spawnSuperMeteors() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "superMeteor.png")
        enemy.name = "superMeteors"
        enemy.setScale(1.2)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.superMeteor
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 2.9)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        
        if currentGameState == gameState.inGame {
            enemy.run(enemySequence)
            
        }
        
        
        
        
        
        
    }
    
    
    func spawnMeteors() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let meteor = SKSpriteNode(imageNamed: "meteor.png")
        meteor.name = "Meteor"
        meteor.setScale(1.2)
        meteor.position = startPoint
        meteor.zPosition = 2
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody!.affectedByGravity = false
        meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
        meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
        meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(meteor)
        
        let moveMeteor = SKAction.move(to: endPoint, duration: 6.5)
        let deleteMeteor = SKAction.removeFromParent()
        let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
        
        if currentGameState == gameState.inGame {
            meteor.run(meteorSequence)
            
        }
        
        
        
        
    }
    
    
    
    
    
    // fire bullet from cat
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentGameState == gameState.inGame {
            fireBullet()
            
        }
    }
    
    
    // cats movement left and right
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch =  touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            
            
            
            if currentGameState == gameState.inGame {
                player.position.x += amountDragged
                
            }
            
            if player.position.x > gameArea.maxX - player.size.width / 2 {
                player.position.x = gameArea.maxX - player.size.width / 2
            }
            
            if player.position.x < gameArea.minX + player.size.width / 2 {
                player.position.x = gameArea.minX + player.size.width / 2
            }
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
}


