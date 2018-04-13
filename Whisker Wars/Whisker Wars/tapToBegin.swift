//
//  tapToBegin.swift
//  Whisker Wars
//
//  Created by arinrocksout on 4/16/17.
//  Copyright © 2017 co.slushbox. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit



class tapToBegin: SKScene {
    
    let tapToBegin = SKLabelNode(fontNamed: "House-Paint-Slab")

    let tip = SKLabelNode(fontNamed: "House-Paint-Slab")
    
      var audioPlayer = SKAudioNode()
    
    override func didMove(to view: SKView) {
        

        tip.text = " "
        tip.fontSize = 40
        tip.fontColor = SKColor.white
        tip.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        tip.position = CGPoint (x: self.size.width / 7, y: self.size.height / 4)
        tip.zPosition = 4
        self.addChild(tip)
        
        
        let background = SKSpriteNode(imageNamed: "WWFINAL.png")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = 0
        self.addChild(background)
       
        
        let press = SKSpriteNode(imageNamed: "info2.png")
        press.setScale(1.8)
        press.position = CGPoint(x: self.size.width / 2, y: self.size.height / 4.6)
        press.zPosition = 1
        self.addChild(press)
        
        let iphone = SKSpriteNode(imageNamed: "introHelp.png")
        iphone.setScale(1.9)
        iphone.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.5)
        iphone.zPosition = 1
        self.addChild(iphone)
        
        
        tapToBegin.text = "Tap to Begin"
        tapToBegin.name = "tap"
        tapToBegin.fontSize = 70
        tapToBegin.fontColor = SKColor.white
        tapToBegin.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        tapToBegin.position = CGPoint (x: self.size.width / 2, y: self.size.height / 2.7)
        tapToBegin.zPosition = 4
        
        var animateList = SKAction.sequence([SKAction.fadeIn(withDuration: 0.88), SKAction.fadeOut(withDuration: 0.88)])
        
       tapToBegin.run(SKAction.repeatForever(animateList))
        
        
        self.addChild(tapToBegin)
    }
    
    
    
    
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            
            if nodeITapped.name == "tap" {
                
                
                
                let sceneToMoveTo = battleOfCatmixia(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
               sceneToMoveTo.zPosition = 1
               // let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo)
                
                
                
            }
            
            
            
            
        }
        
    }

    
    
    
}
