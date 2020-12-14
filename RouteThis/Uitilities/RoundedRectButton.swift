//
//  RoundedRectButton.swift
//  Giphy
//
//  Created by Ferrakkem Bhuiyan on 2020-11-24.
//

import UIKit

class RoundedRectButton: UIButton {

    func customBtn(userBtn: UIButton){
        userBtn.layer.shadowColor = UIColor.white.cgColor
        userBtn.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        userBtn.layer.shadowOpacity = 2.0
        userBtn.layer.masksToBounds = false
        userBtn.layer.cornerRadius = userBtn.frame.size.height/2
        userBtn.layer.borderWidth = 0.5
    }
}

class CustomLabel: UILabel {
    func customLabel(userLabel: UILabel){
        userLabel.layer.shadowColor = UIColor.gray.cgColor
        userLabel.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        userLabel.layer.shadowOpacity = 2.0
        userLabel.layer.masksToBounds = true
        userLabel.layer.cornerRadius = 6.0
    }
}
