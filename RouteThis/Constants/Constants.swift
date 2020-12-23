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
