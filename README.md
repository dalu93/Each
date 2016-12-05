# Each
Elegant ⏱ interface for Swift apps

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=5805caae4b74d00100717ec7&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/5805caae4b74d00100717ec7/build/latest)

Each is a NSTimer bridge library written in Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Leaks](#leaks)
- [License](#license)

## Features

- [x] Completely configurable timers
- [x] Support for time intervals in ms, seconds, minutes and hours
- [x] Fully extendable
- [x] More readable and simple to use in comparison with NSTimer object

## Requirements

- iOS 8.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Each.

To integrate Each into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'Each', '~> 1.2'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install `Each` by adding it to your `Cartfile`:

```
github "dalu93/Each"
```

## Usage

### Creating a new timer instance

```swift
let timer = Each(1).seconds     // Can be .milliseconds, .seconds, .minute, .hours  
```

### Performing operations

```swift
timer.perform {
    // Do your operations
    // This closure has to return a NextStep value
    // Return .continue if you want to leave the timer active, otherwise
    // return .stop to invalidate it
}
```

If you want to leave the memory management decision to the `Each` class, you can simply use the `perform(on: _)` method. 
It requires that the parameter is an `AnyObject` instance.

```swift
timer.perform(on: self) {
    // Do your operations
    // This closure has to return a NextStep value
    // Return .continue if you want to leave the timer active, otherwise
    // return .stop to invalidate it
}
```

### Stopping the timer manually

```swift
timer.stop()    // This stops immediately the timer
```

### Restarting the timer

You can restart the timer only after you stopped it. This method restarts the timer with the same
perform closure.

```swift
timer.restart()
```

## Leaks
Unfortunately the interface doesn't help you with handling the memory leaks the timer
could create. In case of them, two workarounds are provided

### Workaround 1

Use the `perform(on: _)` method as explained in the [usage](#usage) section.
Please note that using this method, the `timer` isn't immediately deallocated when the `owner` is deallocated.
It will be deallocated when the `timer` triggers the next time and it will check whether the `owner` instance is still valid or not.

### Workaround 2

In case you don't want to declare a property that holds the `Each` reference, create a normal `Each` timer in your method scope and return `.stop/true` whenever the `owner` instance is `nil`

```swift
Each(1).seconds.perform { [weak self] in
    guard let _ = self else { return .stop }

    print("timer called")
    return .continue
}
```

90% of closures will call `self` somehow, so this isn't so bad

### Workaround 3

In case the first workaround wasn't enough, you can declare a property that holds the `Each` reference and call the `stop()` function whenever the `owner` is deallocated

```swift
final class ViewController: UIViewController {
    private let _timer = Each(1).seconds

    deinit {
        _timer.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _timer.perform {
            // do something and return. you can check here if the `self` instance is nil as for workaround #1
        }
    }
}
```

## License

Each is released under the MIT license. See LICENSE for details.
