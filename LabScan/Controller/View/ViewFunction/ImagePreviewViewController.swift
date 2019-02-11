//
//  ImagePreviewViewController.swift
//  LabScan
//
//  Created by Android on 11/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView : UIImageView?  = nil
    var scrollView :UIScrollView? = nil
    
    var url :String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        let points = (UIScreen.main.bounds.height / 2) - (UIScreen.main.bounds.width / 2) - 80
        
        imageView  = UIImageView(frame:CGRect(x:0, y:points, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.width));
        imageView?.backgroundColor = UIColor.black
        imageView?.contentMode = .scaleAspectFit
        
        let scrollImg: UIScrollView = UIScrollView()
        scrollImg.delegate = self
        scrollImg.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        scrollImg.backgroundColor = UIColor.black
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        
        self.view.addSubview(scrollImg)
        
        imageView!.layer.cornerRadius = 0.0
        imageView!.clipsToBounds = false
        scrollImg.addSubview(imageView!)

        
        
        //imageView.image = UIImage(named:"image.jpg")
        //self.view.addSubview(imageView!)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = "พรีวิว"
        
        self.navigationController?.navigationBar.barTintColor = .black
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "SukhumvitSet-Bold", size: 20)!]
        self.navigationController?.navigationBar.isTranslucent = true
        MainConfig.init().lightStatusBar(animated: animated)
        
        if(url != nil){
            self.imageView?.downloaded(from: url!)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        
        
    }
    
    func reloadView(){
        if(url != nil){
            self.imageView?.downloaded(from: url!)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
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
