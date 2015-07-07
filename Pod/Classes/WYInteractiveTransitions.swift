//
//  TransitionManager.swift
//  JokeBox
//
//  Created by Wang Yu on 6/5/15.
//  Copyright (c) 2015 Yu Wang. All rights reserved.
//

import UIKit

public enum WYTransitoinType {
    case Push
    case Zoom
    case Up
    case Swing
}

public class WYInteractiveTransitions: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    public func configureTransition(duration: NSTimeInterval?=nil, toViewController: UIViewController, handGestureEnable: Bool, transitionType: WYTransitoinType) {
        if let duration = duration {
            self.durationTransition = duration
        }
        
        self.transitionType = transitionType
        self.toViewController = toViewController
        self.toViewController?.transitioningDelegate = self
        
        if handGestureEnable == true {
            var panEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "screenEdgePanGestureHandler:")
            panEdgeGesture.edges = UIRectEdge.Left
            toViewController.view.addGestureRecognizer(panEdgeGesture)
        }
    }
    
    private var presenting = true
    private var gestureEnable = true
    private var handIn = false
    private var transitionType = WYTransitoinType.Swing
    private var toViewController: UIViewController?
    var durationTransition = 0.5
    
    func screenEdgePanGestureHandler(gesture: UIScreenEdgePanGestureRecognizer) {
        if let toView = toViewController {
            let location: CGPoint = gesture.translationInView(toView.view)
            let velocity: CGPoint = gesture.velocityInView(toView.view)
            
            if gesture.state == UIGestureRecognizerState.Began {
                self.handIn = true
                toView.modalPresentationStyle = UIModalPresentationStyle.Custom
                toView.dismissViewControllerAnimated(true, completion: nil)
            } else if gesture.state == UIGestureRecognizerState.Changed {
                let animationRatio: CGFloat = location.x / toView.view.bounds.width
                self.updateInteractiveTransition(animationRatio)
            } else if gesture.state == .Cancelled || gesture.state == .Failed || gesture.state == .Ended {
                self.handIn = false
                if velocity.x >= 0 {
                    finishInteractiveTransition()
                } else {
                    cancelInteractiveTransition()
                }
            }
        }
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let duration = self.transitionDuration(transitionContext)
        
        switch transitionType {
        case WYTransitoinType.Push:
            let moveToLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
            let moveToRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
            toView.transform = self.presenting ? moveToRight : moveToLeft
            container.addSubview(toView)
            container.addSubview(fromView)
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                fromView.transform = self.presenting ? moveToLeft : moveToRight
                toView.transform = CGAffineTransformIdentity
                }) { (finished) -> Void in
                    transitionContext.completeTransition(true)
            }
            
        case WYTransitoinType.Up:
            if presenting {
                toView.frame = container.bounds
                toView.transform = CGAffineTransformMakeTranslation(0, container.frame.size.height)
                container.addSubview(fromView)
                container.addSubview(toView)
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    fromView.alpha = 0.5
                    toView.transform = CGAffineTransformIdentity
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition(true)
                })
            } else {
                let transfrom = toView.transform
                toView.transform = CGAffineTransformIdentity
                toView.frame = container.bounds
                toView.transform = transfrom
                
                container.addSubview(toView)
                container.addSubview(fromView)
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeTranslation(0, fromView.frame.size.height)
                    toView.transform = CGAffineTransformIdentity
                    toView.alpha = 1
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition(true)
                })
            }
            
        case WYTransitoinType.Zoom:
            if presenting {
                container.addSubview(fromView)
                container.addSubview(toView)
                toView.alpha = 0
                toView.transform = CGAffineTransformMakeScale(2, 2)
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeScale(0.5, 0.5)
                    fromView.alpha = 0
                    toView.transform = CGAffineTransformIdentity
                    toView.alpha = 1
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition(true)
                })
            } else {
                container.addSubview(toView)
                container.addSubview(fromView)
                UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromView.transform = CGAffineTransformMakeScale(2, 2)
                    fromView.alpha = 0
                    toView.transform = CGAffineTransformMakeScale(1, 1)
                    toView.alpha = 1
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition(true)
                })
            }
            
        case WYTransitoinType.Swing:
            let offScreenRight = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
            let offScreenLeft = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            
            toView.transform = self.presenting ? offScreenRight : offScreenLeft
            
            toView.layer.anchorPoint = CGPoint(x:0, y:0)
            fromView.layer.anchorPoint = CGPoint(x:0, y:0)
            toView.layer.position = CGPoint(x:0, y:0)
            fromView.layer.position = CGPoint(x:0, y:0)
            container.addSubview(toView)
            container.addSubview(fromView)
            let duration = self.transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: nil, animations: {
                fromView.transform = self.presenting ? offScreenLeft : offScreenRight
                toView.transform = CGAffineTransformIdentity
                }, completion: { finished in
                    transitionContext.completeTransition(true)
            })
        default: break
        }
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return durationTransition
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        toViewController = presenting
        self.presenting = true
        return self
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    public func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if handIn == true {
            return self
        } else { return nil }
    }
    
    public func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
