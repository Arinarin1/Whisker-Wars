//
//  powerupVC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/19/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit




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
    
    @IBOutlet weak var coinFeverBtn: UIButton!
    @IBOutlet weak var removeAdsBtn: UIButton!
    @IBOutlet weak var restorePurchases: UIButton!
    
    let defaults = UserDefaults()
    var numOfCoins = UserDefaults().integer(forKey: "numOfCoins")
    var highScoreNumber = UserDefaults().integer(forKey: "highScoreSaved")
    
     let bundleID = "com.slushbox.WhiskerWars"
    
    let RemoveAds = RegisteredPurchase.RemoveAds
    let DoubleCoins = RegisteredPurchase.DoubleCoins
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        if defaults.string(forKey: "doubleCoins") == "double" {
            
            coinFeverBtn.setTitle("Active", for: .normal)
            coinFeverBtn.isEnabled = false
            
        }
        
        if defaults.string(forKey: "removeAds") == "removeAds" {
            
            removeAdsBtn.setTitle("Active", for: .normal)
            removeAdsBtn.isEnabled = false
        }
    
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
        if numOfCoins > 14 && highScoreNumber > 49 {
            
            print("Success")
            qLbl1.text = "1/1"
            powerupBtn1.isHidden = true
            defaults.set("powerup1Purchased", forKey: "powerup1Purchased")
        
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 15)"
            defaults.set(numOfCoins - 15, forKey: "numOfCoins")
            
            // high score is met but not enough coins
            } else if numOfCoins < 15 && highScoreNumber > 49 {
            
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
        if numOfCoins > 24 && highScoreNumber > 74 {
            
            print("Success")
            qLbl2.text = "1/1"
            powerupBtn2.isHidden = true
            defaults.set("powerup2Purchased", forKey: "powerup2Purchased")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 25)"
            defaults.set(numOfCoins - 25, forKey: "numOfCoins")
            
            // high score is met but not enough coins
        } else if numOfCoins < 25 && highScoreNumber > 74 {
            
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
        if numOfCoins > 34 && highScoreNumber > 149 {
            
            print("Success")
            qLbl4.text = "1/1"
            powerupBtn4.isHidden = true
            defaults.set("powerup4Purchased", forKey: "powerup4Purchased")
            
            numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") - 35)"
            defaults.set(numOfCoins - 35, forKey: "numOfCoins")
            
            // high score is met but not enough coins
        } else if numOfCoins < 35 && highScoreNumber > 149 {
            
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
        
        purchase(DoubleCoins)
        coinFeverBtn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.coinFeverBtn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
        
    }
    
    @IBAction func buyNow2(_ sender: Any) {
        
        purchase(RemoveAds)
        removeAdsBtn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.removeAdsBtn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
    }
    
    @IBAction func restorePurchases(_ sender: Any) {
        
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
            result in
            NetworkActivityIndicatorManager.NetworkOperationFinished()
            for product in result.restoredPurchases {
                
                if product.productId == "com.slushbox.WhiskerWars.DoubleCoins" {
                    
                    self.defaults.set("double", forKey: "doubleCoins")
                    
                    print("Restored Double Coins")
                }
                
                if product.productId == "com.slushbox.WhiskerWars.RemoveAds" {
                    
                    self.defaults.set("removeAds", forKey: "removeAds")
                    
                    print("Restored remove ads")
                }
                
                
                
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                
            }
            self.showAlert(alert: self.alertForRestorePurchases(results: result))
            
        })
        
        restorePurchases.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.restorePurchases.transform = .identity
            },
                       completion: nil)
    }
    

    func getInfo(purchase: RegisteredPurchase) {
        
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue], completion: {
            result in
            NetworkActivityIndicatorManager.NetworkOperationFinished()
            self.showAlert(alert: self.alertForProductRetrievalInfo(result: result))
        })
        
    }
    
    func purchase(_ purchase: RegisteredPurchase) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue, atomically: true, completion: {
            result in
            NetworkActivityIndicatorManager.NetworkOperationFinished()
            if case .success(let product) = result {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            if let alert = self.alertForPurchaseResult(result: result) {
                self.showAlert(alert: alert)
            }
        })
    }
    
    func verifyPurchase(purchase: RegisteredPurchase) {
        
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
            result in
            NetworkActivityIndicatorManager.NetworkOperationFinished()
            for product in result.restoredPurchases {
                
                if product.productId == "com.slushbox.WhiskerWars.DoubleCoins" {
                    
                    self.defaults.set("double", forKey: "doubleCoins")
                    
                    print("Restored Double Coins")
                }
                
                if product.productId == "com.slushbox.WhiskerWars.RemoveAds" {
                    
                    self.defaults.set("removeAds", forKey: "removeAds")
                    
                    print("Restored remove ads")
                }
                
                
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                    
                }
                
            }
            self.showAlert(alert: self.alertForRestorePurchases(results: result))
            
            
        })
        
        restorePurchases.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.restorePurchases.transform = .identity
            },
                       completion: nil)
    }
    
    
}


extension powerupVC {
    
    
    
