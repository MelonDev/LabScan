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

        self.hero.isEnabled = true
        self.view.hero.id = "TEST"
        
        if(bgColor != nil){
            self.view.backgroundColor = bgColor
            if(isIpad()){
                self.ipadTestView.backgroundColor = bgColor
            }else {
                self.testView.backgroundColor = bgColor

            }
        }
        
        if(isIpad()){
            ipadContentView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
            
            let myView = UITapGestureRecognizer(target: self, action: #selector(someAction(_:)))
            self.ipadTestView.addGestureRecognizer(myView)
            
            setStyle(viewLayer: ipadContentView)
            
        } else {
            contentView.hero.modifiers = [.translate(y: 500), .useGlobalCoordinateSpace]
            
            let myView = UITapGestureRecognizer(target: self, action: #selector(someAction(_:)))
            self.testView.addGestureRecognizer(myView)

            
            setStyle(viewLayer: contentView)
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

        
        //viewLabel2.isHidden = true
    }
    
    func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setStyle(viewLayer :UIView) -> UIView {
        viewLayer.layer.masksToBounds = false
        viewLayer.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewLayer.layer.shadowRadius = 10
        viewLayer.layer.shadowOpacity = 0.4
        viewLayer.layer.cornerRadius = 16
        return viewLayer
    }
    

}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
