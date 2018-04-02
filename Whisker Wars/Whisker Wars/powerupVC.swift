//
//  powerupVC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/19/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit

class powerupVC: UIViewController {

    @IBOutlet weak var powerupBtn1: UIButton! // extra life
    @IBOutlet weak var powerupBtn2: UIButton! // meteor advantage
    @IBOutlet weak var powerupBtn3: UIButton! // shock wave
    @IBOutlet weak var powerupBtn4: UIButton! // lil kitty
    @IBOutlet weak var numberOfCoins: UILabel!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var infoLbl1: UILabel!
    @IBOutlet weak var infoLbl2: UILabel!
    @IBOutlet weak var infoLbl3: UILabel!
    @IBOutlet weak var infoLbl4: UILabel!
    
    @IBOutlet weak var qLbl1: UILabel!
    @IBOutlet weak var qLbl2: UILabel!
    @IBOutlet weak var qLbl3: UILabel!
    @IBOutlet weak var qLbl4: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    
    let defaults = UserDefaults()
    var numOfCoins = UserDefaults().integer(forKey: "numOfCoins")
    var highScoreNumber = UserDefaults().integer(forKey: "highScoreSaved")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        powerupBtn1.layer.cornerRadius = 5
        powerupBtn2.layer.cornerRadius = 5
        powerupBtn3.layer.cornerRadius = 5
        powerupBtn4.layer.cornerRadius = 5
        
        view1.layer.cornerRadius = 5
        view2.layer.cornerRadius = 5
        view3.layer.cornerRadius = 5
        view4.layer.cornerRadius = 5
        view5.layer.cornerRadius = 5
        view6.layer.cornerRadius = 5
        
        
        score.text = "\(highScoreNumber)"
        
        numberOfCoins.text = "\(numOfCoins)"
        
        // Remembering if the user bought the item
         if defaults.string(forKey: "powerup1Purchased") == "powerup1Purchased" {
            
            powerupBtn1.isHidden = true
            qLbl1.text = "1/1"
        }
        if defaults.string(forKey: "powerup1Purchased") == "powerup1Purchase" {
    
            powerupBtn1.isHidden = false
            qLbl1.text = "0/1"
        }
        
        if defaults.string(forKey: "powerup2Purchased") == "powerup2Purchased" {
            
            powerupBtn2.isHidden = true
            qLbl2.text = "1/1"
        }
        if defaults.string(forKey: "powerup2Purchased") == "powerup2Purchase" {
            
            powerupBtn2.isHidden = false
            qLbl2.text = "0/1"
        }
     
        if defaults.string(forKey: "powerup3Purchased") == "powerup3Purchased" {
            
            powerupBtn3.isHidden = true
            qLbl3.text = "1/1"
        }
        if defaults.string(forKey: "powerup3Purchased") == "powerup3Purchase" {
            
            powerupBtn3.isHidden = false
            qLbl3.text = "0/1"
        }
        
        if defaults.string(forKey: "powerup4Purchased") == "powerup4Purchased" {
            
            powerupBtn4.isHidden = true
            qLbl4.text = "1/1"
        }
        if defaults.string(forKey: "powerup4Purchased") == "powerup4Purchase" {
            
            powerupBtn4.isHidden = false
            qLbl4.text = "0/1"
        }
    }
    

    @IBAction func powerup1(_ sender: Any) {
        
        // success user has enough coins and high score is met
        if numOfCoins > 14 && highScoreNumber > 0 {
            
            print("Success")
            qLbl1.text = "1/1"
            powerupBtn1.isHidden = true
            defaults.set("powerup1Purchased", forKey: "powerup1Purchased")
        
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 20)"
            defaults.set(numOfCoins - 20, forKey: "numOfCoins")
            
            // high score is met but not enough coins
            } else if numOfCoins < 20 && highScoreNumber > 20 {
            
            self.infoLbl1.text = "Not enough coins.."
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl1.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl1.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl1.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
            
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl1.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl1.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl1.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
        }
    }
    
    @IBAction func powerup2(_ sender: Any) {
        
        // success user has enough coins and high score is met
        if numOfCoins > 24 && highScoreNumber > 0 {
            
            print("Success")
            qLbl2.text = "1/1"
            powerupBtn2.isHidden = true
            defaults.set("powerup2Purchased", forKey: "powerup2Purchased")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 25)"
            defaults.set(numOfCoins - 25, forKey: "numOfCoins")
            
            // high score is met but not enough coins
        } else if numOfCoins < 25 && highScoreNumber > 39 {
            
            self.infoLbl2.text = "Not enough coins.."
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl2.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl2.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl2.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
            
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl2.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl2.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl2.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
        }
        
    }
    
    @IBAction func powerup3(_ sender: Any) {
        
        // success user has enough coins and high score is met
        if numOfCoins > 29 && highScoreNumber > 0 {
            
            print("Success")
            qLbl3.text = "1/1"
            powerupBtn3.isHidden = true
            defaults.set("powerup3Purchased", forKey: "powerup3Purchased")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 30)"
            defaults.set(numOfCoins - 30, forKey: "numOfCoins")
            
            // high score is met but not enough coins
        } else if numOfCoins < 30 && highScoreNumber > 99 {
            
            self.infoLbl3.text = "Not enough coins.."
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl3.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl3.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl3.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
            
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl3.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl3.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl3.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
        }
        
    }
    
    
    @IBAction func powerup4(_ sender: Any) {
        
        // success user has enough coins and high score is met
        if numOfCoins > 34 && highScoreNumber > 0 {
            
            print("Success")
            qLbl4.text = "1/1"
            powerupBtn4.isHidden = true
            defaults.set("powerup4Purchased", forKey: "powerup4Purchased")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 35)"
            defaults.set(numOfCoins - 35, forKey: "numOfCoins")
            
            // high score is met but not enough coins
        } else if numOfCoins < 35 && highScoreNumber > 199 {
            
            self.infoLbl4.text = "Not enough coins.."
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl4.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl4.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl4.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
            
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.infoLbl4.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.infoLbl4.textColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.infoLbl4.transform = CGAffineTransform.identity
                    //self.powerupBtn1.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
                })
            })
            
        }
        
        
    }
    
    @IBAction func buyNow1(_ sender: Any) {
        
        
    }
    
    @IBAction func buyNow2(_ sender: Any) {
        
        
    }
    
}
