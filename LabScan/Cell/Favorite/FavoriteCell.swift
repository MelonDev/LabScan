//
//  FavoriteCell.swift
//  LabScan
//
//  Created by Android on 13/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imv: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imv.layer.cornerRadius = 10
        imv.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
