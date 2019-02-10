//
//  CategoryViewController.swift
//  LabScan
//
//  Created by Android on 18/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import Hero

class CategoryViewController: UIViewController {
  
 
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func backAction(_ sender: Any) {
        MainConfig.init().dismissAction(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = MainConfig()
        config.initVC(viewController: self)
        
        if(MainConfig.init().isIpad()){
            self.titleLabel.hero.id = "TITLE_C"
        }else {
            self.titleLabel.hero.id = "TITLE"
        }
        
        let topView = UIView(frame:CGRect(x: 0,y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50))
        topView.backgroundColor = UIColor.white
        self.view.insertSubview(topView, at: 0)
        
        /*
        if(!MainConfig.init().isIpad()){
            self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)
        }
 */
        
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively

        
        //self.contentView.roundCorners(corners: [.topLeft, .topRight], radius: 20.0)

       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         contentView.hero.modifiers = [.translate(y: UIScreen.main.bounds.height), .useGlobalCoordinateSpace]
        
        MainConfig.init().lightStatusBar(animated: animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
