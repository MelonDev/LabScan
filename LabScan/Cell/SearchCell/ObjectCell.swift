//
//  ObjectCell.swift
//  LabScan
//
//  Created by Android on 12/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import UIKit

class ObjectCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
   
    
    //@IBOutlet var img: UIImageView!
    @IBOutlet weak var imag: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imag.layer.cornerRadius = 10
        imag.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
