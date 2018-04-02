//
//  playerPickerVC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/15/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import CoreData

class playerPickerVC: UIViewController {

    @IBOutlet weak var numberOfCoins: UILabel!
    
    @IBOutlet weak var catBtn1: UIButton!
    @IBOutlet weak var catBtn2: UIButton!
    @IBOutlet weak var catBtn3: UIButton!
    @IBOutlet weak var catBtn4: UIButton!
    @IBOutlet weak var catBtn5: UIButton!
    @IBOutlet weak var catBtn6: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var cat1: UIImageView!
    @IBOutlet weak var cat2: UIImageView!
    @IBOutlet weak var cat3: UIImageView!
    @IBOutlet weak var cat4: UIImageView!
    @IBOutlet weak var cat5: UIImageView!
    @IBOutlet weak var cat6: UIImageView!
    
    
    
    let defaults = UserDefaults()
    var numOfCoins = UserDefaults().integer(forKey: "numOfCoins")
    
    override func viewDidLoad() {

        UIView.animate(withDuration: 1, animations: {
            self.cat1.frame.origin.y -= 2.5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.65, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.cat1.frame.origin.y += 2.5
            })
        }
        UIView.animate(withDuration: 1, animations: {
            self.cat2.frame.origin.y -= 2.5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.10, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.cat2.frame.origin.y += 2.5
            })
        }
        UIView.animate(withDuration: 1, animations: {
            self.cat3.frame.origin.y -= 2.5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.95, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.cat3.frame.origin.y += 2.5
            })
        }
        UIView.animate(withDuration: 1, animations: {
            self.cat4.frame.origin.y -= 2.5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.70, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.cat4.frame.origin.y += 2.5
            })
        }
        UIView.animate(withDuration: 1, animations: {
            self.cat5.frame.origin.y -= 2.5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.20, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.cat5.frame.origin.y += 2.5
            })
        }
        UIView.animate(withDuration: 1, animations: {
            self.cat6.frame.origin.y -= 2.5
        }) {_ in
            UIView.animateKeyframes(withDuration: 1.2, delay: 0.61, options: [.autoreverse, .allowUserInteraction, .repeat, .beginFromCurrentState], animations: {
                self.cat6.frame.origin.y += 2.5
            })
        }
        
        
        view1.layer.cornerRadius = 5
        view2.layer.cornerRadius = 5
        view3.layer.cornerRadius = 5
        view4.layer.cornerRadius = 5
        view5.layer.cornerRadius = 5
        view6.layer.cornerRadius = 5
        
        catBtn1.layer.cornerRadius = 5
        catBtn2.layer.cornerRadius = 5
        catBtn3.layer.cornerRadius = 5
        catBtn4.layer.cornerRadius = 5
        catBtn5.layer.cornerRadius = 5
        catBtn6.layer.cornerRadius = 5
       
        numberOfCoins.text = "\(numOfCoins)"
        
        
        if defaults.string(forKey: "Purchased") == "Purchased" {
       
              catBtn2.setTitle("Play", for: .normal)
            catBtn2.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
           
            
        } else {
            
              catBtn2.setTitle("200", for: .normal)
            catBtn2.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
           
        }
        
        
        if defaults.string(forKey: "Purchased2") == "Purchased2" {
            
            catBtn3.setTitle("Play", for: .normal)
            catBtn3.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
            
        } else {
            
            catBtn3.setTitle("500", for: .normal)
            catBtn3.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
        }
        
        if defaults.string(forKey: "Purchased3") == "Purchased3" {
            
            catBtn4.setTitle("Play", for: .normal)
            catBtn4.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
            
        } else {
            
            catBtn4.setTitle("1000", for: .normal)
            catBtn4.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
        }
        
        if defaults.string(forKey: "Purchased4") == "Purchased4" {
            
            catBtn5.setTitle("Play", for: .normal)
            catBtn5.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
            
        } else {
            
            catBtn5.setTitle("2000", for: .normal)
            catBtn5.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
        }
        
        if defaults.string(forKey: "Purchased5") == "Purchased5" {
            
            catBtn6.setTitle("Play", for: .normal)
            catBtn6.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
            
        } else {
            
            catBtn6.setTitle("4000", for: .normal)
            catBtn6.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            
        }
        
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VC") as! NewHomeScreen
        self.present(nextViewController, animated:false, completion:nil)
        
     
    }
    
    @IBAction func playCat2(_ sender: Any) {
        
        if catBtn2.titleLabel?.text == "Play" {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map2") as! map2VC
            self.present(nextViewController, animated:true, completion:nil)
            
            print("Success! Starting Tap to Begin - Map 2")
            
        }
        
        if numOfCoins > 199 {
            
            print("User has enough")
            catBtn2.setTitle("Play", for: .normal)
            catBtn2.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            defaults.set("Purchased", forKey: "Purchased")
           
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 200)"
            defaults.set(numOfCoins - 200, forKey: "numOfCoins")
            
        } else {
            
            print("Not enough coins")
          //  catBtn2.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
          //  catBtn2.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
           
            UIView.animate(withDuration: 0.2, animations: {
                self.catBtn2.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.catBtn2.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.catBtn2.transform = CGAffineTransform.identity
                    self.catBtn2.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
                })
            })
            
        }
        
    }
    
    @IBAction func playCat3(_ sender: Any) {
        
        if catBtn3.titleLabel?.text == "Play" {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map3") as! map3VC
            self.present(nextViewController, animated:true, completion:nil)
            
            print("Success! Starting Tap to Begin - Map 2")
            
        }
        
        if numOfCoins > 499 {
            
            print("User has enough")
            catBtn3.setTitle("Play", for: .normal)
            catBtn3.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            defaults.set("Purchased2", forKey: "Purchased2")
            
            //  numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 10)"
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 500)"
            defaults.set(numOfCoins - 500, forKey: "numOfCoins")
            
            
        } else {
            
            print("Not enough coins")
            //  catBtn2.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            //  catBtn2.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.catBtn3.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.catBtn3.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.catBtn3.transform = CGAffineTransform.identity
                    self.catBtn3.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
                })
            })
            
        }
        
        
    }
    
    
    @IBAction func playCat4(_ sender: Any) {
        
        if catBtn4.titleLabel?.text == "Play" {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map4") as! map4VC
            self.present(nextViewController, animated:true, completion:nil)
            
            print("Success! Starting Tap to Begin - Map 2")
            
        }
        
        if numOfCoins > 999 {
            
            print("User has enough")
            catBtn4.setTitle("Play", for: .normal)
            catBtn4.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            defaults.set("Purchased3", forKey: "Purchased3")
            
            //  numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 10)"
        
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 1000)"
            defaults.set(numOfCoins - 1000, forKey: "numOfCoins")
        
            
            
        } else {
            
            print("Not enough coins")
            //  catBtn4.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            //  catBtn4.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.catBtn4.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.catBtn4.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.catBtn4.transform = CGAffineTransform.identity
                    self.catBtn4.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
                })
            })
            
        }
        
        
    }
    
    
    @IBAction func playCat5(_ sender: Any) {
        
        if catBtn5.titleLabel?.text == "Play" {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map5") as! map5VC
            self.present(nextViewController, animated:true, completion:nil)
            
            print("Success! Starting Tap to Begin - Map 2")
            
        }
        
        if numOfCoins > 1999 {
            
            print("User has enough")
            catBtn5.setTitle("Play", for: .normal)
            catBtn5.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            defaults.set("Purchased4", forKey: "Purchased4")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 2000)"
            defaults.set(numOfCoins - 2000, forKey: "numOfCoins")
            
          
            
        } else {
            
            print("Not enough coins")
            //  catBtn4.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            //  catBtn4.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.catBtn5.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.catBtn5.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.catBtn5.transform = CGAffineTransform.identity
                    self.catBtn5.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
                })
            })
            
        }
        
    }
    
    @IBAction func playCat6(_ sender: Any) {
        
        if catBtn6.titleLabel?.text == "Play" {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map6") as! map6VC
            self.present(nextViewController, animated:true, completion:nil)
            
            print("Success! Starting Tap to Begin - Map 2")
            
        }
        
        if numOfCoins > 3999 {
            
            print("User has enough")
            catBtn6.setTitle("Play", for: .normal)
            catBtn6.titleLabel?.font = UIFont(name: "House Paint Slab", size:23)
            defaults.set("Purchased5", forKey: "Purchased5")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 4000)"
            defaults.set(numOfCoins - 4000, forKey: "numOfCoins")
            
        } else {
            
            print("Not enough coins")
            //  catBtn4.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            //  catBtn4.backgroundColor = UIColor(red: 0/255, green: 235/255, blue: 151/255, alpha: 1)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.catBtn6.transform = CGAffineTransform.identity.scaledBy(x: 0.77, y: 0.77)
                self.catBtn6.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
            }, completion: { (finish) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.catBtn6.transform = CGAffineTransform.identity
                    self.catBtn6.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 67/255, alpha: 1)
                })
            })
            
        }
        
    
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func playCat1(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "map1") as! map1VC
        self.present(nextViewController, animated:true, completion:nil)
        
        print("Success! Starting Tap to Begin")
        
    }
    
}
