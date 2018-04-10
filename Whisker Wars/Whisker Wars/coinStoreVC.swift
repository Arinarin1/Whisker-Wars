//
//  coinStoreVC.swift
//  Whisker Wars
//
//  Created by arinrocksout on 3/24/18.
//  Copyright © 2018 co.slushbox. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

 let sharedSecret = "d639b86a32b7485ab9dbfad90ffbcdda"

enum RegisteredPurchase: String {
    case AddCoins1 = "AddCoins1"
    case AddCoins2 = "AddCoins2"
    case AddCoins3 = "AddCoins3"
    case AddCoins4 = "AddCoins4"
    case AddCoins5 = "AddCoins5"
    case RemoveAds = "RemoveAds"
    case DoubleCoins = "DoubleCoins"
    
}

class NetworkActivityIndicatorManager: NSObject {
    
    private static var loadingCount = 0
    class func NetworkOperationStarted() {
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
        
    }
    
    class func NetworkOperationFinished() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            }
        }
        
    }

class coinStoreVC: UIViewController {

    let bundleID = "com.slushbox.WhiskerWars"
    @IBOutlet weak var purchase1Btn: UIButton!
    @IBOutlet weak var purchase2Btn: UIButton!
    @IBOutlet weak var purchase3Btn: UIButton!
    @IBOutlet weak var purchase4Btn: UIButton!
    @IBOutlet weak var purchase5Btn: UIButton!
    
    @IBOutlet weak var numberOfCoins: UILabel!
    @IBOutlet weak var coinFeverBtn: UIButton!
    @IBOutlet weak var removeAdsBtn: UIButton!
    @IBOutlet weak var restorePurchases: UIButton!
    @IBOutlet weak var watchFreeVideoBtn: UIButton!
    
    let defaults = UserDefaults()
    var numOfCoins = UserDefaults().integer(forKey: "numOfCoins")
    
    let AddCoins1 = RegisteredPurchase.AddCoins1
    let AddCoins2 = RegisteredPurchase.AddCoins2
    let AddCoins3 = RegisteredPurchase.AddCoins3
    let AddCoins4 = RegisteredPurchase.AddCoins4
    let AddCoins5 = RegisteredPurchase.AddCoins5
    let RemoveAds = RegisteredPurchase.RemoveAds
    let DoubleCoins = RegisteredPurchase.DoubleCoins
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Chartboost.setDelegate(self)
        
        
         if defaults.string(forKey: "doubleCoins") == "double" {
         
            coinFeverBtn.setTitle("Active", for: .normal)
            
        }
        
        if defaults.string(forKey: "removeAds") == "removeAds" {
            
            removeAdsBtn.setTitle("Active", for: .normal)
            
        }
        
        numberOfCoins.text = "\(numOfCoins)"
        purchase1Btn.layer.cornerRadius = 5
        purchase2Btn.layer.cornerRadius = 5
        purchase3Btn.layer.cornerRadius = 5
        purchase4Btn.layer.cornerRadius = 5
        purchase5Btn.layer.cornerRadius = 5
        coinFeverBtn.layer.cornerRadius = 5
        removeAdsBtn.layer.cornerRadius = 5
        watchFreeVideoBtn.layer.cornerRadius = 5
        
        view1.layer.cornerRadius = 5
        view2.layer.cornerRadius = 5
        view3.layer.cornerRadius = 5
        view4.layer.cornerRadius = 5
        view5.layer.cornerRadius = 5
        view6.layer.cornerRadius = 5
        view7.layer.cornerRadius = 5
        view8.layer.cornerRadius = 5
        
        
    }

    @IBAction func purchase1(_ sender: Any) {
        purchase(AddCoins1)
        purchase1Btn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.purchase1Btn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
    }
    
    @IBAction func purchase2(_ sender: Any) {
        purchase(AddCoins2)
        
        purchase2Btn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.purchase2Btn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
    }

    @IBAction func purchase3(_ sender: Any) {
         purchase(AddCoins3)
        purchase3Btn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.purchase3Btn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
        
    }
    
    @IBAction func purchase4(_ sender: Any) {
         purchase(AddCoins4)
        purchase4Btn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.purchase4Btn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
        
    }
    
    @IBAction func purchase5(_ sender: Any) {
         purchase(AddCoins5)
        purchase5Btn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.purchase5Btn.transform = .identity
            },
                       completion: nil)
        
        print("Tapped")
    }
    
    @IBAction func doubleCoinPressed(_ sender: Any) {
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
    
    @IBAction func removeAdsPressed(_ sender: Any) {
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
    
    @IBAction func restorePurchase(_ sender: Any) {
        NetworkActivityIndicatorManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
            result in
            NetworkActivityIndicatorManager.NetworkOperationFinished()
            for product in result.restoredPurchases {
                
               // if product.productId == "slushbox.Weather.donate0.99" {
                    
                  //  defaults.set("purchased1", forKey: "purchased1")
                    
                   // print("Restored purchase 1")
             //   }
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
    
    @IBAction func watchFreeVideo(_ sender: Any) {
        
         Chartboost.start(withAppId: "5ac06578f7c1590bbdfdf5d1", appSignature: "f57aed811e696e414e94b009afae7d594a96375e", delegate: nil)
        Chartboost.showRewardedVideo(CBLocationMainMenu)
        Chartboost.cacheRewardedVideo(CBLocationMainMenu)
        Chartboost.setDelegate(self)
        watchFreeVideoBtn.transform = CGAffineTransform(scaleX: 0.83, y: 0.83)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.watchFreeVideoBtn.transform = .identity
            },
                       completion: nil)
        
        
        
    print("Tappped")
        
    }
    
    
    
    }


extension coinStoreVC: ChartboostDelegate {
    
    func didPrefetchVideos() {
        
    }
    
    func shouldDisplayRewardedVideo(location: String!) -> Bool {
        return true
    }
    
    func didDisplayRewardedVideo(location: String!) {
        
          print("Displaying Video")
    }
    
    func didCacheRewardedVideo(location: String!) {
        
          print("Cached Video")
    }
    
    func didFailToLoadRewardedVideo(location: String!, withError error: CBLoadError) {
        print("Failed to load rewarded video: \(error)")
    }
    
    func didDismissRewardedVideo(location: String!) {
    }
    
    func didCloseRewardedVideo(location: String!) {
        print("Closed Video")
    }
    
    func didClickRewardedVideo(location: String!) {
    }
    
    func didCompleteRewardedVideo(location: String!, withReward reward: Int32) {
        
        numberOfCoins.text! = "\(defaults.integer(forKey: "numOfCoins") + 5)"
        defaults.set(numOfCoins + 5, forKey: "numOfCoins")
        
        print("Did complete video")
        
    }
    
    func willDisplayVideo(location: String!) {
    }
    
    
    
    
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
              coinFeverBtn.setTitle("Active", for: .normal)
              removeAdsBtn.setTitle("Active", for: .normal)
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






