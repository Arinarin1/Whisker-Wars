//
//  settingsVC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/20/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import AVFoundation
import Social
import SpriteKit
import StoreKit
import SwiftyStoreKit

class settingsVC: UIViewController {

    @IBOutlet weak var musicBtn: UIButton!
    let defaults = UserDefaults()
    var audioPlayer = AVAudioPlayer()

    var highScoreNumber = UserDefaults().integer(forKey: "highScoreSaved")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if defaults.string(forKey: "Music") == "Music" {
            
             musicBtn.setTitle("on", for: .normal)
        }
        
         if defaults.string(forKey: "Music") == "NoMusic" {
        
             musicBtn.setTitle("Off", for: .normal)
        }
    }
 
    @IBAction func musicOnOff(_ sender: Any) {
        
        if musicBtn.titleLabel?.text! == "on" {
            
            print("Turning off")
            defaults.set("NoMusic", forKey: "Music")
            musicBtn.setTitle("Off", for: .normal)
            
            
        } else if musicBtn.titleLabel?.text! == "Off" {
            
            print("Turning On")
             defaults.set("Music", forKey: "Music")
            musicBtn.setTitle("on", for: .normal)
            
        }
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! NewHomeScreen
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func leaveReview(_ sender: Any) {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            
        } else {
            
            // Fallback on earlier versions
            let alert = UIAlertController(title: "Oops", message: "You must have iOS 10.3 or later to leave review in app. Find us in the App Store to leave a direct review.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    @IBAction func shareTwitter(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            post!.setInitialText("My high score on @WhiskerWarsGame is \(highScoreNumber). Now on the iOS App Store! #WhiskerWars")
            post!.add(UIImage(named: ""))
            
            
            self.present(post!, animated: true, completion: nil)
            
            
        } else {
            
            self.showAlert(service: "Twitter")
            
        }
        
        
        
    }
    
    @IBAction func shareFacebook(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            
            let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            post?.setInitialText("My high score on @WhiskerWarsGame is \(highScoreNumber). Now on the iOS App Store! #WhiskerWars")
            post?.add(UIImage(named: ""))
            
            self.present((post)!, animated: true, completion: nil)
            
            
        } else {
            
            self.showAlert(service: "Facebook")
        }
        
    }
    
    func showAlert(service:String) {
        
        let alert = UIAlertController(title: "Oops", message: "Looks like you're not connected to \(service) on this device.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
}

