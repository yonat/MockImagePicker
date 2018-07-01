# MockImagePicker
<img align="right" src="Screenshots/MockImagePicker.png">
Mock UIImagePickerController for use in simulator.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/MockImagePicker.svg)](https://img.shields.io/cocoapods/v/MockImagePicker.svg)  
[![Platform](https://img.shields.io/cocoapods/p/MockImagePicker.svg?style=flat)](http://cocoapods.org/pods/MockImagePicker)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Usage

```swift
#if targetEnvironment(simulator)
    let picker = MockImagePicker()
#else
    let picker = UIImagePickerController()
#endif
picker.sourceType = .camera
picker.delegate = self
present(picker, animated: true)
```

## Requirements

- iOS 9.3+
- Xcode 9

## Installation

### CocoaPods:

```ruby
pod 'MockImagePicker'
```

### Manually:

Copy `Sources/MockImagePicker.swift` and [`MiniLayout.swift`](https://github.com/yonat/MiniLayout) to your Xcode project.

## Meta

[@yonatsharon](https://twitter.com/yonatsharon)

[https://github.com/yonat/MockImagePicker](https://github.com/yonat/MockImagePicker)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE.txt
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
