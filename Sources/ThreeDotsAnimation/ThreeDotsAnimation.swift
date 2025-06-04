// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit

public class ThreeDotsAnimation: NSView {

    // MARK: - Properties
    private let blurView: NSVisualEffectView = {
        let blurView = NSVisualEffectView()
        blurView.blendingMode = .withinWindow
        blurView.material = .hudWindow
        blurView.state = .active
        blurView.layer?.backgroundColor = NSColor.black.cgColor
        blurView.alphaValue = 0.9
        blurView.wantsLayer = true
        blurView.layer?.cornerRadius = 10
        return blurView
    }()

    private let dotsContainerView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.5).cgColor
        view.layer?.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dot1: NSTextField = {
        let label = NSTextField(labelWithString: "•")
        label.font = NSFont.systemFont(ofSize: 70, weight: .heavy)
        label.textColor = .white
        label.alignment = .center
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.wantsLayer = true
        return label
    }()

    private let dot2: NSTextField = {
        let label = NSTextField(labelWithString: "•")
        label.font = NSFont.systemFont(ofSize: 70, weight: .heavy)
        label.textColor = .white
        label.alignment = .center
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.wantsLayer = true
        return label
    }()

    private let dot3: NSTextField = {
        let label = NSTextField(labelWithString: "•")
        label.font = NSFont.systemFont(ofSize: 70, weight: .heavy)
        label.textColor = .white
        label.alignment = .center
        label.isBezeled = false
        label.isEditable = false
        label.isSelectable = false
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.wantsLayer = true
        return label
    }()

    // MARK: - Initialization
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        // Add blur view
        blurView.frame = bounds
        blurView.autoresizingMask = [.width, .height]
        addSubview(blurView)

        // Add dots container view
        addSubview(dotsContainerView)
        NSLayoutConstraint.activate([
            dotsContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dotsContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dotsContainerView.widthAnchor.constraint(equalToConstant: 140),
            dotsContainerView.heightAnchor.constraint(equalToConstant: 60)
        ])

        // Add dots to the container view
        dotsContainerView.addSubview(dot1)
        dotsContainerView.addSubview(dot2)
        dotsContainerView.addSubview(dot3)

        // Position dots horizontally
        NSLayoutConstraint.activate([
            dot1.centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor),
            dot1.trailingAnchor.constraint(equalTo: dot2.leadingAnchor, constant: -2),
            
            dot2.centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor),
            dot2.centerXAnchor.constraint(equalTo: dotsContainerView.centerXAnchor),
            
            dot3.centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor),
            dot3.leadingAnchor.constraint(equalTo: dot2.trailingAnchor, constant: 2)
        ])
    }

    // MARK: - Waving Animation
    private func startWavingAnimation() {
        // Ensure layers are available
        guard let dot1Layer = dot1.layer,
              let dot2Layer = dot2.layer,
              let dot3Layer = dot3.layer else {
            print("Layers are not available for dots")
            return
        }

        // Animation properties
        let duration: CFTimeInterval = 0.6
        let verticalOffset: CGFloat = 14

        // Dot 1 animation
        let dot1Animation = CABasicAnimation(keyPath: "position.y")
        dot1Animation.fromValue = dot1Layer.position.y
        dot1Animation.toValue = dot1Layer.position.y - verticalOffset
        dot1Animation.duration = duration
        dot1Animation.autoreverses = true
        dot1Animation.repeatCount = .infinity
        dot1Animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        dot1Layer.add(dot1Animation, forKey: "dot1Wave")

        // Dot 2 animation (with a delay)
        let dot2Animation = CABasicAnimation(keyPath: "position.y")
        dot2Animation.fromValue = dot2Layer.position.y
        dot2Animation.toValue = dot2Layer.position.y - verticalOffset
        dot2Animation.duration = duration
        dot2Animation.autoreverses = true
        dot2Animation.repeatCount = .infinity
        dot2Animation.beginTime = CACurrentMediaTime() + duration * 0.3
        dot2Animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        dot2Layer.add(dot2Animation, forKey: "dot2Wave")

        // Dot 3 animation (with a delay)
        let dot3Animation = CABasicAnimation(keyPath: "position.y")
        dot3Animation.fromValue = dot3Layer.position.y
        dot3Animation.toValue = dot3Layer.position.y - verticalOffset
        dot3Animation.duration = duration
        dot3Animation.autoreverses = true
        dot3Animation.repeatCount = .infinity
        dot3Animation.beginTime = CACurrentMediaTime() + duration * 0.6
        dot3Animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        dot3Layer.add(dot3Animation, forKey: "dot3Wave")
    }

    // MARK: - Public Methods
    public func show(in viewController: NSViewController) {
        let parentView = viewController.view
        
        // Set the frame to match the parent view's bounds
        frame = parentView.bounds
        
        // Ensure the overlay resizes with the parent view
        autoresizingMask = [.width, .height]
        
        // Add the overlay to the parent view
        parentView.addSubview(self)
        
        // Start the waving animation after adding to the view hierarchy
        startWavingAnimation()
    }

    public func hide() {
        removeFromSuperview()
    }
}
