# WYInteractiveTransitions

[![Version](https://img.shields.io/cocoapods/v/WYInteractiveTransitions.svg?style=flat)](http://cocoapods.org/pods/WYInteractiveTransitions)
[![License](https://img.shields.io/cocoapods/l/WYInteractiveTransitions.svg?style=flat)](http://cocoapods.org/pods/WYInteractiveTransitions)
[![Platform](https://img.shields.io/cocoapods/p/WYInteractiveTransitions.svg?style=flat)](http://cocoapods.org/pods/WYInteractiveTransitions)
![Swift 2.0](https://img.shields.io/badge/swift-2.0-orange.svg)

Interactive only can be done with UINavigationController? No! **WYInteractiveTransitions** come to rescue, bringing interactive transition to **model presentation** between view controllers.

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


## Installation

#### WYInteractiveTransitions is available through [CocoaPods](http://cocoapods.org).

To install it, simply add the following line to your Podfile:

```ruby
pod "WYInteractiveTransitions"
```


#### Or download the git repository
```fish
 git clone https://github.com/yuwang17/WYInteractiveTransitions.git
```

Drag ``WYInteractiveTransitions.swift`` file into your own project

Then import the module in your file
```swift
import WYInteractiveTransitions
```

If you're Objective-C user, please include the header file
```swift
#import "WYInteractiveTransitions-Swift.h"
```

## Usage
1) Create instance
```swift
let transitionMgr = WYInteractiveTransitions()
```
2) Configure WYInteractiveTransitions in proper position
```swift
transitionMgr.configureTransition(duration: 0.5, toView: toView!, panEnable: true, type: WYTransitoinType.Up)
```
3) Present view controller or dismiss would invoke the transitions
* ``performSegueWithIdentifier``
* ``presentViewController``
* ``dismissViewController``
* ``unwindViewController``
* etc...

## Example Codes
```swift
let transitionMgr = WYInteractiveTransitions()
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 if segue.identifier == "showSegue" {
   let toView = segue.destinationViewController as? UIViewController
     transitionMgr.configureTransition(duration: 0.5, toView: toView!, panEnable: true, type: WYTransitoinType.Up)
  }
}
```

## Demo
1) Download the repository
```fish
 git clone https://github.com/yuwang17/WYInteractiveTransitions.git
 cd WYInteractiveTransitions/Example
```

2) Open the workspace
```fish
 open WYInteractiveTransitions.xcodeproj
```

3) Compile and run the app in simulator
* Under Xcode, press ``Ctrl + R``

## Requirements
* Xcode 6
* iOS 7

## LICENSE
WYInteractiveTransitions is available under the [MIT License](LICENSE), see LICENSE for more infomation.
