//
//  MenuiPhoneCollectionViewCell.swift
//  LabScan
//
//  Created by Android on 16/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class MenuiPhoneCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setStyle(viewLayer: cellView)
    }
    
    func setStyle(viewLayer :UIView) -> UIView {
        viewLayer.layer.masksToBounds = false
        viewLayer.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewLayer.layer.shadowRadius = 8
        viewLayer.layer.shadowOpacity = 0.4
        viewLayer.layer.cornerRadius = 16
        return viewLayer
    }

}
