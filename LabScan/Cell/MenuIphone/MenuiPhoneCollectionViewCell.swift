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
        
        cellView.hero.id = "TEST"
        
        //cellImageBg.isHidden = true
        
        setStyle(viewLayer: cellView)
        setStyleImage(viewLayer: cellImageBg)
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

}
