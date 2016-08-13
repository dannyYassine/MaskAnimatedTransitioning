//
//  NavigationControllerDelegate.swift
//  MaskAway
//
//  Created by Danny Yassine on 2016-08-12.
//  Copyright © 2016 DannyYassine. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    var interactionController: UIPercentDrivenInteractiveTransition?
    weak var navigationController:UINavigationController?

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC.isKindOfClass(ViewController) {
            return ImageMaskAnimator()
        } else {
            return ImageMaskDismissAnimator()
        }
        
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return self.interactionController
        
    }
    
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        self.navigationController!.view!.addGestureRecognizer(panGesture)
    }
    
    func panGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .Began:
            self.interactionController = UIPercentDrivenInteractiveTransition()
            
            if self.navigationController?.viewControllers.count > 1 {
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                self.navigationController?.topViewController!.performSegueWithIdentifier("showSource", sender: nil)
            }
            
        //2
        case .Changed:
            let translation = gestureRecognizer.translationInView(self.navigationController!.view)
            let completionProgress = translation.x/CGRectGetWidth(self.navigationController!.view.bounds)
            self.interactionController?.updateInteractiveTransition(completionProgress)
            
        //3
        case .Ended:
            
            if (gestureRecognizer.velocityInView(self.navigationController!.view).x > 0) {
                self.interactionController?.finishInteractiveTransition()
            } else {
                self.interactionController?.cancelInteractiveTransition()
            }
            self.interactionController = nil
            
        //4
        default:
            self.interactionController?.cancelInteractiveTransition()
            self.interactionController = nil
        }
        
    }
}
