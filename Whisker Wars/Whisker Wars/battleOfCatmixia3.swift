//
//  battleOfCatmixia3.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/17/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class battleOfCatmixia3: SKScene, SKPhysicsContactDelegate {
        
    let scoreLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    var coinsLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    var livesNumber = 3
    var livesNumberPowerUp = 4
    let livesLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    var fireShockWaveLbl = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    
    var levelNumber = 0
    
    let player = SKSpriteNode(imageNamed: "privateWhiskers.png")
    let catmixiaPlanet = SKSpriteNode(imageNamed: "planetCatmixia")
    
    
    let bulletSound = SKAction.playSoundFileNamed("Cat-meow-10.mp3", waitForCompletion: false)
    let explosionSound = SKAction.playSoundFileNamed("explosion_01.wav", waitForCompletion: false)
    let coinSound = SKAction.playSoundFileNamed("coinSound.mp3", waitForCompletion: false)
    
    let defaults = UserDefaults()
    
    let themeSound = SKAction.playSoundFileNamed("1.mp3", waitForCompletion: false)
    
    
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
        static let ShockWave: UInt32 = 0b1000000 // 12
        
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
        
        audioPlayer = SKAudioNode(fileNamed: "1.mp3")
        audioPlayer.autoplayLooped = true
        //self.addChild(audioPlayer)
        
        leftArm.physicsBody = SKPhysicsBody(rectangleOf: leftArm.size)
        // leftArm.physicsBody!.isDynamic = true
        leftArm.position = CGPoint(x: self.size.width / 1.9, y: self.size.height * 0.2)
        leftArm.anchorPoint = CGPoint(x: 0, y: 0)
        
        gameScore = 0
        coinsFromGame = 0
        self.physicsWorld.contactDelegate = self
        
        //   player.physicsBody!.isDynamic = false
        
        if defaults.string(forKey: "powerup4Purchased") == "powerup4Purchased" {
            
            player.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2)
            player.setScale(1.2)
            player.zPosition = 2
            player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
            player.physicsBody!.affectedByGravity = false
            player.physicsBody!.categoryBitMask = PhysicsCategories.Player
            player.physicsBody!.collisionBitMask = PhysicsCategories.None
            player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
            
            self.addChild(player)
            
        } else {
            
            
            player.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2)
            player.setScale(1.6)
            player.zPosition = 2
            player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
            player.physicsBody!.affectedByGravity = false
            player.physicsBody!.categoryBitMask = PhysicsCategories.Player
            player.physicsBody!.collisionBitMask = PhysicsCategories.None
            player.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
            
            self.addChild(player)
            
        }
        
        //self.addChild(leftArm)
        
        // let myJoint = SKPhysicsJointPin.joint(withBodyA: leftArm.physicsBody!, bodyB: player.physicsBody!, anchor: CGPoint(x: self.size.width / 0.6, y: self.size.height * 0.2))
        
        // self.physicsWorld.add(myJoint)
        
        
        let background = SKSpriteNode(imageNamed: "WWFINAL.png")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
        
        
        // self.addChild(player)
        
        
        if defaults.string(forKey: "powerup3Purchased") == "powerup3Purchased" {
            
            fireShockWaveLbl.text = "Shock Wave"
            fireShockWaveLbl.name = "fireShockWave"
            fireShockWaveLbl.fontSize = 68
            fireShockWaveLbl.zPosition = 100
            fireShockWaveLbl.position = CGPoint(x: self.size.width / 2, y:self.size.height * 0.10)
            self.addChild(fireShockWaveLbl)
            
        }
        
        coinsLabel.text = "0"
        coinsLabel.fontSize = 68
        coinsLabel.fontColor = SKColor.yellow
        coinsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        coinsLabel.position = CGPoint(x: self.size.width * 0.23, y:self.size.height * 0.85)
        coinsLabel.zPosition = 101
        self.addChild(coinsLabel)
        
        scoreLabel.text = "0"
        scoreLabel.fontSize = 100
        scoreLabel.fontColor = SKColor.white
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.position = CGPoint(x: self.size.width * 0.23, y:self.size.height * 0.9)
        scoreLabel.zPosition = 100
        self.addChild(scoreLabel)
        
        
        if defaults.string(forKey: "powerup1Purchased") == "powerup1Purchased" {
            
            livesLabel.text = "Lives: 4"
            livesLabel.fontSize = 77
            livesLabel.fontColor = SKColor.white
            livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            livesLabel.position = CGPoint(x: self.size.width * 0.85, y: self.size.height * 0.9)
            livesLabel.zPosition = 100
            self.addChild(livesLabel)
            
        } else {
            
            livesLabel.text = "Lives: 3"
            livesLabel.fontSize = 60
            livesLabel.fontColor = SKColor.white
            livesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            livesLabel.position = CGPoint(x: self.size.width * 0.70, y: self.size.height * 0.9)
            livesLabel.zPosition = 100
            self.addChild(livesLabel)
            
        }
        
        
        startNewDifficulty()
        
        
        
    }
    
    
    func loseALife() {
        
        if defaults.string(forKey: "powerup1Purchased") == "powerup1Purchased" {                                    // powerup 2
            livesNumberPowerUp -= 1
            livesLabel.text = "Lives: \(livesNumberPowerUp)"
            
        } else {
            livesNumber -= 1
            livesLabel.text = "Lives: \(livesNumber)"
        }
        
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        livesLabel.run(scaleSequence)
        
        if livesNumber == 0 {
            runGameOver()
        }
        
        if livesNumberPowerUp == 0 {
            runGameOver()
        }
        
        if defaults.string(forKey: "powerup1Purchased") == "powerup1Purchased" {
            print("default function ran")
            
            if livesNumberPowerUp == 3 {
                
                let background = SKSpriteNode(imageNamed: "WWHitOnce.png")
                background.size = self.size
                background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                background.zPosition = 0
                self.addChild(background)
                
            }
            
            if livesNumberPowerUp == 2 {
                
                let background = SKSpriteNode(imageNamed: "WWHitOnce.png")
                background.size = self.size
                background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                background.zPosition = 0
                self.addChild(background)
                
            }
            
            if livesNumberPowerUp == 1 {
                
                let background = SKSpriteNode(imageNamed: "WWHitTwice.png")
                background.size = self.size
                background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                background.zPosition = 0
                self.addChild(background)
            }
            
            
        } else {
            
            
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
            
            //        if livesLabel.text! == "Lives: 2" {
            //
            //            let background = SKSpriteNode(imageNamed: "WWHitOnce.png")
            //            background.size = self.size
            //            background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            //            background.zPosition = 0
            //            self.addChild(background)
            //
            //        }
            //
            //        if livesLabel.text! == "Lives: 1" {
            //
            //            let background = SKSpriteNode(imageNamed: "WWHitTwice.png")
            //            background.size = self.size
            //            background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            //            background.zPosition = 0
            //            self.addChild(background)
            //
            //            }
            
        }
        
    }
    
    
    
    
    func addScore() {
        
        
        gameScore += 1
        scoreLabel.text = "\(gameScore)"
        scoreLabel.fontSize = 100
        //coinsFromGame += 1
        coinsLabel.text = "\(coinsFromGame)"
        
        
        
        if gameScore == 4 || gameScore == 16 || gameScore == 30 || gameScore == 67 || gameScore == 100 || gameScore == 150 || gameScore == 200 || gameScore == 230 || gameScore == 280 || gameScore == 330 {
            startNewDifficulty()
            startNewMeteorDifficulty()
            startNewSuperMeteorDifficulty()
            startSetSlowMeteors()
            // startNewFishShipDifficulty()
            
            
        } else if gameScore == 5000 {
            
            
            runGameWon()
            
            
        }
        
        
        
    }
    
    // Maybe for the fish ships? Isnt set yet
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
        
        defaults.set("powerup1Purchase", forKey: "powerup1Purchased")
        defaults.set("powerup2Purchase", forKey: "powerup2Purchased")
        defaults.set("powerup3Purchase", forKey: "powerup3Purchased")
        defaults.set("powerup4Purchase", forKey: "powerup4Purchased")
        
        self.defaults.set("Startmeowbot2", forKey: "Startmeowbot")
        self.defaults.set("meowbot", forKey: "meowbot10")
        self.defaults.set("meowbot", forKey: "meowbot9")
        self.defaults.set("meowbot", forKey: "meowbot8")
        self.defaults.set("meowbot", forKey: "meowbot7")
        self.defaults.set("meowbot", forKey: "meowbot6")
        self.defaults.set("meowbot", forKey: "meowbot5")
        self.defaults.set("meowbot", forKey: "meowbot4")
        self.defaults.set("meowbot", forKey: "meowbot3")
        self.defaults.set("meowbot", forKey: "meowbot2")
        
        self.defaults.set("meteor", forKey: "Startmeteor")
        self.defaults.set("meteor", forKey: "meteor2")
        self.defaults.set("meteor", forKey: "meteor3")
        self.defaults.set("meteor", forKey: "meteor4")
        self.defaults.set("meteor", forKey: "meteor5")
        self.defaults.set("meteor", forKey: "meteor6")
        self.defaults.set("meteor", forKey: "meteor7")
        self.defaults.set("meteor", forKey: "meteor8")
        self.defaults.set("meteor", forKey: "meteor9")
        self.defaults.set("meteor", forKey: "meteor10")
        
        if defaults.string(forKey: "removeAds") == "removeAds" {
            
            print("Ads removed")
            
        } else {
            
            Chartboost.start(withAppId: "5ac06578f7c1590bbdfdf5d1", appSignature: "f57aed811e696e414e94b009afae7d594a96375e", delegate: nil)
            Chartboost.showInterstitial(CBLocationGameOver)
            
        }
        
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
        
        
        // if bullet hits the meteor
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Meteor && (body2.node?.position.y)! < self.size.height {
            
            body1.node?.removeFromParent()
            print("Bullet hit meteor")
            
        }
        
        
        // if bullet hits the enemy
        if body1.categoryBitMask == PhysicsCategories.Bullet && body2.categoryBitMask == PhysicsCategories.Enemy && (body2.node?.position.y)! < self.size.height {
            
            
            addScore()
            
            if body2.node != nil {
                spawnExplosionWPoints(spawnPosition2: body2.node!.position)
                
            }
            
            //body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
            
        }
        
        // if ShockWave hits the enemy
        if body1.categoryBitMask == PhysicsCategories.ShockWave && body2.categoryBitMask == PhysicsCategories.Enemy && (body2.node?.position.y)! < self.size.height  {
            
            
            addScore()
            
            if body2.node != nil {
                spawnExplosionWPoints(spawnPosition2: body2.node!.position)
                
            }
            
            // body1.node?.removeFromParent()
            body2.node?.removeFromParent()
            
            
            
        }
        
        // if bullet hits the enemy FishShip
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
        
        if defaults.string(forKey: "doubleCoins") == "double" {
            
            coinsFromGame += 20
            
            let explosion = SKSpriteNode(imageNamed: "explosionWhiskerWars.png")
            explosion.position = spawnPositionGoldMeteor
            explosion.zPosition = 3
            explosion.setScale(0.4)
            self.addChild(explosion)
            
            let point = SKLabelNode(fontNamed: "House-Paint-Slab")
            point.position = spawnPositionGoldMeteor
            point.text = "+20"
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
            
        } else {
            
            
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
        
    }
    
    
    func startNewDifficulty() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawningEnemies") != nil {
            
            self.removeAction(forKey: "spawningEnemies")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 3.5
        self.defaults.set("Startmeowbot", forKey: "Startmeowbot")
        case 2: levelDuration = 2.0
        self.defaults.set("meowbot2", forKey: "meowbot2")
        self.defaults.set("Startmeowbot2", forKey: "Startmeowbot")
        case 3: levelDuration = 1.3
        self.defaults.set("meowbot3", forKey: "meowbot3")
        self.defaults.set("meowbot", forKey: "meowbot2")
        case 4: levelDuration = 1.3
        self.defaults.set("meowbot4", forKey: "meowbot4")
        self.defaults.set("meowbot", forKey: "meowbot3")
        case 5: levelDuration = 1.3
        self.defaults.set("meowbot5", forKey: "meowbot5")
        self.defaults.set("meowbot", forKey: "meowbot4")
        case 6: levelDuration = 1.3
        self.defaults.set("meowbot6", forKey: "meowbot6")
        self.defaults.set("meowbot", forKey: "meowbot5")
        case 7: levelDuration = 1.1
        self.defaults.set("meowbot7", forKey: "meowbot7")
        self.defaults.set("meowbot", forKey: "meowbot6")
        case 8: levelDuration = 1.1
        self.defaults.set("meowbot8", forKey: "meowbot8")
        self.defaults.set("meowbot", forKey: "meowbot7")
        case 9: levelDuration = 1.1
        self.defaults.set("meowbot9", forKey: "meowbot9")
        self.defaults.set("meowbot", forKey: "meowbot8")
        case 10: levelDuration = 1.1
        self.defaults.set("meowbot10", forKey: "meowbot10")
        self.defaults.set("meowbot", forKey: "meowbot9")
            
            
        default:
            levelDuration = 0.9
            print("Cannot find level info to spawn meowbot")
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
        
        if defaults.string(forKey: "powerup2Purchased") == "powerup2Purchased" {
            print("Spawning Less Meteors")
            var levelDuration = TimeInterval()
            
            switch levelNumber {
            case 1: levelDuration = 4.2
            self.defaults.set("Startmeteor", forKey: "StartMeteor")
            self.defaults.set("meteor", forKey: "Startmeteor")
            case 2: levelDuration = 3.2
            self.defaults.set("meteor2", forKey: "meteor2")
            case 3: levelDuration = 2.8
            self.defaults.set("meteor3", forKey: "meteor3")
            self.defaults.set("meteor", forKey: "meteor2")
            case 4: levelDuration = 2.6
            self.defaults.set("meteor4", forKey: "meteor4")
            self.defaults.set("meteor", forKey: "meteor3")
            case 5: levelDuration = 2.7
            self.defaults.set("meteor5", forKey: "meteor5")
            self.defaults.set("meteor", forKey: "meteor4")
            case 6: levelDuration = 2.7
            self.defaults.set("meteor6", forKey: "meteor6")
            self.defaults.set("meteor", forKey: "meteor5")
            case 7: levelDuration = 2.9
            self.defaults.set("meteor7", forKey: "meteor7")
            self.defaults.set("meteor", forKey: "meteor6")
            case 8: levelDuration = 2.7
            self.defaults.set("meteor8", forKey: "meteor8")
            self.defaults.set("meteor", forKey: "meteor7")
            case 9: levelDuration = 2.4
            self.defaults.set("meteor9", forKey: "meteor9")
            self.defaults.set("meteor", forKey: "meteor8")
            case 10: levelDuration = 2.2
            self.defaults.set("meteor10", forKey: "meteor10")
            self.defaults.set("meteor", forKey: "meteor9")
                
            default:
                levelDuration = 1
                print("Cannot find level info")
            }
            
            let spawnMeteor = SKAction.run(spawnMeteorsInSlowMo)
            let waitToSpawn = SKAction.wait(forDuration: levelDuration)
            let spawnSequence = SKAction.sequence([waitToSpawn, spawnMeteor])
            let spawnForever = SKAction.repeatForever(spawnSequence)
            self.run(spawnForever, withKey: "spawningMeteors")
            
        } else {
            
            var levelDuration = TimeInterval()
            
            switch levelNumber {
            case 1: levelDuration = 4.0
            self.defaults.set("Startmeteor", forKey: "Startmeteor")
            case 2: levelDuration = 2.9
            self.defaults.set("meteor2", forKey: "meteor2")
            self.defaults.set("meteor", forKey: "Startmeteor")
            case 3: levelDuration = 2.7
            self.defaults.set("meteor3", forKey: "meteor3")
            self.defaults.set("meteor", forKey: "meteor2")
            case 4: levelDuration = 2.5
            self.defaults.set("meteor4", forKey: "meteor4")
            self.defaults.set("meteor", forKey: "meteor3")
            case 5: levelDuration = 2.2
            self.defaults.set("meteor5", forKey: "meteor5")
            self.defaults.set("meteor", forKey: "meteor4")
            case 6: levelDuration = 2.0
            self.defaults.set("meteor6", forKey: "meteor6")
            self.defaults.set("meteor", forKey: "meteor5")
            case 7: levelDuration = 2.0
            self.defaults.set("meteor7", forKey: "meteor7")
            self.defaults.set("meteor", forKey: "meteor6")
            case 8: levelDuration = 2.3
            self.defaults.set("meteor8", forKey: "meteor8")
            self.defaults.set("meteor", forKey: "meteor7")
            case 9: levelDuration = 2.0
            self.defaults.set("meteor9", forKey: "meteor9")
            self.defaults.set("meteor", forKey: "meteor8")
            case 10: levelDuration = 2.0
            self.defaults.set("meteor10", forKey: "meteor10")
            self.defaults.set("meteor", forKey: "meteor9")
                
            default:
                levelDuration = 0.8
                print("Cannot find level info")
            }
            
            let spawnMeteor = SKAction.run(spawnMeteors)
            let waitToSpawn = SKAction.wait(forDuration: levelDuration)
            let spawnSequence = SKAction.sequence([waitToSpawn, spawnMeteor])
            let spawnForever = SKAction.repeatForever(spawnSequence)
            self.run(spawnForever, withKey: "spawningMeteors")
            
        }
        
    }
    
    
    func startSetSlowMeteors() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawningSlowMeteors") != nil {
            
            self.removeAction(forKey: "spawningSlowMeteors")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 11
        case 2: levelDuration = 11
        case 3: levelDuration = 11
        case 4: levelDuration = 11
        case 5: levelDuration = 10
        case 6: levelDuration = 9
        case 7: levelDuration = 9
        case 8: levelDuration = 8
        case 9: levelDuration = 7
        case 10: levelDuration = 6
            
        default:
            levelDuration = 10
            print("Cannot find level info")
        }
        
        
        let spawnMeteor = SKAction.run(spawnSetSlowMeteors)
        let waitToSpawn = SKAction.wait(forDuration: levelDuration)
        let spawnSequence = SKAction.sequence([waitToSpawn, spawnMeteor])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever, withKey: "spawningSlowMeteors")
    }
    
    
    func startNewSuperMeteorDifficulty() {
        
        levelNumber += 1
        
        if self.action(forKey: "spawnSuperMeteors") != nil {
            
            self.removeAction(forKey: "spawnSuperMeteors")
        }
        
        var levelDuration = TimeInterval()
        
        switch levelNumber {
        case 1: levelDuration = 0.0
        case 2: levelDuration = 30.0
        case 3: levelDuration = 30.0
        case 4: levelDuration = 39.0
        case 5: levelDuration = 49.0
        case 6: levelDuration = 49.0
        case 7: levelDuration = 69.0
        case 8: levelDuration = 69.0
        case 9: levelDuration = 69.0
        case 10: levelDuration = 49.0
            
            
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
        
        
        let bullet = SKSpriteNode(imageNamed: "fish.png")
        bullet.name = "Bullet"
        bullet.setScale(1.4)
        bullet.position = player.position
        bullet.zPosition = 2
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody!.affectedByGravity = false
        bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
        bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
        bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
        self.addChild(bullet)
        
        let moveBullet =  SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 1.8)
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
        
        if defaults.string(forKey: "Startmeowbot") == "Startmeowbot" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 5.4)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
        }
        
        
        if defaults.string(forKey: "meowbot2") == "meowbot2" {
            print("Running MeowBot 2 spawn faster")
            let moveEnemy = SKAction.move(to: endPoint, duration: 5.2)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        
        if defaults.string(forKey: "meowbot3") == "meowbot3" {
            print("Running MeowBot 3 spawn faster")
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 4.2)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot4") == "meowbot4" {
            print("Running MeowBot 4 spawn faster")
            let moveEnemy = SKAction.move(to: endPoint, duration: 4.0)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot5") == "meowbot5" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 3.9)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot6") == "meowbot6" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 4.0)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot7") == "meowbot7" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 3.7)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot8") == "meowbot8" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 3.6)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot9") == "meowbot9" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 3.3)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        if defaults.string(forKey: "meowbot10") == "meowbot10" {
            
            let moveEnemy = SKAction.move(to: endPoint, duration: 3.2)
            let deleteEnemy = SKAction.removeFromParent()
            let loseALifeAction = SKAction.run(loseALife)
            let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy, loseALifeAction])
            
            if currentGameState == gameState.inGame {
                enemy.run(enemySequence)
            }
            
        }
        
        
        
    }
    
    
    
    func spawnSuperMeteors() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let enemy = SKSpriteNode(imageNamed: "superMeteor.png")
        enemy.name = "superMeteors"
        enemy.setScale(1.1)
        enemy.position = startPoint
        enemy.zPosition = 2
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody!.affectedByGravity = false
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.superMeteor
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.None
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.8)
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
        meteor.setScale(1.1)
        meteor.position = startPoint
        meteor.zPosition = 2
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody!.affectedByGravity = false
        meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
        meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
        meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
        self.addChild(meteor)
        
        if defaults.string(forKey: "meteor2") == "meteor2" {
            print("Running Meoter 2")
            let moveMeteor = SKAction.move(to: endPoint, duration: 5.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
            
        } else {
            let moveMeteor = SKAction.move(to: endPoint, duration: 4.5)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
            }
        }
        
        if defaults.string(forKey: "meteor3") == "meteor3" {
            print("Running Meoteor 3")
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.5)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor4") == "meteor4" {
            print("Running Meote0r 4")
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.2)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor5") == "meteor5" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.2)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor6") == "meteor6" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor7") == "meteor7" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor8") == "meteor8" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor9") == "meteor9" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.2)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor10") == "meteor10" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        
    }
    
    func spawnMeteorsInSlowMo() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        let meteor = SKSpriteNode(imageNamed: "meteor.png")
        meteor.name = "Meteor"
        meteor.setScale(1.1)
        meteor.position = startPoint
        meteor.zPosition = 2
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody!.affectedByGravity = false
        meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
        meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
        meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player
        self.addChild(meteor)
        
        if defaults.string(forKey: "meteor2") == "meteor2" {
            print("Running Meoter 2")
            let moveMeteor = SKAction.move(to: endPoint, duration: 5.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
            
        } else {
            let moveMeteor = SKAction.move(to: endPoint, duration: 4.5)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
            }
        }
        
        if defaults.string(forKey: "meteor3") == "meteor3" {
            print("Running Meoteor 3")
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.5)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor4") == "meteor4" {
            print("Running Meote0r 4")
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.2)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor5") == "meteor5" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.2)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor6") == "meteor6" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor7") == "meteor7" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor8") == "meteor8" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor9") == "meteor9" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.2)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        if defaults.string(forKey: "meteor10") == "meteor10" {
            
            let moveMeteor = SKAction.move(to: endPoint, duration: 3.0)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
        }
        
    }
    
    func spawnSetSlowMeteors() {
        
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)
        
        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
        
        
        if defaults.string(forKey: "powerup2Purchased") == "powerup2Purchased" {
            
            let meteor = SKSpriteNode(imageNamed: "meteor.png")
            meteor.name = "Meteor"
            meteor.setScale(1.1)
            meteor.position = startPoint
            meteor.zPosition = 2
            meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
            meteor.physicsBody!.affectedByGravity = false
            meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
            meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
            meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
            self.addChild(meteor)
            
            print("Running Slow Meteors")
            let moveMeteor = SKAction.move(to: endPoint, duration: 6.6)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
            
        } else {
            
            let meteor = SKSpriteNode(imageNamed: "meteor.png")
            meteor.name = "Meteor"
            meteor.setScale(1.1)
            meteor.position = startPoint
            meteor.zPosition = 2
            meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
            meteor.physicsBody!.affectedByGravity = false
            meteor.physicsBody!.categoryBitMask = PhysicsCategories.Meteor
            meteor.physicsBody!.collisionBitMask = PhysicsCategories.None
            meteor.physicsBody!.contactTestBitMask = PhysicsCategories.Player | PhysicsCategories.Bullet
            self.addChild(meteor)
            
            print("Running Slow Meteors")
            let moveMeteor = SKAction.move(to: endPoint, duration: 6.6)
            let deleteMeteor = SKAction.removeFromParent()
            let meteorSequence = SKAction.sequence([moveMeteor, deleteMeteor])
            
            if currentGameState == gameState.inGame {
                meteor.run(meteorSequence)
                
            }
            
        }
        
    }
    
    // fire bullet from cat
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            
            if nodeITapped.name == "fireShockWave" {
                
                
                let bullet = SKSpriteNode(imageNamed: "shockWave.png")
                bullet.name = "ShockWave"
                // bullet.setScale(1.4)
                bullet.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.2) // low the #, higher the image
                bullet.zPosition = 1
                bullet.setScale(2.4)
                bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
                bullet.physicsBody!.affectedByGravity = false
                bullet.physicsBody!.categoryBitMask = PhysicsCategories.Bullet
                bullet.physicsBody!.collisionBitMask = PhysicsCategories.None
                bullet.physicsBody!.contactTestBitMask = PhysicsCategories.Enemy
                self.addChild(bullet)
                
                let moveBullet =  SKAction.moveTo(y: self.size.height + bullet.size.height, duration: 5.0)
                let deleteBullet = SKAction.removeFromParent()
                let bulletSequence = SKAction.sequence([moveBullet, deleteBullet])
                bullet.run(bulletSequence)
                
                fireShockWaveLbl.isHidden = true
            }
        }
        
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

