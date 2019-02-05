//
//  ScanViewController.swift
//  LabScan
//
//  Created by Android on 18/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController {

    @IBAction func backAction(_ sender: Any) {
        MainConfig.init().dismissAction(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = MainConfig()
        config.initVC(viewController: self)


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
