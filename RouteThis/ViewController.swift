//
//  ViewController.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-10.
//

import UIKit

class ViewController: UIViewController {
    
    let roundedRectButton = RoundedRectButton()
    
    @IBOutlet weak var downloadUnitLabelOutLet: UILabel!
    
    @IBOutlet weak var uploadUnitLabelOutLet: UILabel!
    
    
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundedRectButton.customBtn(userBtn: startBtn)
    }
    
    @IBAction func StartBtnPressed(_ sender: UIButton) {
        print("start Btn Pressed")
    }
    
}

