//
//  ImageMaskAnimator.swift
//  MaskAway
//
//  Created by Danny Yassine on 2016-08-12.
//  Copyright © 2016 DannyYassine. All rights reserved.
//

import UIKit

class ImageMaskAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    var toViewController: UIViewController?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        // Context container view
        let containerView = transitionContext.containerView()!
        
        // Destination ViewController
        toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        // Mask
        let mask = CAShapeLayer()
        mask.contents = UIImage(named: "twitter")?.CGImage
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: toViewController!.view.center.x, y: toViewController!.view.center.y)
        
        // Add it in the context
        containerView.addSubview(toViewController!.view)
        
        // Apply Mask
        toViewController!.view.layer.mask = mask
        
        // Apply Animation
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let initalBounds = NSValue(CGRect: mask.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        keyFrameAnimation.removedOnCompletion = false
        keyFrameAnimation.fillMode = kCAFillModeForwards
        mask.addAnimation(keyFrameAnimation, forKey: "bounds")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        toViewController?.view.layer.mask = nil
    }
    
}
