//
//  MainConfig.swift
//  LabScan
//
//  Created by Android on 15/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import Foundation
import UIKit
import Hero

class MainConfig {
    
    func requireViewController(storyboard :String,viewController :String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewController)
        
        return vc
    }
    
    func setStyle(viewLayer :UIView) -> UIView {
        viewLayer.layer.masksToBounds = false
        viewLayer.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewLayer.layer.shadowRadius = 8
        viewLayer.layer.shadowOpacity = 0.4
        viewLayer.layer.cornerRadius = 16
        return viewLayer
    }
    
    func setStyleWithOutShadow(viewLayer :UIView,cornerRadius :Float) -> UIView {
        viewLayer.layer.masksToBounds = false
        viewLayer.layer.cornerRadius = CGFloat(cornerRadius)
        return viewLayer
    }
    
    func setStyle(viewLayer :UIView,shadowRadius :Float,shadowOpacity :Float,cornerRadius :Float) -> UIView {
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
    
    func data() -> [MenuStruct] {
        
        
        
        if(UIDevice.isNotch){
            let menu = [
                
                MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_3"), title: "สแกนอุปกรณ์", image: nil,color :nil,description :"เปิดกล้องเพื่อสแกน",colorLabel :UIColor.init(red: 77/255, green: 64/255, blue: 40/255, alpha: 1)),
                MenuStruct(imageBg: nil, title: "หมวดหมู่", image: #imageLiteral(resourceName: "bookshelf"),color :RGBTOCOLOR(red: 186, green: 50, blue: 50, alpha: 255),description :"อุปกรณ์การทดลองวิทยาศาสตร์",colorLabel :UIColor.white),
                MenuStruct(imageBg: nil, title: "ประวัติ", image: #imageLiteral(resourceName: "history-clock-button"),color :RGBTOCOLOR(red: 74, green: 54, blue: 202, alpha: 255),description :"การค้นหา",colorLabel: UIColor.white)
                //MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1"), title: "สแกนอุปกรณ์", image: #imageLiteral(resourceName: "9"))
                
            ]
            
            return menu
        }else {
            
            let menu = [
                
                MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1_plus"), title: "สแกนอุปกรณ์", image: nil,color :nil,description :"เปิดกล้องเพื่อสแกน",colorLabel :UIColor.init(red: 77/255, green: 64/255, blue: 40/255, alpha: 1)),
                MenuStruct(imageBg: nil, title: "หมวดหมู่", image: #imageLiteral(resourceName: "bookshelf"),color :RGBTOCOLOR(red: 186, green: 50, blue: 50, alpha: 255),description :"อุปกรณ์การทดลองวิทยาศาสตร์",colorLabel :UIColor.white),
                MenuStruct(imageBg: nil, title: "ประวัติ", image: #imageLiteral(resourceName: "history-clock-button"),color :RGBTOCOLOR(red: 74, green: 54, blue: 202, alpha: 255),description :"การค้นหา",colorLabel: UIColor.white)
                //MenuStruct(imageBg: #imageLiteral(resourceName: "menu_wall_1"), title: "สแกนอุปกรณ์", image: #imageLiteral(resourceName: "9"))
                
            ]
            
            return menu

        }
        
        
        
        //return menu
    }
    
    func actionVC(this :UIViewController , viewController :UIViewController){
        viewController.isHeroEnabled = true
        this.present(viewController,animated: true,completion: nil)
    }
    
    func actionVCWithOutHero(this :UIViewController , viewController :UIViewController){
        this.present(viewController,animated: true,completion: nil)
    }
    
    func actionNavVC(this :UIViewController , viewController :UIViewController){
        viewController.isHeroEnabled = true
        
        let aObjNavi = UINavigationController(rootViewController: viewController)
        aObjNavi.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        aObjNavi.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        this.present(aObjNavi,animated: true,completion: nil)
    }
    
    func setFormSheet(viewController :UIViewController) -> UIViewController{
        viewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        return viewController
    }
    
    func actionNavVCWithOutHero(this :UIViewController , viewController :UIViewController){
        let aObjNavi = UINavigationController(rootViewController: viewController)
        aObjNavi.modalPresentationStyle = UIModalPresentationStyle.formSheet
        aObjNavi.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        
        this.present(aObjNavi,animated: true,completion: nil)
    }
    
    
    func RGBTOCOLOR(red :Int,green :Int,blue :Int,alpha :Int) -> UIColor {
        return UIColor.init(red: getColorFloat(number: red), green: getColorFloat(number: green), blue:getColorFloat(number: blue), alpha: getColorFloat(number: alpha))
    }
    
    func getColorFloat(number :Int) -> CGFloat {
        return CGFloat.init(number)/255
    }
    
    func isIpad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    func initVC(viewController :UIViewController){
        viewController.hero.isEnabled = true
        viewController.view.hero.id = "VIEW"
        
    }
    
    
    
    
    
    func dismissAction(viewController :UIViewController){
        viewController.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func OnClick(tap :UITapGestureRecognizer,view :UIView){
        view.addGestureRecognizer(tap)
    }
    
    func lightStatusBar(animated: Bool){
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
        
    }
    
    func darkStatusBar(animated: Bool){
        UIApplication.shared.setStatusBarStyle(.default, animated: animated)
    }
    
}
