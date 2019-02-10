//
//  CustomNavigationBar.swift
//  LabScan
//
//  Created by Android on 10/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setNavigationBarBorderColor(_ color:UIColor) {
        self.navigationBar.shadowImage = color.as1ptImage()
    }
}

extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
