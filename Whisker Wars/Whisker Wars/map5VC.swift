//
//  map5VC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/17/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class map5VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let scene = tapToBegin4(size: CGSize(width: 1536, height: 2048))
        // configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        // enhances rendering performance
        skView.ignoresSiblingOrder = true
        
        // set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        skView.presentScene(scene)
        
        
        
        
        
        
    }
    
    @IBAction func homeBtn1(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! NewHomeScreen
        
        self.removeFromParentViewController()
        
        
        self.present(nextViewController, animated:true, completion:nil)
        
        
        
    }
    
    
    
}

