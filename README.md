# WYInteractiveTransitions
Customized transitions between view controllers for iOS. One Line of code with fully interactive animations. Written purely in Swift.

**Four animations is embedded right now:**
* Push

<img src="./Screenshots/push.gif" width="320" height="550"/>
* SlideUp

<img src="./Screenshots/up.gif" width="320" height="550"/>
* Swing

<img src="./Screenshots/swing.gif" width="320" height="550"/>
* Zoom

<img src="./Screenshots/zoom.gif" width="320" height="550"/>

* And your customized animations

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

# Flaws
With gesutre enabled, there's no way animated to dismissed view controller when user screen edge pan gesture is cancelled.
```
$ else if gesture.state == .Cancelled || gesture.state == .Failed || gesture.state == .Ended {
$   finishInteractiveTransition()
$ }
```
The perfect solution is to add ``cancelInteractiveTransition()`` in above gesture selector, but a new problem arised: whenever ``cancelInteractiveTransition()`` is called, the dismissed view controller is no longer exist; therefore a black screen is displayed. 
