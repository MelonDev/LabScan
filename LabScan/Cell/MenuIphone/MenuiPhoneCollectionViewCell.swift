//
//  MenuiPhoneCollectionViewCell.swift
//  LabScan
//
//  Created by Android on 16/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit
import Hero

class MenuiPhoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImageBg: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDesciption: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.hero.id = "VIEW"
        cellTitle.hero.id = "TITLE"
        
        //cellImageBg.isHidden = true
        
        cellView = MainConfig().setStyle(viewLayer: cellView)
        cellImageBg = MainConfig().setStyleImage(viewLayer: cellImageBg)
        
    }
    
   

}
