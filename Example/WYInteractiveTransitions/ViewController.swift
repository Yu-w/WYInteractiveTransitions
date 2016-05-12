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
    
    @IBAction func trigerTransition(sender: UIButton) {
       performSegueWithIdentifier("showSegue", sender: sender)
    }
    
    private let WYTransitionMgr = WYInteractiveTransitions()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSegue" {
            if let sender = sender as? UIButton {
                let toView = segue.destinationViewController
                var type: WYTransitoinType!
                switch sender.currentTitle! as String {
                case "Push":
                    type = WYTransitoinType.Push
                case "Up":
                    type = WYTransitoinType.Up
                case "Zoom":
                    type = WYTransitoinType.Zoom
                case "Swing":
                    type = WYTransitoinType.Swing
                default: break
                }
                WYTransitionMgr.configureTransition(toView, type: type)
            }
        }
    }
}

