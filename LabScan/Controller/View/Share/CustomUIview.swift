import UIKit

class CustomUIView {
    
    
    
}

extension UIView {
    
    func roundCorner(corners :CACornerMask,radius :CGFloat){
        
    }
    
    /*
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
 */
 
}

extension CACornerMask {
    
    
    func topLeft() -> CACornerMask {
        return CACornerMask.layerMinXMinYCorner
    }
    
    func topRight() -> CACornerMask {
        return CACornerMask.layerMaxXMinYCorner
    }
    
    func bottomLeft() -> CACornerMask {
        return CACornerMask.layerMinXMaxYCorner
    }
    
    func bottomRight() -> CACornerMask {
        return CACornerMask.layerMaxXMaxYCorner
    }
 
    
}
