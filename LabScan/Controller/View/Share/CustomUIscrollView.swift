
//
//  CustomUIscrollView.swift
//  LabScan
//
//  Created by Android on 10/2/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import Foundation
import UIKit


extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
