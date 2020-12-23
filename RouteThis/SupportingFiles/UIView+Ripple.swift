//
//  UIView+Radar.swift
//  TestCocoaPods
//

import UIKit

extension UIView {
    open func addRippleAnimation(color: UIColor, rippleWidth: CGFloat = 2, duration: Double = 1.5, repeatCount: Int = 1, rippleCount: Int = 3, rippleDistance: CGFloat? = nil, expandMaxRatio ratio: CGFloat = 1, startReset: Bool = true, handler:((CAAnimation)->Void)? = nil) {
        if startReset {
            removeRippleAnimation()
        } else {
            if isRippleAnimating {
                return
            }
        }
        let rippleAnimationAvatarSize = self.frame.size
        let rippleAnimationLineWidth: CGFloat = rippleWidth
        let rippleAnimationDuration: Double = duration
        var rippleAnimationExpandSizeValue: CGFloat = 0
        
        if let distance = rippleDistance {
            rippleAnimationExpandSizeValue = distance
        } else {
            rippleAnimationExpandSizeValue = rippleAnimationAvatarSize.width / 3.0
        }
        
        let initPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        
        let finalPath = UIBezierPath(ovalIn: CGRect(x: -rippleAnimationExpandSizeValue * ratio, y: -rippleAnimationExpandSizeValue * ratio, width: rippleAnimationAvatarSize.width + rippleAnimationExpandSizeValue * 2 * ratio, height: rippleAnimationAvatarSize.height + rippleAnimationExpandSizeValue * 2 * ratio).insetBy(dx: rippleAnimationLineWidth, dy: rippleAnimationLineWidth))
        clipsToBounds = false
        
        
        
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = rippleCount
        replicator.instanceDelay = rippleAnimationDuration / Double(rippleCount)
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.name = "ReplicatorForRipple"
        self.layer.addSublayer(replicator)

        let shape = animationLayer(path: initPath, color: color, lineWidth: rippleWidth)
        shape.name = "ShapeForRipple"
        shape.frame = CGRect(x: 0, y: 0, width: rippleAnimationAvatarSize.width, height: rippleAnimationAvatarSize.height)
        replicator.addSublayer(shape)

        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.isRemovedOnCompletion = true
        pathAnimation.fromValue = initPath.cgPath
        pathAnimation.toValue = finalPath.cgPath

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = NSNumber(value: 1)
        opacityAnimation.toValue = NSNumber(value: 0)

        let groupAnimation = CAAnimationGroup()
        handler?(groupAnimation)
        groupAnimation.animations = [pathAnimation, opacityAnimation]
        groupAnimation.duration = rippleAnimationDuration
        groupAnimation.repeatCount = Float(repeatCount)
        groupAnimation.isRemovedOnCompletion = true
        groupAnimation.fillMode = .forwards
        shape.add(groupAnimation, forKey: "RippleGroupAnimation")
        
    }
    
    open func removeRippleAnimation() {
        var layers: [CALayer] = []
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                replicator.sublayers?.forEach({ (ly) in
                    if ly.name == "ShapeForRipple" {
                        ly.isHidden = true
                        layers.append(ly)
                    }
                })
                replicator.isHidden = true
                layers.append(replicator)
            }
        })
        
        for i in 0..<layers.count {
            layers[i].removeFromSuperlayer()
        }
        layers.removeAll()
    }

    private func animationLayer(path: UIBezierPath, color: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = color.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        shape.strokeColor = color.cgColor
        shape.lineCap = .round
        return shape
    }
    
    open var isRippleAnimating: Bool {
        var animating = false
        layer.sublayers?.forEach({ (layer) in
            if let replicator = layer as? CAReplicatorLayer, replicator.name == "ReplicatorForRipple" {
                animating = true
            }
        })
        return animating
    }
}
