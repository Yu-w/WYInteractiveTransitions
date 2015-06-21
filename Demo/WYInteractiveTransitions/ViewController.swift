//
//  ViewController.swift
//  WYInteractiveTransitions
//
//  Created by Wang Yu on 6/21/15.
//  Copyright (c) 2015 Yu Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let segueIdentifier: String = "showSegue"
    private let WYTransitionMgr = WYTransitionManager()
    
    @IBAction func trigerTransition(sender: UIButton) {
       performSegueWithIdentifier("showSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSegue" {
            if let sender = sender as? UIButton {
                let toView = segue.destinationViewController as? UIViewController
                let duration = 0.5
                switch sender.currentTitle! as String {
                case "Push":
                    WYTransitionMgr.configureTransition(duration: duration, toViewController: toView!, handGestureEnable: true, transitionType: WYTransitoinType.Push)
                case "Up":
                    WYTransitionMgr.configureTransition(duration: duration, toViewController: toView!, handGestureEnable: true, transitionType: WYTransitoinType.Up)
                case "Zoom":
                    WYTransitionMgr.configureTransition(duration: duration, toViewController: toView!, handGestureEnable: true, transitionType: WYTransitoinType.Zoom)
                case "Swing":
                    WYTransitionMgr.configureTransition(duration: duration, toViewController: toView!, handGestureEnable: true, transitionType: WYTransitoinType.Swing)
                default: break
                }

            }
        }
    }
}

