//
//  WYInteractiveTransitions.swift
//  WYInteractiveTransitions
//
//  Created by Wang Yu on 6/5/15.
//  Copyright (c) 2015 Yu Wang. All rights reserved.
//

import UIKit

public enum WYTransitoinType {
    case push
    case zoom
    case up
    case swing
}

open class WYInteractiveTransitions: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    
    open func configureTransition(duration: TimeInterval?=nil, toView toViewController: UIViewController, panEnable handGestureEnable: Bool?=true, type transitionType: WYTransitoinType) {
        if let duration = duration {
            self.durationTransition = duration
        } else { self.durationTransition = 0.5 }
        self.transitionType = transitionType
        self.toViewController = toViewController
        self.toViewController?.transitioningDelegate = self
        self.toViewController?.modalPresentationStyle = .fullScreen
        if handGestureEnable == true {
            let panEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(WYInteractiveTransitions.screenEdgePanGestureHandler(_:)))
            panEdgeGesture.edges = UIRectEdge.left
            toViewController.view.addGestureRecognizer(panEdgeGesture)
        }
    }
    
    fileprivate var presenting = true
    fileprivate var gestureEnable = true
    fileprivate var handIn = false
    fileprivate var transitionType = WYTransitoinType.up
    fileprivate var toViewController: UIViewController?
    var durationTransition = 0.5
    
    func screenEdgePanGestureHandler(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if let toView = toViewController {
            let location: CGPoint = gesture.translation(in: toView.view)
            let velocity = gesture.velocity(in: toView.view).x
            
            switch gesture.state {
            case .began:
                self.handIn = true
                toView.modalPresentationStyle = UIModalPresentationStyle.custom
                toView.dismiss(animated: true, completion: nil)
            case .changed:
                let animationRatio: CGFloat = location.x / toView.view.bounds.width
                self.update(animationRatio)
            case .ended, .cancelled, .failed:
                self.handIn = false
                if velocity > 0 {
                    finish()
                } else {
                    cancel()
                }
            default: break
            }
            
        }
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromView = fromVC.view
        let toView = toVC.view
        let duration = self.transitionDuration(using: transitionContext)
        
        let completeTransition: () -> () = {
            let isCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!isCancelled)
        }
        
        switch transitionType {
        case WYTransitoinType.push:
            let moveToLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
            let moveToRight = CGAffineTransform(translationX: container.frame.width, y: 0)
            toView?.transform = self.presenting ? moveToRight : moveToLeft
            container.addSubview(toView!)
            container.addSubview(fromView!)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                fromView?.transform = self.presenting ? moveToLeft : moveToRight
                toView?.transform = CGAffineTransform.identity
            }) { (finished) -> Void in
                completeTransition()
            }
            
        case WYTransitoinType.up:
            if presenting {
                toView?.frame = container.bounds
                toView?.transform = CGAffineTransform(translationX: 0, y: container.frame.size.height)
                container.addSubview(fromView!)
                container.addSubview(toView!)
                UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: { () -> Void in
                    fromView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    fromView?.alpha = 0.5
                    toView?.transform = CGAffineTransform.identity
                }, completion: { (finished) -> Void in
                    completeTransition()
                })
            } else {
                let transfrom = toView?.transform
                toView?.transform = CGAffineTransform.identity
                toView?.frame = container.bounds
                toView?.transform = transfrom!
                
                container.addSubview(toView!)
                container.addSubview(fromView!)
                UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions(), animations: { () -> Void in
                    fromView?.transform = CGAffineTransform(translationX: 0, y: (fromView?.frame.size.height)!)
                    toView?.transform = CGAffineTransform.identity
                    toView?.alpha = 1
                }, completion: { (finished) -> Void in
                    completeTransition()
                })
            }
            
        case WYTransitoinType.zoom:
            if presenting {
                container.addSubview(fromView!)
                container.addSubview(toView!)
                toView?.alpha = 0
                toView?.transform = CGAffineTransform(scaleX: 2, y: 2)
                UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: { () -> Void in
                    fromView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    fromView?.alpha = 0
                    toView?.transform = CGAffineTransform.identity
                    toView?.alpha = 1
                }, completion: { (finished) -> Void in
                    completeTransition()
                })
            } else {
                container.addSubview(toView!)
                container.addSubview(fromView!)
                UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions(), animations: { () -> Void in
                    fromView?.transform = CGAffineTransform(scaleX: 2, y: 2)
                    fromView?.alpha = 0
                    toView?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    toView?.alpha = 1
                }, completion: { (finished) -> Void in
                    completeTransition()
                    
                })
            }
            
        case WYTransitoinType.swing:
            let offScreenRight = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
            let offScreenLeft = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
            
            toView?.transform = self.presenting ? offScreenRight : offScreenLeft
            
            toView?.layer.anchorPoint = CGPoint(x:0, y:0)
            fromView?.layer.anchorPoint = CGPoint(x:0, y:0)
            toView?.layer.position = CGPoint(x:0, y:0)
            fromView?.layer.position = CGPoint(x:0, y:0)
            container.addSubview(toView!)
            container.addSubview(fromView!)
            let duration = self.transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [], animations: {
                fromView?.transform = self.presenting ? offScreenLeft : offScreenRight
                toView?.transform = CGAffineTransform.identity
            }, completion: { finished in
                completeTransition()
            })
        }
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTransition
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        toViewController = presenting
        self.presenting = true
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if handIn == true {
            return self
        } else { return nil }
    }
    
    open func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
