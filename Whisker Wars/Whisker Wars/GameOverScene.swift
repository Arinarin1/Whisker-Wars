//
//  GameOverScene.swift
//  Whisker Wars
//
//  Created by arinrocksout on 1/19/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import CoreData
import StoreKit


class GameOverScene: SKScene {
    
    let coinLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    let restartLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    let homeLevel = SKLabelNode(fontNamed: "House-Paint-Slab")
    let defaults = UserDefaults()
    let addedLabel = SKLabelNode(fontNamed: "Helvetica-Neue")
    
   
    let bonus15 = SKSpriteNode(imageNamed: "bonus1.5.png")
    let bonus2 = SKSpriteNode(imageNamed: "bonus2.png")
    let bonus3 = SKSpriteNode(imageNamed: "bonus3.png")
    let bonus4 = SKSpriteNode(imageNamed: "bonus4.png")
    let bonus5 = SKSpriteNode(imageNamed: "bonus5.png")
    let bonus6 = SKSpriteNode(imageNamed: "bonus6.png")
    
    let bonus15x2 = SKSpriteNode(imageNamed: "bonus1.5x2.png")
    let bonus2x2 = SKSpriteNode(imageNamed: "bonus2x2.png")
    let bonus3x2 = SKSpriteNode(imageNamed: "bonus3x2.png")
    let bonus4x2 = SKSpriteNode(imageNamed: "bonus4x2.png")
    let bonus5x2 = SKSpriteNode(imageNamed: "bonus5x2.png")
    let bonus6x2 = SKSpriteNode(imageNamed: "bonus6x2.png")
  
  
    
    override func didMove(to view: SKView) {
       
        let background = SKSpriteNode(imageNamed: "WWHitTwice.png")
        
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = self.size
        background.zPosition = 0
        self.addChild(background)
        
        let  gameOverLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
        gameOverLabel.text = "Catmixia"
        gameOverLabel.fontSize = 140
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.8)
        gameOverLabel.zPosition = 1
       // self.addChild(gameOverLabel)
        
