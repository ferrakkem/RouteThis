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
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet weak var test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton.customBtn(userBtn: startBtn)
        arrowImage.isHidden = true
        
        
    }
    
    //MARK: - Strat dowloading Speed Messaure
    func dowloadingSpeedMessaure(to endValue: Int) {
        informationView.animOut()
        let duration: Double = 3.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.speedCountingLabel.text = "\(Float(i))"
                    if i == endValue{
                        self.downloadSpeedLabel.updateLabel(speed: 200.0, labelName: self.downloadSpeedLabel)
                        self.arrowImage.tintColor  = K.BandColors.imageTintColorDuringUpSpeed
                        self.arrowImage.image = UIImage(systemName: K.imageNameForCheckingUploadSpeed)
                        self.stopBtnAnimation()
                        self.uploadLoadinSpeedMessaure(to:endValue)
                    }
                }
            }
        }
    }
    
    //MARK: - Strat Uploading Speed Messaure
    func uploadLoadinSpeedMessaure(to endValue: Int) {
        let duration: Double = 1.0 //seconds
        DispatchQueue.global().async {
            for i in stride(from: endValue, to: 64, by: -1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.speedCountingLabel.text = "\(Float(i))"
                    self.uploadSpeedLabel.updateLabel(speed: 64.0, labelName: self.uploadSpeedLabel)
                    self.informationView.animIn()
                    self.arrowImage.isHidden = true
                }
            }
        }
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
            self.customButton.flash()
            self.downloadSpeedLabel.text = "-"
            self.uploadSpeedLabel.text = "-"
            self.dowloadingSpeedMessaure(to: 200)
            //Disable button after tap
            self.arrowImage.isHidden = false
            self.arrowImage.image = UIImage(systemName: K.imageNameForCheckingDownloadSpeed)
            self.arrowImage.tintColor  = K.BandColors.imageTintColorDuringDownloadSpeed
            
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

