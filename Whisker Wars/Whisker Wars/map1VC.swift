//
//  map1VC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 5/22/17.
//  Copyright © 2017 co.slushbox. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import CoreData


 weak var homeBtn: UIButton!

class map1VC: UIViewController {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
         let scene = tapToBegin(size: CGSize(width: 1536, height: 2048))
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

    @IBAction func homeBtn(_ sender: Any) {
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! NewHomeScreen
        
            self.removeFromParentViewController()
        
        
           self.present(nextViewController, animated:true, completion:nil)

        
        
    }
    

   
}
