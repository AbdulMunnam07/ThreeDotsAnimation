# ThreeDotsAnimation

A customizable and lightweight macOS loading overlay with a smooth **three-dot wave animation**, built using AppKit. Ideal for native macOS applications that require a clean and minimal loading experience.

![ThreeDotsAnimation Preview](https://github.com/AbdulMunnam07/ThreeDotsAnimation/raw/main/preview.gif)

## 🔧 Requirements

- macOS 11.0+
- Xcode 12+
- Swift 5+
- AppKit only (not compatible with UIKit or iOS)

## 📦 Installation

### Using Swift Package Manager (Recommended)

In **Xcode**:

1. Go to `File` > `Add Packages...`
2. Enter the URL of this repository:
`https://github.com/AbdulMunnam07/ThreeDotsAnimation.git`
3. Select the package and click **Add Package**.

### Manual

Clone or download the repo and drag the `ThreeDotsAnimation.swift` file into your project.

## 🚀 Usage

### 1. Import the Library

```swift
import ThreeDotsAnimation

*To show loading use:*

`let loadingOverlay = LoadingOverlay()
loadingOverlay.show(in: self)`

> self must be an instance of NSViewController.

*To hide loading use:*

`loadingOverlay.hide()`

## ✨Features
- Beautiful wave animation using three dots (•)

- Blurred, semi-transparent background for modal appearance

- Smooth animation with built-in delays

- Lightweight and plug-and-play ready

- Resizes automatically with the parent view

## 🖥️ Platform Support
✅ macOS (AppKit)
❌ iOS (UIKit)

## 🙌 Contribution

Contributions are welcome! If you have ideas to enhance the animation or improve performance, feel free to open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

Made with ❤️ by [Abdul Munnam](https://github.com/AbdulMunnam07)


--- 

Let me know if you want to include CocoaPods or Carthage instructions (though SPM is best for macOS).

