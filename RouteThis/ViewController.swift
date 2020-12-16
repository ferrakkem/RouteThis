//
//  ViewController.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-10.
//

import UIKit

class ViewController: UIViewController {
    
    let customButton = CustomButton()
    
    
    @IBOutlet weak var speedCountingLabel: UILabel!
    
    @IBOutlet weak var downloadSpeedLabel: UILabel!
    
    @IBOutlet weak var uploadSpeedLabel: UILabel!
    
    
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customButton.customBtn(userBtn: startBtn)
        
    }
    
    //MARK: - Strat speed counting
    func incrementLabel(to endValue: Int) {
        let duration: Double = 6.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.speedCountingLabel.text = "\(Float(i))"
                    if i == endValue{
                        self.updateLabelText(downloadSpeed: 80.02, uploaddSpeed: 92.02)
                       
                    }
                }
            }
        }
    }
    
    func updateLabelText(downloadSpeed: Float, uploaddSpeed: Float){
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom //1. CATransitionType
        downloadSpeedLabel.text = String(downloadSpeed)
        uploadSpeedLabel.text = String(uploaddSpeed)
        animation.duration = 0.50
        self.downloadSpeedLabel.layer.add(animation, forKey: CATransitionType.push.rawValue)//2.
        self.uploadSpeedLabel.layer.add(animation, forKey:CATransitionType.push.rawValue)
    }
    

    //MARK: - StartBtnPressed
    @IBAction func StartBtnPressed(_ sender: UIButton) {
        print("start Btn Pressed")
        downloadSpeedLabel.text = "-"
        uploadSpeedLabel.text = "-"
        incrementLabel(to: 200)
    }
    
    
    
}

