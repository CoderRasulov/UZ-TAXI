//
//  Animation.swift
//  UZ TAXI
//
//  Created by Asliddin Rasulov on 02/02/21.
//

import UIKit

class SkeletonView: UIView {
    
    var startLocations : [NSNumber] = [-1.0, -0.5, 0.0]
    var endLocations : [NSNumber] = [1.0, 1.5, 2.0]
    
    var gradientBackgroundColor : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientMovingColor : CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
    
    var movingAnimationDuration : CFTimeInterval = 0.8
    var delayBetweenAnimationLoops : CFTimeInterval = 1.0
    
    
    var gradientLayer : CAGradientLayer!

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.shadowColor = UIColor.clear.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor,
        
        ]
        gradientLayer.locations = startLocations
        gradientLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }
   
    
    
    func startAnimating(){
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }
    
    func stopAnimating() {
        gradientLayer.removeAllAnimations()
        gradientLayer.removeFromSuperlayer()
    }
    
}
