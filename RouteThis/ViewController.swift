//
//  ViewController.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-10.
//

import UIKit
import SSSpinnerButton
//import StarWars


class ViewController: UIViewController {
    
    var customButton = CustomButton()
    @IBOutlet weak var informationView: UIView!
        
    @IBOutlet weak var speedCountingLabel: UILabel!
    @IBOutlet weak var downloadSpeedLabel: UILabel!
    @IBOutlet weak var uploadSpeedLabel: UILabel!
    
    @IBOutlet weak var startBtn: SSSpinnerButton!
    
    @IBOutlet weak var downloadArrowImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //downloadArrowImage.isHidden = true
        
        // Do any additional setup after loading the view.
        customButton.customBtn(userBtn: startBtn)
                
    }
    
    //MARK: - Strat speed counting
    func incrementLabel(to endValue: Int) {
    
        informationView.animOut()
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
    
    //MARK: - Update speed label text
    func updateLabelText(downloadSpeed: Float, uploaddSpeed: Float){
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        downloadSpeedLabel.text = String(downloadSpeed)
        uploadSpeedLabel.text = String(uploaddSpeed)
        animation.duration = 0.50
        self.downloadSpeedLabel.layer.add(animation, forKey: CATransitionType.push.rawValue)//2.
        self.uploadSpeedLabel.layer.add(animation, forKey:CATransitionType.push.rawValue)
     
        informationView.animback()
 


    }
    

    //MARK: - StartBtnPressed
    @IBAction func StartBtnPressed(_ sender: UIButton) {
        print("start Btn Pressed")
        startBtnAnimation()
    }
    
    //MARK: - Button chasing animation
    func startBtnAnimation(){
        //downloadArrowImage.isHidden = false
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
    
    //MARK: - Stop chasing animation
    func stopBtnAnimation(){
        startBtn.stopAnimate {
            self.startBtn.isEnabled = true
        }

    }
}

extension UIView{
    func animOut(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut],
                       animations: {
                        self.bounds.origin.y = self.bounds.origin.y - self.frame.height/2
                       
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animback(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.bounds.origin.y = 0
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = false
            })
    }
    
}
