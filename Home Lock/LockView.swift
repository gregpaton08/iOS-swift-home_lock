//
//  LockView.swift
//  Home Lock
//
//  Created by Greg Paton on 11/10/17.
//  Copyright © 2017 GSP. All rights reserved.
//

import UIKit

@IBDesignable
class LockView: UIView {
    
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
