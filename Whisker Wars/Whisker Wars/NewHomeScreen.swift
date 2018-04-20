

//  Copyright © 2018 co.slushbox. All rights reserved.
//

// Make sure to credit https://www.iconfinder.com/DOTonPAPER for cat icon on home screen.
// http://cienel.net/photoshop-tutorials/quick-tip-no.-8---create-a-cartoon-space-planet-in-photoshop
//
// Github 4/10/18

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import CoreData
import StoreKit
import SwiftyStoreKit
import Social

class NewHomeScreen: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var audioPlayer = AVAudioPlayer()
    let defaults = UserDefaults()
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var upgradeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var numberOfCoins: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var privateWhiskers: UIImageView!
    
    
    var highScoreNumber = UserDefaults().integer(forKey: "highScoreSaved")
    
    override func viewDidLoad() {
        
        //  defaults.set("Music", forKey: "Music")
       
        SwiftyStoreKit.completeTransactions(atomically: true) { products in
            
            for product in products {
                
                if product.transaction.transactionState == .purchased || product.transaction.transactionState == .restored {
                    
                    if product.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(product.transaction)
                    }
                    print("purchased: \(product)")
                }
            }
        }
       
            
        // Audio player
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Meloody-2", ofType: "m4a")!))
            audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        
        if audioPlayer.isPlaying == true && defaults.string(forKey: "Music") == "NoMusic" {
            
            audioPlayer.stop()
            
        } else if audioPlayer.isPlaying == false && defaults.string(forKey: "Music") == "Music"  {
            
            audioPlayer.play()
            
        } else if audioPlayer.isPlaying == false && defaults.string(forKey: "Music") == "NoMusic" {
            
                 audioPlayer.stop()
        
        } else if audioPlayer.isPlaying == false {
            
            audioPlayer.play()
        }
        
        
       // if defaults.string(forKey: "Music") == "MusicOff" {
            
         //    audioPlayer.stop()
     //   }
        
        // Play buttin animation
        UIView.animate(withDuration: 1, animations: {
            self.playBtn.frame.origin.y -= 5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.25, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.playBtn.frame.origin.y += 5
            })
        }
        
        // cat upgrade button animation
        UIView.animate(withDuration: 1, animations: {
            self.upgradeBtn.frame.origin.y -= 3
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.90, options: [.autoreverse, .allowUserInteraction, .repeat], animations: {
                self.upgradeBtn.frame.origin.y += 3
            })
        }
        
        // social share btn animation
        UIView.animate(withDuration: 1, animations: {
            self.shareBtn.frame.origin.y -= 2
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.50, options: [.autoreverse, .allowUserInteraction, .repeat], animations: {
                self.shareBtn.frame.origin.y += 2
            })
        }
        
        // settins btn animation
        UIView.animate(withDuration: 1, animations: {
            self.settingsBtn.frame.origin.y -= 2
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 1.2, options: [.autoreverse, .allowUserInteraction, .repeat], animations: {
                self.settingsBtn.frame.origin.y += 2
            })
        }
        
        // meowbot 1 animation
        UIView.animate(withDuration: 1.0, delay: 8, animations: {
            self.privateWhiskers.frame.origin.y += 60
        
        })
        
        
        
      //  var highScoreNumber = defaults.integer(forKey: "highScoreSaved")
        scoreLbl.text = "\(highScoreNumber)"
        
       var numOfCoins = defaults.integer(forKey: "numOfCoins")
        numberOfCoins.text = "\(numOfCoins)"
    
    }
    
    @IBAction func playAction(_ sender: Any) {
        
        playBtn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.playBtn.transform = .identity
            },
                       completion: nil)
        
       audioPlayer.stop()
       audioPlayer.volume = 0
        
       if defaults.string(forKey: "Music") == "NoMusic" {
            
            audioPlayer.stop()
        audioPlayer.volume = 0

        }
        
        print("Success! Launching Player Picker")
    
    }
    
    @IBAction func upgradeBtnPressed(_ sender: Any) {
        
        upgradeBtn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.upgradeBtn.transform = .identity
            },
                       completion: nil)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coinStore") as! coinStoreVC
        self.present(nextViewController, animated:true, completion:nil)
        audioPlayer.stop()
        
    }
    @IBAction func shareBtnPressed(_ sender: Any) {
        
        
        
        shareBtn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.shareBtn.transform = .identity
            },
                       completion: nil)
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            post!.setInitialText("My high score on @WhiskerWarsGame is \(highScoreNumber). Eat it grandma. Now on the iOS App Store! #WhiskerWars")
            post!.add(UIImage(named: "whiskerWarsPromo.png"))
            
            
            self.present(post!, animated: true, completion: nil)
            
            
        } else {
            
            self.showAlert(service: "Twitter")
            
        }
        
        
    }
    @IBAction func settingsBtnPressed(_ sender: Any) {
        
     
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "settings") as! settingsVC
        self.present(nextViewController, animated:true, completion:nil)
        audioPlayer.stop()
        
    }
    
    
    func showAlert(service:String) {
        
        let alert = UIAlertController(title: "Oops", message: "Looks like you're not connected to \(service) on this device.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
   
}
