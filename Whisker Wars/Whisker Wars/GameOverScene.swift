//
//  GameOverScene.swift
//  Whisker Wars
//
//  Created by arinrocksout on 1/19/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class GameOverScene: SKScene {
    
    
     let restartLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    let homeLevel = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    
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
        
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        var numOfCoins = defaults.integer(forKey: "numOfCoins")
        
        if gameScore > highScoreNumber {
            
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
            
        }
        
        numOfCoins += coinsFromGame
        defaults.set(numOfCoins, forKey: "numOfCoins")
        
        
        let coinLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
        coinLabel.text = "Total Coins: \(defaults.integer(forKey: "numOfCoins"))"
        coinLabel.fontSize = 100
        coinLabel.fontColor = SKColor.yellow
        coinLabel.zPosition = 1
        coinLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.459)
        self.addChild(coinLabel)
        
       
        let highScoreLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
        highScoreLabel.text = "High Score \(highScoreNumber)"
        highScoreLabel.fontSize = 112
        highScoreLabel.fontColor = SKColor.white
        highScoreLabel.zPosition = 1
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.55)
        self.addChild(highScoreLabel)
        
       
        restartLabel.text = "Restart"
        restartLabel.fontSize = 80
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.26)
        self.addChild(restartLabel)
        
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
            
           
         
           
       
        
    }
    
    
}
    
    
    

}
