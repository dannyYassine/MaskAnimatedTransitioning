//
//  ImageMaskDismissAnimator.swift
//  MaskAway
//
//  Created by Danny Yassine on 2016-08-13.
//  Copyright © 2016 DannyYassine. All rights reserved.
//

import UIKit

class ImageMaskDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    weak var transitionContext: UIViewControllerContextTransitioning?
    var toViewController: UIViewController?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        // Context container view
        let containerView = transitionContext.containerView()!
        
        // Destination ViewController
        toViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let viewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)

        // Mask
        let mask = CAShapeLayer()
        mask.contents = UIImage(named: "twitter")?.CGImage
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: toViewController!.view.center.x, y: toViewController!.view.center.y)
        
        // Add it in the context
        containerView.addSubview(viewController!.view)
        containerView.addSubview(toViewController!.view)
        
        // Apply Mask
        toViewController!.view.layer.mask = mask
        
//        let moveUpAnimation = CABasicAnimation(keyPath: "transform.translation.y")
//        moveUpAnimation.duration = 0.5
//        moveUpAnimation.toValue = NSNumber(float: 0.0)
//        moveUpAnimation.beginTime = 0.0
//        moveUpAnimation.fromValue = NSNumber(float: Float(mask.position.y))
//        mask.addAnimation(moveUpAnimation, forKey: "moveUp")
        
        // Apply Animation
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = self.transitionDuration(self.transitionContext)
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let initalBounds = NSValue(CGRect: CGRect.zero)
        let firstBounds = NSValue(CGRect: mask.bounds)
        let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
        keyFrameAnimation.values = [finalBounds, secondBounds, firstBounds, initalBounds]
        keyFrameAnimation.keyTimes = [0, 0.2, 0.4, 1]
        keyFrameAnimation.removedOnCompletion = false
        keyFrameAnimation.fillMode = kCAFillModeForwards
        mask.addAnimation(keyFrameAnimation, forKey: "bounds")
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let firstRotate = NSNumber(float: 0.0)
        let finalRotate = NSNumber(float: 2 * Float(M_PI))
        scaleAnimation.values = [firstRotate, finalRotate]
        scaleAnimation.keyTimes = [0.4, 1]
        scaleAnimation.duration = self.transitionDuration(self.transitionContext)
        mask.addAnimation(scaleAnimation, forKey: "rotate")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        toViewController?.view.layer.mask = nil
    }
    

    
}
