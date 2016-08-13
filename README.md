# MaskAnimatedTransitioning

### Animator Controller for a custom transition between UIViewControllers

I got inspired by this post (http://iosdevtips.co/post/88481653818/twitter-ios-app-bird-zoom-animation) to create a custom transition between two UIViewControllers.

#### A mask is applied during the transition. The destionation UIViewController is set a mask, which is an image.

![](https://raw.githubusercontent.com/dannyYassine/MaskAnimatedTransitioning/master/mask_away.gif)

#### Snippet

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
