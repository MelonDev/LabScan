//
//  DetailCollectionCell.swift
//  LabScan
//
//  Created by Android on 11/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class DetailCollectionCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelBG: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView = MainConfig().setStyleWithOutShadow(viewLayer: cellView, cornerRadius: 10)
        
        cellView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        labelBG.backgroundColor = .clear
        
        let colorTop = Colors.colorPoint.init(color: UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.0), location: 0.0)
        
        let colorBottom = Colors.colorPoint.init(color: UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.6), location: 1.0)
        
        labelBG = Colors.init().loadColorWithRadius(UIView: labelBG, color: [colorTop,colorBottom],ats: 0,corner: [.layerMinXMaxYCorner,.layerMaxXMaxYCorner],radius: 10)
        
       
        
        /*
        let co = Colors()
        co.gl.frame = self.labelBG.bounds
        
        
        labelBG.layer.addSublayer(co.gl!)
 */
        
        
        
        //content.backgroundColor = UIColor.blue
        // Initialization code
    }

}
