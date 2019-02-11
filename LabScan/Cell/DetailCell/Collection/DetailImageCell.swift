//
//  DetailImageCell.swift
//  LabScan
//
//  Created by Android on 10/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class DetailImageCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView = MainConfig().setStyleWithOutShadow(viewLayer: cellView, cornerRadius: 10)
        
        cellView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFill

        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        //veView.layer.cornerRadius = 10
        //veView.clipsToBounds = true
        
        
        
    }
    

}
