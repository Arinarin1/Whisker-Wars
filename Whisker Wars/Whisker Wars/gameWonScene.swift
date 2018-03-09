//
//  gameWonScene.swift
//  Whisker Wars
//
//  Created by arinrocksout on 4/25/17.
//  Copyright © 2017 co.slushbox. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation


class gameWonScene: SKScene {
    
    
    
    let restartLabel = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    
    
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "WWFINAL.png")
        
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
        self.addChild(gameOverLabel)
        
        let gameOverLabel2 = SKLabelNode(fontNamed: "House-Paint-Slab")
        gameOverLabel2.text = "was saved!"
        gameOverLabel2.fontSize = 140
        gameOverLabel2.fontColor = SKColor.white
        gameOverLabel2.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.73)
        gameOverLabel2.zPosition = 1
        self.addChild(gameOverLabel2)
        
        
        
        
                   
        
        restartLabel.text = "CONGRATS! Here's 1000 coins!"
        restartLabel.fontSize = 90
        restartLabel.fontColor = SKColor.white
        restartLabel.zPosition = 1
        restartLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.3)
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
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
                
            }
            
            
            
            

            
            
        }
        
        
        
        
        
        
        
        
    }
    
}
