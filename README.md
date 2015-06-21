# WYInteractiveTransitions
Customized transitions between view controllers for iOS. One Line of code with fully interactive animations. Written purely in Swift.

# Animations
* Push
* SlideUp
* Swing
* Zoom
* Your customized animations

# Usage
1) Download the repository
```
$ git clone https://github.com/yuwang17/WYInteractiveTransitions.git
$ cd WYInteractiveTransitions
```

2) Drag ``WYTransitionManager.swift`` file into your own project

3) Create instance
```
$ let transitionMgr = WYTransitionManager()
```
4) Configure WYTransitionManager in proper position (normally in prepare segue)
```
$ transitionMgr.configureTransition(duration: 0.5, toViewController: toView!, 
$                                 handGestureEnable: true, transitionType: WYTransitoinType.Push)
```

# Demo
1) Download the repository
```
$ git clone https://github.com/yuwang17/WYInteractiveTransitions.git
$ cd WYInteractiveTransitions/Demo
```

2) Open the workspace
```
$ open WYInteractiveTransitions.xcodeproj
```

3) Compile and run the app in simulator
* Under Xcode, press ``Ctrl + R``

# Example Codes
```
$ let transitionMgr = WYTransitionManager()
$ override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
$   if segue.identifier == "showSegue" {
$     let toView = segue.destinationViewController as? UIViewController
$       transitionMgr.configureTransition(duration: 0.5, toViewController: toView!, 
$                                       handGestureEnable: true, transitionType: WYTransitoinType.Push)
$   }
$ }
```

# Requirements
* Xcode 6
* iOS 7

