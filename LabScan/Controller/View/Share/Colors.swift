import Foundation
import UIKit

class Colors {
    var gl:CAGradientLayer!
    
    struct colorPoint {
        var color :UIColor
        var location :NSNumber
    }
    
    init() {
        /*
        let colorTop = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.0).cgColor
        let colorBottom = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.6).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
 */
    }
    
    func loadColor(bound bg:CGRect,color :[colorPoint]) -> CAGradientLayer{
        
        let gradient:CAGradientLayer! = CAGradientLayer()

        
        var arrColor :Array<CGColor> = []
        var arrLocation :Array<NSNumber> = []
        
        for i in color {
            arrColor.append(i.color.cgColor)
            arrLocation.append(i.location)
        }
        
        gradient.frame = bg
        gradient.colors = arrColor
        gradient.locations = arrLocation
        
        return gradient
        
    }
    
    func loadColor(UIView view:UIView,color :[colorPoint]) -> UIView{
        
        let gradient:CAGradientLayer! = CAGradientLayer()
        
        
        var arrColor :Array<CGColor> = []
        var arrLocation :Array<NSNumber> = []
        
        for i in color {
            arrColor.append(i.color.cgColor)
            arrLocation.append(i.location)
        }
        
        gradient.frame = view.bounds
        gradient.colors = arrColor
        gradient.locations = arrLocation
        
        view.layer.addSublayer(gradient)
        
        return view
        
    }
    
    func loadColorWithRadius(UIView view:UIView,color :[colorPoint] ,ats :UInt32,corner :CACornerMask,radius :CGFloat) -> UIView{
        
        let gradient:CAGradientLayer! = CAGradientLayer()
        
        
        var arrColor :Array<CGColor> = []
        var arrLocation :Array<NSNumber> = []
        
        for i in color {
            arrColor.append(i.color.cgColor)
            arrLocation.append(i.location)
        }
        
        gradient.frame = view.bounds
        gradient.colors = arrColor
        gradient.locations = arrLocation
        
        //gradient.cornerRadius = radius
        //gradient.maskedCorners = corner
        
        view.layer.insertSublayer(gradient, at: ats)
        //view.layer.addSublayer(gradient)
        
        return view
        
    }
    
}
