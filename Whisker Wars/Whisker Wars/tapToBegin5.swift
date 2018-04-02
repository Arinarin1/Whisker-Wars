//
//  tapToBegin5.swift
//  Whisker Wars
//
//  Created by Arin Waichulis on 3/18/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class tapToBegin5: SKScene {

    let tapToBegin = SKLabelNode(fontNamed: "House-Paint-Slab")
    
    let tip = SKLabelNode(fontNamed: "House-Paint-Slab")
    
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
        
        let drag = SKSpriteNode(imageNamed: "dragThumb.png")
        drag.setScale(1.5)
        drag.position = CGPoint(x: self.size.width / 2.40, y: self.size.height / 2)
        drag.zPosition = 1
        self.addChild(drag)
        
        let press = SKSpriteNode(imageNamed: "pressThumb.png")
        press.setScale(1.5)
        press.position = CGPoint(x: self.size.width / 1.78, y: self.size.height / 2)
        press.zPosition = 1
        self.addChild(press)
        
        let iphone = SKSpriteNode(imageNamed: "iPhoneDrawing.png")
        iphone.setScale(1.2)
        iphone.position = CGPoint(x: self.size.width / 2.03, y: self.size.height / 1.6)
        iphone.zPosition = 1
        self.addChild(iphone)
        
        
        
        tapToBegin.text = "Tap to Begin"
        tapToBegin.name = "tap"
        tapToBegin.fontSize = 70
        tapToBegin.fontColor = SKColor.white
        tapToBegin.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        tapToBegin.position = CGPoint (x: self.size.width / 3, y: self.size.height / 2.5)
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
                
                
                
                
                let sceneToMoveTo = battleOfCatmixia5(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                sceneToMoveTo.zPosition = 1
                // let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo)
                
                
                
            }
            
            
            
            
        }
        
    }
    
    
    
    
}




