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
}


extension UIColor {
    convenience init(hexaString: String, alpha: CGFloat = 1) {
        let chars = Array(hexaString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}
