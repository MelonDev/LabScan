//
//  MainConfig.swift
//  LabScan
//
//  Created by Android on 15/1/2562 BE.
//  Copyright © 2562 Android. All rights reserved.
//

import Foundation
import UIKit
import Hero

class MainConfig {
    
    func requireViewController(storyboard :String,viewController :String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewController)
        
        return vc
    }
    
}