        let gameOverLabel2 = SKLabelNode(fontNamed: "House-Paint-Slab")
        gameOverLabel2.text = "was Captured"
        gameOverLabel2.fontSize = 145
        gameOverLabel2.fontColor = SKColor.white
        gameOverLabel2.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.73)
        gameOverLabel2.zPosition = 1
        //self.addChild(gameOverLabel2)

        
        
        let scoreLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
        scoreLabel.text = "\(gameScore)"
        scoreLabel.fontSize = 180
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.75)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        var numOfCoins = defaults.integer(forKey: "numOfCoins")
        
        if gameScore > highScoreNumber {
            
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
            
        }
        
        numOfCoins += coinsFromGame
        defaults.set(numOfCoins, forKey: "numOfCoins")
        
        
        
        
        coinLabel.text = "Total Coins: \(defaults.integer(forKey: "numOfCoins"))"
        coinLabel.fontSize = 93
        coinLabel.fontColor = SKColor.yellow
        coinLabel.zPosition = 1
        coinLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.459)
        self.addChild(coinLabel)
        
       
        let highScoreLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
        highScoreLabel.text = "High Score \(highScoreNumber)"
        highScoreLabel.fontSize = 103
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.55)
        self.addChild(highScoreLabel)
        
       
        restartLabel.text = "Restart"
        restartLabel.fontSize = 80
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.16)
        self.addChild(restartLabel)
        
        // Coins for getting to curtain level
        
      if defaults.string(forKey: "doubleCoins") == "double" {
        
        if gameScore > 49 && gameScore < 100 {
            
            bonus15x2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus15x2.zPosition = 3
            bonus15x2.name = "bonus"
            bonus15x2.setScale(1.7)
            self.addChild(bonus15x2)
            
            let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0), SKAction.fadeOut(withDuration: 1.0)])
            
            bonus15x2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 30)"
            defaults.set(numOfCoins + 30, forKey: "numOfCoins")
            
        }
        
        if gameScore > 99 && gameScore < 200 {
            
            bonus2x2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus2x2.zPosition = 3
            bonus2x2.name = "bonus"
            bonus2x2.setScale(1.7)
            self.addChild(bonus2x2)
            
            let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus2x2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 40)"
            defaults.set(numOfCoins + 40, forKey: "numOfCoins")
            
        }
        
        if gameScore > 199 && gameScore < 300 {
            
            bonus3x2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus3x2.zPosition = 3
            bonus3x2.name = "bonus"
            bonus3x2.setScale(1.7)
            self.addChild(bonus3x2)
         
            let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus3x2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 40)"
            defaults.set(numOfCoins + 40, forKey: "numOfCoins")
            
        }
        
        if gameScore > 299 && gameScore < 400 {
            
            bonus4x2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus4x2.zPosition = 3
            bonus4x2.setScale(1.7)
            bonus4x2.name = "bonus"
            self.addChild(bonus4x2)
            
           let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus4x2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 100)"
            defaults.set(numOfCoins + 100, forKey: "numOfCoins")
            
        }
        
        if gameScore > 399 && gameScore < 500 {
            
            bonus5x2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus5x2.zPosition = 3
            bonus5x2.setScale(1.7)
            bonus5x2.name = "bonus"
            self.addChild(bonus5x2)
            
           let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus5x2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 100)"
            defaults.set(numOfCoins + 100, forKey: "numOfCoins")
            
        }
        
        if gameScore > 499  {
            
            bonus6x2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus6x2.zPosition = 3
            bonus6x2.setScale(1.7)
            bonus6x2.name = "bonus"
            self.addChild(bonus6x2)
            
           let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus6x2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 500)"
            defaults.set(numOfCoins + 500, forKey: "numOfCoins")
            
        }
        
        
      } else {
        
        if gameScore > 49 && gameScore < 100 {
            
            bonus15.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus15.zPosition = 3
            bonus15.setScale(1.7)
            bonus15.name = "bonus"
            self.addChild(bonus15)
            
           let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1.0), SKAction.fadeOut(withDuration: 1.0)])
            
            bonus15.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 15)"
            defaults.set(numOfCoins + 15, forKey: "numOfCoins")
            
        }
        
        if gameScore > 99 && gameScore < 200 {
            
            bonus2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus2.zPosition = 3
            bonus2.setScale(1.7)
            bonus2.name = "bonus"
            self.addChild(bonus2)
            
            let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
           bonus2.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 20)"
            defaults.set(numOfCoins + 20, forKey: "numOfCoins")
            
        }
        
        if gameScore > 199 && gameScore < 300 {
            
            bonus3.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus3.zPosition = 3
            bonus3.setScale(1.7)
            bonus3.name = "bonus"
            self.addChild(bonus3)
            
        let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
        bonus3.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 20)"
            defaults.set(numOfCoins + 20, forKey: "numOfCoins")
            
        }
        
        if gameScore > 299 && gameScore < 400 {
            
            bonus4.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus4.zPosition = 3
            bonus4.setScale(1.7)
            bonus4.name = "bonus"
            self.addChild(bonus4)
            
            
            let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus4.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 50)"
            defaults.set(numOfCoins + 50, forKey: "numOfCoins")
            
        }
        
        if gameScore > 399 && gameScore < 500 {
            
            bonus5.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus5.zPosition = 3
            bonus5.setScale(1.7)
            bonus5.name = "bonus"
            self.addChild(bonus5)
            
        let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
        bonus5.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 100)"
            defaults.set(numOfCoins + 100, forKey: "numOfCoins")
            
        }
        
        if gameScore > 499  {
            
            bonus6.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
            bonus6.zPosition = 3
            bonus6.setScale(1.7)
            bonus6.name = "bonus"
            self.addChild(bonus6)
            
            let animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 1), SKAction.fadeOut(withDuration: 1.4)])
            
            bonus6.run(SKAction.repeatForever(animateList))
            
            coinLabel.text! = "Total Coins: \(defaults.integer(forKey: "numOfCoins") + 250)"
            defaults.set(numOfCoins + 250, forKey: "numOfCoins")
            
            }
        
        
        }
        
        
    }
  
        
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointofTouch = touch.location(in: self)
             let nodeITapped = atPoint(pointofTouch)
            
            
            if restartLabel.contains(pointofTouch) {
                
                let sceneToMoveTo = battleOfCatmixia(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo)
                
                
            }
            
       if nodeITapped.name == "bonus" {
        
        bonus15x2.isHidden = true
        bonus2x2.isHidden = true
        bonus3x2.isHidden = true
        bonus4x2.isHidden = true
        bonus5x2.isHidden = true
        bonus6x2.isHidden = true
        
        bonus15.isHidden = true
        bonus2.isHidden = true
        bonus3.isHidden = true
        bonus4.isHidden = true
        bonus5.isHidden = true
        bonus6.isHidden = true
        
        
        addedLabel.text = "Coins Already Added!"
        addedLabel.fontSize = 35
        addedLabel.zPosition = 1
        addedLabel.fontColor = SKColor.yellow
        addedLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.34)
        addChild(addedLabel)
        
        let animateList = SKAction.sequence([SKAction.fadeOut(withDuration: 2.7)])
        
        addedLabel.run(SKAction.repeatForever(animateList))
        
       
        
            }
        
    }
    
    
}
    
    
    

}
