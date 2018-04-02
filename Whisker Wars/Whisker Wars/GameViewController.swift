//
//  GameViewController.swift
//  Whisker Wars
//
//  Created by arinrocksout on 2/21/17.
//  Copyright © 2017 co.slushbox. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import CoreData

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let reuseIndentifier = "wwCell"
    let reuseIndentifier2 = "wwwCell"

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewController: UIViewController?
    
   // scene.viewController = self
    
    var Array = [String]()
    
     var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    //    scoreLbl.text = "\(gameScore)"
        
        Array = ["Battle of Catmixia", "War for Hairballia", "Revange of Pushakitty", "The fall of the Meow Order"]
        
        
        if Array == ["Battle for instagram"] {
            
            
            
            
        }
        
        
        
        
           }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Array.count
        
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: indexPath) as! battleOfCatmixiaCell
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier2, for: indexPath) as! battleOfCatmixiaCell
        
        let defaults = UserDefaults()
        var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        
        if gameScore > highScoreNumber {
            
            highScoreNumber = gameScore
            defaults.set(highScoreNumber, forKey: "highScoreSaved")
            
        }
        
        
                
        
        
         cell.myLabel.text = self.Array[indexPath.item]
        // cell.highScoreLbl.text = "\(highScoreNumber)"
        
        
        
   
        return cell
            
        
        
    }
    
    // this function is function is called  when the cat is touch on the right side of the screen
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
          
            
          // collectionView.isHidden = true
            
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map1") as! map1VC
               self.present(nextViewController, animated:true, completion:nil)

            print("You selected cell \(indexPath.item)")
            
        }
        
    if indexPath.item == 1 {
            
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map1") as! map1VC
        self.present(nextViewController, animated:true, completion:nil)
        
        print("You selected cell \(indexPath.item)")

        
        // this is the selected cell method called when cat is touched
            
        }

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.size.width - 80, height: self.collectionView.bounds.size.height - 40)
    }
    
    
    
  
}


//  let scene = homeScreen(size: CGSize(width: 1536, height: 2048))
// configure the view.
//  let skView = self.view as! SKView
//  skView.showsFPS = true
//   skView.showsNodeCount = true

// enhances rendering performance
//  skView.ignoresSiblingOrder = true

// set the scale mode to scale to fit the window
//  scene.scaleMode = .aspectFill

//   skView.presentScene(scene)

