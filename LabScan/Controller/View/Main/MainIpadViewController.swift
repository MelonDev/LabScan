//
//  MainIpadViewController.swift
//  LabScan
//
//  Created by Android on 14/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class MainIpadViewController: UIViewController {

    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var scanImageView: UIImageView!
    @IBOutlet weak var scanBtn: UIButton!
    
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var historyBtn: UIButton!
    
    @IBOutlet weak var bookView: UIView!
    @IBOutlet weak var bookBtn: UIButton!
    
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var favoriteMoreBtn: UIButton!
    @IBOutlet weak var favoriteView: UIView!
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    @IBAction func scanAction(_ sender: Any) {
        scanView.hero.id = "VIEW"
        
        
        
        historyView.hero.id = "NIL"
        bookView.hero.id = "NIL"
        
        MainConfig().actionNavVC(this: self,viewController: MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().ScanViewController) as! ScanViewController)

        //goToTest(color: UIColor.init(red: 77/255, green: 64/255, blue: 40/255, alpha: 1))
    }
    @IBAction func bookAction(_ sender: Any) {
        bookView.hero.id = "VIEW"
        
        scanView.hero.id = "NIL"
        historyView.hero.id = "NIL"
        
        MainConfig().actionVC(this: self,viewController: MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().CategoryViewController) as! CategoryViewController)

        //goToTest(color: UIColor.init(red: 186/255, green: 50/255, blue: 50/255, alpha: 1))
    }
    @IBAction func historyAction(_ sender: Any) {
        historyView.hero.id = "VIEW"
        
        scanView.hero.id = "NIL"
        bookView.hero.id = "NIL"
        
        MainConfig().actionVC(this: self,viewController: MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().HistoryViewController) as! HistoryViewController)

        //goToTest(color: UIColor.init(red: 74/255, green: 54/255, blue: 202/255, alpha: 1))
    }
    
    @IBAction func searchAction(_ sender: Any) {
        MainConfig().actionVCWithOutHero(this: self,viewController: MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().SearchViewController) as! SearchViewController)
    }
    
    
    @IBAction func profileAction(_ sender: Any) {
        MainConfig().actionVCWithOutHero(this: self,viewController: MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().ProfileViewController) as! ProfileViewController)
        
        
    }
    @IBAction func favoriteAction(_ sender: Any) {
         MainConfig().actionVCWithOutHero(this: self,viewController: MainConfig().requireViewController(storyboard: CallCenter.init().AppStoryboard, viewController: CallCenter.init().FavoriteViewController) as! FavoriteViewController)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scanView = MainConfig().setStyle(viewLayer: scanView)
        self.historyView = MainConfig().setStyle(viewLayer: historyView)
        self.bookView = MainConfig().setStyle(viewLayer: bookView)
        self.scanImageView = MainConfig().setStyleImage(viewLayer: scanImageView)
        MainConfig().buttonStyle(viewLayer: favoriteMoreBtn, radius: 10)
        MainConfig().buttonStyle(viewLayer: scanBtn, radius: 16)
        MainConfig().buttonStyle(viewLayer: historyBtn, radius: 16)
        MainConfig().buttonStyle(viewLayer: bookBtn, radius: 16)
        
        self.favoriteView.layer.masksToBounds = false
        self.favoriteView.layer.cornerRadius = 20
        
     

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MainConfig.init().darkStatusBar(animated: animated)

    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func goToTest(color :UIColor) {
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "testVC") as! TestViewController
        
        //let main = MainConfig()
        
        
        //let storyboard = UIStoryboard(name: "AppStoryboard", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier: "testAppVC") as! TestAppViewController
        
        let vc = MainConfig().requireViewController(storyboard :CallCenter.init().AppStoryboard,viewController :CallCenter.init().TestViewController) as! TestAppViewController
        
        //vc.modalPresentationStyle = .pageSheet
        //vc.modalTransitionStyle = .coverVertical
        
        //vc.bgColor = color
        vc.isHeroEnabled = true
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    
    
    

}
