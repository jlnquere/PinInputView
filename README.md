# PinInputView

[![CI Status](http://img.shields.io/travis/jlnquere/PinInputView.svg?style=flat)](https://travis-ci.org/jlnquere/PinInputView)
[![Version](https://img.shields.io/cocoapods/v/PinInputView.svg?style=flat)](http://cocoapods.org/pods/PinInputView)
[![License](https://img.shields.io/cocoapods/l/PinInputView.svg?style=flat)](http://cocoapods.org/pods/PinInputView)
[![Platform](https://img.shields.io/cocoapods/p/PinInputView.svg?style=flat)](http://cocoapods.org/pods/PinInputView)

PinInputView is an `UIControl` used to enter a pin code. The typical use case is two-factors authentication. 

This component is really simple to use. You can easily customize the fonts and colors. It resizes automatically according to its configuration.

![Demo](https://github.com/jlnquere/PinInputView/blob/master/docs/demo.gif?raw=true)


### Features
- [x] Custolizable font and color.
- [x] As many digits as you need (from 1 to +∞).
- [x] AutoLayout compatible (`intrinsicContentSize` updated according to the configuration).
- [x] Interface-Builder compatible.
- [x] Pure Swift 4.
- [x] Open project: you have an issue or an idea ? Feel free to [create an issue](https://github.com/jlnquere/PinInputView/issues/new), or submit a PR :)

## Integration
You can add `PinInput` to your UI using code or with Interface Builder. 

### Using code
This is as easy as:
- creating the `PinInput` object,
- adding it to your view,
- add some layout constraints (if you want),
- subscribe to _target-action_ events to get noticed of value changes.

For example, in your `viewDidLoad`

```swift
 override func viewDidLoad() {
        super.viewDidLoad()

        self.pinInput = PinInput()
        self.view.addSubview(pinInput)

        // Just center the pinInput is its superView.
        // You can use any layout you want :)
        pinInput.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pinInput.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // Use target-action pattern to get noticed
        // of all value changes.
        pinInput.addTarget(self,
                           action: #selector(onPinValueChanged),
                           for: .valueChanged)
        // Or to know when the input is completed
        // (i.e. you have as many digits as you expect)
        pinInput.addTarget(self,
                           action: #selector(onInputCompleted),
                           for: .primaryActionTriggered)
        
    }
    @objc func onPinValueChanged() {
        print("Value changed to \(pinInput.textValue)")
    }
    @objc func onInputCompleted() {
        print("Input completed with \(pinInput.textValue)")
    }
```

## Customisation
You can customise the number of digits, the font, and the text color. All these elements are dynamic: if you change one of them, the PinInput will relayout itself according to this new setup. 

```swift
        pinInput.font = UIFont(name: "Baskerville-Bold", size: 72)!
        pinInput.textColor = .purple
        pinInput.length = 5
```
![Result](https://github.com/jlnquere/PinInputView/blob/master/docs/custom_pin.png?raw=true)

### Get rid of target-action
If you don't want to use standard UIKit `target-action` pattern, you can use `onValueChanged` and `onCompletion` closures:
```swift
        pinInput.onValueChanged = {
            print("Value changed to \(self.pinInput.textValue)")
        }
        pinInput.onCompletion = {
            print("Input completed with \(self.pinInput.textValue)")
        }
```

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 9.0 or above.
- Swift 4

## Installation

PinInputView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PinInputView'
```

## Author

Julien Quéré, [@jlnquere](http://twitter.com/jlnquere), julien@sinplicity.fr

## License

PinInputView is available under the MIT license. See the [LICENSE file](https://github.com/jlnquere/PinInputView/blob/master/LICENSE) for more info.
