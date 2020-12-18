//
//  ViewController.swift
//  RouteThis
//
//  Created by Ferrakkem Bhuiyan on 2020-12-10.
//

//self.speedTestGrapView.frame = CGRect(x: 0, y: 0, width: K.iPhoneScreen.screenWidth, height: K.iPhoneScreen.screenHeight)

import UIKit
import SSSpinnerButton

class ViewController: UIViewController,CAAnimationDelegate {
    
    var ripple:Ripple!
    
    @IBOutlet weak var animateView: UIView!
    var customButton = CustomButton()
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var ping: UILabel!
    
    @IBOutlet weak var speedCountingLabel: UILabel!
    @IBOutlet weak var downloadSpeedLabel: UILabel!
    @IBOutlet weak var uploadSpeedLabel: UILabel!
    @IBOutlet weak var startBtn: SSSpinnerButton!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var speedTestGrapView: UIView!
    
    @IBOutlet weak var topSpeedCountingView: UIView!
    
    @IBOutlet weak var pingInfoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customButton.customBtn(userBtn: startBtn)
        arrowImage.isHidden = true
        ping.isHidden = true

    }
    
    
    //MARK: - Strat dowloading Speed Messaure
    func dowloadingSpeedMessaure(to endValue: Int) {
        informationView.animOut()
        //pingInfoView.nanimOut()
        ping.isHidden = false
        pingInfoView.move()
        //pingInfoView.tanimOut()
        
        let duration: Double = 3.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.speedCountingLabel.text = "\(Float(i))"
                    if i == endValue{
                        self.downloadSpeedLabel.updateLabel(speed: 200.02, labelName: self.downloadSpeedLabel)
                        self.arrowImage.tintColor  = K.BandColors.imageTintColorDuringUpSpeed
                        self.arrowImage.image = UIImage(systemName: K.imageNameForCheckingUploadSpeed)
                        self.stopBtnAnimation()
                        self.uploadLoadinSpeedMessaure(to:endValue)
                        self.ripple(rippleColor: K.BandColors.imageTintColorDuringUpSpeed)
                    }
                }
            }
        }
    }
    
    //MARK: - Strat Uploading Speed Messaure
    func uploadLoadinSpeedMessaure(to endValue: Int) {
        let duration: Double = 3.0 //seconds
        DispatchQueue.global().async {
            for i in stride(from: endValue, to: 64, by: -1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.speedCountingLabel.text = "\(Float(i))"
                    if i == 65{
                        self.uploadSpeedLabel.updateLabel(speed: 65.00, labelName: self.uploadSpeedLabel)
                        self.informationView.animIn()
                        self.pingInfoView.moveback()
                        self.arrowImage.isHidden = true
                    }
                }
            }
        }
    }
    //MARK: - StartBtnPressed
    @IBAction func StartBtnPressed(_ sender: UIButton) {
        print("start Btn Pressed")
        startBtnAnimation()
        ripple(rippleColor: K.BandColors.imageTintColorDuringDownloadSpeed)
    }
    
    //MARK: - Riipl
    func ripple(rippleColor: UIColor ){
        print("ripple")
        arrowImage.addRippleAnimation(color: rippleColor , duration: 3, rippleCount: 3, rippleDistance: nil, startReset: true, handler: { animation in
            animation.delegate = self
        })
        
    }
    
    //MARK: - Button chasing animation
    func startBtnAnimation(){
        //downloadArrowImage.isHidden = false
        startBtn.startAnimate(spinnerType: SpinnerType.ballRotateChase, spinnercolor: UIColor.white, spinnerSize: 40, complete: {
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
