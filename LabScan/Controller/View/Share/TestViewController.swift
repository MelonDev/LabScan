//
//  TestViewController.swift
//  LabScan
//
//  Created by Android on 16/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import Hero

class TestViewController: UIViewController {
    
    var bgColor :UIColor? = nil

    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var ipadContentView: UIView!
    @IBOutlet weak var ipadTestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = MainConfig()

        self.hero.isEnabled = true
        self.view.hero.id = "VIEW"
        
        if(bgColor != nil){
            self.view.backgroundColor = bgColor
            if(config.isIpad()){
                self.ipadTestView.backgroundColor = bgColor
            }else {
                self.testView.backgroundColor = bgColor

            }
        }
        
        if(config.isIpad()){
            ipadContentView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
            
            let myView = UITapGestureRecognizer(target: self, action: #selector(someAction(_:)))
            self.ipadTestView.addGestureRecognizer(myView)
            
            config.setStyle(viewLayer: ipadContentView)
            
        } else {
            contentView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
            
            let myView = UITapGestureRecognizer(target: self, action: #selector(someAction(_:)))
            self.testView.addGestureRecognizer(myView)

            
            config.setStyle(viewLayer: contentView)
        }
        
       
        

        
        //contentView.roundCorners(corners: [.topLeft, .topRight], radius: 8.0)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)

    }
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
        
        self.dismiss(animated: true, completion: nil)
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

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
 
}
