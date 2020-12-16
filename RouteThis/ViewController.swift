//
//  ViewController.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-10.
//

import UIKit
import SSSpinnerButton

class ViewController: UIViewController {
    
    var customButton = CustomButton()
    
    @IBOutlet weak var informationView: UIView!
    
    @IBOutlet weak var speedCountingLabel: UILabel!
    @IBOutlet weak var downloadSpeedLabel: UILabel!
    @IBOutlet weak var uploadSpeedLabel: UILabel!
    
    @IBOutlet weak var startBtn: SSSpinnerButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customButton.customBtn(userBtn: startBtn)
        
    }
    
    //MARK: - Strat speed counting
    func incrementLabel(to endValue: Int) {
        //self.informationView.fadeIn()
        let duration: Double = 5.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.speedCountingLabel.text = "\(Float(i))"
                    if i == endValue{
                        self.updateLabelText(downloadSpeed: 80.02, uploaddSpeed: 92.02)
                        self.stopBtnAnimation()
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
        
        // Enable Start button after update download and upload label value
        //informationView.fadeOut()

    }
    

    //MARK: - StartBtnPressed
    @IBAction func StartBtnPressed(_ sender: UIButton) {
        print("start Btn Pressed")
        startBtnAnimation()
    }
    
    func startBtnAnimation(){
        startBtn.startAnimate(spinnerType: SpinnerType.ballRotateChase, spinnercolor: UIColor.white, spinnerSize: 40, complete: {
            // Your code here
            self.customButton.flash()
            self.downloadSpeedLabel.text = "-"
            self.uploadSpeedLabel.text = "-"
            self.incrementLabel(to: 200)
            //Disable button after tap
            self.startBtn.isEnabled = false
        })
    }
    
    func stopBtnAnimation(){
        startBtn.stopAnimate {
            self.startBtn.isEnabled = true
        }

    }
    
}

