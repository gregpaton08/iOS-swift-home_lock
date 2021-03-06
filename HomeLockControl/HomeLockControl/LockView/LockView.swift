//
//  LockView.swift
//  HomeLockControl
//
//  Created by Greg Paton on 11/13/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

public protocol LockViewDelegate {
    func handleTapFor(lockView: LockView)
}

@IBDesignable
public class LockView: UIView {
    
    // Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTapGesture()
        
        lockBodyView.lockColor = currentLockColor
        addSubview(lockBodyView)
        lockShackleView.lockColor = currentLockColor
        addSubview(lockShackleView)
        addSubview(lockDisabledView)
        addSubview(lockSpinnerView)
    }
    
    // MARK: - API
    
    public var delegate: LockViewDelegate?
    
    public var isEnabled = true {
        didSet {
            currentLockColor = isEnabled ? lockColor : lockColorDisabled
            lockDisabledView.isHidden = isEnabled
        }
    }
    
    public var isLocked: Bool {
        get {
            return lockShackleView.isLocked
        }
        set {
            if newValue != lockShackleView.isLocked {
                lockShackleView.isLocked = newValue
                UIView.animate(withDuration: 0.5, animations: {
                    self.lockShackleView.frame.origin.x = self.lockViewRect.origin.x + (newValue ? 0 : self.pointsFrom(units: 4))
                })
            }
        }
    }
    
    public var isSpinning: Bool {
        get {
            return lockSpinnerView.isSpinning
        }
        set {
            lockSpinnerView.isSpinning = newValue
        }
    }
    
    private var currentLockColor = UIColor.black {
        didSet {
            if currentLockColor != oldValue {
                lockBodyView.lockColor = currentLockColor
                lockBodyView.setNeedsDisplay()
                lockShackleView.lockColor = currentLockColor
                lockShackleView.setNeedsDisplay()
            }
        }
    }
    private var lockColorDisabled = UIColor.red
    public var lockColor = UIColor.black {
        didSet {
            if isEnabled {
                currentLockColor = lockColor
            }
        }
    }
    
    // MARK: - Tap Gesture Recognizer
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    @objc
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // Don't allow user to click when lock is disabled of when lock is spinning.
        if isEnabled && !isSpinning {
            delegate?.handleTapFor(lockView: self)
        }
    }
    
    // MARK: - Subview configuration
    
    private var lockBodyView = LockBodyView()
    
    private var lockShackleView = LockShackleView()
    
    private var lockSpinnerView = LockSpinnerView()
    
    private var lockDisabledView = LockDisableView()
    
    // MARK: - Geometry
    
    private let lockViewAspectRatio = CGSize(width: 16.0, height: 10.0)
    private var lockViewRect = CGRect()
    
    private var lockBodySize: CGSize {
        get {
            return CGSize(width: pointsFrom(units: 8), height: pointsFrom(units: 6))
        }
    }
    
    private var lockBodyOrigin: CGPoint {
        get {
            let boundsCenter = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
            return CGPoint(x: boundsCenter.x - pointsFrom(units: 4), y: boundsCenter.y - pointsFrom(units: 1))
        }
    }
    
    // The lock dimensions are conceptualized as "units" so that the lock can be generically drawn given any view size. For reference, the total size required by the lock view is 16 units wide and 10 units high. The lock body is 8 units wide and 6 units tall. Since the lock view size is 10 units in height, we can convert from units to actual points by multiply the height by the number of units and dividing by 10.
    private func pointsFrom(units: CGFloat) -> CGFloat {
        return lockViewRect.size.height * units / 10.0
    }
    
    // MARK:- View functions
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Find the largest size that will fit within the bounds given the aspect ratio.
        var lockViewSize: CGSize
        if self.bounds.width * lockViewAspectRatio.height < self.bounds.height * lockViewAspectRatio.width {
            lockViewSize = CGSize(width: self.bounds.width, height: self.bounds.width * lockViewAspectRatio.height / lockViewAspectRatio.width)
        } else {
            lockViewSize = CGSize(width: self.bounds.height * lockViewAspectRatio.width / lockViewAspectRatio.height, height: self.bounds.height)
        }
        
        lockViewRect.origin = CGPoint(x: (self.bounds.width - lockViewSize.width) / 2, y: (self.bounds.height - lockViewSize.height) / 2)
        lockViewRect.size = lockViewSize
        
        lockBodyView.frame = CGRect(origin: lockBodyOrigin, size: lockBodySize)
        
        lockShackleView.frame.origin.x = lockViewRect.origin.x + (isLocked ? 0 : pointsFrom(units: 4))
        lockShackleView.frame.origin.y = lockViewRect.origin.y
        lockShackleView.frame.size = lockViewRect.size
        
        lockDisabledView.frame.origin = lockBodyOrigin
        lockDisabledView.frame.size = lockBodySize
        
        var spinnerRect = CGRect.zero
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        spinnerRect.origin = CGPoint(x: center.x - pointsFrom(units: 1), y: center.y + pointsFrom(units: 1))
        spinnerRect.size = CGSize(width: pointsFrom(units: 2), height: pointsFrom(units: 2))
        lockSpinnerView.frame = spinnerRect
    }
    
}
