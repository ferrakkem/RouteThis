//
//  ViewController.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-10.
//

import UIKit

struct K{
    
    static let imageNameForCheckingDownloadSpeed = "arrow.down.circle.fill"
    static let imageNameForCheckingUploadSpeed = "arrow.up.circle.fill"
    
    struct BandColors {
        static let imageTintColorDuringDownloadSpeed = UIColor(hexaString: "#A0E0E9")
        static let imageTintColorDuringUpSpeed = UIColor(hexaString: "#674982")
        static let backGroundColor = UIColor(hexaString: "#192B37")
    }
    
    struct iPhoneScreen {
        static let screenSize = UIScreen.main.bounds
        static let screenWidth = screenSize.width
        static let screenHeight = screenSize.height
    }
    
}


extension UIColor {
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}


extension UINavigationController {
  static public func navBarHeight() -> CGFloat {
    let nVc = UINavigationController(rootViewController: UIViewController(nibName: nil, bundle: nil))
    let navBarHeight = nVc.navigationBar.frame.size.height
    return navBarHeight
  }
}
