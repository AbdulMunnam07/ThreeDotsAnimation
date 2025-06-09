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
    
    private var symbolLabels: [NSTextField] = []
    private var symbols: [String] = ["•", "•", "•"] {
        didSet {
            updateSymbols()
        }
    }
    
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
        
        // Create and setup symbol labels
        setupSymbolLabels()
    }
    
    private func setupSymbolLabels() {
        // Clear existing labels
        symbolLabels.forEach { $0.removeFromSuperview() }
        symbolLabels.removeAll()
        
        // Create new labels for each symbol
        for symbol in symbols {
            let label = NSTextField(labelWithString: symbol)
            label.font = NSFont.systemFont(ofSize: 70, weight: .heavy)
            label.textColor = .white
            label.alignment = .center
            label.isBezeled = false
            label.isEditable = false
            label.isSelectable = false
            label.backgroundColor = .clear
            label.translatesAutoresizingMaskIntoConstraints = false
            label.wantsLayer = true
            
            dotsContainerView.addSubview(label)
            symbolLabels.append(label)
        }
        
        // Position labels horizontally
        positionSymbolLabels()
    }
    
    private func positionSymbolLabels() {
        guard !symbolLabels.isEmpty else { return }
        
        // Center the middle label
        let middleIndex = symbolLabels.count / 2
        symbolLabels[middleIndex].centerXAnchor.constraint(equalTo: dotsContainerView.centerXAnchor).isActive = true
        symbolLabels[middleIndex].centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor).isActive = true
        
        // Position labels to the left of the middle
        for i in 0..<middleIndex {
            let currentIndex = middleIndex - 1 - i
            symbolLabels[currentIndex].centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor).isActive = true
            symbolLabels[currentIndex].trailingAnchor.constraint(
                equalTo: symbolLabels[currentIndex + 1].leadingAnchor,
                constant: -2
            ).isActive = true
        }
        
        // Position labels to the right of the middle
        for i in (middleIndex + 1)..<symbolLabels.count {
            symbolLabels[i].centerYAnchor.constraint(equalTo: dotsContainerView.centerYAnchor).isActive = true
            symbolLabels[i].leadingAnchor.constraint(
                equalTo: symbolLabels[i - 1].trailingAnchor,
                constant: 2
            ).isActive = true
        }
    }
    
    private func updateSymbols() {
        // Ensure we have the same number of labels as symbols
        if symbolLabels.count != symbols.count {
            setupSymbolLabels()
        } else {
            // Update existing labels
            for (index, label) in symbolLabels.enumerated() {
                label.stringValue = symbols[index]
            }
        }
    }
    
    // MARK: - Waving Animation
    private func startWavingAnimation() {
        // Ensure we have labels to animate
        guard !symbolLabels.isEmpty else { return }
        
        // Animation properties
        let duration: CFTimeInterval = 0.6
        let verticalOffset: CGFloat = 14
        
        // Animate each symbol with a staggered delay
        for (index, label) in symbolLabels.enumerated() {
            guard let layer = label.layer else { continue }
            
            let animation = CABasicAnimation(keyPath: "position.y")
            animation.fromValue = layer.position.y
            animation.toValue = layer.position.y - verticalOffset
            animation.duration = duration
            animation.autoreverses = true
            animation.repeatCount = .infinity
            animation.beginTime = CACurrentMediaTime() + duration * Double(index) * 0.3
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            layer.add(animation, forKey: "symbolWave\(index)")
        }
    }
    
    // MARK: - Public Methods
    public func show(in viewController: NSViewController, symbols: [String]? = nil) {
        // Update symbols if provided
        if let customSymbols = symbols {
            self.symbols = customSymbols
        }
        
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
        // Remove all animations before hiding
        symbolLabels.forEach { $0.layer?.removeAllAnimations() }
        removeFromSuperview()
    }
}