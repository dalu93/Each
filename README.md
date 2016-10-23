# Each
Elegant ⏱ interface for Swift apps

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=5805caae4b74d00100717ec7&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/5805caae4b74d00100717ec7/build/latest)

Each is a NSTimer bridge library written in Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
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

> CocoaPods 1.1.0+ is required to build Each 1.0.0+.

To integrate Each into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'Each', '~> 1.1'
end
```

Then, run the following command:

```bash
$ pod install
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
    // This closure has to return a Boolean value
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

## License

Each is released under the MIT license. See LICENSE for details.
