//
//  ScanVIewCell.swift
//  LabScan
//
//  Created by Android on 9/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class ScanVIewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var veView: UIVisualEffectView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var percentage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView = MainConfig().setStyleWithOutShadow(viewLayer: cellView, cornerRadius: 10)
        
        
        veView.layer.cornerRadius = 10
        veView.clipsToBounds = true
    }

}
