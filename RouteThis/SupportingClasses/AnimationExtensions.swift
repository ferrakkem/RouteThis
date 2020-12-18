//
//  AnimationExtensions.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-17.
//

import Foundation
import UIKit

extension UIView{
    func animOut(){
        UIView.animate(withDuration: 2, delay: 1, options: [.curveEaseOut],
                       animations: {
                        self.bounds.origin.y = self.bounds.origin.y - self.frame.height/2
                        
                        self.layoutIfNeeded()
                       }, completion: nil)
        self.isHidden = false
    }
    
    func animIn(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.bounds.origin.y = 0
                        self.layoutIfNeeded()
                        
                       },  completion: {(_ completed: Bool) -> Void in
                        self.isHidden = false
                       })
    }
    
    
    func move() {
      UIView.animate(withDuration: 2, delay: 1, options: [.curveEaseOut],
                     animations: {
                        self.frame.origin.y = UINavigationController.navBarHeight() + 30
      }, completion: nil)
    }
    
    func moveback() {
      UIView.animate(withDuration: 2, delay: 1, options: [.curveEaseOut],
                     animations: {
                        self.frame.origin.y = 0
      }, completion: nil)
    }
}


extension UILabel{
    func updateLabel(speed: Float, labelName: UILabel){
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        labelName.text = String(speed)
        animation.duration = 0.50
        labelName.layer.add(animation, forKey: CATransitionType.push.rawValue)//2.
    }
}

extension UINavigationController {
  static public func navBarHeight() -> CGFloat {
    let nVc = UINavigationController(rootViewController: UIViewController(nibName: "Main", bundle: nil))
    let navBarHeight = nVc.navigationBar.frame.size.height
    return navBarHeight
  }
}

extension UIImageView{

}
