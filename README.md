# WYInteractiveTransitions

[![CI Status](http://img.shields.io/travis/Yu Wang/WYInteractiveTransitions.svg?style=flat)](https://travis-ci.org/Yu Wang/WYInteractiveTransitions)
[![Version](https://img.shields.io/cocoapods/v/WYInteractiveTransitions.svg?style=flat)](http://cocoapods.org/pods/WYInteractiveTransitions)
[![License](https://img.shields.io/cocoapods/l/WYInteractiveTransitions.svg?style=flat)](http://cocoapods.org/pods/WYInteractiveTransitions)
[![Platform](https://img.shields.io/cocoapods/p/WYInteractiveTransitions.svg?style=flat)](http://cocoapods.org/pods/WYInteractiveTransitions)

# Installation

WYInteractiveTransitions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WYInteractiveTransitions"
```

# Author

Yu Wang, wangyu2165@gmail.com

# Intro
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

If you're Objective-C user, please include the header file
```
#import "WYTransitionManager-Swift.h"
```

3) Create instance
```
$ let transitionMgr = WYTransitionManager()
```
4) Configure WYTransitionManager in proper position
```
$ transitionMgr.configureTransition(duration: 0.5, toViewController: toView!, 
                                 handGestureEnable: true, transitionType: WYTransitoinType.Push)
```
5) Present view controller or dismiss would invoke the transitions
* ``performSegueWithIdentifier``
* ``presentViewController``
* ``dismissViewController``
* ``unwindViewController``
* etc...

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

# LICENSE
WYInteractiveTransitions is available under the [MIT License](LICENSE), see LICENSE for more infomation.
>>>>>>> fa86c057d55027a0f007c1710a349b6fb943e2fc
