//
//  LockView.swift
//  Home Lock
//
//  Created by Greg Paton on 11/10/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

protocol LockViewDelegate {
    func handleTapFor(lockView: LockView)
}

@IBDesignable
class LockView: UIView {
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTapGesture()
        
        // Create an animator.
//        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear, animations: {
//            self.rotateSpinView()
//        })
//        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveLinear, .repeat], animations: {
//            UIView.setAnimationRepeatCount(27)
//            self.rotateSpinView()
//            self.rotateSpinView()
//        }, completion: nil)
    }
    
    var delegate: LockViewDelegate?
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    private var animator: UIViewPropertyAnimator!
    
    @objc
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        delegate?.handleTapFor(lockView: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
    
    private var _isSpinning = false
    public var isSpinning: Bool {
        get {
            return _isSpinning
        }
        set {
            _isSpinning = newValue
            if _isSpinning {
                rotateSpinView()
            } else {
                lockSpinnerView.layer.removeAllAnimations()
            }
//            animator.startAnimation()
        }
    }
    
    private func rotateSpinView() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveLinear], animations: {
            self.lockSpinnerView.transform = self.lockSpinnerView.transform.rotated(by: CGFloat.pi)
        }, completion: { finished in
            if finished && self._isSpinning {
                self.rotateSpinView()
            }
        })
//        lockSpinnerView.transform = lockSpinnerView.transform.rotated(by: CGFloat.pi)
    }
    
    public var lockColor = UIColor.black {
        didSet {
            lockShackleView.lockColor = lockColor
        }
    }
    
    private lazy var lockShackleView: LockShackleView = createLockShackleView()
    
    private func createLockShackleView() -> LockShackleView {
        let shackle = LockShackleView()
        shackle.backgroundColor = UIColor.clear
        shackle.lockColor = lockColor
        addSubview(shackle)
        return shackle
    }
    
    private lazy var lockSpinnerView: LockSpinnerView = createLockSpinnerView()
    
    private func createLockSpinnerView() -> LockSpinnerView {
        let spinner = LockSpinnerView()
        addSubview(spinner)
        return spinner
    }
    
    private let lockViewAspectRatio = CGSize(width: 16.0, height: 10.0)
    private var lockViewRect = CGRect()
    
    // The lock dimensions are conceptualized as "units" so that the lock can be generically drawn given any view size. For reference, the total size required by the lock view is 16 units wide and 10 units high. The lock body is 8 units wide and 6 units tall. Since the lock view size is 10 units in height, we can convert from units to actual points by multiply the height by the number of units and dividing by 10.
    private func pointsFrom(units: CGFloat) -> CGFloat {
        return lockViewRect.size.height * units / 10.0
    }
    
    override func layoutSubviews() {
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
        
        lockShackleView.frame = lockViewRect
        
        var spinnerRect = CGRect.zero
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        spinnerRect.origin = CGPoint(x: center.x - pointsFrom(units: 1), y: center.y + pointsFrom(units: 1))
        spinnerRect.size = CGSize(width: pointsFrom(units: 2), height: pointsFrom(units: 2))
        lockSpinnerView.frame = spinnerRect
        
//        self.isSpinning = true
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        lockColor.setFill()
        path.lineWidth = 1.0
        
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    
        // Draw the lock body.
        let lockBodySize = CGSize(width: pointsFrom(units: 8), height: pointsFrom(units: 6))
        let lockBodyOrigin = CGPoint(x: center.x - pointsFrom(units: 4), y: center.y - pointsFrom(units: 1))
        let lockBodyPath = UIBezierPath(roundedRect: CGRect(origin: lockBodyOrigin, size: lockBodySize), cornerRadius: 3.0)
        lockBodyPath.fill()
    }
}
