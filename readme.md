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

### Basic usage (Three dots)

`import ThreeDotsAnimation`

`let loading = ThreeDotsAnimation()`

`loading.show(in: self)`

> self must be an instance of NSViewController.

### Custom symbols

`loading.show(in: self, symbols: ["❤️", "❤️", "❤️"])`

`loading.show(in: self, symbols: ["★", "★", "★"])`

`loading.show(in: self, symbols: ["⚡️", "🔥", "✨"])`


### To hide loading use

`loading.hide()`

## ✨Features

- Customizable Symbols: Use any combination of emoji or text characters
- Beautiful Wave Animation: Smooth, staggered animation effect
- Dynamic Layout: Automatically adjusts to any number of symbols
- Blurred Background: Semi-transparent modal appearance
- Lightweight: Simple plug-and-play implementation
- Auto-Resizing: Adapts to parent view size changes

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

