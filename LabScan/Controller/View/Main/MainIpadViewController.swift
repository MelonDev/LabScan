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
        scanView.hero.id = "TEST"
        
        
        
        historyView.hero.id = "NIL"
        bookView.hero.id = "NIL"

        goToTest(color: UIColor.init(red: 77/255, green: 64/255, blue: 40/255, alpha: 1))
    }
    @IBAction func bookAction(_ sender: Any) {
        bookView.hero.id = "TEST"
        
        scanView.hero.id = "NIL"
        historyView.hero.id = "NIL"

        goToTest(color: UIColor.init(red: 186/255, green: 50/255, blue: 50/255, alpha: 1))
    }
    @IBAction func historyAction(_ sender: Any) {
        historyView.hero.id = "TEST"
        
        scanView.hero.id = "NIL"
        bookView.hero.id = "NIL"

        goToTest(color: UIColor.init(red: 74/255, green: 54/255, blue: 202/255, alpha: 1))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scanView = setStyle(viewLayer: scanView)
        self.historyView = setStyle(viewLayer: historyView)
        self.bookView = setStyle(viewLayer: bookView)
        self.scanImageView = setStyleImage(viewLayer: scanImageView)
        buttonStyle(viewLayer: favoriteMoreBtn, radius: 10)
        buttonStyle(viewLayer: scanBtn, radius: 16)
        buttonStyle(viewLayer: historyBtn, radius: 16)
        buttonStyle(viewLayer: bookBtn, radius: 16)
        
        self.favoriteView.layer.masksToBounds = false
        self.favoriteView.layer.cornerRadius = 20
        
        


        
    }
    
    func setStyle(viewLayer :UIView) -> UIView {
        viewLayer.layer.masksToBounds = false
        viewLayer.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewLayer.layer.shadowRadius = 8
        viewLayer.layer.shadowOpacity = 0.4
        viewLayer.layer.cornerRadius = 16
        return viewLayer
    }
    
    func setStyleImage(viewLayer :UIImageView) -> UIImageView {
        viewLayer.layer.masksToBounds = true
        viewLayer.layer.cornerRadius = 16
        return viewLayer
    }
    
    func buttonStyle(viewLayer :UIButton,radius :Int) {
        viewLayer.layer.masksToBounds = false
        viewLayer.layer.cornerRadius = CGFloat(radius)
        //return viewLayer
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
        
        let vc = MainConfig().requireViewController(storyboard :"AppStoryboard",viewController :"testAppVC") as! TestAppViewController
        
        
        vc.bgColor = color
        vc.isHeroEnabled = true
        self.present(vc, animated: true, completion: nil)
    }
    
    

}