    func alertWithTitle(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func showAlert(alert: UIAlertController) {
        
        guard self.presentedViewController != nil else {
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    func alertForProductRetrievalInfo(result: RetrieveResults) -> UIAlertController {
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        } else if let invalidProductId = result.invalidProductIDs.first {
            return alertWithTitle(title: "Could not retrieve info", message: "Invalid product identifier: \(invalidProductId)")
        } else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Try again later."
            return alertWithTitle(title: "Could not retrieve product info", message: errorString)
        }
    }
    
    func alertForPurchaseResult(result: PurchaseResult) -> UIAlertController? {
        switch result {
        case .success(let product):
            
            if product.productId == "com.slushbox.WhiskerWars.AddCoins1" {
                
                numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") + 500)"
                defaults.set(numOfCoins + 500, forKey: "numOfCoins")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coinStore") as! coinStoreVC
                self.present(nextViewController, animated:false, completion:nil)
                
                print("**** Refreshing ****")
                
            }
            
            if product.productId == "com.slushbox.WhiskerWars.AddCoins2" {
                
                numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") + 1100)"
                defaults.set(numOfCoins + 1100, forKey: "numOfCoins")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coinStore") as! coinStoreVC
                self.present(nextViewController, animated:false, completion:nil)
            }
            
            if product.productId == "com.slushbox.WhiskerWars.AddCoins3" {
                
                numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") + 3000)"
                defaults.set(numOfCoins + 3000, forKey: "numOfCoins")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coinStore") as! coinStoreVC
                self.present(nextViewController, animated:false, completion:nil)
                
            }
            
            if product.productId == "com.slushbox.WhiskerWars.AddCoins4" {
                
                numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") + 6500)"
                defaults.set(numOfCoins + 65000, forKey: "numOfCoins")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coinStore") as! coinStoreVC
                self.present(nextViewController, animated:false, completion:nil)
                
            }
            
            if product.productId == "com.slushbox.WhiskerWars.AddCoins5" {
                
                numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") + 20000)"
                defaults.set(numOfCoins + 20000, forKey: "numOfCoins")
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "coinStore") as! coinStoreVC
                self.present(nextViewController, animated:false, completion:nil)
                
            }
            
            if product.productId == "com.slushbox.WhiskerWars.DoubleCoins" {
                self.defaults.set("double", forKey: "doubleCoins")
                coinFeverBtn.setTitle("Active", for: .normal)
                
                print("You now will earn double coins")
            }
            
            if product.productId == "com.slushbox.WhiskerWars.RemoveAds" {
                self.defaults.set("removeAds", forKey: "removeAds")
                removeAdsBtn.setTitle("Active", for: .normal)
                print("***** Successfully Removed Ads *****")
            }
            
            return alertWithTitle(title: "Coin Store", message: "Thank you and enjoy!")
            
        case .error(let error):
            print("Purchase failed: \(error)")
            switch error.code {
            case .unknown:
                return alertWithTitle(title: "Purchase failed ):", message: "Unknown error. Please try again later.")
            case .clientInvalid:
                return alertWithTitle(title: "Purchase failed", message: "You're not allowed to make the payment")
            case .paymentInvalid:
                return alertWithTitle(title: "Purchase failed ):", message: "Unknown error. Please try again later")
            case .paymentNotAllowed:
                return alertWithTitle(title: "Purchase failed", message: "The device is not allowed to make any payment")
            case .storeProductNotAvailable:
                return alertWithTitle(title: "Purchase failed", message: "Item is currently out of stock.")
            case .cloudServicePermissionDenied:
                return alertWithTitle(title: "Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed:
                return alertWithTitle(title: "Purchase failed", message: "Unable to connect to the internet. Please check your internet connection or try again later")
            case .cloudServiceRevoked:
                return alertWithTitle(title: "Purchase failed", message: "Cloud service was revoked")
            case .paymentCancelled:
                return alertWithTitle(title: "Purchase failed", message: "You've cancelled the transaction")
                
            }
        }
        
    }
    
    
    func alertForRestorePurchases(results: RestoreResults) -> UIAlertController {
        if results.restoreFailedPurchases.count > 0 {
            return alertWithTitle(title: "Restored failed", message: "Unknown error. Please try again later.")
        } else if results.restoredPurchases.count > 0 {
            
            
            print("Restore Success: \(results.restoredPurchases)")
            
            
            return alertWithTitle(title: "Purchase Restored", message: "All purchases have been restored!")
            
            
        } else {
            return alertWithTitle(title: "Nothing to restore", message: "No previous purchases were found")
        }
        
    }
    
    func alertForVerifyReceipts(result: VerifyReceiptResult) -> UIAlertController {
        switch result {
        case .success:
            return alertWithTitle(title: "Receipt Verified", message: "Receipt verified remotely")
        case .error(let error):
            switch error {
            case .noRemoteData:
                return alertWithTitle(title: "Receipt Verification", message: "No receipt data, application will try to get one for you. Try again later")
            default:
                return alertWithTitle(title: "Receipt Verification", message: "Receipt verification failed")
            }
        }
    }
    
    
}

